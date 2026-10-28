# Input Select

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6597-3495&m=dev

## Input / Select

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6601-110&m=dev

### Layer structure

- Input / Select (COMPONENT)
  - Input / Select/Leading-Icon (INSTANCE, icon: email)
  - Input / Select/Input Text (FRAME)
    - Input / Select/Input Text/Placeholder (TEXT)
    - Input / Select/Input Text/Value (TEXT)
  - Input / Select/Chevron (INSTANCE, icon: expand_more)

### Resolved tokens (default variant: Size=medium, Shape=rounded, State=enabled, Flavour=default)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Input / Select | height | 40 | control.md |
| Input / Select | fill[0] | #ffffff | interactive.neutral.background.default |
| Input / Select | stroke[0] | #ced2db | interactive.neutral.border.default |
| Input / Select | cornerRadius | 4 | radius.sm |
| Input / Select | strokeWeight | 1 | stroke.thin |
| Input / Select | itemSpacing | 4 | space.xxs |
| Input / Select | padding.left | 12 | space.md |
| Input / Select | padding.right | 12 | space.md |
| Input / Select | padding.top | 8 | space.sm |
| Input / Select | padding.bottom | 8 | space.sm |
| Input / Select/Input Text | padding.left | 4 | space.xxs |
| Input / Select/Input Text | padding.right | 4 | space.xxs |
| Input / Select/Input Text/Placeholder | fill[0] | #8d95a3 | foreground.disabled |
| Input / Select/Input Text/Placeholder | fontSize | 16 | body.medium.font size |
| Input / Select/Input Text/Placeholder | lineHeight | 24 | body.medium.line height |
| Input / Select/Input Text/Placeholder | letterSpacing | 0 | body.medium.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Size | large | Input / Select | height | control.lg |
| Size | small | Input / Select | height | control.sm |
| Size | small | Input / Select/Input Text/Placeholder | fontSize | body.small.font size |
| Size | small | Input / Select/Input Text/Placeholder | lineHeight | body.small.line height |
| Size | small | Input / Select/Input Text/Placeholder | letterSpacing | body.small.letter spacing |
| Shape | sharp | Input / Select | cornerRadius | radius.none |
| Shape | full | Input / Select | cornerRadius | radius.pill |
| State | hover | Input / Select | stroke[0] | interactive.neutral.border.hover |
| State | focus | Input / Select | stroke[0] | border.focus |
| State | focus | Input / Select | strokeWeight | stroke.thick |
| State | open | Input / Select | stroke[0] | border.focus |
| State | filled | Input / Select/Input Text/Placeholder | fill[0] | — |
| State | filled | Input / Select/Input Text/Placeholder | fontSize | — |
| State | filled | Input / Select/Input Text/Placeholder | lineHeight | — |
| State | filled | Input / Select/Input Text/Placeholder | letterSpacing | — |
| State | filled | Input / Select/Input Text/Value | fill[0] | foreground.primary |
| State | filled | Input / Select/Input Text/Value | fontSize | body.medium.font size |
| State | filled | Input / Select/Input Text/Value | lineHeight | body.medium.line height |
| State | filled | Input / Select/Input Text/Value | letterSpacing | body.medium.letter spacing |
| State | invalid | Input / Select | stroke[0] | border.error |
| State | invalid | Input / Select/Input Text/Placeholder | fill[0] | — |
| State | invalid | Input / Select/Input Text/Placeholder | fontSize | — |
| State | invalid | Input / Select/Input Text/Placeholder | lineHeight | — |
| State | invalid | Input / Select/Input Text/Placeholder | letterSpacing | — |
| State | invalid | Input / Select/Input Text/Value | fill[0] | foreground.primary |
| State | invalid | Input / Select/Input Text/Value | fontSize | body.medium.font size |
| State | invalid | Input / Select/Input Text/Value | lineHeight | body.medium.line height |
| State | invalid | Input / Select/Input Text/Value | letterSpacing | body.medium.letter spacing |
| State | read-only | Input / Select | stroke[0] | border.subtle |
| State | read-only | Input / Select/Input Text/Placeholder | fill[0] | — |
| State | read-only | Input / Select/Input Text/Placeholder | fontSize | — |
| State | read-only | Input / Select/Input Text/Placeholder | lineHeight | — |
| State | read-only | Input / Select/Input Text/Placeholder | letterSpacing | — |
| State | read-only | Input / Select/Input Text/Value | fill[0] | foreground.primary |
| State | read-only | Input / Select/Input Text/Value | fontSize | body.medium.font size |
| State | read-only | Input / Select/Input Text/Value | lineHeight | body.medium.line height |
| State | read-only | Input / Select/Input Text/Value | letterSpacing | body.medium.letter spacing |
| State | disabled | Input / Select | fill[0] | interactive.neutral.background.disabled |
| State | disabled | Input / Select | stroke[0] | interactive.neutral.border.disabled |
| State | disabled | Input / Select/Input Text/Placeholder | fill[0] | — |
| State | disabled | Input / Select/Input Text/Placeholder | fontSize | — |
| State | disabled | Input / Select/Input Text/Placeholder | lineHeight | — |
| State | disabled | Input / Select/Input Text/Placeholder | letterSpacing | — |
| State | disabled | Input / Select/Input Text/Value | fill[0] | foreground.disabled |
| State | disabled | Input / Select/Input Text/Value | fontSize | body.medium.font size |
| State | disabled | Input / Select/Input Text/Value | lineHeight | body.medium.line height |
| State | disabled | Input / Select/Input Text/Value | letterSpacing | body.medium.letter spacing |
| Flavour | gradient | Input / Select | stroke[0] | linear-gradient(90deg, foreground.gradient.start 0%, foreground.gradient.end 100%) |
| Flavour | ghost | Input / Select | fill[0] | — |
| Flavour | ghost | Input / Select | stroke[0] | interactive.ghost.border.default |
| Flavour | ghost | Input / Select | strokeWeight | stroke.base |

