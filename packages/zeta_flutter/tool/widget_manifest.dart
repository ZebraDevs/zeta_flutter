import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:path/path.dart' as p;

const _widgetBases = {
  'FormField',
  'ImplicitlyAnimatedWidget',
  'InheritedWidget',
  'MaterialBanner',
  'PreferredSizeWidget',
  'ProxyWidget',
  'RenderObjectWidget',
  'SingleChildRenderObjectWidget',
  'SnackBar',
  'StatefulWidget',
  'StatelessWidget',
  'Tab',
  'TabBar',
  'Widget',
  'ZetaStatefulWidget',
  'ZetaStatelessWidget',
};

final _widgetType = RegExp('(?<![A-Za-z0-9_])Widget(?![A-Za-z0-9_])');
final _whitespace = RegExp(r'\s+');
final _docLink = RegExp(r'\[([^\]]+)\]');
final _docMacro = RegExp(r'\{@[a-zA-Z]+[^}]*\}');
final _version = RegExp(r'^version:\s*(\S+)\s*$', multiLine: true);

/// Walks up from [start] to the directory that contains `zeta_flutter`.
Directory findZetaFlutterPackage(Directory start) {
  final absolute = start.absolute;
  final nested = Directory(p.join(absolute.path, 'packages', 'zeta_flutter'));
  for (final candidate in [absolute, nested]) {
    if (_isZetaFlutterPackage(candidate)) return candidate;
  }
  var dir = absolute;
  while (true) {
    final parent = dir.parent;
    if (parent.path == dir.path) {
      throw ArgumentError('zeta_flutter package not found from ${start.path}');
    }
    dir = parent;
    if (_isZetaFlutterPackage(dir)) return dir;
  }
}

bool _isZetaFlutterPackage(Directory dir) {
  final pubspec = File(p.join(dir.path, 'pubspec.yaml'));
  final marker = File(p.join(dir.path, 'lib', 'zeta_components.dart'));
  if (!pubspec.existsSync() || !marker.existsSync()) return false;
  final text = pubspec.readAsStringSync();
  return text.startsWith('name: zeta_flutter\n') || text.startsWith('name: zeta_flutter\r\n');
}

/// JSON manifest of the public widget API and the tokens v2 groups.
///
/// The result is deterministic and ends with a newline.
String generateWidgetManifest(Directory packageRoot) {
  final root = packageRoot.absolute;
  final version = _packageVersion(File(p.join(root.path, 'pubspec.yaml')));
  final libraries = _parseTree(Directory(p.join(root.path, 'lib')));
  final entries = <String, _ApiEntry>{};
  for (final library in libraries.values) {
    for (final entry in _entriesIn(library)) {
      entries.putIfAbsent(entry.name, () => entry);
    }
  }
  _assignKinds(entries);

  final entryPoint = p.join(root.path, 'lib', 'zeta_flutter.dart');
  final exported = [..._exportedNames(entryPoint, libraries)]..sort();
  final widgets = <Map<String, Object?>>[];
  for (final name in exported) {
    final entry = entries[name];
    if (entry == null) {
      throw StateError(
        'Exported "$name" has no manifest entry. Add a parser for its declaration.',
      );
    }
    widgets.add(entry.toJson(entries));
  }

  final tokensDir = Directory(
    p.normalize(
      p.join(
        root.path,
        '..',
        'zeta_flutter_theme',
        'lib',
        'src',
        'generated',
        'tokens',
      ),
    ),
  );
  if (!tokensDir.existsSync()) {
    throw StateError('Token sources not found at ${tokensDir.path}');
  }

  final manifest = <String, Object?>{
    'schemaVersion': 1,
    'notice':
        'Generated file. Do not edit. Run `dart run tool/generate_widget_manifest.dart` from packages/zeta_flutter.',
    'name': 'zeta_flutter',
    'version': version,
    'import': 'package:zeta_flutter/zeta_flutter.dart',
    'generatedFrom': 'lib/zeta_flutter.dart',
    'icons': const {
      'widget': 'ZetaIcon',
      'constant': 'ZetaIcons.{name}',
      'example': 'ZetaIcon(ZetaIcons.add)',
      'note': 'ZetaIcon selects the round or sharp font from the rounded theme. '
          'ZetaIcons.{name}_round and ZetaIcons.{name}_sharp pin a font family; '
          'use those only when a fixed style is required.',
    },
    'tokens': _tokens(tokensDir),
    'widgets': widgets,
  };

  return '${const JsonEncoder.withIndent('  ').convert(manifest)}\n';
}

