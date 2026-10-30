# Avatar

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=2364-6017&m=dev

## Avatar

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=4906-1172&m=dev

### Overview

A visual representation of a user or entity, shown as a photo, initials, or icon, with an optional status indicator. Nine sizes step from xxxsmall to xxxlarge with medium as the base, and the badges, ring and glyphs all scale from that step. The status badge carries a distinct glyph per state as well as its colour. Content type isn't an exposed property, swap the nested Avatar Type instance directly to change it. For a notification count on an icon or nav item, use the Notification Indicator component instead, Avatar's own indicator is for presence, not counts.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Size | xxxsmall | true | The smallest step, for dense inline contexts like compact tables or comment threads. The presence glyph is only a few pixels across here, so do not rely on anyone reading it. |
| Size | xxsmall | - | A step up from xxxsmall, still compact, for dense lists. |
| Size | xsmall | - | For secondary avatars in tight layouts, like a stacked group of collaborators. |
| Size | small | - | For list rows and menu items where the avatar sits alongside text. |
| Size | medium | - | The base step, and a balanced general-purpose choice for cards and list headers. Every other size is scaled from it, so start here unless something specific argues otherwise. |
| Size | large | - | For emphasis in a card header or a comment's author avatar. |
| Size | xlarge | - | For a prominent single avatar, like a user menu or account switcher. |
| Size | xxlarge | - | For profile headers where the avatar is a focal point. |
| Size | xxxlarge | - | The largest step, for full profile pages or standalone display. The close glyph does not grow with its badge at this size, so check it still reads as a target. |
| Show Close | true | true | Shows a dismiss badge pinned to the top-right corner. Use in removable contexts, like a multi-select chip list. |
| Show Close | false | - | Hides the dismiss badge. The default for most read-only contexts where the avatar isn't removable. |
| Show Status | true | true | Shows a presence badge pinned to the bottom-right corner, defaulting to Available. The badge is an exposed instance, so its state is reachable in the properties panel without detaching or hunting for the nested layer. |
| Show Status | false | - | Hides the presence badge. Use when presence doesn't apply, like a generic entity avatar or a purely illustrative photo. |
| Show Ring | true | true | Shows a border/default outline ring around the avatar, weight scales with Size. |
| Show Ring | false | - | Hides the ring. Use on backgrounds where the outline competes with surrounding content. |
| Status | Available | true | The person is reachable now. It is the default, so an avatar whose presence never updates will keep claiming availability it cannot back up. Turn Show Status off rather than leaving a stale Available. |
| Status | Away | - | Signed in but idle. Only use it where the system can actually detect idleness, otherwise it reads as a guess the viewer will trust. |
| Status | Busy | - | Reachable but occupied. It describes the person, where DND describes what their notifications are doing, so the two are not interchangeable. |
| Status | DND | - | Notifications are suppressed by the person's own choice. Use it only when something really is being suppressed, because it tells the viewer a message may never surface. |
| Status | On Shift | - | Working a scheduled shift, for rota-based contexts. Outside a shift-based product it reads as a second word for Available and dilutes both. |
| Status | Offline | - | Not reachable. It is the one state drawn as a hollow badge rather than a filled one, so it stays tellable apart when colour is unreliable. |
| Status | Close | - | Not a presence state. It is a dismiss mark that happens to live in the same component, and Avatar already uses it for the top-right badge. Setting the bottom-right Status to Close puts two dismiss marks on one avatar. |
| Status | Icon | - | Hands the glyph over to the Custom Icon property for a meaning outside the presence set. Everything a viewer has learned from the other seven states stops applying, so use it rarely. |
| Custom Icon | instance swap | Star | Takes effect only while Status is Icon, where it replaces the built-in glyph. The suggested list holds just the Star set, though any component can be swapped in. A custom glyph carries none of the shared meaning the named states have, so it needs a text equivalent beside it. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| Static | — | — | Avatar has no hover, pressed, or focus states in Figma. Close and Status are static badges that change only with the Status property, so whatever click behaviour Close has in a real interface lives in code rather than here. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | None modeled in Figma. Avatar is presented as a static graphic, any transition when swapping Size, content, or toggling Show Close, Show Status, or Show Ring lives in code. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Content type | fixed per instance | Initials, photo, or icon. Not an exposed property, swap the nested Avatar Type instance directly to change it. |
| Swatch color | fixed per instance, 7 options | Background color behind initials or an icon (purple, blue, sea, yellow, orange, green, burgundy, using chart/series tokens). Not used behind a photo. Swap the nested Swatch instance directly. |
| Photo | instance swap, 40 named options | Used only when Content type is photo, fills the circle. In Figma swap the nested Photo instance to any of the named photos in _Avatar Photos. In code any image can be passed as an image property. |
| Status | exposed nested instance, 8 states | Holds one of eight states from the _Status Indicator component, each drawn with its own glyph from the Assets library. The instance is exposed, so the state is set from Avatar's own properties panel without detaching. Only rendered while Show Status is true. |
| Custom Icon | instance swap, any component | The glyph used while Status is Icon. Any component can be swapped in and the suggested list holds only the Star set, so nothing constrains it to a presence-shaped mark. |

