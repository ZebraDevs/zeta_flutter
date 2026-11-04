# Top App Bar

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3108-191&m=dev

## Top App Bar

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=3116-1217&m=dev

### Overview

The header at the top of a mobile screen, carrying the screen’s name between a leading control and whatever actions the screen needs. Type switches it between six arrangements: a standard title row, a centred title, two selection toolbars, a full width search field, and a taller layout that drops the title onto its own line. Each arrangement brings its own leading control and its own content, so changing Type replaces what the bar holds rather than rearranging it.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Type | default | true | Use for an ordinary screen that needs a title and a few actions. It is the only arrangement that carries an avatar beside the title. |
| Type | centered | — | Use where the title should read as the screen’s name rather than a label beside controls. It allows one trailing control, so a screen needing several will not fit. |
| Type | contextual | — | Use while items are selected and the bar becomes a toolbar for them. Its count is fixed content, so it does not report the real selection. |
| Type | contextual alt | — | Use for the same selection toolbar where the count needs to be settable. The count sits inside a button, so it reads as something to press. |
| Type | search | — | Use when search takes over the whole bar. It drops the title and every action but the back control, so nothing else is reachable while searching. |
| Type | extended | — | Use where the title needs a line of its own below the controls. It is taller than the other five, so a layout assuming one bar height will shift. |
| Shape | sharp | true | Use where the bar meets the screen edges and reads as part of the chrome. |
| Shape | rounded | — | Use where the bar sits inside a padded surface. It rounds the bar’s own corner only, and the controls inside keep the shape they already have. |
| Page Title | text | Title | Names the screen. It is read by default, centered and extended only, so setting it on the other three changes nothing. |
| Contextual Control Slot | slot | — | Takes the actions offered while items are selected. It exists on contextual and contextual alt, and nowhere else. |
| Trailing Slot | slot | — | Takes the trailing actions on an ordinary screen. It exists on default and extended, and nowhere else. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| Static | — | — | The bar has no interaction states. Hover, focus and press belong to the controls placed inside it. |
| Type | The Type value | — | Each value replaces the bar’s contents rather than repositioning them. The leading control, the title treatment and which slot exists all change together. |
| Shape | The Shape value | — | The bar’s own corner, and nothing else. The controls inside hold the shape they were given either way. |
| Leading control | The Type value | — | A hamburger on default, centered and extended. A close on contextual and contextual alt. A back arrow on search. |
| Title treatment | The Type value | — | default and extended set the title a step larger than centered. contextual shows a fixed count in its place, and contextual alt shows that count inside a button. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | No transition is defined. Changing Type replaces the bar’s contents outright, and nothing animates between one arrangement and the next. |
| Type is a content switch | Type does not rearrange one set of parts. Each value brings its own leading control, its own middle content and its own slot, so moving between values is a replacement rather than a reflow. |
| Shape does not carry | Shape sets the bar’s corner on its own. The nested controls are rounded in both values, so a sharp bar still contains rounded controls. |
| Height | Five arrangements stand at one height. extended is taller because it puts the title on a second row beneath the controls. |
| Slot availability | The two slots are never both present. Each Type offers at most one of them, and centered and search offer neither. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Screen title | Page Title, text | Consumer owned on default, centered and extended. The other three arrangements draw no title, so the property has nowhere to land. |
| Trailing actions | Trailing Slot, consumer owned | Present on default and extended. The content in it by default is three icon buttons set to small and subtle. |
| Contextual actions | Contextual Control Slot, consumer owned | Present on contextual and contextual alt. The content in it by default is four icon buttons set to small and subtle. |
| Centered trailing | Parent owned | centered holds a single icon button rather than a slot, so its trailing action is fixed rather than passed in. |
| Leading control | Icon Button, parent owned | Set to small and subtle on every arrangement. Its glyph is decided by Type and is not exposed as an input. |
| Avatar | Parent owned | default carries a small photo avatar beside the title. It is not exposed as an input, and no other arrangement has one. |
| Selection count | Parent owned | contextual draws a fixed count as plain text. contextual alt puts the same count inside a button, where it is that button’s own label. |
| Search field | Search, parent owned | Set to small and ghost, and carried already in its typing state with text and a cursor in place. |

### Anatomy

1. **Bar** — The surface itself, holding one content row padded on every side. extended adds a second row beneath it.
2. **Leading control** — An icon button at the start of the bar. Which glyph it carries is decided by Type, not passed in.
3. **Title** — The screen’s name. It is present on default, centered and extended, and centered sets it a step smaller than the other two.
4. **Trailing region** — Either a slot, a single fixed control, or nothing at all, depending on Type.
5. **Second row** — extended only. The title moves off the control row onto a line of its own, which is what makes that arrangement taller.

