# Notification Item

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6020-1488&m=dev

## Notification Item

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6032-3093&m=dev

### Overview

A single entry in a notification list, carrying who or what it came from, a title and message, an optional attachment, and an action. Read is the only variant and decides whether the entry still looks unseen. Everything else is a toggle, so a single component covers the range a real list throws at it.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Read | false | true | The unseen entry, and the state the component is drawn around. |
| Read | true | - | The entry has been seen. The card drops its surface and sits flush on the list background, which is what tells it apart from an unread entry at a glance. |
| Group | false | true | A standalone entry. |
| Group | true | - | Marks the entry as standing for several collapsed together. It applies while the entry is unread, and a read entry shows no group bar. |
| Show Attachment | true | true | Show the attached file's name and icon. Turn it on only when a file is genuinely attached, because the row is not a placeholder and reads as a broken link when empty. |
| Show Attachment | false | - | No attachment row, and the card shortens to match. |
| Show Actions | true | true | Show the action slot. It is the only place an entry offers something to do, so switching it off makes the item read-only. |
| Show Actions | false | - | No action row. Reach for this on entries that are purely informational. |
| Show Urgency Indicator | true | true | Flag the entry as needing attention before the rest. Reserve it, because an indicator on every item in a list signals nothing. |
| Show Urgency Indicator | false | - | The ordinary case, and what most entries in a list should use. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| Static | — | — | The notification itself has no hover, focus, pressed or disabled state. The only interactive part is the Button in the action slot, which carries its own. |
| Read | Read | — | Read=false fills the card with surface/card and shows the indicator dot in the header. Read=true removes both. Nothing else changes. |
| Grouped | Group set to true | — | A bar appears pinned to the bottom edge of the card. It is absolutely positioned, so the card's height does not change. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | No transition is defined. Marking an entry read is a fill disappearing, with nothing specified between the two states. |
| Height | The card hugs its content. Hiding the attachment takes some space off and hiding the actions takes a small button height off, and because both sit in the same column the two shorten it independently. |
| Grouping | The group bar appears on unread entries only, so the grouping affordance applies while an entry is still unseen. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Action Slots | slot, one Button by default | Holds whatever the entry offers to do and fills the width of the content column. It takes a single Button by default. |
| Leading Visual | Flavour=avatar | A person, and the default. Carries an Avatar at Size=xxsmall with its own Status, Ring and Close turned off, so only the face or initials shows. Flavour belongs to the leading visual rather than to the notification, so it is decided where the visual is supplied. |
| Leading Visual | Flavour=image | Something with artwork of its own, such as a product or a file preview. The artwork is the slot's background rather than a separate element inside it. |
| Leading Visual | Flavour=icon | A system or category source with neither a face nor artwork. It tells entries apart least well of the three, so it is the fallback rather than the first choice. |
| Title and timestamp | text inputs | The two pieces of text the component takes. Title carries what happened and defaults to Urgent Message, Time Stamp carries when and defaults to Just now. |
| Body and filename | not parameterised | The message body is part of the component's content rather than inputs it accepts. Only the title, attachment and timestamp are parameterized. |

### Anatomy

1. **Leading Visual** — The square slot standing for whoever or whatever the entry came from. Its Flavour picks an avatar, an image or an icon, and it is circular in all three.
2. **Content** — The column holding the header, the message, the attachment row and the action slot.
3. **Group Indicator** — The bar marking a collapsed group. Hidden until Group is turned on, and present only while the entry is unread.

### How to use

**Do:**
- Keep the title to the event and the body to the detail. The body truncates, so the title has to carry the meaning on its own.
- Switch off the rows you have no content for. An empty attachment row reads as a failed load rather than an absence.

**Don't:**
- Don't rely on Group on a read entry. The bar appears only while the entry is unread.
- Don't use Read as a general status. It carries two values, and anything past seen and unseen needs another mechanism.

### Accessibility & Content Guidelines

