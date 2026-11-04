# Stepper

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=7357-18457&m=dev

## Vertical Stepper

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=7557-19407&m=dev

### Layer structure

- Vertical Stepper (COMPONENT)
  - Vertical Stepper/Steps (SLOT)

### Resolved tokens (default variant: Rounded=false, Card=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Vertical Stepper | cornerRadius | 0 | radius.none |
| Vertical Stepper/Steps | cornerRadius | 0 | radius.none |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Card | true | Vertical Stepper | itemSpacing | space.sm |
| Card | true | Vertical Stepper/Steps | itemSpacing | space.sm |

## Horizontal Stepper

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=7561-19693&m=dev

### Layer structure

- Horizontal Stepper (COMPONENT)
  - Horizontal Stepper/Steps (SLOT)
  - Horizontal Stepper/Summary (FRAME)
    - Horizontal Stepper/Summary/Step Info (FRAME)
      - Horizontal Stepper/Summary/Step Info/Step Label (TEXT)
      - Horizontal Stepper/Summary/Step Info/Current Step (TEXT)
      - Horizontal Stepper/Summary/Step Info/Step Divider (TEXT)
      - Horizontal Stepper/Summary/Step Info/Total Steps (TEXT)
    - Horizontal Stepper/Summary/Heading (FRAME)
      - Horizontal Stepper/Summary/Heading/Title (TEXT)
      - Horizontal Stepper/Summary/Heading/Subtitle (TEXT)
  - Horizontal Stepper/Segments (SLOT)

### Resolved tokens (default variant: Size=default)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Horizontal Stepper | cornerRadius | 0 | radius.none |
| Horizontal Stepper | padding.left | 12 | space.md |
| Horizontal Stepper | padding.right | 12 | space.md |
| Horizontal Stepper/Steps | cornerRadius | 0 | radius.none |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Size | compact | Horizontal Stepper | padding.left | — |
| Size | compact | Horizontal Stepper | padding.right | — |
| Size | compact | Horizontal Stepper | itemSpacing | space.md |
| Size | compact | Horizontal Stepper/Steps | cornerRadius | — |
| Size | compact | Horizontal Stepper/Summary | cornerRadius | radius.none |
| Size | compact | Horizontal Stepper/Summary | itemSpacing | space.2xs |
| Size | compact | Horizontal Stepper/Summary/Step Info | cornerRadius | radius.none |
| Size | compact | Horizontal Stepper/Summary/Step Info | itemSpacing | space.2xs |
| Size | compact | Horizontal Stepper/Summary/Step Info/Step Label | fill[0] | foreground.tertiary |
| Size | compact | Horizontal Stepper/Summary/Step Info/Current Step | fill[0] | foreground.tertiary |
| Size | compact | Horizontal Stepper/Summary/Step Info/Step Divider | fill[0] | foreground.tertiary |
| Size | compact | Horizontal Stepper/Summary/Step Info/Total Steps | fill[0] | foreground.tertiary |
| Size | compact | Horizontal Stepper/Summary/Heading | cornerRadius | radius.none |
| Size | compact | Horizontal Stepper/Summary/Heading | itemSpacing | space.2xs |
| Size | compact | Horizontal Stepper/Summary/Heading/Title | fill[0] | foreground.primary |
| Size | compact | Horizontal Stepper/Summary/Heading/Title | fontSize | title.medium.font size |
| Size | compact | Horizontal Stepper/Summary/Heading/Title | lineHeight | title.medium.line height |
| Size | compact | Horizontal Stepper/Summary/Heading/Title | letterSpacing | title.medium.letter spacing |
| Size | compact | Horizontal Stepper/Summary/Heading/Subtitle | fill[0] | foreground.secondary |
| Size | compact | Horizontal Stepper/Summary/Heading/Subtitle | fontSize | body.small.font size |
| Size | compact | Horizontal Stepper/Summary/Heading/Subtitle | lineHeight | body.small.line height |
| Size | compact | Horizontal Stepper/Summary/Heading/Subtitle | letterSpacing | body.small.letter spacing |
| Size | compact | Horizontal Stepper/Segments | cornerRadius | radius.none |
| Size | compact | Horizontal Stepper/Segments | itemSpacing | space.xs |

## Step Segment

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=7362-110&m=dev

### Overview

The equivalent of step connectors but for the compact variant of horizontal stepper. It is a flat capsule split into two halves, and Status fills neither, one or both of them. It carries no text, so the count and title above the bar do the naming.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Status | default | true | A step not yet reached. Both halves stay muted, so the segment reads as empty track waiting to be filled. |
| Status | complete | — | A step finished and passed. Both halves fill, which is what lets a run of finished steps read as one continuous bar. |
| Status | partial | — | A step entered and left unfinished. Only the leading half fills, and it is the one value that shows progress inside a single step. |
| Status | active | — | The step a person is on now. It fills both halves exactly as complete does, so the title above the bar is what names the current step. |
| Status | error | — | A step that failed. Both halves take the error tone, the only colour the bar uses besides the primary one. |
| Status | disabled | — | A step not available in this run. Both halves stay muted, so it is drawn the same as default. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| default | Status=default | — | Both halves on border/subtle. |
| complete | Status=complete | — | Both halves on interactive/primary/background/default. |
| partial | Status=partial | — | Leading half on interactive/primary/background/default, trailing half on border/subtle. |
| active | Status=active | — | Both halves on interactive/primary/background/default, identical to complete. |
| error | Status=error | — | Both halves on foreground/error. |
| disabled | Status=disabled | — | Both halves on border/subtle, identical to default. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Two halves | The segment is split in two so that a single step can report partial progress. Every other value fills both halves or neither. The partial fill aspect ratio is always kept to fill 50% of it’s container to denote partial progress. |
| Width | Each segment takes an equal share of the bar. The more steps a sequence holds, the shorter the width of every segment equally becomes. |

### Anatomy

1. **Segment** — One step of the bar, rounded at both ends. Five of them with a gap between each is what a five step sequence looks like on mobile.
2. **Start** — The leading half. On partial this is the half that fills, which is the only way the bar reports progress within a step.
3. **End** — The trailing half. It fills alongside Start on complete, active and error, and stays muted otherwise.