### How to use

**Do:**
- Pick Type for what the screen is doing. Each value is a different arrangement with its own content, not a styling choice applied to one layout.
- Keep Page Title to the screen's name. It is the bar's only text input, and it reads as the screen's identity rather than as a label.

**Don't:**
- Don't set Page Title on contextual, contextual alt or search. Those arrangements draw no title, so the text has nowhere to appear.
- Don't expect Shape to reshape the controls. It sets the bar's own corner, and the icon buttons inside stay rounded either way.

### Accessibility & Content Guidelines

- The bar is a landmark rather than a control, so it takes its role and its name from the screen around it. Every control in it carries a glyph and no visible label, so the leading control and each trailing action need an accessible name supplied where they are placed, and that name has to follow Type, since the same leading position is a menu, a dismiss and a back control depending on the arrangement. The title is the screen’s name and should match whatever the screen is announced as, so a person arriving by screen reader hears the same thing a sighted person reads. On the selection arrangements the count is the only report of how many items are held, so it needs to be announced when it changes rather than only drawn.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Fixed width, hug height | 390 wide on every variant. 60 tall on five arrangements and 100 on extended, which carries a second row. |
| Direction | Column | A content row, with extended adding a title row beneath it. space/sm between rows, and space/lg on extended. |
| Padding | Tokenised | space/md above and below, space/sm on both sides. |
| Content row | Fill | Spreads its leading group and its trailing region to opposite ends. search instead lays its two parts out from the start, space/md apart. |
| Leading group | Fill | space/md between the leading control and whatever follows it. |
| Leading control | Set to small | An icon button set to small and subtle on every arrangement. |
| Trailing region | Hug | Hugs its content on default, extended, contextual and contextual alt. centered instead holds one control that fills the row height. |
| Search field | Set to small | Fills the width left beside the back control, set to small and ghost. |
| Surface | Tokenised | surface/section across every arrangement. |
| Radius | Per Shape | radius/element-sm on rounded. sharp carries a plain zero corner with no token bound to it. |
| Title | Per Type | label/large on default and extended, label/medium on centered. The title colour is set directly rather than bound to a token. |
| Selection count | Per Type | label/medium on contextual, also set directly rather than bound. On contextual alt it comes from the button and takes interactive/neutral/foreground/default. |

### Layer structure

- Top App Bar (COMPONENT)
  - Top App Bar/Main (FRAME)
    - Top App Bar/Main/Frame 2 (FRAME)
      - Top App Bar/Main/Frame 2/Icon Button (INSTANCE)
      - Top App Bar/Main/Frame 2/Page Header (FRAME)
        - Top App Bar/Main/Frame 2/Page Header/Avatar (INSTANCE)
        - Top App Bar/Main/Frame 2/Page Header/Page Title (FRAME)
          - Top App Bar/Main/Frame 2/Page Header/Page Title/Title (TEXT)
    - Top App Bar/Main/Trailing Slot (SLOT)
    - Top App Bar/Main/Trailing (FRAME)
      - Top App Bar/Main/Trailing/Icon Button (INSTANCE)
    - Top App Bar/Main/Frame 3 (FRAME)
      - Top App Bar/Main/Frame 3/Icon Button (INSTANCE)
      - Top App Bar/Main/Frame 3/Contextual Details (FRAME)
        - Top App Bar/Main/Frame 3/Contextual Details/Count (FRAME)
          - Top App Bar/Main/Frame 3/Contextual Details/Count/2 Items (TEXT)
      - Top App Bar/Main/Frame 3/Button (INSTANCE)
    - Top App Bar/Main/Contextual Control Slot (SLOT)
    - Top App Bar/Main/Frame 4 (FRAME)
      - Top App Bar/Main/Frame 4/Icon Button (INSTANCE)
      - Top App Bar/Main/Frame 4/Contextual Details (FRAME)
        - Top App Bar/Main/Frame 4/Contextual Details/Count (FRAME)
          - Top App Bar/Main/Frame 4/Contextual Details/Count/2 Items (TEXT)
    - Top App Bar/Main/Icon Button (INSTANCE)
    - Top App Bar/Main/Search (INSTANCE)
  - Top App Bar/Page Title (FRAME)
    - Top App Bar/Page Title/Title (TEXT)