### Anatomy

1. **Avatar Type** — Fills the frame, auto-positioned. Holds initials with a colored swatch, a photo, or an icon with a colored swatch. Not an exposed property, swap the nested instance directly
2. **Ring** — An absolute-positioned outline matching the frame's edges. border/default color, stroke only. Weight scales proportionally with Size, 2px at medium
3. **Close** — Pinned to the top-right corner. An instance of the Status Indicator component's Close variant, shown or hidden with Show Close
4. **Status** — Pinned to the bottom-right corner, defaults to Available. Shown or hidden with Show Status. The instance is exposed, so its state, and for the Icon state its glyph, are reachable directly.

### How to use

**Do:**
- Match Size to context, dense lists and tables call for the smaller sizes (xxxsmall to small), profile headers and standalone display call for the larger ones (xlarge to xxxlarge).
- Turn off Show Status for generic entities or purely illustrative photos where presence doesn't apply.

**Don't:**
- Don't use the presence Status badge for unread or notification counts, that's a different purpose, use the Notification Indicator component instead.

### Accessibility & Content Guidelines

- Purely visual, an avatar image or initials alone don't convey a name, pair it with visible text or provide an accessible name in code
- Each presence state now carries its own glyph as well as its colour, so the badge no longer depends on colour alone. Still give it a text equivalent, because at the smallest sizes the glyph is only a few pixels across
- The Close badge implies a dismiss action, give it an accessible name in code like "Remove [name]", Figma has no interactive state for it
- The close glyph is drawn at a fixed size whatever the avatar, so on the largest avatars it sits very small inside its badge. Check it still reads as a target

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Fixed per Size, medium is the base | Nine fixed squares stepping 24, 32, 36, 40, 48, 64, 80, 120 and 200px, with medium at 48px as the base. Medium is the only step bound to a token (control/lg), every other step is an authored value. Not resizable independently of the Size property. |
| Badge size | Scales with Size, medium is the base | The Status and Close badges are 16px at medium, exactly one third of the avatar, and step 8, 10, 12, 12, 16, 18, 24, 36 and 56px across the ladder. Above medium they grow more slowly than the avatar, so a large avatar is never dominated by its badge. |
| Badge glyph | Scales with the badge | The status glyph holds a constant share of its badge at every size, 0.42 of the badge width, so it stays proportional from 24px through 200px. The close glyph is drawn at a fixed 5px at every size, so its share of the badge falls from two thirds at xxxsmall to under a tenth at xxxlarge. |
| Ring weight | Scales per Size tier, medium is the base | 2px (stroke/thick) at medium and every step below it, 4px (stroke/heavy) at large and xlarge, then 6px and 8px at xxlarge and xxxlarge. The two heaviest weights are authored values rather than tokens. |
| Close and Status position | Fixed | Pinned flush to the top-right and bottom-right corners, inset by exactly the badge's own width so both sit inside the avatar's bounds at every size. They scale in position as the avatar resizes and do not move independently. |
| Color | Theming | Ring uses border/default. Each status draws its circle from a chart token, chart/positive for Available, chart/negative for Busy and chart/series steps for the rest, with the glyph on foreground/inverse. Offline inverts that pair, a foreground/inverse circle carrying a foreground/secondary glyph. Swatch colours use chart/series. All resolve separately for light and dark mode. |

### Layer structure

- Avatar (COMPONENT)
  - Avatar/Avatar Type (INSTANCE)
  - Avatar/Ring (ELLIPSE)
  - Avatar/Close (INSTANCE)
  - Avatar/Status (INSTANCE)

### Resolved tokens (default variant: Size=xxxsmall)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Avatar/Ring | stroke[0] | #ced2db | border.default |
| Avatar/Ring | strokeWeight | 1 | — |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Size | medium | Avatar | width | control.lg |
| Size | medium | Avatar/Ring | strokeWeight | stroke.thick |