- Unread is carried by a fill and a small dot, both visual only. The unread state has to be exposed in the markup as well.
- The notification has no focus state of its own. Only the Button in the action slot is focusable by default, so reaching the entry itself comes from code.
- The border sits at zero weight by default and is bound to border/default, so a high-contrast theme can raise it to a hard outline. At the default weight an entry is bounded by its fill and the spacing around it.
- The leading visual carries no text in any of its three flavours, and on the image flavour the artwork is a background rather than an element of its own. The source has to be named in the title or described alongside the image.
- The urgency indicator is an icon with no text. It needs a name, or the urgency is invisible to anyone not seeing the glyph.
- The body truncates rather than wrapping on. The full message has to be reachable some other way.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Fixed width, hug height | 360 wide, and 164 tall with every row shown. Hiding the attachment takes it to 140 and hiding the actions to 120. |
| Padding and gap | Fixed | space/gutter top and bottom, space/card left and right, with a space/sm gap between the leading visual and the content column. |
| Radius | Fixed | radius/md on all four corners, identical on both variants. There is no shape property. |
| Fill | Per Read | surface/card when Read is false. Read=true carries no fill at all. |
| Border | Theming | A stroke bound to border/default sits on both variants at zero weight. The weight is a theming hook rather than an omission, so a high-contrast variable set can give every main component a hard outline, including elements that carry none by default. |
| Group Indicator | Fixed, absolute | Component width less 24 by 4 height, centered and pinned to the bottom edge, filled with border/focus and rounded to radius/md. Being absolute it does not affect the card's height. |
| Leading Visual | Fixed | 36 square on all three flavours, with radius/pill on every one so the slot is always circular. The Avatar sits at Size=xxsmall and the Icon at Size=medium, both centered inside the frame. |
| Type | Theming | Title uses label/large and Body body/small, both over foreground/primary. Timestamp is label/small over foreground/tertiary and the attachment filename label/small over foreground/link. |

### Layer structure

- Notification Item (COMPONENT)
  - Notification Item/Leading Visual (INSTANCE)
  - Notification Item/Content (FRAME)
    - Notification Item/Content/Message (FRAME)
      - Notification Item/Content/Message/Header (FRAME)
        - Notification Item/Content/Message/Header/Frame 1 (FRAME)
          - Notification Item/Content/Message/Header/Frame 1/Notification Indicator (INSTANCE)
        - Notification Item/Content/Message/Header/Title (TEXT)
        - Notification Item/Content/Message/Header/Metadata (FRAME)
          - Notification Item/Content/Message/Header/Metadata/Timestamp (TEXT)
          - Notification Item/Content/Message/Header/Metadata/Icon Indicator (INSTANCE)
      - Notification Item/Content/Message/Body (TEXT)
    - Notification Item/Content/Attachment (FRAME)
      - Notification Item/Content/Attachment/Attachment Icon (INSTANCE, icon: attachment)
      - Notification Item/Content/Attachment/Attachment Filename (TEXT)
    - Notification Item/Content/Action Slots (SLOT)
  - Notification Item/Group Indicator (RECTANGLE)