## Select

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6602-712&m=dev

### Overview

The full select assembly: a label above, a Select Field in the middle and a hint below, stacked and spaced as one unit. The Open property switches the assembly between its closed state and its open state, which reveals the dropdown menu overlapping the region below. The label and hint can each be turned off. Reach for it wherever a dropdown needs a name or supporting text, and reach for Select Field on its own where it needs neither.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Open | false | true | The closed state. The nested Select Field is set to State=enabled and the dropdown menu instance is hidden. |
| Open | true | - | The open state. The nested Select Field switches to State=open and the dropdown menu becomes visible. The menu is absolutely positioned at base . It overlaps the hint region and any content below the element. |
| Show Label | true | true | The label sits above the field and names it. Keep it on, because the placeholder text disappears the moment a value is selected. |
| Show Label | false | - | Drops the label from the stack. Only safe where something else nearby already names the field, and the name must still reach assistive technology through another means. |
| Show Hint | true | true | Keeps the supporting line below the field. Leaving it on reserves the space before validation is needed and prevents layout shift when an error message appears. |
| Show Hint | false | - | Drops the hint and shortens the stack. A select that can fail validation then has nowhere to put the reason, and turning the line back on later moves everything below it. |
| Label / Type | default | true | The plain name with nothing after it. |
| Label / Type | optional | - | Appends (optional) after the name. Use when most other selects in the form are required, so the exception is what is marked. |
| Label / Type | required | - | Adds an asterisk after the name. Use only where submission genuinely fails without a chosen value. |
| Label / Show Information | false | true | No information icon, which is the default state for Select. |
| Label / Show Information | true | - | Adds an information icon after the label name, for context the label itself has no room for. The icon requires a label and target in the implementation. |
| Hint / Type | default | true | The resting supporting line, for guidance about what to choose. |
| Hint / Type | error | - | The validation message that says what went wrong. The Select Field border carries the signal via State=invalid; this carries the reason. Neither works alone. |
| Hint / Type | disabled | - | Dims the hint line to sit with a disabled select field. |
| Hint / Show Icon | true | true | Keeps an icon ahead of the hint message. Especially important at Type=error so the validation state is perceived before the words are read. |
| Hint / Show Icon | false | - | Message only, no leading icon. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| enabled | Default / resting | — | Placeholder text visible. Border at interactiveNeutralBorderDefault. Chevron pointing down. |
| hover | Set on the nested field | — | Only the nested field is affected and behavior is inherited from it |
| focus | Set on the nested field | — | Inherited from the nested field |
| open | Assembly Open=true + nested field State=open | — | Dropdown menu becomes visible, absolutely positioned at below the field. Assembly height does not grow. |
| filled | Set on the nested field | — | Text changes from foregroundDisabled (placeholder) to foregroundPrimary (selected value). |
| invalid | Set on the element | — | Border switches to borderError. The hint is set to Type=error independently. One supplies the visual signal, the other the reason text — neither implies the other. |
| disabled | Set on the element | — | Inherited by all nested component |
| read-only | Set on the nested field only | — | Only the field carries this state. The label stays at full strength, which is correct: the name of a value worth reading is still worth reading. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | No transition is defined on the assembly. Each nested part swaps its own tokens on state change. There are no authored prototype interactions. |
| Composition | Three parts stacked vertically with 4px gap, height hugging all visible parts. Turning off the label or the hint removes its height and the stack shortens. Whatever sits below moves up. |
| Dropdown overlap | When Open=true the dropdown menu is absolutely positioned 4px below the field's bottom edge, inheriting the select width and clips content. The assembly height does not increase; the menu is overlaid and does not determine assembly height. Implementations must reserve z-order and spacing so the open menu does not obscure adjacent content. |
| Dropdown width | The dropdown menu has a flexible width, matching the assembly. |
| State coordination | These ae the assembly-level state that cascades to nested parts. Invalid, disabled and read-only. |
| Chevron direction | Closed variants use ExpandMore (chevron down). Open variants use ExpandLess (chevron up). This swap is authored in the component variants. |