### How to use

**Do:**
- Let the bar carry progress and the summary carry naming. The segment has no text, so the count and title above it are the only place a step is named.
- Use partial where a step was left half done. It is the only value that fills one half, and it is the reason the segment is split at all.

**Don't:**
- Don't rely on the bar to show which step is current. Active and complete fill identically, so the title above the bar has to say so.
- Don't put a long sequence on the mobile bar. Segments divide the width evenly, so every one of them shortens in width as steps are added.

### Accessibility & Content Guidelines

- The bar conveys progress through fill alone, with no text and no change of shape, so it cannot be the only account of where a person is. The count and title above it carry that, and they are what should be announced. active and complete fill identically, which means position is not recoverable from the bar by itself. The error tone is the one place the bar uses colour to carry meaning rather than quantity, so a failed step needs saying in words somewhere else on the screen.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Fill width, fixed height | space/xxs tall, taking an equal share of the bar’s width. |
| Radius | radius/pill | Applied to the segment rather than to its halves, so a part filled segment keeps a rounded outer edge and a straight join down the middle. |
| Halves | Fill | Start and End each take half the segment, which is what fixes partial at exactly half rather than at a measured amount. |
| Colour | Per Status | interactive/primary/background/default on complete, active and the leading half of partial. border/subtle on default, disabled and the trailing half of partial. foreground/error on both halves of error. |

### Layer structure

- Step Segment (COMPONENT)
  - Step Segment/Start (FRAME)
  - Step Segment/End (FRAME)

### Resolved tokens (default variant: Status=default)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Step Segment | height | 4 | space.2xs |
| Step Segment | cornerRadius | 9999 | radius.pill |
| Step Segment/Start | fill[0] | #e0e3e9 | border.subtle |
| Step Segment/Start | cornerRadius | 0 | radius.none |
| Step Segment/End | fill[0] | #e0e3e9 | border.subtle |
| Step Segment/End | cornerRadius | 0 | radius.none |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Status | complete | Step Segment/Start | fill[0] | interactive.primary.background.default |
| Status | complete | Step Segment/End | fill[0] | interactive.primary.background.default |
| Status | partial | Step Segment/Start | fill[0] | interactive.primary.background.default |
| Status | active | Step Segment/Start | fill[0] | interactive.primary.background.default |
| Status | active | Step Segment/End | fill[0] | interactive.primary.background.default |
| Status | error | Step Segment/Start | fill[0] | foreground.error |
| Status | error | Step Segment/End | fill[0] | foreground.error |

## Step Card/Sharp

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=7447-306&m=dev

### Layer structure

- Step Card/Sharp (COMPONENT)
  - Step Card/Sharp/Indicator (FRAME)
    - Step Card/Sharp/Indicator/Number (TEXT)
    - Step Card/Sharp/Indicator/Icon (INSTANCE, icon: check_mark)
  - Step Card/Sharp/Text (FRAME)
    - Step Card/Sharp/Text/Label (TEXT)
    - Step Card/Sharp/Text/Subtitle (TEXT)

### Resolved tokens (default variant: Status=default)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Step Card/Sharp | fill[0] | #ffffff | surface.card |
| Step Card/Sharp | stroke[0] | #ced2db | border.default |
| Step Card/Sharp | cornerRadius | 0 | radius.none |
| Step Card/Sharp | strokeWeight | 1 | stroke.thin |
| Step Card/Sharp | itemSpacing | 12 | space.md |
| Step Card/Sharp | padding.left | 12 | space.md |
| Step Card/Sharp | padding.right | 12 | space.md |
| Step Card/Sharp | padding.top | 8 | space.sm |
| Step Card/Sharp | padding.bottom | 8 | space.sm |
| Step Card/Sharp/Indicator | width | 28 | control.icon-lg |
| Step Card/Sharp/Indicator | height | 28 | control.icon-lg |
| Step Card/Sharp/Indicator | fill[0] | #ffffff | interactive.neutral.background.default |
| Step Card/Sharp/Indicator | stroke[0] | #ced2db | border.default |
| Step Card/Sharp/Indicator | cornerRadius | 9999 | radius.pill |
| Step Card/Sharp/Indicator | strokeWeight | 2 | stroke.thick |
| Step Card/Sharp/Indicator/Number | fill[0] | #0c0d0e | foreground.primary |
| Step Card/Sharp/Indicator/Number | fontSize | 12 | label.small.font size |
| Step Card/Sharp/Indicator/Number | lineHeight | 16 | label.small.line height |
| Step Card/Sharp/Indicator/Number | letterSpacing | 0 | label.small.letter spacing |
| Step Card/Sharp/Text | cornerRadius | 0 | radius.none |
| Step Card/Sharp/Text | padding.top | 2 | space.3xs |
| Step Card/Sharp/Text/Label | fill[0] | #545963 | foreground.secondary |
| Step Card/Sharp/Text/Label | fontSize | 16 | label.large.font size |
| Step Card/Sharp/Text/Label | lineHeight | 24 | label.large.line height |
| Step Card/Sharp/Text/Label | letterSpacing | 0 | label.large.letter spacing |
| Step Card/Sharp/Text/Subtitle | fill[0] | #7a8190 | foreground.tertiary |
| Step Card/Sharp/Text/Subtitle | fontSize | 14 | body.small.font size |
| Step Card/Sharp/Text/Subtitle | lineHeight | 18 | body.small.line height |
| Step Card/Sharp/Text/Subtitle | letterSpacing | 0 | body.small.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Status | complete | Step Card/Sharp | fill[0] | feedback.success.background.subtle |
| Status | complete | Step Card/Sharp | stroke[0] | border.success |
| Status | complete | Step Card/Sharp/Indicator | fill[0] | feedback.success.background.strong |
| Status | complete | Step Card/Sharp/Indicator | stroke[0] | feedback.success.background.strong |
| Status | complete | Step Card/Sharp/Indicator/Number | fill[0] | — |
| Status | complete | Step Card/Sharp/Indicator/Number | fontSize | — |
| Status | complete | Step Card/Sharp/Indicator/Number | lineHeight | — |
| Status | complete | Step Card/Sharp/Indicator/Number | letterSpacing | — |
| Status | partial | Step Card/Sharp/Indicator | fill[0] | feedback.success.background.subtle |
| Status | partial | Step Card/Sharp/Indicator | stroke[0] | border.success |
| Status | active | Step Card/Sharp | fill[0] | surface.brand |
| Status | active | Step Card/Sharp | stroke[0] | interactive.primary.border.default |
| Status | active | Step Card/Sharp/Indicator | fill[0] | interactive.primary.background.default |
| Status | active | Step Card/Sharp/Indicator | stroke[0] | interactive.primary.background.default |
| Status | active | Step Card/Sharp/Indicator/Number | fill[0] | interactive.primary.foreground.default |
| Status | active | Step Card/Sharp/Text/Label | fill[0] | foreground.primary |
| Status | error | Step Card/Sharp | stroke[0] | border.error |
| Status | error | Step Card/Sharp/Indicator | fill[0] | feedback.error.background.strong |
| Status | error | Step Card/Sharp/Indicator | stroke[0] | feedback.error.background.strong |
| Status | error | Step Card/Sharp/Indicator/Number | fill[0] | — |
| Status | error | Step Card/Sharp/Indicator/Number | fontSize | — |
| Status | error | Step Card/Sharp/Indicator/Number | lineHeight | — |
| Status | error | Step Card/Sharp/Indicator/Number | letterSpacing | — |
| Status | error | Step Card/Sharp/Text/Label | fill[0] | foreground.error |
| Status | disabled | Step Card/Sharp | stroke[0] | border.subtle |
| Status | disabled | Step Card/Sharp/Indicator | fill[0] | border.subtle |
| Status | disabled | Step Card/Sharp/Indicator | stroke[0] | border.subtle |
| Status | disabled | Step Card/Sharp/Indicator/Number | fill[0] | foreground.disabled |
| Status | disabled | Step Card/Sharp/Text/Label | fill[0] | foreground.disabled |
| Status | disabled | Step Card/Sharp/Text/Subtitle | fill[0] | foreground.disabled |

