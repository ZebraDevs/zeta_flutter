// The content of this file is taken from
// package:flutter_test/lib/src/accessibility.dart
// Changes are commented with "Zeta change:"

// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE-3RD-PARTY file..

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

// Zeta change: Create a new guideline for stricter AAA text contrast checking.
class AAATextGuideline extends AccessibilityGuideline {
  /// Create a new [AAATextGuideline].
  const AAATextGuideline();

  /// The minimum text size considered large for contrast checking.
  ///
  /// Defined by http://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html
  static const int kLargeTextMinimumSize = 18;

  /// The minimum text size for bold text to be considered large for contrast
  /// checking.
  ///
  /// Defined by http://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html
  static const int kBoldTextMinimumSize = 14;

  /// The minimum contrast ratio for normal text.
  ///
  /// Defined by http://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html
// Zeta change: Changed from 4.5 to 7 for stricter AAA compliance.
  static const double kMinimumRatioNormalText = 7;

  /// The minimum contrast ratio for large text.
  ///
  /// Defined by http://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html
  // Zeta change: Changed from 3 to 4.5 for stricter AAA compliance.
  static const double kMinimumRatioLargeText = 4.5;

  static const double _kDefaultFontSize = 12;

  static const double _tolerance = -0.01;

  @override
  Future<Evaluation> evaluate(WidgetTester tester) async {
    Evaluation result = const Evaluation.pass();
    for (final RenderView renderView in tester.binding.renderViews) {
      final OffsetLayer layer = renderView.debugLayer! as OffsetLayer;
      final SemanticsNode root = renderView.owner!.semanticsOwner!.rootSemanticsNode!;

      late ui.Image image;
      final ByteData? byteData = await tester.binding.runAsync<ByteData?>(() async {
        // Needs to be the same pixel ratio otherwise our dimensions won't match
        // the last transform layer.
        final double ratio = 1 / renderView.flutterView.devicePixelRatio;
        image = await layer.toImage(renderView.paintBounds, pixelRatio: ratio);
        final ByteData? data = await image.toByteData();
        image.dispose();
        return data;
      });

      result += await _evaluateNode(root, tester, image, byteData!, renderView);
    }

    return result;
  }

  Future<Evaluation> _evaluateNode(
    SemanticsNode node,
    WidgetTester tester,
    ui.Image image,
    ByteData byteData,
    RenderView renderView,
  ) async {
    Evaluation result = const Evaluation.pass();

    // Skip disabled nodes, as they not required to pass contrast check.
    final bool isDisabled = node.hasFlag(ui.SemanticsFlag.hasEnabledState) && !node.hasFlag(ui.SemanticsFlag.isEnabled);

    if (node.isInvisible || node.isMergedIntoParent || node.hasFlag(ui.SemanticsFlag.isHidden) || isDisabled) {
      return result;
    }

    final SemanticsData data = node.getSemanticsData();
    final List<SemanticsNode> children = <SemanticsNode>[];
    node.visitChildren((SemanticsNode child) {
      children.add(child);
      return true;
    });
    for (final SemanticsNode child in children) {
      result += await _evaluateNode(child, tester, image, byteData, renderView);
    }
    if (shouldSkipNode(data)) {
      return result;
    }
    final String text = data.label.isEmpty ? data.value : data.label;
    final Iterable<Element> elements = find.text(text).hitTestable().evaluate();
    for (final Element element in elements) {
      result += await _evaluateElement(node, element, tester, image, byteData, renderView);
    }
    return result;
  }