### Resolved tokens (default variant: Type=default, Shape=sharp)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Top App Bar | fill[0] | #ffffff | surface.section |
| Top App Bar | itemSpacing | 8 | space.sm |
| Top App Bar | padding.left | 8 | space.sm |
| Top App Bar | padding.right | 8 | space.sm |
| Top App Bar | padding.top | 12 | space.md |
| Top App Bar | padding.bottom | 12 | space.md |
| Top App Bar/Main/Frame 2 | itemSpacing | 12 | space.md |
| Top App Bar/Main/Frame 2/Icon Button | width | 36 | control.sm |
| Top App Bar/Main/Frame 2/Icon Button | height | 36 | control.sm |
| Top App Bar/Main/Frame 2/Icon Button | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| Top App Bar/Main/Frame 2/Icon Button | stroke[0] | #ced2db | interactive.neutral.border.default |
| Top App Bar/Main/Frame 2/Icon Button | cornerRadius | 4 | radius.element-sm |
| Top App Bar/Main/Frame 2/Icon Button | strokeWeight | 0 | stroke.base |
| Top App Bar/Main/Frame 2/Icon Button | padding.left | 4 | space.2xs |
| Top App Bar/Main/Frame 2/Icon Button | padding.right | 4 | space.2xs |
| Top App Bar/Main/Frame 2/Icon Button | padding.top | 4 | space.2xs |
| Top App Bar/Main/Frame 2/Icon Button | padding.bottom | 4 | space.2xs |
| Top App Bar/Main/Frame 2/Page Header | itemSpacing | 8 | space.sm |
| Top App Bar/Main/Frame 2/Page Header/Page Title | itemSpacing | 8 | space.sm |
| Top App Bar/Main/Frame 2/Page Header/Page Title/Title | fill[0] | #000000 | — |
| Top App Bar/Main/Frame 2/Page Header/Page Title/Title | fontSize | 16 | label.large.font size |
| Top App Bar/Main/Frame 2/Page Header/Page Title/Title | lineHeight | 24 | label.large.line height |
| Top App Bar/Main/Frame 2/Page Header/Page Title/Title | letterSpacing | 0 | label.large.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Type | centered | Top App Bar/Main/Frame 2/Page Header/Page Title/Title | fontSize | label.medium.font size |
| Type | centered | Top App Bar/Main/Frame 2/Page Header/Page Title/Title | lineHeight | label.medium.line height |
| Type | centered | Top App Bar/Main/Frame 2/Page Header/Page Title/Title | letterSpacing | label.medium.letter spacing |
| Type | centered | Top App Bar/Main/Trailing/Icon Button | width | control.sm |
| Type | centered | Top App Bar/Main/Trailing/Icon Button | height | control.sm |
| Type | centered | Top App Bar/Main/Trailing/Icon Button | fill[0] | interactive.ghost.background.default |
| Type | centered | Top App Bar/Main/Trailing/Icon Button | stroke[0] | interactive.neutral.border.default |
| Type | centered | Top App Bar/Main/Trailing/Icon Button | cornerRadius | radius.element-sm |
| Type | centered | Top App Bar/Main/Trailing/Icon Button | strokeWeight | stroke.base |
| Type | centered | Top App Bar/Main/Trailing/Icon Button | padding.left | space.2xs |
| Type | centered | Top App Bar/Main/Trailing/Icon Button | padding.right | space.2xs |
| Type | centered | Top App Bar/Main/Trailing/Icon Button | padding.top | space.2xs |
| Type | centered | Top App Bar/Main/Trailing/Icon Button | padding.bottom | space.2xs |
| Type | contextual | Top App Bar/Main/Frame 2 | itemSpacing | — |
| Type | contextual | Top App Bar/Main/Frame 2/Icon Button | width | — |
| Type | contextual | Top App Bar/Main/Frame 2/Icon Button | height | — |
| Type | contextual | Top App Bar/Main/Frame 2/Icon Button | fill[0] | — |
| Type | contextual | Top App Bar/Main/Frame 2/Icon Button | stroke[0] | — |
| Type | contextual | Top App Bar/Main/Frame 2/Icon Button | cornerRadius | — |
| Type | contextual | Top App Bar/Main/Frame 2/Icon Button | strokeWeight | — |
| Type | contextual | Top App Bar/Main/Frame 2/Icon Button | padding.left | — |
| Type | contextual | Top App Bar/Main/Frame 2/Icon Button | padding.right | — |
| Type | contextual | Top App Bar/Main/Frame 2/Icon Button | padding.top | — |
| Type | contextual | Top App Bar/Main/Frame 2/Icon Button | padding.bottom | — |
| Type | contextual | Top App Bar/Main/Frame 2/Page Header | itemSpacing | — |
| Type | contextual | Top App Bar/Main/Frame 2/Page Header/Page Title | itemSpacing | — |
| Type | contextual | Top App Bar/Main/Frame 2/Page Header/Page Title/Title | fontSize | — |
| Type | contextual | Top App Bar/Main/Frame 2/Page Header/Page Title/Title | lineHeight | — |
| Type | contextual | Top App Bar/Main/Frame 2/Page Header/Page Title/Title | letterSpacing | — |
| Type | contextual | Top App Bar/Main/Frame 3/Icon Button | width | control.sm |
| Type | contextual | Top App Bar/Main/Frame 3/Icon Button | height | control.sm |
| Type | contextual | Top App Bar/Main/Frame 3/Icon Button | fill[0] | interactive.ghost.background.default |
| Type | contextual | Top App Bar/Main/Frame 3/Icon Button | stroke[0] | interactive.neutral.border.default |
| Type | contextual | Top App Bar/Main/Frame 3/Icon Button | cornerRadius | radius.element-sm |
| Type | contextual | Top App Bar/Main/Frame 3/Icon Button | strokeWeight | stroke.base |
| Type | contextual | Top App Bar/Main/Frame 3/Icon Button | padding.left | space.2xs |
| Type | contextual | Top App Bar/Main/Frame 3/Icon Button | padding.right | space.2xs |
| Type | contextual | Top App Bar/Main/Frame 3/Icon Button | padding.top | space.2xs |
| Type | contextual | Top App Bar/Main/Frame 3/Icon Button | padding.bottom | space.2xs |
| Type | contextual | Top App Bar/Main/Frame 3/Contextual Details | itemSpacing | space.sm |
| Type | contextual | Top App Bar/Main/Frame 3/Contextual Details/Count | itemSpacing | space.sm |
| Type | contextual | Top App Bar/Main/Frame 3/Contextual Details/Count/2 Items | fontSize | label.medium.font size |
| Type | contextual | Top App Bar/Main/Frame 3/Contextual Details/Count/2 Items | lineHeight | label.medium.line height |
| Type | contextual | Top App Bar/Main/Frame 3/Contextual Details/Count/2 Items | letterSpacing | label.medium.letter spacing |
| Type | contextual alt | Top App Bar/Main/Frame 2 | itemSpacing | — |
| Type | contextual alt | Top App Bar/Main/Frame 2/Icon Button | width | — |
| Type | contextual alt | Top App Bar/Main/Frame 2/Icon Button | height | — |
| Type | contextual alt | Top App Bar/Main/Frame 2/Icon Button | fill[0] | — |
| Type | contextual alt | Top App Bar/Main/Frame 2/Icon Button | stroke[0] | — |
| Type | contextual alt | Top App Bar/Main/Frame 2/Icon Button | cornerRadius | — |
| Type | contextual alt | Top App Bar/Main/Frame 2/Icon Button | strokeWeight | — |
| Type | contextual alt | Top App Bar/Main/Frame 2/Icon Button | padding.left | — |
| Type | contextual alt | Top App Bar/Main/Frame 2/Icon Button | padding.right | — |
| Type | contextual alt | Top App Bar/Main/Frame 2/Icon Button | padding.top | — |
| Type | contextual alt | Top App Bar/Main/Frame 2/Icon Button | padding.bottom | — |
| Type | contextual alt | Top App Bar/Main/Frame 2/Page Header | itemSpacing | — |
| Type | contextual alt | Top App Bar/Main/Frame 2/Page Header/Page Title | itemSpacing | — |
| Type | contextual alt | Top App Bar/Main/Frame 2/Page Header/Page Title/Title | fontSize | — |
| Type | contextual alt | Top App Bar/Main/Frame 2/Page Header/Page Title/Title | lineHeight | — |
| Type | contextual alt | Top App Bar/Main/Frame 2/Page Header/Page Title/Title | letterSpacing | — |
| Type | contextual alt | Top App Bar/Main/Frame 3 | itemSpacing | space.md |
| Type | contextual alt | Top App Bar/Main/Frame 3/Button | height | control.sm |
| Type | contextual alt | Top App Bar/Main/Frame 3/Button | fill[0] | interactive.ghost.background.default |
| Type | contextual alt | Top App Bar/Main/Frame 3/Button | stroke[0] | interactive.neutral.border.default |
| Type | contextual alt | Top App Bar/Main/Frame 3/Button | cornerRadius | radius.element-sm |
| Type | contextual alt | Top App Bar/Main/Frame 3/Button | strokeWeight | stroke.base |
| Type | contextual alt | Top App Bar/Main/Frame 3/Button | padding.left | space.md |
| Type | contextual alt | Top App Bar/Main/Frame 3/Button | padding.right | space.md |
| Type | contextual alt | Top App Bar/Main/Frame 3/Button | padding.top | space.2xs |
| Type | contextual alt | Top App Bar/Main/Frame 3/Button | padding.bottom | space.2xs |
| Type | search | Top App Bar/Main | itemSpacing | space.md |
| Type | search | Top App Bar/Main/Frame 2 | itemSpacing | — |
| Type | search | Top App Bar/Main/Frame 2/Icon Button | width | — |
| Type | search | Top App Bar/Main/Frame 2/Icon Button | height | — |
| Type | search | Top App Bar/Main/Frame 2/Icon Button | fill[0] | — |
| Type | search | Top App Bar/Main/Frame 2/Icon Button | stroke[0] | — |
| Type | search | Top App Bar/Main/Frame 2/Icon Button | cornerRadius | — |
| Type | search | Top App Bar/Main/Frame 2/Icon Button | strokeWeight | — |
| Type | search | Top App Bar/Main/Frame 2/Icon Button | padding.left | — |
| Type | search | Top App Bar/Main/Frame 2/Icon Button | padding.right | — |
| Type | search | Top App Bar/Main/Frame 2/Icon Button | padding.top | — |
| Type | search | Top App Bar/Main/Frame 2/Icon Button | padding.bottom | — |
| Type | search | Top App Bar/Main/Frame 2/Page Header | itemSpacing | — |
| Type | search | Top App Bar/Main/Frame 2/Page Header/Page Title | itemSpacing | — |
| Type | search | Top App Bar/Main/Frame 2/Page Header/Page Title/Title | fontSize | — |
| Type | search | Top App Bar/Main/Frame 2/Page Header/Page Title/Title | lineHeight | — |
| Type | search | Top App Bar/Main/Frame 2/Page Header/Page Title/Title | letterSpacing | — |
| Type | search | Top App Bar/Main/Icon Button | width | control.sm |
| Type | search | Top App Bar/Main/Icon Button | height | control.sm |
| Type | search | Top App Bar/Main/Icon Button | fill[0] | interactive.ghost.background.default |
| Type | search | Top App Bar/Main/Icon Button | stroke[0] | interactive.neutral.border.default |
| Type | search | Top App Bar/Main/Icon Button | cornerRadius | radius.element-sm |
| Type | search | Top App Bar/Main/Icon Button | strokeWeight | stroke.base |
| Type | search | Top App Bar/Main/Icon Button | padding.left | space.2xs |
| Type | search | Top App Bar/Main/Icon Button | padding.right | space.2xs |
| Type | search | Top App Bar/Main/Icon Button | padding.top | space.2xs |
| Type | search | Top App Bar/Main/Icon Button | padding.bottom | space.2xs |
| Type | search | Top App Bar/Main/Search | height | control.sm |
| Type | search | Top App Bar/Main/Search | fill[0] | interactive.ghost.background.default |
| Type | search | Top App Bar/Main/Search | stroke[0] | border.focus |
| Type | search | Top App Bar/Main/Search | cornerRadius | radius.element-sm |
| Type | search | Top App Bar/Main/Search | strokeWeight | stroke.base |
| Type | search | Top App Bar/Main/Search | itemSpacing | space.2xs |
| Type | search | Top App Bar/Main/Search | padding.left | space.md |
| Type | search | Top App Bar/Main/Search | padding.right | space.md |
| Type | search | Top App Bar/Main/Search | padding.top | space.sm |
| Type | search | Top App Bar/Main/Search | padding.bottom | space.sm |
| Type | extended | Top App Bar | itemSpacing | space.lg |
| Type | extended | Top App Bar/Main/Frame 2/Page Header | itemSpacing | — |
| Type | extended | Top App Bar/Main/Frame 2/Page Header/Page Title | itemSpacing | — |
| Type | extended | Top App Bar/Main/Frame 2/Page Header/Page Title/Title | fontSize | — |
| Type | extended | Top App Bar/Main/Frame 2/Page Header/Page Title/Title | lineHeight | — |
| Type | extended | Top App Bar/Main/Frame 2/Page Header/Page Title/Title | letterSpacing | — |
| Type | extended | Top App Bar/Page Title | itemSpacing | space.sm |
| Type | extended | Top App Bar/Page Title | padding.left | space.sm |
| Type | extended | Top App Bar/Page Title | padding.right | space.sm |
| Type | extended | Top App Bar/Page Title/Title | fontSize | label.large.font size |
| Type | extended | Top App Bar/Page Title/Title | lineHeight | label.large.line height |
| Type | extended | Top App Bar/Page Title/Title | letterSpacing | label.large.letter spacing |
| Shape | rounded | Top App Bar | cornerRadius | radius.element-sm |