## Step Card/Round

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=7557-18475&m=dev

### Layer structure

- Step Card/Round (COMPONENT)
  - Step Card/Round/Indicator (FRAME)
    - Step Card/Round/Indicator/Number (TEXT)
    - Step Card/Round/Indicator/Icon (INSTANCE, icon: check_mark)
  - Step Card/Round/Text (FRAME)
    - Step Card/Round/Text/Label (TEXT)
    - Step Card/Round/Text/Subtitle (TEXT)

### Resolved tokens (default variant: Status=default)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Step Card/Round | fill[0] | #ffffff | surface.card |
| Step Card/Round | stroke[0] | #ced2db | border.default |
| Step Card/Round | cornerRadius | 4 | radius.sm |
| Step Card/Round | strokeWeight | 1 | stroke.thin |
| Step Card/Round | itemSpacing | 12 | space.md |
| Step Card/Round | padding.left | 12 | space.md |
| Step Card/Round | padding.right | 12 | space.md |
| Step Card/Round | padding.top | 8 | space.sm |
| Step Card/Round | padding.bottom | 8 | space.sm |
| Step Card/Round/Indicator | width | 28 | control.icon-lg |
| Step Card/Round/Indicator | height | 28 | control.icon-lg |
| Step Card/Round/Indicator | fill[0] | #ffffff | interactive.neutral.background.default |
| Step Card/Round/Indicator | stroke[0] | #ced2db | border.default |
| Step Card/Round/Indicator | cornerRadius | 9999 | radius.pill |
| Step Card/Round/Indicator | strokeWeight | 2 | stroke.thick |
| Step Card/Round/Indicator/Number | fill[0] | #0c0d0e | foreground.primary |
| Step Card/Round/Indicator/Number | fontSize | 12 | label.small.font size |
| Step Card/Round/Indicator/Number | lineHeight | 16 | label.small.line height |
| Step Card/Round/Indicator/Number | letterSpacing | 0 | label.small.letter spacing |
| Step Card/Round/Text | cornerRadius | 0 | radius.none |
| Step Card/Round/Text | padding.top | 2 | space.3xs |
| Step Card/Round/Text/Label | fill[0] | #545963 | foreground.secondary |
| Step Card/Round/Text/Label | fontSize | 16 | label.large.font size |
| Step Card/Round/Text/Label | lineHeight | 24 | label.large.line height |
| Step Card/Round/Text/Label | letterSpacing | 0 | label.large.letter spacing |
| Step Card/Round/Text/Subtitle | fill[0] | #7a8190 | foreground.tertiary |
| Step Card/Round/Text/Subtitle | fontSize | 14 | body.small.font size |
| Step Card/Round/Text/Subtitle | lineHeight | 18 | body.small.line height |
| Step Card/Round/Text/Subtitle | letterSpacing | 0 | body.small.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Status | complete | Step Card/Round | fill[0] | feedback.success.background.subtle |
| Status | complete | Step Card/Round | stroke[0] | border.success |
| Status | complete | Step Card/Round/Indicator | fill[0] | feedback.success.background.strong |
| Status | complete | Step Card/Round/Indicator | stroke[0] | feedback.success.background.strong |
| Status | complete | Step Card/Round/Indicator/Number | fill[0] | — |
| Status | complete | Step Card/Round/Indicator/Number | fontSize | — |
| Status | complete | Step Card/Round/Indicator/Number | lineHeight | — |
| Status | complete | Step Card/Round/Indicator/Number | letterSpacing | — |
| Status | partial | Step Card/Round/Indicator | fill[0] | feedback.success.background.subtle |
| Status | partial | Step Card/Round/Indicator | stroke[0] | border.success |
| Status | active | Step Card/Round | fill[0] | surface.brand |
| Status | active | Step Card/Round | stroke[0] | interactive.primary.border.default |
| Status | active | Step Card/Round/Indicator | fill[0] | interactive.primary.background.default |
| Status | active | Step Card/Round/Indicator | stroke[0] | interactive.primary.background.default |
| Status | active | Step Card/Round/Indicator/Number | fill[0] | interactive.primary.foreground.default |
| Status | active | Step Card/Round/Text/Label | fill[0] | foreground.primary |
| Status | error | Step Card/Round | stroke[0] | border.error |
| Status | error | Step Card/Round/Indicator | fill[0] | feedback.error.background.strong |
| Status | error | Step Card/Round/Indicator | stroke[0] | feedback.error.background.strong |
| Status | error | Step Card/Round/Indicator/Number | fill[0] | — |
| Status | error | Step Card/Round/Indicator/Number | fontSize | — |
| Status | error | Step Card/Round/Indicator/Number | lineHeight | — |
| Status | error | Step Card/Round/Indicator/Number | letterSpacing | — |
| Status | error | Step Card/Round/Text/Label | fill[0] | foreground.error |
| Status | disabled | Step Card/Round | stroke[0] | border.subtle |
| Status | disabled | Step Card/Round/Indicator | fill[0] | border.subtle |
| Status | disabled | Step Card/Round/Indicator | stroke[0] | border.subtle |
| Status | disabled | Step Card/Round/Indicator/Number | fill[0] | foreground.disabled |
| Status | disabled | Step Card/Round/Text/Label | fill[0] | foreground.disabled |
| Status | disabled | Step Card/Round/Text/Subtitle | fill[0] | foreground.disabled |