String _packageVersion(File pubspec) {
  final match = _version.firstMatch(pubspec.readAsStringSync());
  if (match == null) {
    throw StateError('No version in ${pubspec.path}');
  }
  return match.group(1)!;
}

Map<String, _Library> _parseTree(Directory root) {
  final libraries = <String, _Library>{};
  for (final entity in root.listSync(recursive: true)) {
    if (entity is! File || !entity.path.endsWith('.dart')) continue;
    final parsed = parseFile(
      path: entity.path,
      featureSet: FeatureSet.latestLanguageVersion(),
    );
    libraries[p.normalize(entity.path)] = _Library(p.normalize(entity.path), parsed.content, parsed.unit);
  }
  return libraries;
}

List<_ApiEntry> _entriesIn(_Library library) {
  final entries = <_ApiEntry>[];
  for (final declaration in library.unit.declarations) {
    if (declaration is ClassDeclaration) {
      final name = declaration.name.lexeme;
      if (name.startsWith('_')) continue;
      entries.add(_classEntry(library, declaration));
    } else if (declaration is EnumDeclaration) {
      final name = declaration.name.lexeme;
      if (name.startsWith('_')) continue;
      entries.add(_enumEntry(library, declaration));
    } else if (declaration is MixinDeclaration) {
      final name = declaration.name.lexeme;
      if (name.startsWith('_')) continue;
      entries.add(
        _ApiEntry(
          name: name,
          kind: 'mixin',
          file: library.relativeFile,
          description: _summary(declaration, library.source),
          figma: _figma(declaration, library.source),
          deprecated: _deprecated(declaration, library.source),
          typeParameters: _typeParameters(declaration.typeParameters, library.source),
        ),
      );
    } else if (declaration is ExtensionDeclaration) {
      final name = declaration.name?.lexeme;
      if (name == null || name.startsWith('_')) continue;
      final onClause = declaration.onClause;
      entries.add(
        _ApiEntry(
          name: name,
          kind: 'extension',
          file: library.relativeFile,
          description: _summary(declaration, library.source),
          deprecated: _deprecated(declaration, library.source),
          typeParameters: _typeParameters(declaration.typeParameters, library.source),
          onType: onClause == null ? null : _sliceNode(library.source, onClause.extendedType),
          members: [
            for (final member in declaration.members)
              if (member is MethodDeclaration && !member.name.lexeme.startsWith('_'))
                {
                  'name': member.name.lexeme,
                  if (member.returnType != null) 'type': _sliceNode(library.source, member.returnType!),
                  if (member.isGetter) 'getter': true,
                  if (member.isSetter) 'setter': true,
                  if (_summary(member, library.source) case final description?) 'description': description,
                  if (_deprecated(member, library.source) case final deprecated?) 'deprecated': deprecated,
                  if (member.parameters != null)
                    'parameters': _parameters(
                      member.parameters,
                      library.source,
                      _ApiEntry(name: '', kind: 'extension', file: ''),
                      const <String, _ApiEntry>{},
                    ),
                },
          ],
        ),
      );
    } else if (declaration is GenericTypeAlias) {
      final name = declaration.name.lexeme;
      if (name.startsWith('_')) continue;
      entries.add(
        _ApiEntry(
          name: name,
          kind: 'typedef',
          file: library.relativeFile,
          description: _summary(declaration, library.source),
          deprecated: _deprecated(declaration, library.source),
          signature: _slice(
            library.source,
            declaration.firstTokenAfterCommentAndMetadata.offset,
            declaration.end,
          ),
        ),
      );
    } else if (declaration is FunctionDeclaration) {
      final name = declaration.name.lexeme;
      if (name.startsWith('_')) continue;
      entries.add(_functionEntry(library, declaration));
    }
  }
  return entries;
}