### Content & Slot

| Slot | Component | Description |
| --- | --- | --- |
| Label | Input Label, toggled by Show Label | The field's name. Carries required/optional marker and information icon. The assembly exposes only its visibility; the marker, dimming and icon are all set on the label sub-component directly. |
| Field | Input / Select | The control. Arrives at Size=medium, Shape=rounded, State=enabled, Flavour=default, hasLeading=false, placeholder "Select an option." All of its own properties (Size, Shape, State, Flavour, hasLeading) are set here. |
| Dropdown Menu | Dropdown Menu, Rounded=true | Absolutely positioned 4px below the field's bottom edge. Visible only when Open=true. Contains slot containers for options. Option labels, values and slot content come from the implementation. |
| Hint | Input Hint, toggled by Show Hint | Supporting line below the field. Guidance at rest; the validation reason when its Type is error. The icon toggle is on the hint sub-component, not the assembly. |
| Placeholder vs Value | Text in field — not parameterised | Enabled/focus states show placeholder ("Select an option") in foregroundDisabled. Filled/open states show the selected value in foregroundPrimary. The actual label text, hint text, option labels, selected value and error message are all implementation concerns, not assembly inputs. |

### Anatomy

1. **Label** — The field's name, turned on by Show Label. Carries the required/optional marker and the information icon.
2. **Select Field** — The control. Size, Shape, State and Flavour are all set on this nested component, not on the assembly. Trailing chevron always present.
3. **Hint** — Supporting line, turned on by Show Hint. Guidance at rest; validation message when Type=error on the hint.
4. **Dropdown Menu (open only)** — Absolutely positioned 4px below the field's bottom edge. Overlaid and does not determine assembly height. Contains Menu Items via slot. Width is inherited from field width.

### How to use

**Do:**
- Field name * Select an option Choose the most relevant option Keep Show Label on. The placeholder disappears as soon as a value is selected, leaving nothing to name the field. Always pair Show Hint=true on fields that can be validated so space is reserved before a message is needed.
- Field name Option A Please select a valid option Set the nested field to State=invalid and the hint to Type=error together. The field border carries the visual signal; the hint carries the reason. Either alone is an incomplete message.

**Don't:**
- Select an option Don't remove the label from a visible select. There is no built-in name for the field once the placeholder is gone, and assistive technology has nothing to announce.
- Field name Value Don't leave the label at full strength while the field is disabled. Set Label Disabled=true and Hint Type=disabled together. There is no automatic coordination — mismatched states create contrast inconsistencies.