  Future<Evaluation> _evaluateElement(
    SemanticsNode node,
    Element element,
    WidgetTester tester,
    ui.Image image,
    ByteData byteData,
    RenderView renderView,
  ) async {
    // Look up inherited text properties to determine text size and weight.
    late bool isBold;
    double? fontSize;

    late final Rect screenBounds;
    late final Rect paintBoundsWithOffset;

    final RenderObject? renderBox = element.renderObject;
    if (renderBox is! RenderBox) {
      throw StateError('Unexpected renderObject type: $renderBox');
    }

    final Matrix4 globalTransform = renderBox.getTransformTo(null);
    paintBoundsWithOffset = MatrixUtils.transformRect(
      globalTransform,
      renderBox.paintBounds.inflate(4),
    );

    // The semantics node transform will include root view transform, which is
    // not included in renderBox.getTransformTo(null). Manually multiply the
    // root transform to the global transform.
    final Matrix4 rootTransform = Matrix4.identity();
    renderView.applyPaintTransform(renderView.child!, rootTransform);
    rootTransform.multiply(globalTransform);
    screenBounds = MatrixUtils.transformRect(rootTransform, renderBox.paintBounds);
    Rect nodeBounds = node.rect;
    SemanticsNode? current = node;
    while (current != null) {
      final Matrix4? transform = current.transform;
      if (transform != null) {
        nodeBounds = MatrixUtils.transformRect(transform, nodeBounds);
      }
      current = current.parent;
    }
    final Rect intersection = nodeBounds.intersect(screenBounds);
    if (intersection.width <= 0 || intersection.height <= 0) {
      // Skip this element since it doesn't correspond to the given semantic
      // node.
      return const Evaluation.pass();
    }

    final Widget widget = element.widget;
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(element);
    if (widget is Text) {
      final TextStyle? style = widget.style;
      final TextStyle effectiveTextStyle =
          style == null || style.inherit ? defaultTextStyle.style.merge(widget.style) : style;
      isBold = effectiveTextStyle.fontWeight == FontWeight.bold;
      fontSize = effectiveTextStyle.fontSize;
    } else if (widget is EditableText) {
      isBold = widget.style.fontWeight == FontWeight.bold;
      fontSize = widget.style.fontSize;
    } else {
      throw StateError('Unexpected widget type: ${widget.runtimeType}');
    }

    if (isNodeOffScreen(paintBoundsWithOffset, renderView.flutterView)) {
      return const Evaluation.pass();
    }

    final Map<Color, int> colorHistogram = _colorsWithinRect(
      byteData,
      paintBoundsWithOffset,
      image.width,
      image.height,
    );

    // Node was too far off screen.
    if (colorHistogram.isEmpty) {
      return const Evaluation.pass();
    }

    final _ContrastReport report = _ContrastReport(colorHistogram);

    final double contrastRatio = report.contrastRatio();
    final double targetContrastRatio = this.targetContrastRatio(fontSize, bold: isBold);

    if (contrastRatio - targetContrastRatio >= _tolerance) {
      return const Evaluation.pass();
    }
    return Evaluation.fail(
      '$node:\n'
      'Expected contrast ratio of at least $targetContrastRatio '
      'but found ${contrastRatio.toStringAsFixed(2)} '
      'for a font size of $fontSize.\n'
      'The computed colors was:\n'
      'light - ${report.lightColor}, dark - ${report.darkColor}\n'
      'See also: '
      'https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
    );
  }

  /// Returns whether node should be skipped.
  ///
  /// Skip routes which might have labels, and nodes without any text.
  bool shouldSkipNode(SemanticsData data) =>
      data.hasFlag(ui.SemanticsFlag.scopesRoute) || (data.label.trim().isEmpty && data.value.trim().isEmpty);

  /// Returns if a rectangle of node is off the screen.
  ///
  /// Allows node to be of screen partially before culling the node.
  bool isNodeOffScreen(Rect paintBounds, ui.FlutterView window) {
    final Size windowPhysicalSize = window.physicalSize * window.devicePixelRatio;
    return paintBounds.top < -50.0 ||
        paintBounds.left < -50.0 ||
        paintBounds.bottom > windowPhysicalSize.height + 50.0 ||
        paintBounds.right > windowPhysicalSize.width + 50.0;
  }

  /// Returns the required contrast ratio for the [fontSize] and [bold] setting.
  ///
  /// Defined by http://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html
  double targetContrastRatio(double? fontSize, {required bool bold}) {
    final double fontSizeOrDefault = fontSize ?? _kDefaultFontSize;
    if ((bold && fontSizeOrDefault >= kBoldTextMinimumSize) || fontSizeOrDefault >= kLargeTextMinimumSize) {
      return kMinimumRatioLargeText;
    }
    return kMinimumRatioNormalText;
  }