_ApiEntry _classEntry(_Library library, ClassDeclaration declaration) {
  final fields = <String, _Field>{};
  final constructors = <ConstructorDeclaration>[];
  for (final member in declaration.members) {
    if (member is FieldDeclaration && !member.isStatic) {
      final type = member.fields.type;
      final typeName = type == null ? 'dynamic' : _sliceNode(library.source, type);
      for (final variable in member.fields.variables) {
        final fieldName = variable.name.lexeme;
        if (fieldName.startsWith('_')) continue;
        final documented = variable.documentationComment == null ? member : variable;
        fields[fieldName] = _Field(typeName, _summary(documented, library.source));
      }
    } else if (member is ConstructorDeclaration) {
      final constructorName = member.name?.lexeme;
      if (constructorName != null && constructorName.startsWith('_')) continue;
      constructors.add(member);
    }
  }

  return _ApiEntry(
    name: declaration.name.lexeme,
    kind: 'class',
    file: library.relativeFile,
    description: _summary(declaration, library.source),
    figma: _figma(declaration, library.source),
    deprecated: _deprecated(declaration, library.source),
    typeParameters: _typeParameters(declaration.typeParameters, library.source),
    superclass: _superclass(declaration, library.source),
    fields: fields,
    constructors: constructors,
    source: library.source,
  );
}

_ApiEntry _enumEntry(_Library library, EnumDeclaration declaration) {
  return _ApiEntry(
    name: declaration.name.lexeme,
    kind: 'enum',
    file: library.relativeFile,
    description: _summary(declaration, library.source),
    figma: _figma(declaration, library.source),
    deprecated: _deprecated(declaration, library.source),
    typeParameters: _typeParameters(declaration.typeParameters, library.source),
    values: [
      for (final constant in declaration.constants)
        {
          'name': constant.name.lexeme,
          if (_summary(constant, library.source) case final description?) 'description': description,
          if (_deprecated(constant, library.source) case final deprecated?) 'deprecated': deprecated,
        },
    ],
  );
}

_ApiEntry _functionEntry(_Library library, FunctionDeclaration declaration) {
  final expression = declaration.functionExpression;
  return _ApiEntry(
    name: declaration.name.lexeme,
    kind: 'function',
    file: library.relativeFile,
    description: _summary(declaration, library.source),
    deprecated: _deprecated(declaration, library.source),
    signature: declaration.returnType == null ? null : _sliceNode(library.source, declaration.returnType!),
    parameters: _parameters(
      expression.parameters,
      library.source,
      _ApiEntry(name: '', kind: 'function', file: ''),
      const <String, _ApiEntry>{},
    ),
  );
}

void _assignKinds(Map<String, _ApiEntry> entries) {
  for (final entry in entries.values) {
    if (entry.kind != 'class') continue;
    entry.kind = _kindOf(entry, entries);
  }
}

String _kindOf(_ApiEntry entry, Map<String, _ApiEntry> entries) {
  final seen = <String>{};
  var current = entry.superclass;
  while (current != null && seen.add(current)) {
    if (current == 'State') return 'state';
    if (_widgetBases.contains(current) || current.endsWith('Widget')) {
      return 'widget';
    }
    current = entries[current]?.superclass;
  }
  return 'class';
}

List<String> _exportedNames(
  String entryPoint,
  Map<String, _Library> libraries,
) {
  final cache = <String, List<String>>{};

  List<String> resolve(String file) {
    final normalized = p.normalize(file);
    final cached = cache[normalized];
    if (cached != null) return cached;
    final library = libraries[normalized];
    if (library == null) {
      throw StateError('Exported library not parsed: $normalized');
    }
    final names = <String>[];
    cache[normalized] = names;
    for (final declaration in library.unit.declarations) {
      final name = _declarationName(declaration);
      if (name != null && !name.startsWith('_') && !names.contains(name)) {
        names.add(name);
      }
    }
    for (final directive in library.unit.directives.whereType<ExportDirective>()) {
      final uri = directive.uri.stringValue;
      if (uri == null) {
        throw StateError('Unresolvable export in $normalized');
      }
      // Exports from other packages (and dart: core libraries) are out of
      // scope: this tool only parses zeta_flutter's own lib/ tree, so there
      // is no AST to resolve them against. Skip them rather than failing;
      // any type that is *also* re-exported locally will still be found via
      // the package's own export directives.
      if (uri.startsWith('package:') || uri.startsWith('dart:')) {
        continue;
      }
      final child = resolve(p.normalize(p.join(p.dirname(normalized), uri)));
      final visible = child.toSet();
      for (final combinator in directive.combinators) {
        if (combinator is ShowCombinator) {
          final shown = combinator.shownNames.map((identifier) => identifier.name).toSet();
          visible.retainAll(shown);
        } else if (combinator is HideCombinator) {
          visible.removeAll(
            combinator.hiddenNames.map((identifier) => identifier.name),
          );
        }
      }
      for (final name in child) {
        if (visible.contains(name) && !names.contains(name)) names.add(name);
      }
    }
    return names;
  }

  return resolve(entryPoint);
}