## _Avatar Swatch

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=2695-17235&m=dev

### Layer structure

- _Avatar Swatch (COMPONENT)
  - _Avatar Swatch/swatch (ELLIPSE)

### Resolved tokens (default variant: Color=purple)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Avatar Swatch/swatch | fill[0] | #7e0cff | chart.series.4 |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Color | blue | _Avatar Swatch/swatch | fill[0] | chart.series.1 |
| Color | sea | _Avatar Swatch/swatch | fill[0] | chart.series.9 |
| Color | yellow | _Avatar Swatch/swatch | fill[0] | chart.series.7 |
| Color | orange | _Avatar Swatch/swatch | fill[0] | chart.series.11 |
| Color | green | _Avatar Swatch/swatch | fill[0] | chart.series.6 |
| Color | burgundy | _Avatar Swatch/swatch | fill[0] | chart.series.5 |

## _Avatar Photos

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=2695-17612&m=dev

### Layer structure

- _Avatar Photos (COMPONENT)
  - _Avatar Photos/Photo (ELLIPSE)

### Resolved tokens (default variant: Name=Ophelia McKenna)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |

## _Avatar Type

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=2697-17618&m=dev

### Layer structure

- _Avatar Type (COMPONENT)
  - _Avatar Type/Swatch (INSTANCE)
  - _Avatar Type/AA (TEXT)
  - _Avatar Type/Photo (INSTANCE)
  - _Avatar Type/Icon (INSTANCE, icon: verified)

### Resolved tokens (default variant: Type=initials)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Avatar Type/AA | fill[0] | #ffffff | — |
| _Avatar Type/AA | fontSize | 16 | label.large.font size |
| _Avatar Type/AA | lineHeight | 24 | label.large.line height |
| _Avatar Type/AA | letterSpacing | 0 | label.large.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Type | photo | _Avatar Type/AA | fontSize | — |
| Type | photo | _Avatar Type/AA | lineHeight | — |
| Type | photo | _Avatar Type/AA | letterSpacing | — |
| Type | Icon | _Avatar Type/AA | fontSize | — |
| Type | Icon | _Avatar Type/AA | lineHeight | — |
| Type | Icon | _Avatar Type/AA | letterSpacing | — |

## _Status Indicator

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=2699-17716&m=dev

### Layer structure

- _Status Indicator (COMPONENT)
  - _Status Indicator/Fill (ELLIPSE)
  - _Status Indicator/Void (VECTOR)
  - _Status Indicator/Icon (INSTANCE)
  - _Status Indicator/Custom Icon (INSTANCE)

### Resolved tokens (default variant: Status=Available)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Status Indicator/Fill | fill[0] | #00864f | chart.positive |
| _Status Indicator/Void | fill[0] | #ffffff | foreground.inverse |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Status | Away | _Status Indicator/Fill | fill[0] | chart.series.8 |
| Status | Busy | _Status Indicator/Fill | fill[0] | chart.negative |
| Status | DND | _Status Indicator/Fill | fill[0] | chart.series.4 |
| Status | On Shift | _Status Indicator/Fill | fill[0] | chart.series.1 |
| Status | Offline | _Status Indicator/Fill | fill[0] | foreground.inverse |
| Status | Offline | _Status Indicator/Void | fill[0] | foreground.secondary |
| Status | Close | _Status Indicator/Fill | fill[0] | chart.series.12 |
| Status | Icon | _Status Indicator/Fill | fill[0] | chart.series.1 |

## Avatar Rail

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6494-1953&m=dev

### Overview

