# Screen Header Bar

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5712-290&m=dev

## Screen Header Bar

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=5712-3566&m=dev

### Overview

The bar at the top of a screen, carrying a back affordance, the screen's title and one action. It holds a single slot on the right, so it suits a screen with exactly one primary action rather than a toolbar of several. Use Top App Bar when the screen needs more than one action or a different leading control.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Title | text | Add Subscribers | The screen's name, and the thing a reader orients by. Name the screen rather than the task in progress, because the bar does not change as someone works and a title implying progress goes stale the moment they act. |
| Show Leading Icon | true | true | Show the back affordance. Leave it on for any screen pushed on top of another, which is the case this bar is drawn for. |
| Show Leading Icon | false | - | Drop it on a root screen with nowhere to go back to. The heading takes the reclaimed space, so nothing else needs adjusting. |
| Rounded | true | true | Despite the name this does not round the bar. It sets the contour of the action button in the slot, so pick the value matching the buttons used elsewhere on the screen. |
| Rounded | false | - | The sharp pairing for that same button. It reaches only the button shipped in the slot, so replacing the slot content drops the connection entirely. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| Static | — | — | The set declares no hover, focus, pressed or disabled axis. The two variants render identically apart from the corners of the action button. |
| Leading icon | Show Leading Icon toggled off | — | The back affordance is removed and the heading absorbs the 28px it occupied. Nothing else moves, because the bar's width is fixed. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | Figma stores no timing and no transition is authored. Nothing in the set changes over time. |
| Navigation | The leading chevron is a locked Icon instance with no state of its own. What it does on activation, and whether it is reachable at all, belongs to the implementation. |
| Reach of Rounded | Rounded is a variant on this set rather than a property passed down, so it restyles the shipped action button and nothing else. Slot content put there later will not follow it. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Title | text property | Plain text set per instance, defaulting to Add Subscribers. The heading wrapper is built with a gap for a second line, but no subtitle property exists to fill it. |
| Action Slot | slot, one Button as shipped | Holds the trailing action and hugs whatever is placed in it. It ships a Button at Size=medium and Flavour=primary. Nothing limits it to one control, so a crowded slot is possible and is the thing to watch. |
| Leading icon | fixed nested Icon, toggled by Show Leading Icon | An Icon at Size=medium swapped to Chevron Left. Only its visibility is surfaced, so the glyph cannot be changed from an instance without detaching. |

### Anatomy

1. **Leading icon** — The back chevron, present when Show Leading Icon is on. A locked Icon instance with only its visibility exposed.
2. **Heading Content** — The title wrapper. It fills the space between the icon and the slot, which is what holds the action hard right.
3. **Action Slot** — The trailing region a consumer fills. It hugs its content, so the heading absorbs whatever width is left.

### How to use

**Do:**
- Use it as the top bar of a pushed screen, with the back chevron on and a single action on the right.
- Match Rounded to the buttons used elsewhere on the screen. It exists to keep the action button consistent, not to shape the bar.

**Don't:**
- Don't put more than one control in the Action Slot. It will hug them, but the bar was drawn around a single action.
- Don't assume the bar stretches to the screen. It ships at a fixed width, so it has to be set to fill wherever it is placed.

### Accessibility & Content Guidelines

- The leading chevron is a locked icon with no label and no state. It needs an accessible name and a keyboard path, neither of which is modelled here.
- No focus state exists anywhere in the set, so focus order and a visible focus ring both have to come from code.
- The title uses title/large at 20px. It names the screen, so it should map to a real heading in the markup rather than being styled text.
- The bar's fill is interactive/ghost/background/default, an interactive token on a static container. Check it against the screen behind it and against the action button sitting on it.
- Turning the leading icon off removes the only back affordance. On a pushed screen something else then has to provide one.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Fixed width, hug height | 474 wide and 56 tall in both variants. The width is fixed rather than filling, so a placed instance will not stretch to its container on its own. |
| Padding and gap | Fixed | space/sm top and bottom, space/lg left and right, with a space/sm gap between the icon, the heading and the slot. |
| Alignment | Fixed | Horizontal auto-layout, items centred on the cross axis and packed from the start. The heading fills, which pushes the slot hard right. |
| Radius | None | Zero on both variants with no token bound. The Rounded axis does not touch it. |
| Fill | Theming | interactive/ghost/background/default, an interactive token on a static container. No border and no shadow. |
| Title | Theming | title/large, IBM Plex Sans Medium 20 over a 24px line, in foreground/primary. This style resolves to a remote library rather than a local one. |
| Leading icon | Fixed | Icon at Size=medium, 20 square. Hiding it returns 28px to the heading, the icon plus one gap. |

### Layer structure

- Screen Header Bar (COMPONENT)
  - Screen Header Bar/Leading Icon (INSTANCE)
  - Screen Header Bar/Heading Content (FRAME)
    - Screen Header Bar/Heading Content/Title (FRAME)
      - Screen Header Bar/Heading Content/Title/Add Subscribers (TEXT)
  - Screen Header Bar/Action Slot (SLOT)

### Resolved tokens (default variant: Rounded=true)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Screen Header Bar | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| Screen Header Bar | itemSpacing | 4 | space.xxs |
| Screen Header Bar | padding.left | 8 | space.sm |
| Screen Header Bar | padding.right | 12 | space.md |
| Screen Header Bar | padding.top | 12 | space.md |
| Screen Header Bar | padding.bottom | 12 | space.md |
| Screen Header Bar/Leading Icon | width | 40 | control.md |
| Screen Header Bar/Leading Icon | height | 40 | control.md |
| Screen Header Bar/Leading Icon | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| Screen Header Bar/Leading Icon | stroke[0] | #ced2db | interactive.neutral.border.default |
| Screen Header Bar/Leading Icon | cornerRadius | 0 | radius.none |
| Screen Header Bar/Leading Icon | strokeWeight | 0 | stroke.base |
| Screen Header Bar/Leading Icon | padding.left | 4 | space.xxs |
| Screen Header Bar/Leading Icon | padding.right | 4 | space.xxs |
| Screen Header Bar/Leading Icon | padding.top | 4 | space.xxs |
| Screen Header Bar/Leading Icon | padding.bottom | 4 | space.xxs |
| Screen Header Bar/Heading Content | itemSpacing | 2 | space.2xs |
| Screen Header Bar/Heading Content/Title | itemSpacing | 4 | space.xs |
| Screen Header Bar/Heading Content/Title/Add Subscribers | fill[0] | #0c0d0e | foreground.primary |
| Screen Header Bar/Heading Content/Title/Add Subscribers | fontSize | 20 | — |
| Screen Header Bar/Heading Content/Title/Add Subscribers | lineHeight | 24 | — |
| Screen Header Bar/Heading Content/Title/Add Subscribers | letterSpacing | 0 | — |
| Screen Header Bar/Action Slot | itemSpacing | 4 | space.xxs |
