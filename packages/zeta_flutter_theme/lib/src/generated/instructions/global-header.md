# Global header

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=2314-3348&m=dev

## Global Header

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=2356-5644&m=dev

### Overview

The bar across the top of an application, carrying the product’s identity at the leading edge, navigation and search in the middle, and the person’s account at the trailing edge. Most of what it holds is optional: the app switcher, the search bar, the two menu regions and the dividers each turn on independently, so one component covers a bare branded bar and a fully loaded one. Rounded is set once and carries into every control nested inside it.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Rounded | false | true | Use where the header meets the viewport edges and reads as part of the chrome. Every control inside squares off with the bar. |
| Rounded | true | — | The corner carries into every nested control, so nothing stays square.  (Use the radius around the header where the header sits inside a padded shell and reads as a floating surface.) |
| AppSwitcher | true | true | Keeps the grid button that moves a person between products. Drop it in a single product, where there is nothing to switch to. |
| AppSwitcher | false | — | Removes it. The account control then sits against the trailing edge with nothing after it. |
| SearchBar | true | true | Keeps search in the middle band. It holds a fixed width, so it will not stretch to fill a wider header. |
| SearchBar | false | — | Removes it. The middle band collapses to whatever the menu regions hold, and to nothing when both are off. |
| MenuItems | false | true | Leaves the navigation region out, which suits a header whose navigation lives elsewhere on the page. |
| MenuItems | true | — | Opens the navigation region before search. It takes the width the middle band has spare, so it is the part that absorbs a wider viewport. |
| Slot-Menu-Items | slot | — | Takes the navigation controls. It is only drawn when MenuItems is on, so filling it alone leaves it hidden. |
| ActionMenu | false | true | Leaves the trailing action region out, keeping the middle band to navigation and search. |
| ActionMenu | true | — | Opens a region for icon actions after search. It hugs its content, so it never takes width from search. |
| Slot-Menu-Actions | slot | — | Takes the trailing action controls. It is only drawn when ActionMenu is on. |
| Dividers | false | true | Leaves the three regions to spacing alone, which reads as one continuous bar. |
| Dividers | true | — | Draws a hairline before the middle band and another after it. Use it where the regions hold enough to blur together. |
| PlatformName | text | Platform Name | Names the product beside the mark. It takes a product name rather than a page title, because it does not change as a person navigates. |
| Show Platform Name | true | true | Keeps the product name. Use it where the mark alone does not identify the product. |
| Show Platform Name | false | — | Drops it, leaving the mark to carry identity on its own. |
| Show Logo | boolean | true | Declared on the component and defaulting to true. Nothing in the header is bound to it, so the logo region is present either way and Slot Logo is what varies it. |
| Slot Logo | slot | — | Takes the product’s mark at the leading edge. It carries no visibility toggle of its own, so the region is always drawn. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| Static | — | — | The header itself has no interaction states. Hover, focus and press belong to the controls placed inside it. |
| Rounded | The Rounded value | — | Every corner in the bar changes together, from the bar itself through the icon buttons, the search field and the account control. |
| Account control | _User Profile State | — | It carries default, hover, pressed, focus and disabled. The background moves through the neutral interactive tokens, and focus is the only one that draws a visible border. |
| Menu open | The dropdown Open value | — | The account control is the trigger for a dropdown. What opening it does belongs to Template/Dropdown and is described in its own frame. |
| Region visibility | AppSwitcher, SearchBar, MenuItems, ActionMenu, Dividers | — | Each toggle takes its region out of the layout rather than leaving a gap, so the remaining regions close up. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | No transition is defined. Regions appear and disappear with their toggles, and nothing animates the change. |
| Width | The bar holds a fixed width, with the middle band filling whatever the two end groups leave. Those groups hug their content, so a longer product name or an extra action takes width away from navigation. |
| Middle alignment | The middle band packs its content to its trailing edge. With navigation off, search sits next to the account group rather than in the centre of the bar. |
| Shape propagation | Rounded is set once on the bar and carried into every nested control. Setting a nested control’s own shape separately is the one place a consumer can leave the header inconsistent with itself. |
| Border theming | A stroke bound to border/default sits on the bar at zero weight, and the nested controls carry the same arrangement. The weight is a theming hook, so a high contrast variable set can give the bar and everything in it a hard outline. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Brand mark | Slot Logo, consumer owned | Takes the product’s mark at the leading edge. The content sitting in it by default is _Brand Logo Horizontal, which filling the slot replaces. |
| Product name | PlatformName, text | Consumer owned, and the only text the header itself takes in. |
| Navigation | Slot-Menu-Items, consumer owned | Takes the navigation controls. The content in it by default is one Icon Button and one Button, both subtle and medium, which is the pairing the region is spaced for. |
| Trailing actions | Slot-Menu-Actions, consumer owned | Takes icon actions after search. The content in it by default is two Icon Buttons at the same size and flavour. |
| Search | Search, parent owned | Held at medium with its shape following Rounded. It comes from a separate library rather than this file, so it has no frame here. |
| App switcher | Icon Button, parent owned | An Apps glyph on a subtle medium Icon Button. The glyph is fixed, so this is a product switcher rather than a general purpose action. |
| Menu button | Icon Button, parent owned | A Hamburger glyph at the leading edge. It carries no visibility toggle, so it is always present. |
| Account control | _User Profile, parent owned | A username, an avatar and a chevron, wired as the trigger of Template/Dropdown. Neither the username nor the avatar is exposed as an input. |
| Dividers | Divider, parent owned | Two vertical hairlines shown together by one toggle. They stretch to the height of the content row. |

