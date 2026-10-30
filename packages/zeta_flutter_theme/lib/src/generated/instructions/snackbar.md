# Snackbar

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6547-2448&m=dev

## Snackbar

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6551-170&m=dev

### Overview

A brief message about something the app just did, carrying at most one action. Variant chooses between a contextual pill, where Flavour sets the tint, the leading glyph and the controls together, and a plain standard bar with a filled action button. Use it where the message is worth noticing and not worth interrupting for, and for Dialog where the person has to answer before carrying on.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Message | text | Message | The line the snackbar exists to deliver. One short sentence, because the bar holds a single line at a fixed width and anything longer runs past the edge rather than wrapping. |
| Variant | contextual | true | A pill that takes its tint, its glyph and its controls from Flavour. Use it where the message is about something specific that just happened. |
| Variant | standard | - | The plain bar, dark and softly squared, with a filled action button. It carries no flavour colour, so use it where the message needs no status attached to it. |
| Flavour | info | - | Something worth knowing with nothing to do about it. An Info glyph on the info tint, carrying only a close. |
| Flavour | positive | - | Something finished successfully. A Check Circle on the success tint, close only. |
| Flavour | warning | - | Something needs attention without having failed. A Warning glyph on the warning tint, close only. |
| Flavour | error | - | Something failed. An Error glyph on the error tint with a close and nothing else, so a failure the person could retry needs a flavour that carries an action. |
| Flavour | deletion | - | Something was removed, with Undo offered beside it. It shares the error tint, so it reads as destructive even where the message itself is neutral. |
| Flavour | view | - | Something was created or filed somewhere the person can go and look at it. It carries View and no close, so acting or waiting are the only ways out. |
| Flavour | action | - | A message whose action is the point. It drops the glyph, sits on the inverse surface and carries a bordered control rather than a plain text one. |
| Flavour | default | true | No status at all. The inverse surface with a close and nothing else, for a message that reports rather than signals. |
| Shape | rounded | true | Match the contour of the surface the bar floats over. It reads as a pill on contextual and a soft rectangle on standard, so the same setting does not give the same silhouette. |
| Shape | sharp | - | Square corners throughout, carried into the close and the action as well as the bar itself. |
| Show Icon | false | true | No icon slot, which is where standard starts. It has no effect on contextual, where Flavour supplies the glyph instead. |
| Show Icon | true | - | Opens an icon slot on standard, for a glyph the message needs and that Flavour is not there to choose. |
| Show Action | true | true | Keeps the action on the flavours that carry one. info, positive, warning, error and default have none, so it changes nothing there. |
| Show Action | false | - | Drops the action. On deletion that removes Undo, which is the only way back, and on view it leaves a bar with nothing to act on and no close either. |
| Show Close | true | true | Keeps the dismiss control, which is how a person clears a bar that is not going to act on its own. |
| Show Close | false | - | Drops it. Only safe where the bar dismisses itself on a timer, because otherwise the message has no way out. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| Static | — | — | The bar has no interaction states. Nothing answers hover, focus or press, and the controls inside it carry their own. |
| Flavour | The Flavour value | — | The fill, the leading glyph, the message colour and which controls are present all move together. It is a preset rather than a colour setting. |
| Variant | The Variant value | — | contextual and standard differ in silhouette, in whether Flavour applies at all and in how the action is drawn. Moving between them changes the whole bar rather than one property of it. |
| Entering | Opened | 300ms | Rises from below its resting place while fading in, then settles. |
| Leaving | Closed by its close, its action or its timer | 200ms | Rises a little further and fades out, then is removed. The timer pauses while the pointer or keyboard focus is on the bar. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | It slides in from below over 300ms, fading in as it rises, and leaves by sliding up and fading out over 200ms, so neither direction runs past 0.3s. It stays on screen until the exit has finished, and a bar opened again while it is leaving returns fully visible. With reduced motion it only fades, over 150ms, without moving. |
| Layering (z-axis) | It floats in the browser's top layer rather than in the page's stacking order, so no z-index anywhere on the page can sit above it, modals and overlays included. It neither takes focus nor blocks the page beneath it. Two bars open at once occupy the same spot; there is no queue yet. |
| Width | Each variant holds a fixed width and the message sits on a single line without wrapping. Message length is therefore a constraint on what gets written rather than something the bar absorbs. |
| Flavour presets | Each flavour arrives with its glyph, its tint and its control set already decided. Changing flavour changes all three at once, so one picked for its colour brings controls along with it. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Message | text property | Consumer owned, set through Message. It is the only text the component takes in. |
| Leading icon | contextual, per Flavour | Chosen by Flavour rather than passed in. info takes Info, positive Check Circle, warning Warning, error Error, deletion Delete and view Open In New Window. |
| Leading icon | standard, via Show Icon | An icon slot that opens when Show Icon is on. This is the one place a consumer picks the glyph, and it exists because standard has no Flavour to pick one for it. |
| Leading icon | action and default | No glyph at all. Both sit on the inverse surface, where the message and its control carry the whole bar. |
| Controls | Action and Close, per Flavour | Drawn by the bar rather than taken in. The action label is fixed per flavour, Undo on deletion, View on view and Action elsewhere, and is not exposed as an input. |