  @override
  String get description => 'Text contrast should follow WCAG guidelines';
}

/// Gives the color histogram of all pixels inside a given rectangle on the
/// screen.
///
/// Given a [ByteData] object [data], which stores the color of each pixel
/// in row-first order, where each pixel is given in 4 bytes in RGBA order,
/// and [paintBounds], the rectangle, and [width] and [height],
//  the dimensions of the [ByteData] returns color histogram.
Map<Color, int> _colorsWithinRect(ByteData data, Rect paintBounds, int width, int height) {
  final Rect truePaintBounds = paintBounds.intersect(
    Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
  );

  final int leftX = truePaintBounds.left.floor();
  final int rightX = truePaintBounds.right.ceil();
  final int topY = truePaintBounds.top.floor();
  final int bottomY = truePaintBounds.bottom.ceil();

  final Map<int, int> rgbaToCount = <int, int>{};

  int getPixel(ByteData data, int x, int y) {
    final int offset = (y * width + x) * 4;
    return data.getUint32(offset);
  }

  for (int x = leftX; x < rightX; x++) {
    for (int y = topY; y < bottomY; y++) {
      rgbaToCount.update(getPixel(data, x, y), (int count) => count + 1, ifAbsent: () => 1);
    }
  }

  return rgbaToCount.map<Color, int>((int rgba, int count) {
    final int argb = (rgba << 24) | (rgba >> 8) & 0xFFFFFFFF;
    return MapEntry<Color, int>(Color(argb), count);
  });
}

/// A class that reports the contrast ratio of a part of the screen.
///
/// Commonly used in accessibility testing to obtain the contrast ratio of
/// text widgets and other types of widgets.
class _ContrastReport {
  /// Generates a contrast report given a color histogram.
  ///
  /// The contrast ratio of the most frequent light color and the most
  /// frequent dark color is calculated. Colors are divided into light and
  /// dark colors based on their lightness as an [HSLColor].
  factory _ContrastReport(Map<Color, int> colorHistogram) {
    // To determine the lighter and darker color, partition the colors
    // by HSL lightness and then choose the mode from each group.
    double totalLightness = 0;
    int count = 0;
    for (final MapEntry<Color, int> entry in colorHistogram.entries) {
      totalLightness += HSLColor.fromColor(entry.key).lightness * entry.value;
      count += entry.value;
    }
    final double averageLightness = totalLightness / count;
    assert(!averageLightness.isNaN, 'Lightness must be a value');

    MapEntry<Color, int>? lightColor;
    MapEntry<Color, int>? darkColor;

    // Find the most frequently occurring light and dark color.
    for (final MapEntry<Color, int> entry in colorHistogram.entries) {
      final double lightness = HSLColor.fromColor(entry.key).lightness;
      final int count = entry.value;
      if (lightness <= averageLightness) {
        if (count > (darkColor?.value ?? 0)) {
          darkColor = entry;
        }
      } else if (count > (lightColor?.value ?? 0)) {
        lightColor = entry;
      }
    }

    // If there is only single color, it is reported as both dark and light.
    return _ContrastReport._(lightColor?.key ?? darkColor!.key, darkColor?.key ?? lightColor!.key);
  }

  const _ContrastReport._(this.lightColor, this.darkColor);

  /// The most frequently occurring light color. Uses [Colors.transparent] if
  /// the rectangle is empty.
  final Color lightColor;

  /// The most frequently occurring dark color. Uses [Colors.transparent] if
  /// the rectangle is empty.
  final Color darkColor;

  /// Computes the contrast ratio as defined by the WCAG.
  ///
  /// Source: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html
  double contrastRatio() => (lightColor.computeLuminance() + 0.05) / (darkColor.computeLuminance() + 0.05);
}

// Zeta Change: export AAA text guideline.
const AccessibilityGuideline aaaGuideline = AAATextGuideline();