### Accessibility & Content Guidelines

- The label is the select's accessible name. Show Label controls only visual presence. A select without a visible label still needs its name to reach assistive technology — use aria-label or aria-labelledby in the implementation.
- The placeholder "Select an option" is decorative until a value is chosen. Do not rely on it as an accessible name; it disappears from view once State=filled.
- Keyboard behavior is an implementation requirement: Space or Enter should open the dropdown, Arrow keys should move between options, Enter should confirm, Escape should close and return focus to the trigger.
- The dropdown menu must be associated with the trigger via aria-haspopup="listbox", aria-expanded, and aria-controls in the implementation. The Figma component does not produce these attributes.
- Each menu item requires a role="option" and the selected option aria-selected="true". Visual indication of the selected state is not authored in this component; the implementation must add it.
- The required marker is an asterisk and a color. Neither alone is accessible; the required constraint must be conveyed via aria-required="true" on the control in the implementation.
- A validation message in the hint must be associated with the select via aria-describedby or a live region, otherwise it is announced as loose text with nothing tying it to the field that failed.
- The information icon on the label has no text content. If it triggers a tooltip or disclosure, give it an accessible name and a keyboard-reachable target in the implementation.
- Check the full stack at a given state. A disabled field under a full-strength label is a contrast mismatch and the Figma assembly does not flag it automatically.
- Label text should be concise, noun-first, and sentence case. Avoid starting with a verb. Hint text should be short enough to fit on one line at the field's width; multi-line hints increase the stack height unexpectedly.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Assembly size | Fill width × hug height | Assembly height is derived from the nested input/field Size variant plus visible label and hint content, plus the 4px gaps between them. The field fills the assembly width; the label and hint hug their content. The total stack height is relational and depends on which parts are visible. |
| Gap | space/xs = 4 | 4px between all three parts. The same gap the field uses internally between its icons and its text, so the stack and its content share one rhythm. |
| Label | Hug width and height | Hugs its text. A space/xs gap between name, any marker and the information icon. |
| Field | Fill width | Fills the assembly width. Height is determined by its Size property. Label and hint hug their content; only the field tracks the container width. |
| Hint | Hug width and height | Hugs its content. 4px gap between optional icon and message text. Smaller than the field text so the selected value is the loudest element in the stack. |
| Dropdown Menu | Overlaid / out of normal flow | The dropdown is absolutely positioned and overlaid. Its top edge is 4px below the field's bottom edge. It does not affect assembly height; the assembly height remains determined by the visible label, field, hint, and gaps. Height is determined by the number of visible menu items. |
| Colour | Semantic tokens | Label uses foregroundPrimary, drops to foregroundDisabled when Disabled=true. Field border uses interactiveNeutralBorderDefault at rest, interactiveNeutralBorderHover on hover, borderFocus on focus/open, borderError on invalid, and interactiveNeutralBorderDisabled on disabled. Placeholder text uses foregroundDisabled; selected value uses foregroundPrimary. The dropdown menu surface uses surfaceMenu with a medium shadow. |

### Layer structure

- Select (COMPONENT)
  - Select/Label (INSTANCE)
  - Select/Field (INSTANCE)
  - Select/Hint (INSTANCE)
  - Select/Dropdown Menu (INSTANCE)

### Resolved tokens (default variant: Open=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Select | itemSpacing | 4 | space.xxs |
| Select/Label | itemSpacing | 4 | space.xxs |
| Select/Field | height | 40 | control.md |
| Select/Field | fill[0] | #ffffff | interactive.neutral.background.default |
| Select/Field | stroke[0] | #ced2db | interactive.neutral.border.default |
| Select/Field | cornerRadius | 4 | radius.sm |
| Select/Field | strokeWeight | 1 | stroke.thin |
| Select/Field | itemSpacing | 4 | space.xxs |
| Select/Field | padding.left | 12 | space.md |
| Select/Field | padding.right | 12 | space.md |
| Select/Field | padding.top | 8 | space.sm |
| Select/Field | padding.bottom | 8 | space.sm |
| Select/Hint | itemSpacing | 4 | space.xxs |
| Select/Dropdown Menu | fill[0] | #ffffff | surface.menu |
| Select/Dropdown Menu | cornerRadius | 6 | radius.element-md |
| Select/Dropdown Menu | itemSpacing | 2 | space.2xs |
| Select/Dropdown Menu | padding.left | 12 | space.card |
| Select/Dropdown Menu | padding.right | 12 | space.card |
| Select/Dropdown Menu | padding.top | 12 | space.card |
| Select/Dropdown Menu | padding.bottom | 12 | space.card |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Open | true | Select/Field | stroke[0] | border.focus |