### Anatomy

1. **Content** — The leading glyph and the message, space/md apart, filling whatever width the controls leave.
2. **Action** — Present only on the flavours that carry one. Plain text on deletion and view, bordered on action and a filled button on standard.
3. **Close** — The dismiss control, a 36 square around a 20 glyph. Absent on view, where the action is the only way out.

### How to use

**Do:**
- Pick the flavour for what happened rather than for the colour. Each one brings its own glyph and its own controls, so the choice settles the whole bar.
- Keep the message to one short line. The bar holds a fixed width and does not wrap, so anything longer runs past the edge.

**Don't:**
- Don't turn the close off on a bar with no action and no timer. That leaves a person with a message and no way to clear it.
- Don't use deletion just to get an error tint. It promises an Undo, and offering one the product cannot honour is worse than a plain error.

### Accessibility & Content Guidelines

- A snackbar appears without being asked for, so it has to announce itself. Nothing in the component does that, and the structure around it has to.
- Flavour is carried by a tint and a glyph. The tints are subtle by design, so the glyph and the words are what separate info from error for anyone who cannot rely on colour.
- The message does not wrap. A line longer than the bar runs past its edge rather than reflowing, so the content has to be written to the space rather than the space found for the content.
- view carries no close. Where the bar does not dismiss itself, its action is the only way out and it has to be reachable by keyboard.
- The close is a 36 square around a 20 glyph and it is a real target rather than decoration. It needs a name, because the glyph carries no text.
- Two drop shadows lift the bar off whatever it covers. Check it does not settle over something a person still needs to read or reach.
- Its movement respects reduced motion: with that preference set it fades in and out without sliding.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Fixed width, hug height | 48 tall throughout. Each variant carries its own fixed width, running from 190 to 323 depending on the flavour and its controls, rather than growing with the message. |
| Position | Fixed to the viewport | Centred horizontally, space/xl above the bottom edge of the viewport, and never wider than the viewport less space/lg on each side. It does not move with the page as it scrolls. |
| Padding and gap | Fixed | space/xs top and bottom, space/lg on the leading edge and space/sm on the trailing one, with space/sm between the content and the controls. The action flavour tightens the trailing edge to space/xs and opens the gap to space/lg so a bordered control sits closer to the end. |
| Content | Fill | The leading icon and the message sit space/md apart, and the content block fills whatever width the controls leave it. |
| Radius | Per Variant and Shape | contextual is radius/pill when rounded and standard is radius/md, so the two read differently at the same setting. Both drop to radius/none when sharp, and the close and the action follow. |
| Fill | Per Flavour | info, positive, warning and error take feedback/info, success, warning and error at background/subtle. deletion shares the error tint and view takes feedback/neutral/background/subtle. action and default sit on surface/inverse, which is what moves the message to foreground/inverse. |
| Controls | Fixed | Close is a 36 square holding a 20 glyph. The action is 36 tall where it is plain text and 40 tall where it carries a border or a fill, the bordered one at 2px on foreground/inverse and the filled one at radius/sm on interactive/inverse/background/default. |
| Elevation | Theming | Two drop shadows on every variant. They are what lift the bar off whatever it is floating over, since it has no border to separate it. |

### Layer structure

- Snackbar (COMPONENT)
  - Snackbar/Content (FRAME)
    - Snackbar/Content/Icon (INSTANCE, icon: info)
    - Snackbar/Content/Message (TEXT)
    - Snackbar/Content/Icon Slot (INSTANCE, icon: verified)
  - Snackbar/Controls (FRAME)
    - Snackbar/Controls/Close (INSTANCE)
    - Snackbar/Controls/Action (INSTANCE)
  - Snackbar/Action (INSTANCE)