String? _declarationName(CompilationUnitMember declaration) {
  if (declaration is ClassDeclaration) return declaration.name.lexeme;
  if (declaration is EnumDeclaration) return declaration.name.lexeme;
  if (declaration is MixinDeclaration) return declaration.name.lexeme;
  if (declaration is GenericTypeAlias) return declaration.name.lexeme;
  if (declaration is FunctionDeclaration) return declaration.name.lexeme;
  if (declaration is ExtensionDeclaration) return declaration.name?.lexeme;
  return null;
}

List<Map<String, Object?>> _parameters(
  FormalParameterList? list,
  String source,
  _ApiEntry owner,
  Map<String, _ApiEntry> entries,
) {
  if (list == null) return const [];
  final parameters = <Map<String, Object?>>[];
  for (final parameter in list.parameters) {
    final NormalFormalParameter inner;
    final Expression? defaultValue;
    if (parameter is DefaultFormalParameter) {
      inner = parameter.parameter;
      defaultValue = parameter.defaultValue;
    } else if (parameter is NormalFormalParameter) {
      inner = parameter;
      defaultValue = null;
    } else {
      continue;
    }
    final name = inner.name?.lexeme;
    if (name == null) continue;
    final type = _parameterType(inner, source, owner, entries);
    final description = _fieldDescription(owner, name, entries);
    parameters.add({
      'name': name,
      'type': type,
      'named': parameter.isNamed,
      'required': parameter.isRequired,
      if (defaultValue != null) 'default': _sliceNode(source, defaultValue),
      if (_widgetType.hasMatch(type)) 'slot': true,
      if (description != null) 'description': description,
    });
  }
  return parameters;
}

String _parameterType(
  NormalFormalParameter parameter,
  String source,
  _ApiEntry owner,
  Map<String, _ApiEntry> entries,
) {
  if (parameter is SimpleFormalParameter && parameter.type != null) {
    return _sliceNode(source, parameter.type!);
  }
  if (parameter is FieldFormalParameter && parameter.type != null && parameter.parameters == null) {
    return _sliceNode(source, parameter.type!);
  }
  if (parameter is SuperFormalParameter && parameter.type != null && parameter.parameters == null) {
    return _sliceNode(source, parameter.type!);
  }
  final name = parameter.name?.lexeme;
  if (name == null) return 'dynamic';
  return _fieldType(owner, name, entries) ?? (name == 'key' ? 'Key?' : 'dynamic');
}

String? _fieldType(
  _ApiEntry start,
  String name,
  Map<String, _ApiEntry> entries,
) {
  final seen = <String>{};
  _ApiEntry? current = start;
  while (current != null && seen.add(current.name)) {
    final field = current.fields[name];
    if (field != null) return field.type;
    final parent = current.superclass;
    if (parent == null) return null;
    current = entries[parent];
  }
  return null;
}

String? _fieldDescription(
  _ApiEntry start,
  String name,
  Map<String, _ApiEntry> entries,
) {
  final seen = <String>{};
  _ApiEntry? current = start;
  while (current != null && seen.add(current.name)) {
    final description = current.fields[name]?.description;
    if (description != null) return description;
    final parent = current.superclass;
    if (parent == null) return null;
    current = entries[parent];
  }
  return null;
}