## Select Field (documentation only)

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6597-3495&m=dev

### Overview

The select control on its own, without a label or hint around it. One model covers the select interaction pattern, with Size, Shape, State and Flavour that differ only in border, surface, text strength and chevron orientation. Reach for it directly when a field needs no label or supporting text, and reach for Select when it does.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Size | medium | true | The default, for surfaces and toolbars where the field sits alongside other controls. |
| Size | large | - | For a more prominent field or a roomier control density. |
| Size | small | - | The tightest, and the only size that also reduces the text. |
| Shape | rounded | true | The default softened corners, matching the surrounding rounded controls. |
| Shape | sharp | - | Square corners, for surfaces built from sharp-edged controls. |
| Shape | full | - | A pill, for a field that reads as its own object on a surface rather than one row of a form. |
| State | enabled | true | The resting empty field, showing its placeholder and waiting. |
| State | hover | - | Pointer over the field. The border is the only thing that answers. |
| State | focus | - | The field has keyboard focus and is ready for input. It carries the heaviest border in the set, so it stays findable where several fields sit together. |
| State | open | - | The field is expanded and the chevron points up. The border stays at focus weight and the popup is shown. |
| State | filled | - | A committed value. The field is at rest again but the text stays at full strength, which is what separates it from enabled. |
| State | invalid | - | The value failed validation. The border carries the signal and nothing else does, so pairing it with a Hint set to error is what makes the problem readable. |
| State | read-only | - | The value is shown but cannot be changed. Reach for it where a person still needs to read or copy the value, and reach for disabled where they do not. |
| State | disabled | - | The field cannot be used and is out of the tab order. Both the surface and the border drop away, so it reads as out of play rather than merely empty. |
| Flavour | default | true | A bordered field on a neutral surface, and the right choice inside a form. |
| Flavour | gradient | - | For a unique interaction highlight, such as an AI companion field. It marks the field as special, so using it on an ordinary field spends that signal for nothing. |
| Flavour | ghost | - | No visible border at rest, for a field sitting on a surface that already bounds it. On an unbounded surface it stops reading as a field at all. |
| hasLeading | false | true | No leading icon, which is where the field starts. The text begins at the padding edge and takes the full width. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| enabled | — | — | The resting empty field. interactive/neutral/border/default at 1px on an interactive/neutral/background/default surface, with the placeholder at foreground/disabled. |
| hover | Pointer over the field | — | The border moves to interactive/neutral/border/hover. Surface and text hold. |
| focus | Keyboard focus | — | The border becomes border/focus at 2px, double its resting weight. The field is ready for input but the placeholder still reads as a placeholder. |
| open | Keyboard open or click | — | The border stays at focus weight and the chevron points up. The popup is shown below the field. |
| filled | A committed value | — | The border returns to interactive/neutral/border/default while the text stays at foreground/primary. The chevron returns to down. |
| invalid | Validation failed | — | The border moves to border/error. The text stays at foreground/primary, so the border carries the whole signal and the Hint beneath it carries the reason. |
| read-only | Presented but not editable | — | The border drops to border/subtle and the value stays at foreground/primary. Still legible and still selectable, which is what separates it from disabled. |
| disabled | — | — | Surface and border move to interactive/neutral/background/disabled and interactive/neutral/border/disabled, and the text and every icon drop to foreground/disabled. The whole control recedes. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | No transition is defined. Each state is a swap of border colour, border weight, text colour and, at open, chevron orientation. |
| Keyboard behavior | Open on Alt+Down or Enter, navigate with Up/Down, commit with Enter and close with Escape. The field itself does not implement this behavior; the parent Select handles keyboard interaction. |
| Expanded semantics | The field is the trigger, but the popup and options belong to the parent Select. The field itself has no option slots or menu. |
| Validation association | invalid changes the border colour and nothing else. The reason belongs in the Hint set to error, and the field has to be associated with it for the message to be announced. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Display text | not parameterised | The placeholder before selection and the chosen value afterward. Neither is exposed as an input on the field, so both come from the implementation. |
| Leading icon | nested Icon, toggled by hasLeading | Off by default. When on it takes an Icon at Size=medium, 20 square, and the glyph is swappable through the Icon's own Name property. |
| Trailing chevron | always present | Points down in all states except open, where it points up. It is decorative within a single trigger and does not expose a separate toggle. |