## Step / Horizontal

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=7526-374&m=dev

### Layer structure

- Step / Horizontal (COMPONENT)
  - Step / Horizontal/Head (FRAME)
    - Step / Horizontal/Head/Indicator (FRAME)
      - Step / Horizontal/Head/Indicator/Number (TEXT)
      - Step / Horizontal/Head/Indicator/Icon (INSTANCE, icon: check_mark)
    - Step / Horizontal/Head/Text (FRAME)
      - Step / Horizontal/Head/Text/Label (TEXT)
      - Step / Horizontal/Head/Text/Subtitle (TEXT)
  - Step / Horizontal/Track (FRAME)
    - Step / Horizontal/Track/Line (FRAME)

### Resolved tokens (default variant: Status=default)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Step / Horizontal | cornerRadius | 0 | radius.none |
| Step / Horizontal | padding.top | 4 | space.2xs |
| Step / Horizontal | padding.bottom | 4 | space.2xs |
| Step / Horizontal/Head | width | 28 | control.icon-lg |
| Step / Horizontal/Head | cornerRadius | 0 | radius.none |
| Step / Horizontal/Head | itemSpacing | 8 | space.sm |
| Step / Horizontal/Head/Indicator | width | 28 | control.icon-lg |
| Step / Horizontal/Head/Indicator | height | 28 | control.icon-lg |
| Step / Horizontal/Head/Indicator | fill[0] | #ffffff | interactive.neutral.background.default |
| Step / Horizontal/Head/Indicator | stroke[0] | #ced2db | border.default |
| Step / Horizontal/Head/Indicator | cornerRadius | 9999 | radius.pill |
| Step / Horizontal/Head/Indicator | strokeWeight | 2 | stroke.thick |
| Step / Horizontal/Head/Indicator/Number | fill[0] | #0c0d0e | foreground.primary |
| Step / Horizontal/Head/Indicator/Number | fontSize | 12 | label.small.font size |
| Step / Horizontal/Head/Indicator/Number | lineHeight | 16 | label.small.line height |
| Step / Horizontal/Head/Indicator/Number | letterSpacing | 0 | label.small.letter spacing |
| Step / Horizontal/Head/Text | cornerRadius | 0 | radius.none |
| Step / Horizontal/Head/Text | padding.top | 2 | space.3xs |
| Step / Horizontal/Head/Text/Label | fill[0] | #7a8190 | foreground.tertiary |
| Step / Horizontal/Head/Text/Label | fontSize | 16 | label.large.font size |
| Step / Horizontal/Head/Text/Label | lineHeight | 24 | label.large.line height |
| Step / Horizontal/Head/Text/Label | letterSpacing | 0 | label.large.letter spacing |
| Step / Horizontal/Head/Text/Subtitle | fill[0] | #7a8190 | foreground.tertiary |
| Step / Horizontal/Head/Text/Subtitle | fontSize | 14 | body.small.font size |
| Step / Horizontal/Head/Text/Subtitle | lineHeight | 18 | body.small.line height |
| Step / Horizontal/Head/Text/Subtitle | letterSpacing | 0 | body.small.letter spacing |
| Step / Horizontal/Track | height | 28 | control.icon-lg |
| Step / Horizontal/Track | cornerRadius | 0 | radius.none |
| Step / Horizontal/Track/Line | height | 2 | stroke.thick |
| Step / Horizontal/Track/Line | stroke[0] | #ced2db | border.default |
| Step / Horizontal/Track/Line | strokeWeight | 1 | stroke.thick |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Status | complete | Step / Horizontal/Head/Indicator | fill[0] | feedback.success.background.strong |
| Status | complete | Step / Horizontal/Head/Indicator | stroke[0] | feedback.success.background.strong |
| Status | complete | Step / Horizontal/Head/Indicator/Number | fill[0] | — |
| Status | complete | Step / Horizontal/Head/Indicator/Number | fontSize | — |
| Status | complete | Step / Horizontal/Head/Indicator/Number | lineHeight | — |
| Status | complete | Step / Horizontal/Head/Indicator/Number | letterSpacing | — |
| Status | complete | Step / Horizontal/Track/Line | stroke[0] | border.success |
| Status | active | Step / Horizontal/Head/Indicator | fill[0] | interactive.primary.background.default |
| Status | active | Step / Horizontal/Head/Indicator | stroke[0] | interactive.primary.background.default |
| Status | active | Step / Horizontal/Head/Indicator/Number | fill[0] | interactive.primary.foreground.default |
| Status | active | Step / Horizontal/Head/Text/Label | fill[0] | foreground.primary |
| Status | partial | Step / Horizontal/Head/Indicator | fill[0] | feedback.success.background.subtle |
| Status | partial | Step / Horizontal/Head/Indicator | stroke[0] | border.success |
| Status | partial | Step / Horizontal/Track/Line | stroke[0] | border.success |
| Status | error | Step / Horizontal/Head/Indicator | fill[0] | feedback.error.background.strong |
| Status | error | Step / Horizontal/Head/Indicator | stroke[0] | feedback.error.background.strong |
| Status | error | Step / Horizontal/Head/Indicator/Number | fill[0] | — |
| Status | error | Step / Horizontal/Head/Indicator/Number | fontSize | — |
| Status | error | Step / Horizontal/Head/Indicator/Number | lineHeight | — |
| Status | error | Step / Horizontal/Head/Indicator/Number | letterSpacing | — |
| Status | error | Step / Horizontal/Head/Text/Label | fill[0] | foreground.error |
| Status | disabled | Step / Horizontal/Head/Indicator | fill[0] | border.subtle |
| Status | disabled | Step / Horizontal/Head/Indicator | stroke[0] | border.subtle |
| Status | disabled | Step / Horizontal/Head/Indicator/Number | fill[0] | foreground.disabled |
| Status | disabled | Step / Horizontal/Head/Text/Label | fill[0] | foreground.disabled |
| Status | disabled | Step / Horizontal/Head/Text/Subtitle | fill[0] | foreground.disabled |