Map<String, Object?> _tokens(Directory tokensDir) {
  final classes = <String, _TokenClass>{};
  for (final entity in tokensDir.listSync()) {
    if (entity is! File || !entity.path.endsWith('.dart')) continue;
    final parsed = parseFile(
      path: entity.path,
      featureSet: FeatureSet.latestLanguageVersion(),
    );
    for (final declaration in parsed.unit.declarations.whereType<ClassDeclaration>()) {
      classes[declaration.name.lexeme] = _TokenClass(declaration, parsed.content);
    }
  }
  final zeta = classes['ZetaTokens'];
  if (zeta == null) {
    throw StateError('ZetaTokens was not found in ${tokensDir.path}');
  }

  final properties = <Map<String, Object?>>[];
  for (final member in zeta.members) {
    if (member.name.startsWith('_')) continue;
    final typeName = member.type.replaceAll(_whitespace, '');
    final bare = typeName.endsWith('?') ? typeName.substring(0, typeName.length - 1) : typeName;
    final nested = classes[bare];
    final expandMembers = nested != null && bare != 'ZetaPrimitiveTokens' && bare != 'ZetaPaletteTokens';
    properties.add({
      'name': member.name,
      'type': member.type,
      if (member.description != null) 'description': member.description,
      if (bare == 'ZetaPrimitiveTokens' || bare == 'ZetaPaletteTokens')
        'note':
            'Raw token layer. Prefer surface, foreground, border, interactive, overlay, feedback, focus, chart, selection, space, radius, text, and shadow.',
      if (expandMembers)
        'members': [
          for (final child in nested.members)
            if (!child.name.startsWith('_'))
              {
                'name': child.name,
                'type': child.type,
                if (child.description != null) 'description': child.description,
              },
        ],
    });
  }

  return {
    'access': 'Zeta.of(context).tokens',
    'contextAlias': 'context.zetaTokens',
    'doNotUse': const [
      'Zeta.of(context).colors',
      'Zeta.of(context).spacing',
      'Zeta.of(context).radius',
      'Zeta.of(context).textStyles',
      'Zeta.of(context).primitives',
      'Zeta.of(context).semantics',
    ],
    'properties': properties,
  };
}

String? _superclass(ClassDeclaration declaration, String source) {
  final clause = declaration.extendsClause;
  if (clause == null) return null;
  final text = _sliceNode(source, clause.superclass);
  final angle = text.indexOf('<');
  return (angle == -1 ? text : text.substring(0, angle)).trim();
}

List<String> _typeParameters(TypeParameterList? list, String source) {
  if (list == null) return const [];
  return [
    for (final parameter in list.typeParameters) _sliceNode(source, parameter),
  ];
}

String? _summary(AnnotatedNode node, String source) {
  final comment = node.documentationComment;
  if (comment == null) return null;
  final raw = _slice(source, comment.offset, comment.end);
  final lines = <String>[];
  for (final line in raw.split('\n')) {
    var text = line.trim();
    if (text.startsWith('///')) text = text.substring(3).trim();
    if (text.startsWith('/**')) text = text.substring(3).trim();
    if (text.startsWith('*/')) continue;
    if (text.startsWith('*')) text = text.substring(1).trim();
    if (text.isEmpty) {
      if (lines.isNotEmpty) break;
      continue;
    }
    if (text.startsWith('Figma:') || text.startsWith('Widgetbook:')) continue;
    lines.add(text);
  }
  if (lines.isEmpty) return null;
  final summary = lines
      .join(' ')
      .replaceAll(_docMacro, '')
      .replaceAllMapped(_docLink, (match) => match.group(1)!)
      .replaceAll(_whitespace, ' ')
      .trim();
  return summary.isEmpty ? null : summary;
}

String? _figma(AnnotatedNode node, String source) {
  final comment = node.documentationComment;
  if (comment == null) return null;
  final raw = _slice(source, comment.offset, comment.end);
  final match = RegExp(r'https://www\.figma\.com/\S+').firstMatch(raw);
  if (match == null) return null;
  return match.group(0)!.replaceAll(RegExp(r'[)\].,]+$'), '');
}

String? _deprecated(AnnotatedNode node, String source) {
  for (final annotation in node.metadata) {
    final name = _sliceNode(source, annotation.name);
    if (name != 'Deprecated' && !name.endsWith('.Deprecated')) continue;
    final arguments = annotation.arguments?.arguments;
    if (arguments == null || arguments.isEmpty) return '';
    final first = arguments.first;
    if (first is StringLiteral && first.stringValue != null) {
      return first.stringValue;
    }
    return _sliceNode(source, first);
  }
  return null;
}

String _sliceNode(String source, AstNode node) => _slice(source, node.offset, node.end);

String _slice(String source, int start, int end) => source.substring(start, end).trim();

class _Library {
  _Library(this.path, this.source, this.unit);

  final String path;
  final String source;
  final CompilationUnit unit;