### Anatomy

1. **Bar** — The surface itself, one row of content padded on every side and holding its three regions a shared gutter apart.
2. **Leading group** — The menu button, the brand mark and the product name. It hugs its content, so a longer product name takes width from the middle.
3. **Middle band** — Navigation, search and the trailing actions. It fills whatever the two end groups leave and packs its content to the trailing edge.
4. **Account group** — The account control and the app switcher, hugging their content at the end of the bar.
5. **Dividers** — Two vertical hairlines, one before the middle band and one after it. Both are off by default and appear together.

### How to use

**Do:**
- Set Rounded once on the header and let it carry. Every control inside follows it, so the bar stays consistent without touching each one.
- Keep PlatformName to the product's name. It sits beside the mark as identity and should not change as a person moves around the product.

**Don't:**
- Don't fill a menu slot and leave its toggle off. Slot-Menu-Items and Slot-Menu-Actions only appear when MenuItems and ActionMenu are on.
- Don't lean on search to absorb a wider viewport. It holds a fixed width, so the navigation region is the part that grows.

### Accessibility & Content Guidelines

- The header is a landmark rather than a control, so it takes its role and its name from the page around it, and the navigation region inside it needs one of its own. Every control in the bar carries a glyph and no visible label, so the menu button, the app switcher and the trailing actions each need an accessible name supplied where they are placed. The account control is a dropdown trigger, so it has to announce both the person it represents and the fact that it opens a menu. Focus is the only state on that control that draws a visible border, which makes the border/focus outline the one thing a keyboard user has to locate it by.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Filled width, hug height | 100% wide and 56 tall on both variants, with the content row inside standing at control/md. |
| Direction | Row | Leading group, middle band and account group on one line, space/gutter apart, with space/sm padding on every side of the bar. |
| Leading group | Hug | space/gutter between the menu button, the brand mark and the product name. |
| Middle band | Fill | Takes the width the two end groups leave, spaces its children space/sm apart, and packs them to its trailing edge. |
| Navigation region | Fill | Takes the width spare inside the middle band, with space/2xs between its controls. |
| Action region | Hug | Hugs its controls with space/2xs between them, which is why it never takes width from search. |
| Search | Set to medium | Its shape follows Rounded and its size is held at medium. The header gives it a maximum 280 in the middle band, so it does not stretch with the bar. |
| Account group | Hug | space/gutter between the account control and the app switcher. |
| Controls | Set per variant | The icon buttons are set to medium and subtle. The account control is control/md tall and hugs its width, padded space/xxs and space/sm with space/xxs between its parts. |
| Radius | Per Rounded | radius/none throughout when false. When true the bar takes radius/element-sm and every nested control is set to its rounded shape, while the account control takes radius/sm. |
| Surface | Tokenised | surface/section on the bar. The icon buttons are set to the subtle flavour, and the account control carries the neutral interactive backgrounds. |
| Text | Tokenised | The product name is title/medium in foreground/primary. The username is label/small, dropping to interactive/ghost/foreground/disabled when the account control is disabled. |
| Account states | Per State | interactive/neutral/background at default, hover, pressed, focused and disabled. focus adds a border/focus stroke at 1 wide, and every other state carries interactive/neutral/border/default at zero weight. |
| Dividers | Fill height | Set to vertical and stretching to the height of the content row. The two of them appear together. |
| Theme/Mode | Frozen in Dark Mode | The global header is frozen in dark mode irrespective of the page mode, except a mode override is set on the global header itself. |