### Resolved tokens (default variant: Variant=contextual, Flavour=info, Shape=rounded)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Snackbar | fill[0] | #f1f8ff | feedback.info.background.subtle |
| Snackbar | cornerRadius | 9999 | radius.pill |
| Snackbar | itemSpacing | 16 | space.lg |
| Snackbar | padding.left | 16 | space.lg |
| Snackbar | padding.right | 4 | space.xxs |
| Snackbar | padding.top | 4 | space.xxs |
| Snackbar | padding.bottom | 4 | space.xxs |
| Snackbar/Content | itemSpacing | 12 | space.md |
| Snackbar/Content | padding.top | 8 | space.sm |
| Snackbar/Content | padding.bottom | 8 | space.sm |
| Snackbar/Content/Message | fill[0] | #0c0d0e | foreground.primary |
| Snackbar/Content/Message | fontSize | 16 | body.medium.font size |
| Snackbar/Content/Message | lineHeight | 24 | body.medium.line height |
| Snackbar/Content/Message | letterSpacing | 0 | body.medium.letter spacing |
| Snackbar/Controls | itemSpacing | 4 | space.xxs |
| Snackbar/Controls/Close | width | 40 | control.md |
| Snackbar/Controls/Close | height | 40 | control.md |
| Snackbar/Controls/Close | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| Snackbar/Controls/Close | stroke[0] | #ced2db | interactive.neutral.border.default |
| Snackbar/Controls/Close | cornerRadius | 9999 | radius.pill |
| Snackbar/Controls/Close | strokeWeight | 0 | stroke.base |
| Snackbar/Controls/Close | padding.left | 4 | space.xxs |
| Snackbar/Controls/Close | padding.right | 4 | space.xxs |
| Snackbar/Controls/Close | padding.top | 4 | space.xxs |
| Snackbar/Controls/Close | padding.bottom | 4 | space.xxs |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Flavour | positive | Snackbar | fill[0] | feedback.success.background.subtle |
| Flavour | warning | Snackbar | fill[0] | feedback.warning.background.subtle |
| Flavour | error | Snackbar | fill[0] | feedback.error.background.subtle |
| Flavour | deletion | Snackbar | fill[0] | feedback.error.background.subtle |
| Flavour | deletion | Snackbar/Controls/Action | height | control.md |
| Flavour | deletion | Snackbar/Controls/Action | fill[0] | interactive.ghost.background.default |
| Flavour | deletion | Snackbar/Controls/Action | stroke[0] | interactive.neutral.border.default |
| Flavour | deletion | Snackbar/Controls/Action | cornerRadius | radius.pill |
| Flavour | deletion | Snackbar/Controls/Action | strokeWeight | stroke.base |
| Flavour | deletion | Snackbar/Controls/Action | padding.left | space.md |
| Flavour | deletion | Snackbar/Controls/Action | padding.right | space.md |
| Flavour | deletion | Snackbar/Controls/Action | padding.top | space.xxs |
| Flavour | deletion | Snackbar/Controls/Action | padding.bottom | space.xxs |
| Flavour | view | Snackbar | fill[0] | feedback.neutral.background.subtle |
| Flavour | view | Snackbar/Controls/Close | width | — |
| Flavour | view | Snackbar/Controls/Close | height | — |
| Flavour | view | Snackbar/Controls/Close | fill[0] | — |
| Flavour | view | Snackbar/Controls/Close | stroke[0] | — |
| Flavour | view | Snackbar/Controls/Close | cornerRadius | — |
| Flavour | view | Snackbar/Controls/Close | strokeWeight | — |
| Flavour | view | Snackbar/Controls/Close | padding.left | — |
| Flavour | view | Snackbar/Controls/Close | padding.right | — |
| Flavour | view | Snackbar/Controls/Close | padding.top | — |
| Flavour | view | Snackbar/Controls/Close | padding.bottom | — |
| Flavour | view | Snackbar/Controls/Action | height | control.md |
| Flavour | view | Snackbar/Controls/Action | fill[0] | interactive.ghost.background.default |
| Flavour | view | Snackbar/Controls/Action | stroke[0] | interactive.neutral.border.default |
| Flavour | view | Snackbar/Controls/Action | cornerRadius | radius.pill |
| Flavour | view | Snackbar/Controls/Action | strokeWeight | stroke.base |
| Flavour | view | Snackbar/Controls/Action | padding.left | space.md |
| Flavour | view | Snackbar/Controls/Action | padding.right | space.md |
| Flavour | view | Snackbar/Controls/Action | padding.top | space.xxs |
| Flavour | view | Snackbar/Controls/Action | padding.bottom | space.xxs |
| Flavour | action | Snackbar | fill[0] | surface.popover |
| Flavour | action | Snackbar/Controls | itemSpacing | — |
| Flavour | action | Snackbar/Controls/Close | width | — |
| Flavour | action | Snackbar/Controls/Close | height | — |
| Flavour | action | Snackbar/Controls/Close | fill[0] | — |
| Flavour | action | Snackbar/Controls/Close | stroke[0] | — |
| Flavour | action | Snackbar/Controls/Close | cornerRadius | — |
| Flavour | action | Snackbar/Controls/Close | strokeWeight | — |
| Flavour | action | Snackbar/Controls/Close | padding.left | — |
| Flavour | action | Snackbar/Controls/Close | padding.right | — |
| Flavour | action | Snackbar/Controls/Close | padding.top | — |
| Flavour | action | Snackbar/Controls/Close | padding.bottom | — |
| Flavour | action | Snackbar/Action | height | control.sm |
| Flavour | action | Snackbar/Action | fill[0] | interactive.ghost.background.default |
| Flavour | action | Snackbar/Action | stroke[0] | interactive.neutral.border.default |
| Flavour | action | Snackbar/Action | cornerRadius | radius.pill |
| Flavour | action | Snackbar/Action | strokeWeight | stroke.thin |
| Flavour | action | Snackbar/Action | padding.left | space.md |
| Flavour | action | Snackbar/Action | padding.right | space.md |
| Flavour | action | Snackbar/Action | padding.top | space.xxs |
| Flavour | action | Snackbar/Action | padding.bottom | space.xxs |
| Flavour | default | Snackbar | fill[0] | surface.popover |
| Shape | sharp | Snackbar | cornerRadius | radius.none |
| Shape | sharp | Snackbar/Controls/Close | cornerRadius | radius.none |
