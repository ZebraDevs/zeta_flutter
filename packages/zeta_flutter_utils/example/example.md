### Debounce

```dart
/// Initialize Debouncer
final debouncer = Debounce(()=> print('Hello, world!'), duration: Duration(seconds: 1));

/// Reset timer with optional new callback
debouncer.debounce(newCallback: ()=> print('Later, world!'));

/// Cancel debouncer
debouncer.cancel();

```

### Nothing

```dart
    child: Nothing()
```

### Extensions

#### Iterable<Widget>

```dart
Column(
    children: [
        Text('Hello'),
        Text('world'),
    ].divide(const Text('!')).toList(),
)

Column(
    children: [
        Text('Hello'),
        Text('world'),
    ].gap(40),
)
```

#### Widget

```dart

Text('Hello world').paddingAll(10);
Text('Hello world').paddingStart(10);
Text('Hello world').paddingEnd(10);
Text('Hello world').paddingTop(10);
Text('Hello world').paddingBottom(10);
Text('Hello world').paddingHorizontal(10);
Text('Hello world').paddingVertical(10);
```

#### Num

```dart
102.formatMaxChars(3); // 99+
```

#### String

```dart
'Zebra Employee'.initials; // ZE

'zebra'.capitalize; // Zebra
```

### Platform

```dart
// To check host platform:

if (PlatformIs.android)
if (PlatformIs.iOS)
if (PlatformIs.macOS)
if (PlatformIs.windows)
if (PlatformIs.linux)
if (PlatformIs.fuchsia)

// To check device type:
if (PlatformIs.mobile)
if (PlatformIs.desktop)

// To check if application is running on web:
if (PlatformIs.web)

```