  String get relativeFile {
    final lib = path.split('${p.separator}lib${p.separator}').last;
    return 'lib/$lib'.replaceAll(r'\', '/');
  }
}

class _Field {
  const _Field(this.type, this.description);

  final String type;
  final String? description;
}

class _ApiEntry {
  _ApiEntry({
    required this.name,
    required this.kind,
    required this.file,
    this.description,
    this.figma,
    this.deprecated,
    this.typeParameters = const [],
    this.superclass,
    this.fields = const {},
    this.constructors = const [],
    this.values = const [],
    this.parameters = const [],
    this.members = const [],
    this.signature,
    this.source,
    this.onType,
  });

  final String name;
  String kind;
  final String file;
  final String? description;
  final String? figma;
  final String? deprecated;
  final List<String> typeParameters;
  final String? superclass;
  final Map<String, _Field> fields;
  final List<ConstructorDeclaration> constructors;
  final List<Map<String, Object?>> values;
  final List<Map<String, Object?>> parameters;
  final List<Map<String, Object?>> members;
  final String? signature;
  final String? source;
  final String? onType;

  Map<String, Object?> toJson(Map<String, _ApiEntry> entries) {
    final constructorJson = source == null
        ? const <Map<String, Object?>>[]
        : [
            for (final constructor in constructors) _constructorJson(constructor, entries),
          ];
    final slots = <String>[];
    for (final constructor in constructorJson) {
      final params = constructor['parameters'];
      if (params is! List) continue;
      for (final parameter in params) {
        if (parameter is Map && parameter['slot'] == true) {
          final slotName = parameter['name'];
          if (slotName is String && !slots.contains(slotName)) {
            slots.add(slotName);
          }
        }
      }
    }
    return {
      'name': name,
      'kind': kind,
      'file': file,
      if (description != null) 'description': description,
      if (figma != null) 'figma': figma,
      if (deprecated != null) 'deprecated': deprecated,
      if (typeParameters.isNotEmpty) 'typeParameters': typeParameters,
      if (superclass != null) 'extends': superclass,
      if (signature != null) 'signature': signature,
      if (onType != null) 'on': onType,
      if (members.isNotEmpty) 'members': members,
      if (values.isNotEmpty) 'values': values,
      if (parameters.isNotEmpty) 'parameters': parameters,
      if (constructorJson.isNotEmpty) 'constructors': constructorJson,
      if (slots.isNotEmpty) 'slots': slots,
    };
  }

  Map<String, Object?> _constructorJson(
    ConstructorDeclaration constructor,
    Map<String, _ApiEntry> entries,
  ) {
    final constructorName = constructor.name?.lexeme;
    final fullName = constructorName == null ? name : '$name.$constructorName';
    return {
      'name': fullName,
      if (constructor.constKeyword != null) 'const': true,
      if (constructor.factoryKeyword != null) 'factory': true,
      if (_deprecated(constructor, source!) case final deprecated?) 'deprecated': deprecated,
      if (_summary(constructor, source!) case final description?) 'description': description,
      'parameters': _parameters(constructor.parameters, source!, this, entries),
    };
  }
}

class _TokenMember {
  const _TokenMember(this.name, this.type, this.description);

  final String name;
  final String type;
  final String? description;
}

class _TokenClass {
  _TokenClass(ClassDeclaration declaration, String source) : members = _members(declaration, source);

  final List<_TokenMember> members;

  static List<_TokenMember> _members(
    ClassDeclaration declaration,
    String source,
  ) {
    final members = <_TokenMember>[];
    for (final member in declaration.members) {
      if (member is MethodDeclaration && member.isGetter && !member.isStatic && !member.isOperator) {
        final type = member.returnType == null ? 'dynamic' : _sliceNode(source, member.returnType!);
        members.add(
          _TokenMember(member.name.lexeme, type, _summary(member, source)),
        );
      } else if (member is FieldDeclaration && !member.isStatic) {
        final type = member.fields.type == null ? 'dynamic' : _sliceNode(source, member.fields.type!);
        for (final variable in member.fields.variables) {
          if (variable.name.lexeme.startsWith('_')) continue;
          final documented = variable.documentationComment == null ? member : variable;
          members.add(
            _TokenMember(
              variable.name.lexeme,
              type,
              _summary(documented, source),
            ),
          );
        }
      }
    }
    return members;
  }
}