Shows a group of people as overlapping avatars, with an optional counter standing in for everyone who did not fit. Up to four avatars are carried, the first two always and the last two by choice, and Size moves the whole rail together rather than any single avatar. Use it where the group matters more than the individuals, and for a single Avatar where one person is the subject.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Size | xxxsmall | true | The smallest step, for a rail sitting inside a dense row such as a table cell. |
| Size | xxsmall | - | A step up, still for compact rows where the group is secondary to the text beside it. |
| Size | xsmall | - | For secondary groups in a list, where the rail supports the row rather than leading it. |
| Size | small | - | For list rows and menu items where the people are part of the point rather than decoration. |
| Size | medium | - | The balanced step, and the right choice where the rail stands on its own inside a card. |
| Size | large | - | For emphasis in a card header, where the group is the subject of the block. |
| Size | xlarge | - | For a prominent group on a detail page. |
| Size | xxlarge | - | For a header where the people are the main content rather than a supporting detail. |
| Size | xxxlarge | - | The largest step, for a full width header. The rail grows quickly at this end, so check it still fits its column before using it. |
| Stacking | start | true | The first avatar sits above the ones after it, so the group reads left to right with the earliest person shown whole. |
| Stacking | end | - | Reverses it, so the last position is the one shown whole. Use it where the counter should sit on top of the stack rather than beneath it. |
| Show Overflow | true | true | Keeps the counter at the end, standing in for everyone not shown. In code it appears only when there are more avatars than Max. |
| Show Overflow | false | - | Drops it. Only safe where the rail shows the whole group, because without the counter a trimmed group reads as complete. |
| Max | 2 to 4 | 4 | Code only. How many avatars the rail shows, with the first two always present. Figma has no Max property and sets the same thing with Show Avatar 3 and Show Avatar 4. Everyone past Max is counted into the overflow, as the avatars passed in less Max, so a group of six at Max 4 reads +2 and at Max 3 reads +3. |
| Overflow Count | text | +2 | Figma only. How many people the rail is not showing, typed by hand in Figma. In code it is not a property: the rail generates it from Max, as the avatars passed in less Max. It is a remainder rather than a total, so a group of six shown four at a time reads +2 and never 6. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| Static | — | — | The rail has no interaction states. Nothing answers hover, focus or press, and the avatars inside it carry none either. |
| Stacking | The Stacking value | — | Only the paint order changes. Positions, diameters and the overlap all hold, so the two values differ solely in which edge of each avatar is covered. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | No transition is defined. Changing Size or Stacking is a static swap. |
| Overlap | The quarter diameter overlap is what makes the rail read as one group rather than a row of separate avatars. Spacing them apart turns the same content into a list of individuals. |
| Composition limits | Four positions and a counter, with the first two always present. A group of one belongs in a single Avatar, and a group too large for four belongs in the counter rather than in a longer rail. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Avatar slots | nested Avatar | Up to four positions, each an Avatar, the first two always present. In code Max sets how many show (2 to 4); in Figma, Show Avatar 3 and Show Avatar 4 do. |
| Avatar properties | parent owned | The rail turns off the ring and the dismiss badge on every avatar and surfaces none of Avatar's own properties except the status badge. The person shown is set on the nested avatar, and everything else is left to the rail so the group stays uniform. Avatar Metadata covers what an Avatar offers on its own terms. |
| Overflow | drawn | A circle at the end of the rail, drawn by the rail rather than taken in. It is not an Avatar, so it carries no person, no photo and no presence. |
| Overflow Count | text property (Figma only) | Figma only, typed by hand through Overflow Count. In code the count is generated from Max and the avatars passed in, so there is no count to set. Keep it short, because the circle holding it does not grow. |

### Anatomy

1. **Avatar 1 and 2** — The two positions always present. The rail does not go below two people. (Figma only)
2. **Avatar 3 and 4** — The two optional positions, each toggled on its own, so a rail can carry two, three or four. (Figma Only)
3. **Overlap** — Each avatar covers a quarter of the one beside it. Stacking decides which of the two is on top.
4. **Overflow** — The counter standing in for everyone not shown, drawn by the rail rather than taken in as an Avatar.

### How to use

**Do:**
- Keep Show Overflow on whenever the group is larger than the rail shows. Without the counter a trimmed group reads as the whole group.
- Let Size move the whole rail. Every avatar takes the same diameter, so the step is a decision about the group and not about any one person in it.

**Don't:**
- Don't use the rail to show one person. A single Avatar is the component for that, and a rail of one has an overlap that never happens.

### Accessibility & Content Guidelines