## Step / Vertical

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=7526-427&m=dev

### Layer structure

- Step / Vertical (COMPONENT)
  - Step / Vertical/Rail (FRAME)
    - Step / Vertical/Rail/Indicator (FRAME)
      - Step / Vertical/Rail/Indicator/Number (TEXT)
      - Step / Vertical/Rail/Indicator/Icon (INSTANCE, icon: check_mark)
    - Step / Vertical/Rail/Line (FRAME)
  - Step / Vertical/Text (FRAME)
    - Step / Vertical/Text/Label (TEXT)
    - Step / Vertical/Text/Subtitle (TEXT)

### Resolved tokens (default variant: Status=default)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Step / Vertical | cornerRadius | 0 | radius.none |
| Step / Vertical | itemSpacing | 24 | space.xl |
| Step / Vertical/Rail | cornerRadius | 0 | radius.none |
| Step / Vertical/Rail/Indicator | width | 28 | control.icon-lg |
| Step / Vertical/Rail/Indicator | height | 28 | control.icon-lg |
| Step / Vertical/Rail/Indicator | fill[0] | #ffffff | interactive.neutral.background.default |
| Step / Vertical/Rail/Indicator | stroke[0] | #ced2db | border.default |
| Step / Vertical/Rail/Indicator | cornerRadius | 9999 | radius.pill |
| Step / Vertical/Rail/Indicator | strokeWeight | 2 | stroke.thick |
| Step / Vertical/Rail/Indicator/Number | fill[0] | #0c0d0e | foreground.primary |
| Step / Vertical/Rail/Indicator/Number | fontSize | 12 | label.small.font size |
| Step / Vertical/Rail/Indicator/Number | lineHeight | 16 | label.small.line height |
| Step / Vertical/Rail/Indicator/Number | letterSpacing | 0 | label.small.letter spacing |
| Step / Vertical/Rail/Line | width | 2 | stroke.thick |
| Step / Vertical/Rail/Line | stroke[0] | #ced2db | border.default |
| Step / Vertical/Rail/Line | cornerRadius | 0 | radius.none |
| Step / Vertical/Rail/Line | strokeWeight | 0 | — |
| Step / Vertical/Text | padding.top | 2 | space.3xs |
| Step / Vertical/Text/Label | fill[0] | #7a8190 | foreground.tertiary |
| Step / Vertical/Text/Label | fontSize | 16 | label.large.font size |
| Step / Vertical/Text/Label | lineHeight | 24 | label.large.line height |
| Step / Vertical/Text/Label | letterSpacing | 0 | label.large.letter spacing |
| Step / Vertical/Text/Subtitle | fill[0] | #7a8190 | foreground.tertiary |
| Step / Vertical/Text/Subtitle | fontSize | 14 | body.small.font size |
| Step / Vertical/Text/Subtitle | lineHeight | 18 | body.small.line height |
| Step / Vertical/Text/Subtitle | letterSpacing | 0 | body.small.letter spacing |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Status | complete | Step / Vertical/Rail/Indicator | fill[0] | feedback.success.background.strong |
| Status | complete | Step / Vertical/Rail/Indicator | stroke[0] | feedback.success.background.strong |
| Status | complete | Step / Vertical/Rail/Indicator/Number | fill[0] | — |
| Status | complete | Step / Vertical/Rail/Indicator/Number | fontSize | — |
| Status | complete | Step / Vertical/Rail/Indicator/Number | lineHeight | — |
| Status | complete | Step / Vertical/Rail/Indicator/Number | letterSpacing | — |
| Status | complete | Step / Vertical/Rail/Line | stroke[0] | border.success |
| Status | active | Step / Vertical/Rail/Indicator | fill[0] | interactive.primary.background.default |
| Status | active | Step / Vertical/Rail/Indicator | stroke[0] | interactive.primary.background.default |
| Status | active | Step / Vertical/Rail/Indicator/Number | fill[0] | interactive.primary.foreground.default |
| Status | active | Step / Vertical/Text/Label | fill[0] | foreground.primary |
| Status | partial | Step / Vertical/Rail/Indicator | fill[0] | feedback.success.background.subtle |
| Status | partial | Step / Vertical/Rail/Indicator | stroke[0] | border.success |
| Status | partial | Step / Vertical/Rail/Line | stroke[0] | border.success |
| Status | error | Step / Vertical/Rail/Indicator | fill[0] | feedback.error.background.strong |
| Status | error | Step / Vertical/Rail/Indicator | stroke[0] | feedback.error.background.strong |
| Status | error | Step / Vertical/Rail/Indicator/Number | fill[0] | — |
| Status | error | Step / Vertical/Rail/Indicator/Number | fontSize | — |
| Status | error | Step / Vertical/Rail/Indicator/Number | lineHeight | — |
| Status | error | Step / Vertical/Rail/Indicator/Number | letterSpacing | — |
| Status | error | Step / Vertical/Text/Label | fill[0] | foreground.error |
| Status | disabled | Step / Vertical/Rail/Indicator | fill[0] | border.subtle |
| Status | disabled | Step / Vertical/Rail/Indicator | stroke[0] | border.subtle |
| Status | disabled | Step / Vertical/Rail/Indicator/Number | fill[0] | foreground.disabled |
| Status | disabled | Step / Vertical/Text/Label | fill[0] | foreground.disabled |
| Status | disabled | Step / Vertical/Text/Subtitle | fill[0] | foreground.disabled |