### Layer structure

- Global Header (COMPONENT)
  - Global Header/Header-Left (FRAME)
    - Global Header/Header-Left/Icon Button (INSTANCE)
    - Global Header/Header-Left/Slot Logo (SLOT)
    - Global Header/Header-Left/Platform Name (TEXT)
  - Global Header/Divider[1] (INSTANCE)
  - Global Header/Header-Middle (FRAME)
    - Global Header/Header-Middle/Slot-Menu-Items (SLOT)
    - Global Header/Header-Middle/Search (INSTANCE)
    - Global Header/Header-Middle/Slot-Menu-Actions (SLOT)
  - Global Header/Divider[2] (INSTANCE)
  - Global Header/Header-Right (FRAME)
    - Global Header/Header-Right/Template/Dropdown (INSTANCE)
    - Global Header/Header-Right/Icon Button (INSTANCE)

### Resolved tokens (default variant: Rounded=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Global Header | fill[0] | #0c0d0e | surface.section |
| Global Header | stroke[0] | #545963 | border.default |
| Global Header | strokeWeight | 0 | stroke.base |
| Global Header | itemSpacing | 16 | space.gutter |
| Global Header | padding.left | 8 | space.sm |
| Global Header | padding.right | 8 | space.sm |
| Global Header | padding.top | 8 | space.sm |
| Global Header | padding.bottom | 8 | space.sm |
| Global Header/Header-Left | itemSpacing | 16 | space.gutter |
| Global Header/Header-Left/Icon Button | width | 40 | control.md |
| Global Header/Header-Left/Icon Button | height | 40 | control.md |
| Global Header/Header-Left/Icon Button | fill[0] | #d6dce200 | interactive.ghost.background.default |
| Global Header/Header-Left/Icon Button | stroke[0] | #545963 | interactive.neutral.border.default |
| Global Header/Header-Left/Icon Button | cornerRadius | 0 | radius.none |
| Global Header/Header-Left/Icon Button | strokeWeight | 0 | stroke.base |
| Global Header/Header-Left/Icon Button | padding.left | 4 | space.xxs |
| Global Header/Header-Left/Icon Button | padding.right | 4 | space.xxs |
| Global Header/Header-Left/Icon Button | padding.top | 4 | space.xxs |
| Global Header/Header-Left/Icon Button | padding.bottom | 4 | space.xxs |
| Global Header/Header-Left/Platform Name | fill[0] | #ffffff | foreground.primary |
| Global Header/Header-Left/Platform Name | fontSize | 16 | title.medium.font size |
| Global Header/Header-Left/Platform Name | lineHeight | 20 | title.medium.line height |
| Global Header/Header-Left/Platform Name | letterSpacing | 0 | title.medium.letter spacing |
| Global Header/Divider[1] | width | 1 | stroke.thin |
| Global Header/Divider[1] | cornerRadius | 0 | radius.none |
| Global Header/Header-Middle | itemSpacing | 8 | space.sm |
| Global Header/Header-Middle/Slot-Menu-Items | itemSpacing | 2 | space.2xs |
| Global Header/Header-Middle/Search | height | 40 | — |
| Global Header/Header-Middle/Search | fill[0] | #ffffff | — |
| Global Header/Header-Middle/Search | stroke[0] | #ced2db | — |
| Global Header/Header-Middle/Search | cornerRadius | 0 | — |
| Global Header/Header-Middle/Search | strokeWeight | 1 | — |
| Global Header/Header-Middle/Search | itemSpacing | 4 | — |
| Global Header/Header-Middle/Search | padding.left | 12 | — |
| Global Header/Header-Middle/Search | padding.right | 12 | — |
| Global Header/Header-Middle/Search | padding.top | 8 | — |
| Global Header/Header-Middle/Search | padding.bottom | 8 | — |
| Global Header/Header-Middle/Slot-Menu-Actions | itemSpacing | 2 | space.2xs |
| Global Header/Divider[2] | width | 1 | stroke.thin |
| Global Header/Divider[2] | cornerRadius | 0 | radius.none |
| Global Header/Header-Right | itemSpacing | 16 | space.gutter |
| Global Header/Header-Right/Icon Button | width | 40 | control.md |
| Global Header/Header-Right/Icon Button | height | 40 | control.md |
| Global Header/Header-Right/Icon Button | fill[0] | #d6dce200 | interactive.ghost.background.default |
| Global Header/Header-Right/Icon Button | stroke[0] | #545963 | interactive.neutral.border.default |
| Global Header/Header-Right/Icon Button | cornerRadius | 0 | radius.none |
| Global Header/Header-Right/Icon Button | strokeWeight | 0 | stroke.base |
| Global Header/Header-Right/Icon Button | padding.left | 4 | space.xxs |
| Global Header/Header-Right/Icon Button | padding.right | 4 | space.xxs |
| Global Header/Header-Right/Icon Button | padding.top | 4 | space.xxs |
| Global Header/Header-Right/Icon Button | padding.bottom | 4 | space.xxs |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Rounded | true | Global Header | cornerRadius | radius.element-sm |
| Rounded | true | Global Header/Header-Left/Icon Button | cornerRadius | radius.element-sm |
| Rounded | true | Global Header/Header-Middle/Search | cornerRadius | radius.element-sm |
| Rounded | true | Global Header/Header-Right/Icon Button | cornerRadius | radius.element-sm |