- The rail is a group and the counter at the end is part of what it says. A reader who gets only the avatars gets a smaller group than the real one.
- The counter is a bare number. Something has to say what it counts, because +2 on its own does not say two more people.
- Avatars overlap by a quarter, so part of each one is always covered. Check initials still read at the smallest step, where the diameter is 24.
- The rail turns the presence badge off on every avatar, so presence is not available here. Anything depending on it needs a different arrangement.
- Nothing in the rail is focusable and nothing announces itself. Where people join or leave the group while a person is on the page, the structure around it has to report that.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Fixed per Size | Nine steps, 24, 32, 36, 40, 48, 60, 80, 120 and 200 square. Every avatar in the rail takes the same diameter, so the step is a decision about the group rather than about any one person in it. |
| Overlap | Derived from Size | Each avatar sits over the one before it by a quarter of a diameter, from 6 at the smallest step to 50 at the largest. The overlap scales with the avatar rather than holding one fixed value, so the rail reads the same at every size. |
| Overall width | Hug | Four times the diameter when all five positions are filled, from 96 at the smallest to 800 at the largest. Each position after the first adds three quarters of a diameter, so dropping one takes exactly that much back. |
| Overflow | Fixed | A circle matching the avatar diameter, at radius/pill on feedback/neutral/background/subtle. It does not grow with its text, so a longer count has to fit the circle rather than widen it. |
| Count | Scales with Size | Centred in the overflow circle and scaling with the rail rather than holding one size across the nine steps. |
| Paint order | Per Stacking | start paints each avatar above the one after it and end reverses that. Nothing moves and nothing resizes, only which edge of each avatar is the covered one. |

### Layer structure

- Avatar Rail (COMPONENT)
  - Avatar Rail/Avatar 1 (INSTANCE)
  - Avatar Rail/Avatar 2 (INSTANCE)
  - Avatar Rail/Avatar 3 (INSTANCE)
  - Avatar Rail/Avatar 4 (INSTANCE)
  - Avatar Rail/Overflow (FRAME)
    - Avatar Rail/Overflow/Count (TEXT)

### Resolved tokens (default variant: Size=xxxsmall, Stacking=start)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Avatar Rail | itemSpacing | -6 | — |
| Avatar Rail/Avatar 1 | stroke[0] | #ffffff | border.inverse |
| Avatar Rail/Avatar 1 | cornerRadius | 4999.5 | radius.pill |
| Avatar Rail/Avatar 1 | strokeWeight | 1 | — |
| Avatar Rail/Avatar 2 | stroke[0] | #ffffff | border.inverse |
| Avatar Rail/Avatar 2 | cornerRadius | 4999.5 | radius.pill |
| Avatar Rail/Avatar 2 | strokeWeight | 1 | — |
| Avatar Rail/Avatar 3 | stroke[0] | #ffffff | border.inverse |
| Avatar Rail/Avatar 3 | cornerRadius | 4999.5 | radius.pill |
| Avatar Rail/Avatar 3 | strokeWeight | 1 | — |
| Avatar Rail/Avatar 4 | stroke[0] | #ffffff | border.inverse |
| Avatar Rail/Avatar 4 | cornerRadius | 4999.5 | radius.pill |
| Avatar Rail/Avatar 4 | strokeWeight | 1 | — |
| Avatar Rail/Overflow | fill[0] | #f8fbff | feedback.neutral.background.subtle |
| Avatar Rail/Overflow | stroke[0] | #ced2db | border.default |
| Avatar Rail/Overflow | cornerRadius | 9999 | radius.pill |
| Avatar Rail/Overflow | strokeWeight | 1 | — |
| Avatar Rail/Overflow/Count | fill[0] | #0c0d0e | foreground.primary |
| Avatar Rail/Overflow/Count | fontSize | 8 | — |
| Avatar Rail/Overflow/Count | lineHeight | 12 | — |
| Avatar Rail/Overflow/Count | letterSpacing | 0 | — |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Size | medium | Avatar Rail | itemSpacing | space.neg.xl |
| Size | medium | Avatar Rail/Avatar 1 | strokeWeight | stroke.thick |
| Size | medium | Avatar Rail/Avatar 1 | width | control.lg |
| Size | medium | Avatar Rail/Avatar 2 | strokeWeight | stroke.thick |
| Size | medium | Avatar Rail/Avatar 2 | width | control.lg |
| Size | medium | Avatar Rail/Avatar 3 | strokeWeight | stroke.thick |
| Size | medium | Avatar Rail/Avatar 3 | width | control.lg |
| Size | medium | Avatar Rail/Avatar 4 | strokeWeight | stroke.thick |
| Size | medium | Avatar Rail/Avatar 4 | width | control.lg |
| Size | medium | Avatar Rail/Overflow | strokeWeight | stroke.thick |
| Size | medium | Avatar Rail/Overflow | width | control.lg |
| Size | medium | Avatar Rail/Overflow | height | control.lg |
| Size | medium | Avatar Rail/Overflow/Count | fontSize | label.large.font size |
| Size | medium | Avatar Rail/Overflow/Count | lineHeight | label.large.line height |
| Size | medium | Avatar Rail/Overflow/Count | letterSpacing | label.large.letter spacing |
