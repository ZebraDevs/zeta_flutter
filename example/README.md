### Building embedded app for Zeta docs site

cd example
flutter build web -t lib/embedded.dart --no-tree-shake-icons --base-href=/flutter/

Copy example/build/web/main.dart.js into docusaurus/static/flutter

Edit lines in main.dart.js - change lines that have 'flutter/assets' or 'assets' strings to '/flutter/assets' and '/assets'