### Resolved tokens (default variant: Read=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Notification Item | fill[0] | #f8fbff | surface.card |
| Notification Item | stroke[0] | #ced2db | border.default |
| Notification Item | cornerRadius | 8 | radius.md |
| Notification Item | strokeWeight | 0 | stroke.base |
| Notification Item | itemSpacing | 8 | space.sm |
| Notification Item | padding.left | 12 | space.card |
| Notification Item | padding.right | 12 | space.card |
| Notification Item | padding.top | 16 | space.gutter |
| Notification Item | padding.bottom | 16 | space.gutter |
| Notification Item/Leading Visual | width | 36 | control.sm |
| Notification Item/Leading Visual | height | 36 | control.sm |
| Notification Item/Leading Visual | cornerRadius | 9999 | radius.pill |
| Notification Item/Content | itemSpacing | 8 | space.sm |
| Notification Item/Content/Message | itemSpacing | 4 | space.xxs |
| Notification Item/Content/Message/Header | itemSpacing | 8 | space.sm |
| Notification Item/Content/Message/Header/Frame 1 | itemSpacing | 10 | — |
| Notification Item/Content/Message/Header/Frame 1 | padding.top | 8 | space.sm |
| Notification Item/Content/Message/Header/Frame 1 | padding.bottom | 8 | space.sm |
| Notification Item/Content/Message/Header/Frame 1/Notification Indicator | fill[0] | #1f69ff | interactive.primary.background.default |
| Notification Item/Content/Message/Header/Frame 1/Notification Indicator | stroke[0] | #ffffff | border.inverse |
| Notification Item/Content/Message/Header/Frame 1/Notification Indicator | cornerRadius | 9999 | radius.pill |
| Notification Item/Content/Message/Header/Frame 1/Notification Indicator | strokeWeight | 0 | stroke.base |
| Notification Item/Content/Message/Header/Frame 1/Notification Indicator | itemSpacing | 4 | space.xxs |
| Notification Item/Content/Message/Header/Title | fill[0] | #0c0d0e | foreground.primary |
| Notification Item/Content/Message/Header/Title | fontSize | 16 | label.large.font size |
| Notification Item/Content/Message/Header/Title | lineHeight | 24 | label.large.line height |
| Notification Item/Content/Message/Header/Title | letterSpacing | 0 | label.large.letter spacing |
| Notification Item/Content/Message/Header/Metadata | itemSpacing | 4 | space.xxs |
| Notification Item/Content/Message/Header/Metadata | padding.top | 2 | space.2xs |
| Notification Item/Content/Message/Header/Metadata | padding.bottom | 2 | space.2xs |
| Notification Item/Content/Message/Header/Metadata/Timestamp | fill[0] | #7a8190 | foreground.tertiary |
| Notification Item/Content/Message/Header/Metadata/Timestamp | fontSize | 12 | label.small.font size |
| Notification Item/Content/Message/Header/Metadata/Timestamp | lineHeight | 16 | label.small.line height |
| Notification Item/Content/Message/Header/Metadata/Timestamp | letterSpacing | 0 | label.small.letter spacing |
| Notification Item/Content/Message/Header/Metadata/Icon Indicator | width | 16 | control.icon-sm |
| Notification Item/Content/Message/Header/Metadata/Icon Indicator | height | 16 | control.icon-sm |
| Notification Item/Content/Message/Header/Metadata/Icon Indicator | fill[0] | #d70015 | interactive.destructive.background.default |
| Notification Item/Content/Message/Header/Metadata/Icon Indicator | cornerRadius | 9999 | radius.pill |
| Notification Item/Content/Message/Body | fill[0] | #0c0d0e | foreground.primary |
| Notification Item/Content/Message/Body | fontSize | 14 | body.small.font size |
| Notification Item/Content/Message/Body | lineHeight | 18 | body.small.line height |
| Notification Item/Content/Message/Body | letterSpacing | 0 | body.small.letter spacing |
| Notification Item/Content/Attachment | itemSpacing | 4 | space.xxs |
| Notification Item/Content/Attachment/Attachment Icon | itemSpacing | 4 | space.xxs |
| Notification Item/Content/Attachment/Attachment Filename | fill[0] | #1f69ff | foreground.link |
| Notification Item/Content/Attachment/Attachment Filename | fontSize | 12 | label.small.font size |
| Notification Item/Content/Attachment/Attachment Filename | lineHeight | 16 | label.small.line height |
| Notification Item/Content/Attachment/Attachment Filename | letterSpacing | 0 | label.small.letter spacing |
| Notification Item/Content/Action Slots | itemSpacing | 4 | space.xxs |
| Notification Item/Group Indicator | fill[0] | #3886ff | border.focus |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Read | true | Notification Item | fill[0] | — |
| Read | true | Notification Item/Content/Message/Header/Frame 1 | padding.top | — |
| Read | true | Notification Item/Content/Message/Header/Frame 1 | padding.bottom | — |
| Read | true | Notification Item/Content/Message/Header/Frame 1/Notification Indicator | fill[0] | — |
| Read | true | Notification Item/Content/Message/Header/Frame 1/Notification Indicator | stroke[0] | — |
| Read | true | Notification Item/Content/Message/Header/Frame 1/Notification Indicator | cornerRadius | — |
| Read | true | Notification Item/Content/Message/Header/Frame 1/Notification Indicator | strokeWeight | — |
| Read | true | Notification Item/Content/Message/Header/Frame 1/Notification Indicator | itemSpacing | — |
| Read | true | Notification Item/Content/Message/Header/Title | fontSize | body.medium.font size |
| Read | true | Notification Item/Content/Message/Header/Title | lineHeight | body.medium.line height |
| Read | true | Notification Item/Content/Message/Header/Title | letterSpacing | body.medium.letter spacing |
| Read | true | Notification Item/Group Indicator | fill[0] | — |

## _Leading Visual

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6032-3319&m=dev

### Layer structure

- _Leading Visual (COMPONENT)
  - _Leading Visual/Avatar (INSTANCE)
  - _Leading Visual/Icon (INSTANCE, icon: verified)

### Resolved tokens (default variant: Flavour=avatar)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| _Leading Visual | width | 36 | control.sm |
| _Leading Visual | height | 36 | control.sm |
| _Leading Visual | cornerRadius | 9999 | radius.pill |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Flavour | icon | _Leading Visual | stroke[0] | border.default |
| Flavour | image | _Leading Visual | width | — |
