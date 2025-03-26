### Building Embedded App for Zeta Docs Site

> Note: This procedure is automated in the Zeta script `build_flutter_example.tsx` found in the Zeta docs repository.

1. **Navigate to the example directory:**

   ```bash
   cd example
   ```

2. **Build the Flutter web app:**

   ```bash
   flutter build web -t lib/embedded.dart --no-tree-shake-icons --base-href=/flutter/
   ```

3. **Copy the built JavaScript file:**

   ```bash
   cp example/build/web/main.dart.js docusaurus/static/flutter
   ```

4. **Edit the `main.dart.js` file:**
   - Change lines containing `"flutter/assets"` to `"/flutter/assets"`
   - Change lines containing `"assets"` to `"/assets"`

> 🚧 **Note**: Currently not sure why we need to make these changes, as we are setting the correct base-href. Also, there may be other changes required in main.dart.js