## Stepper (documentation only)

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=7357-18457&m=dev

### Overview

Shows where a person is in a fixed sequence of steps, marking what is finished, what is current and what is still ahead. Two sets: Horizontal Stepper, default for desktop or compact for mobile, and Vertical Stepper, a rail or a column of cards. All stepper variants excluding the horizontal compact variant names only the current step above a segmented bar.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| HORIZONTAL STEPPER |  |  |  |
| Size | default | true | The desktop variant of a horizontal stepper. Every step is named, its label centered under its indicator, and the connector runs indicator to indicator. |
| Size | compact | — | The scaled down variant of a horizontal stepper, ideally used for mobile screens. The count, the current title and subtitle, over the segment bar. |
| Slot | slot | — | Holds the Step / Horizontal instances on Default variant. Turn Show Line off on the last one. |
| Segments | slot | — | Holds one Step Segment per step on Compact variant. |
| Current Step | text | 3 | This shows the current step number on Compact variant. |
| Total Steps | text | 5 | This shows the total number of steps on Compact variant. |
| Label | text | Label | This shows the current step title on Compact variant. |
| Subtitle | text | Subtitle | This shows the current step subtitle on Compact variant. |
| Show Subtitle | true | true | On default, subtitles are hidden but can be toggled on to show additional context to the step. Ideally, limit to using one or few words, rather than a longer description. |
| Show Subtitle | false | — | Drops the subtitle, surfacing just the count and the step title. |
| VERTICAL STEPPER |  |  |  |
| Card | false | true | The desktop variant of a vertical stepper. Every step is named, its label centered under its indicator, and the connector connects and runs from indicator to indicator. This is the default variant used for vertical stepper. |
| Card | true | — | A card style of the vertical stepper. Each step used a Step Card, with active and completed steps highlighted for prominence. Ideally, use this variant if your prefer to show more visual-focused step progress. |
| Rounded | true | true | Only applicable when vertical stepper card property is set to true.  The default state of the card vertical stepper shows step cards with rounded corners. This property should be used consistently with the rest of the page’s styling. |
| Rounded | false | — | Only applicable when vertical stepper card property is set to false.  This property shows step cards with sharp corners and should be used consistently with the rest of the page’s styling. |
| Slot | slot | — | Holds Step / Vertical or Step Card instances. Turn Show Line off on the last one. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| Static | — | — | The default state features the step at hand, with respective progress states indicated for steps that follow before and after it. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | No transition is defined. Progress changes by resetting each step’s Status, and the page decides whether anything moves as the content behind it changes. |
| Width change | Horizontal stepper steps should equally fill to the width of the overall component. |
| Height change | Vertical stepper steps should equally fill to the width of each individual step’s height. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Steps | Step / Horizontal, Step / Vertical | One step each, documented in their own frames. Horizontal and vertical are separate components rather than one component turned on its side. |
| Steps, Cards | Step Card/Round, Step Card/Sharp | One step of the cards arrangement, in two sets that differ only in their corners. It carries a surface and no connector. |
| Steps, Mobile | Step Segment | One division of the mobile bar, documented in its own frame. Segments carry no text, so the summary above them does the naming. These steps have reduced set of properties, featured with more simplification. |
| Step content | Slot | Steps go in through the component’s slot. Compact variant uses segments in place of steps. Label, Subtitle, Step Number and Status are set on each step instance. |

### Anatomy

1. **Step** — One step of the sequence, carrying its indicator, its label and the connector that follows it. Which component draws it depends on the set and its Size or Card value.
2. **Indicator** — The numbered circle at the head of a step. Every desktop arrangement shares it, and it takes its appearance from that step’s Status.
3. **Connector** — The line running from one indicator to the next on a rail. Cards drop it, and mobile replaces the whole run with a segmented bar.
4. **Label + Subtitle** — This text comes below the step indicator.

### How to use

**Do:**
- Give every step a short noun label, ideally single word. The rail divides its width evenly between steps, so a long label pushes into its neighbour before it wraps.
- Keep the sequence fixed for the whole task. A stepper promises a known number of steps, and adding one part way through breaks that promise.

**Don't:**
- Don’t use steppers for progress that is less than two steps and more than 8 steps. If so necessary to use more, consider which steps can be grouped.
- Don't treat default and compact as one arrangement resized. Mobile drops every step label but the current one, so the whole path stops being visible.

### Accessibility & Content Guidelines

- The ability to move between steps with flexibility depends on choice when implementing.
- Give the stepper an accessible name, so position is read out alongside the label rather than conveyed by color alone.
- Status is carried by the fill and by the glyph inside the indicator together, which is what keeps complete and error apart for anyone who cannot rely on hue.
- On mobile the bar holds no text at all, so the count and title above it are the only announcement of where a person is.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Hug | Horizontal Stepper default hugs its steps and compact the width of its bar; Vertical Stepper hugs its column. |
| Direction | Per Orientation and Layout | The horizontal rail lays steps in a row, the vertical rail and cards in a column. Mobile is a column holding the summary above the bar. |
| Padding and gap | Mixed | 8px between the step indicator and text group, with 2px between the label and subtitle. |
| Step /Vertical | Hug | Each step takes the height of the content it hugs. |
| Step / Horizontal | Fill | Each step takes an equal share of the total component’s width |
| Segments | Fill | Each segment takes an equal share of the bar's width. |
| Colour | Per step Status | The stepper paints nothing itself. Every colour arrives with the step component it holds, and those are listed in the step frames. |