### Anatomy

1. **Optional leading icon** — Off by default, and an Icon at Size=medium when hasLeading turns it on.
2. **Display text** — The placeholder, and then the value once one is entered. It fills whatever width the icons leave.
3. **Trailing chevron** — Always present, pointing down in all states except open, where it points up.

### How to use

**Do:**
- Pair invalid with a Hint set to error. The border colour is the only thing invalid changes, so on its own it says something is wrong without saying what.
- Use read-only when the value should remain legible and selectable, but not editable. Native select has no readonly attribute; use an appropriate non-editable presentation pattern instead.

**Don't:**
- Don't reach for disabled where a person still needs to read the value. read-only keeps it legible and selectable, disabled puts it out of reach and out of the tab order.
- Don't lean on the placeholder as the label. It clears the moment typing starts, so whatever it was carrying disappears exactly when it is needed.

### Accessibility & Content Guidelines

- The field carries no label of its own. Select pairs it with Select Label, and a field used on its own still needs a name from the implementation.
- A placeholder is not a label. It clears the moment a value is entered, so anything a reader has to keep is not safe there.
- invalid changes the border colour and nothing else. The reason belongs in the Hint set to error, and the field has to be associated with it for the message to be announced.
- read-only and disabled look alike and behave differently. read-only keeps the value reachable and selectable, disabled takes the control out of the tab order.
- The leading icon and the chevron are glyphs with no text. Each needs a name, and the chevron needs one that says it opens or closes the options.
- At small the text drops to 14px and the control to 36 tall. Check the trailing chevron still offers a large enough target at that height.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Fixed | 280 wide and fixed, so the container sets the width rather than the content. Height is bound per size, control/lg at large for 48, control/md at medium for 40 and control/sm at small for 36. |
| Padding and gap | Fixed | space/sm top and bottom, space/md left and right, with a space/xs gap between the leading icon, the text and the trailing control. Padding holds across all three sizes, so height alone carries the density. |
| Radius | Per Shape | radius/none when sharp, radius/sm when rounded and radius/pill when full. The four corners are bound individually rather than as a single value. |
| Surface | Per Flavour | interactive/neutral/background/default on default and gradient, moving to interactive/neutral/background/disabled when disabled. Ghost carries no surface of its own, so whatever sits behind it shows through. |
| Border | Per Flavour | Default draws at 1px and rises to 2px on focus. Gradient keeps those weights and draws its border from the gradient tokens: a foreground/gradient/start to foreground/gradient/end gradient at rest and when filled, border/gradient/end on hover and border/gradient/start when selected or typing. Focus, invalid, read-only and disabled use the same tokens as default. Ghost holds a bound border at zero weight, which is a theming hook rather than an absent border, so a high contrast variable set can give it a hard outline. |
| Text | Theming | body/medium at 16px for large and medium, body/small at 14px for small. The colour changes with state, which States and Triggers sets out. |
| Icons and controls | Fixed | Every icon is Size=medium at 20 square at large and medium, and Size=small at 16 square at small, and the inner text frame fills whatever width they leave. At large one icon costs 24 including its gap, taking the text from 254 to 230, and two take it to 206. Every icon and control, leading, trailing, the type control and clear, draws foreground/primary like the value, and foreground/disabled when the field is disabled. |