## _User Profile

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=2742-885&m=dev

### Layer structure

- _User Profile (COMPONENT)
  - _User Profile/Username (TEXT)
  - _User Profile/Avatar (INSTANCE)
  - _User Profile/Icon (INSTANCE, icon: expand_more)

### Resolved tokens (default variant: State=Default, Rounded=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _User Profile | height | 40 | control.md |
| _User Profile | fill[0] | #ffffff | interactive.neutral.background.default |
| _User Profile | stroke[0] | #ced2db | interactive.neutral.border.default |
| _User Profile | cornerRadius | 0 | radius.none |
| _User Profile | strokeWeight | 0 | stroke.base |
| _User Profile | itemSpacing | 4 | space.xxs |
| _User Profile | padding.left | 8 | space.sm |
| _User Profile | padding.right | 8 | space.sm |
| _User Profile | padding.top | 4 | space.xxs |
| _User Profile | padding.bottom | 4 | space.xxs |
| _User Profile/Username | fill[0] | #0c0d0e | foreground.primary |
| _User Profile/Username | fontSize | 12 | label.small.font size |
| _User Profile/Username | lineHeight | 16 | label.small.line height |
| _User Profile/Username | letterSpacing | 0 | label.small.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| State | hover | _User Profile | fill[0] | interactive.neutral.background.hover |
| State | focus | _User Profile | fill[0] | interactive.neutral.background.focused |
| State | focus | _User Profile | stroke[0] | border.focus |
| State | focus | _User Profile | strokeWeight | stroke.thin |
| State | pressed | _User Profile | fill[0] | interactive.neutral.background.pressed |
| State | disabled | _User Profile | fill[0] | interactive.neutral.background.disabled |
| State | disabled | _User Profile | stroke[0] | interactive.neutral.border.disabled |
| State | disabled | _User Profile/Username | fill[0] | interactive.ghost.foreground.disabled |
| Rounded | true | _User Profile | cornerRadius | radius.sm |