## Step / Horizontal & Vertical (documentation only)

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=7357-18457&m=dev

### Overview

Each step that is used within a stepper parent component. Step / Horizontal puts the label under its indicator and runs the connector on to the next step. Step / Vertical sets the label beside it and drops the connector towards the next. Status sets how the step reads at a glance, from default through complete to error.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Status | default | true | A step not yet reached. The indicator is outlined and the label stays muted, so it recedes behind the step in progress. |
| Status | complete | — | A step finished and passed. A tick replaces the number, so the number set on this step stops being visible. |
| Status | active | — | The step a user is actively on. It is the only value that promotes the label to the primary tone, so use exactly one in a row or column. |
| Status | partial | — | A step entered and left unfinished. It keeps its number on a tinted ground, which is what tells it apart from complete. |
| Status | error | — | A step that failed. It is the only value that recolours the label, so a failure stays legible without reading the indicator. |
| Status | disabled | — | A step not available in this run. Every part mutes together, so it reads as out of scope rather than merely unreached. |
| Label | text | Label | Names the step in a word or two. Horizontally, the label sits below the indicator whereas vertically, the label sits to the right of the indicator. |
| Step Number | text | 1 | The number in the indicator. Only two states that show glyphs in place of step numbers are complete and error. |
| Subtitle | text | Subtitle | A qualifier under the label for a step which needs extra context. Ideally, this subtitle should be no longer than a word or two. It is only drawn when Show Subtitle is on. |
| Show Subtitle | false | true | Leaves the step to its label alone, which keeps every step in a row or column the same height. |
| Show Subtitle | true | — | Adds the subtitle line and makes the respective step taller. |
| Show Line | true | true | Keeps the connector running on to the next step, across or down. It is what makes the steps read as one path rather than separate markers. |
| Show Line | false | — | Drops the connector. Using this property is recommended for last end steps on steppers where there is nothing further to connect to. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| default | Status=default | — | Outlined indicator on the neutral background with the number in the primary tone, a muted label, and a default connector. |
| complete | Status=complete | — | Solid success indicator carrying a tick in place of the number, a muted label, and a success connector. |
| active | Status=active | — | Solid primary indicator with the number reversed out, the label promoted to the primary tone, and a default connector. |
| partial | Status=partial | — | Subtle success fill behind the number with a success border, a muted label, and a success connector. |
| error | Status=error | — | Solid error indicator carrying a priority glyph, the label in the error tone, and a default connector. |
| disabled | Status=disabled | — | Indicator, number, label and subtitle all drop to the disabled tone, with a default connector. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Height | The step hugs its content. For horizontal steps, the row top aligns to the tallest step. For vertical steps, the step grows downward and the connector carries the height of the step component. |
| Head frame width | On horizontal steps, the head frame should hug to fit the indicator with the label and subtitle texts center aligned in frame. This will mean the label and subtitle texts will overflow from the head frame width. This is to ensure equal sizing and spacing of steps. |
| Horizontal step indicator responsiveness | Indicator lengths on horizontal steps are set fixed for consistency but if the full length of the stepper component must be adjusted, all indicators must be treated with same length and fill behavior, to ensure equal spacing. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Indicator | Drawn by the step | Drawn from the step's own Status. Step Number sets the number it shows; complete and error replace it with a glyph. |
| Label | text property | Consumer owned, set through Label. It is the step’s name and the only text always present. Ideally, this should be a word or two at maximum. |
| Subtitle | text property, optional | Consumer owned, set through Subtitle and drawn only when Show Subtitle is on. Ideally, this should be a word or two at maximum. |
| Connector | Drawn by the step | Drawn by the step, horizontal on Step / Horizontal and vertical on Step / Vertical, its status taken from the step's own Status. |
| Glyphs | Check Mark and Priority | Chosen by Status rather than passed in. complete takes Check Mark, error takes Priority, and neither can be swapped. |

### Anatomy

1. **Indicator** — The numbered circle at the head of the step. Its fill, its border and whether it shows a number or a glyph all come from Status.
2. **Text** — The label, with the subtitle beneath it when Show Subtitle is on: centred under the indicator on Step / Horizontal, beside it on Step / Vertical.
3. **Connector** — The line from this step to the next, to the right on Step / Horizontal and below on Step / Vertical, carried by this step rather than the next. Show Line turns it off on the last step.

### How to use

**Do:**
- Keep exactly one step on active. That value is what marks a person’s position, and two of them leave the row or column with no single current step.
- Turn Show Line off on the last step. Each step draws the connector after itself, so the last one otherwise trails a line into nothing.

**Don't:**
- Don't treat complete and partial as interchangeable. partial says a step was entered and left unfinished, complete says it is done.
- Don't use vertical and horizontal steps interchangeably for steppers, but rather use them for their respective orientation intended for consistency.

### Accessibility & Content Guidelines

- The step carries its state through the indicator’s fill and the glyph inside it together, which is what keeps complete and error apart for anyone who cannot rely on colour.
- The label and subtitles are the step’s accessible name, so it should read as a noun a person would recognize out of context rather than as an instruction.
- The vertical arrangement gives a label room to wrap, which makes it the better choice where step names cannot be shortened.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Per set | Step / Horizontal has a fixed width, but can be made set to fill if the stepper must be expanded wider.  Step / Vertical hugs its fills it’s parent component width and height is set to hug its nested contents. |
| Head (horizontal) | 28 px | The head frame hugs the contents of the indicator, which should be set to 28px. |
| Rail (vertical) | Hug | The indicator with the connector below it, space/xl from the text beside it. |
| Text block (vertical) | Hug | Hugs the label, with space/2xs above it and nothing below. |
| Subtitle (vertical) | Fill | Held at a filled width of the text frame, wrapping within the text block if absolutely necessary to exceed more than a single line. |
| Connector | Fill | Horizontal: the track stands control/icon-lg tall so the line centers on the indicator, and the line fills the width left over at stroke/thick. Vertical: a stroke/thick line of fixed length below the indicator. |
| Indicator | Fixed | A control/icon-lg square at radius/pill, carrying a stroke/thick inside border. Size should usually be 28px aspect ratio. |
| Label colour | Per Status | foreground/tertiary on default, complete and partial, foreground/primary on active, foreground/error on error, foreground/disabled on disabled. |
| Subtitle colour | Per Status | foreground/tertiary on every value except disabled, which takes foreground/disabled. |
| Indicator colour | Per Status | interactive/neutral/background/default with border/default on default, feedback/success/background/strong on complete, feedback/success/background/subtle with border/success on partial, interactive/primary/background/default on active, feedback/error/background/strong on error, border/subtle on disabled. |
| Connector colour | Per Status | border/success on complete and partial, border/default on every other value. |

## Step Card (documentation only)

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=7357-18457&m=dev

### Overview

One step of the cards arrangement: a bordered surface carrying a numbered indicator and the step’s label side by side. There is no connector, so a column of cards reads as a set of stages rather than one drawn path, and Stepper places them rather than a consumer using one alone. This variant is intended to bring more visual clarity to steps, without needing more detail.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Status | default | true | A step not yet reached. The card keeps the plain surface and default border, so the outlined indicator is what marks it as pending. |
| Status | complete | — | A step finished and passed. The card takes feedback/success/background/subtle behind border/success, and the indicator a tick in place of the number. |
| Status | partial | — | A step entered and left unfinished. The card does not change, so the tinted indicator alone carries the difference. |
| Status | active | — | The step a person is on now. It is the only value that takes surface/brand and promotes its label, which is what makes the current step findable in a column. |
| Status | error | — | A step that failed. The border turns and the label recolours, so a failed card is readable without reading the indicator. |
| Status | disabled | — | A step not available in this run. The border and every piece of text mute together, so the card reads as out of scope. |
| Set | Step Card/Round | true | Use where the card sits in open space and reads as its own surface. It is the softer of the two and the usual choice. |
| Set | Step Card/Sharp | — | Use where cards meet a panel edge and a rounded corner would break the line. Nothing but the corner changes. |
| Label | text | Label | Names the step beside its indicator. The card is fixed in both directions, so a label long enough to wrap overruns it. |
| Step Number | text | 1 | The number in the indicator. complete and error show a glyph instead, so it is hidden there. |
| Subtitle | text | Subtitle | A qualifier under the label for a step whose name is ambiguous. It is only drawn when Show Subtitle is on. |
| Show Subtitle | false | true | Leaves the card to its label alone, which is the content the fixed card height is set for. |
| Show Subtitle | true | — | Adds the subtitle line. The card height does not grow with it, so both lines have to fit the height already set. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| default | Status=default | — | surface/card behind a default border, a muted label, and an outlined indicator carrying the number. |
| complete | Status=complete | — | The card takes feedback/success/background/subtle behind border/success, and the indicator fills solid success with a tick. The label stays muted. |
| partial | Status=partial | — | Card and label unchanged from default. Only the indicator moves, to a subtle success fill with a success border. |
| active | Status=active | — | The card takes surface/brand behind a primary border, the label is promoted to the primary tone, and the indicator fills solid primary. |
| error | Status=error | — | The border turns to border/error and the label to the error tone, with a solid error indicator carrying a priority glyph. |
| disabled | Status=disabled | — | Border, indicator, label and subtitle all drop to the muted and disabled tones together. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| No connector | Cards carry no line between them. Order is conveyed by the numbers in the indicators and by the stacking itself, which is why the arrangement is built for a vertical column. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Indicator | Drawn by the card | Drawn from the card's own Status. Step Number sets the number it shows; complete and error replace it with a glyph. |
| Label | text property | Consumer owned, set through Label. It fills whatever width is left beside the indicator. |
| Subtitle | text property, optional | Consumer owned, set through Subtitle and drawn only when Show Subtitle is on. |
| Surface | Parent owned, per Status and set | The card draws its own background, border and corner. None of the three is passed in. |

### Anatomy

1. **Card surface** — The bordered ground the step sits on. Its fill and border come from Status, and its corner from the set.
2. **Indicator** — The numbered circle on the leading edge. It matches the rail steps' indicator, and with the card's tint it carries the status reading.
3. **Text** — The label, with the subtitle beneath it when Show Subtitle is on, filling the width left beside the indicator.

### How to use

**Do:**
- Keep exactly one card on active. It is the only value that takes surface/brand, so two of them give a column two current steps.
- Match the set to the surrounding UI: Step Card/Sharp where it is flat or cards meet a panel edge, Step Card/Round where it is rounded.

**Don't:**
- Don't rely on the card to tell partial from default. The two share a surface and a border, and only the indicator differs.
- Don't give a card more text than its height holds. It is fixed in both directions and does not grow to its content.

### Accessibility & Content Guidelines

- The label is the card’s accessible name, so it should read as a noun a person would recognise out of context.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Fill | Fill the width of the main component column. |
| Text block | Fill | Takes whatever width is left beside the indicator, and the label fills that in turn. |
| Padding | Tokenised | space/sm above and below, space/md on both sides. |
| Subtitle | Fill | Text should fill the width of it’s container. |
| Indicator | Fixed | 28px aspect ratio. A control/icon-lg square at radius/pill, carrying a stroke/thick inside border. |
| Radius | Per set | radius/sm or 4px on Step Card/Round and radius/none on Step Card/Sharp. Nothing else differs between the two. |
| Border | stroke/thin, per Status | border/default on default and partial, border/success on complete, interactive/primary/border/default on active, border/error on error, border/subtle on disabled. |
| Surface | Per Status | surface/card on default, partial, error and disabled, feedback/success/background/subtle on complete, surface/brand on active. |
| Label colour | Per Status | foreground/tertiary on default, complete and partial, foreground/primary on active, foreground/error on error, foreground/disabled on disabled. |
| Indicator colour | Per Status | interactive/neutral/background/default with border/default on default, feedback/success/background/strong on complete, feedback/success/background/subtle with border/success on partial, interactive/primary/background/default on active, feedback/error/background/strong on error, border/subtle on disabled. |
