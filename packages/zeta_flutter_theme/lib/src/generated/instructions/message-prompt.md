# Message Prompt

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6649-196&m=dev

## Message Input

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6962-798&m=dev

### Overview

The composer for a message prompt. One State property moves it between typing, dictation, voice recording and the assistant speaking back, swapping the body region each time. Two slots let a product add its own attachment row and its own extra tools.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| State | empty | true | The resting composer, nothing typed. Send stays off until there is something to send. |
| State | filled | - | A typed message ready to go. Send turns on here and nowhere earlier. |
| State | attachment-open | - | The attachment tray is showing its choices. Transient, not a resting state. |
| State | listening | - | Dictation is capturing speech. Extra tools drop away so nothing competes with Stop. |
| State | transcribing | - | Speech captured, text not back yet. Everything is off, so it must not linger. |
| State | dictated | - | Dictation returned text the person can still edit. Treat it as filled, not as sent. |
| State | recording | - | A voice message is being captured. Unlike listening, this ends as audio. |
| State | playback | - | A take waiting to be sent or discarded. The only chance to hear it first. |
| State | speaking | - | The assistant is replying aloud. The only state with no toolbar at all. |
| State | disabled | - | Composing is unavailable. Say why in the value text, or there is nothing to act on. |
| Attachment File Slot | slot | — | Holds whatever the product attaches, above the text. Empty until the product fills it. |
| More Tools Slot | slot | — | Room for product tools beside Attachment. Icon controls only, at the toolbar's size. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| empty | Resting | — | Placeholder at foreground/disabled, Send disabled. |
| filled | Text entered | — | The value moves to foreground/primary and Send enables. |
| attachment-open | Attachment pressed | — | Attachment expands to its open form and the More Tools slot drops out. |
| listening | Dictation started | — | Text swaps for the Voice bar. Actions become Stop and a disabled Send. |
| transcribing | Dictation stopped | — | The Voice bar holds while every control disables. |
| dictated | Transcript returned | — | The Voice bar swaps back to Text carrying the transcript, and Send enables. |
| recording | Record started | — | The Voice bar gains a foreground/error dot and a discard control. Send stays off. |
| playback | Record stopped | — | The Voice bar gains Play, a full waveform and an elapsed timer. Send enables. |
| speaking | Assistant replies | — | The body becomes an orb and a caption. The toolbar is gone entirely. |
| disabled | — | — | Surface and border take their disabled tokens and every control turns off. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | No transition is defined. Each state is a swap of the body region and the toolbar. |
| Body region | Text, Voice and Speaking are mutually exclusive. Only one is ever present. |
| Send enablement | Send is on only where there is something to send, at filled, attachment-open, dictated and playback. |
| Two voice paths | Dictation ends as editable text. Recording ends as an audio message. They share the Voice bar and nothing else. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Message value | text | The typed or dictated text. Not exposed as an input, so it comes from the implementation. |
| Slots | two, product filled | The only places a product adds content of its own. |
| Slots | Attachment File Slot | Sits above the text on filled and attachment-open. |
| Slots | More Tools Slot | Sits beside Attachment in the toolbar. Absent on attachment-open and listening. |
| Nested controls | Icon Button and Attachment | Every control is an Icon Button at Shape=full. Attachment has its own frame. |
| Voice and Speaking | drawn | The waveform, timer, orb and caption are drawn by the component, not passed in. |

### Anatomy

1. **Body region** — Text, Voice or Speaking. One at a time, and it sets the height.
2. **Toolbar** — Tools on the left, Actions on the right. Absent while speaking.
3. **Slots** — Attachment File above the text, More Tools beside Attachment.

### How to use

**Do:**
- Say why in the value text when disabled. A composer that refuses input without a reason reads as broken.
- Keep playback in the recording flow. It is the only chance to hear a take before sending it.

**Don't:**
- Don't use listening for a voice message. It ends as text, recording ends as audio.
- Don't put a toolbar back during speaking. It is absent so nothing can be composed over the reply.

### Accessibility & Content Guidelines

- State changes are not announced. Dictation starting, transcription finishing and the assistant speaking all need announcing by the surrounding structure.
- The waveform and the orb carry no text. The label and timer beside them are all a reader gets, so they have to say what is happening.
- Send is disabled in five of the ten states. Disabled does not say why, so the value text or a nearby message has to.
- Every control is an icon with no label. Each needs a name, and the names differ by state even where the glyph repeats.
- While speaking there is no toolbar and only Stop speaking interrupts it. That control has to be reachable by keyboard.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Fixed width, hug height | 440 wide. Height follows the body region, 130 empty, 146 voice, 168 with an attachment row and 276 speaking. |
| Padding and gap | Fixed | space/md on all four sides, space/sm between the body region and the toolbar. |
| Radius | Fixed | radius/container on every state. |
| Surface | Per State | surface/card with a border/default outline, moving to interactive/neutral/background/disabled and border/disabled when disabled. |
| Body region | One of three | Text, Voice or Speaking. Text carries body/medium at 16px. |
| Toolbar | Fixed | Tools on the left, Actions on the right. Controls are 36 square, Send and Stop 40. |
| Voice bar | Fixed | 48 tall on surface/track, holding a 2px bar waveform, a label, a timer and one trailing control. |

### Layer structure

- Message Input (COMPONENT)
  - Message Input/Text (FRAME)
    - Message Input/Text/Value (TEXT)
  - Message Input/Toolbar (FRAME)
    - Message Input/Toolbar/Tools (FRAME)
      - Message Input/Toolbar/Tools/Attachment (INSTANCE)
      - Message Input/Toolbar/Tools/More Tools Slot (SLOT)
    - Message Input/Toolbar/Actions (FRAME)
      - Message Input/Toolbar/Actions/Dictate (INSTANCE)
      - Message Input/Toolbar/Actions/Send (INSTANCE)
      - Message Input/Toolbar/Actions/Stop (INSTANCE)
  - Message Input/Attachment File Slot (SLOT)
  - Message Input/Voice (FRAME)
    - Message Input/Voice/Voice Bar (FRAME)
      - Message Input/Voice/Voice Bar/Waveform (FRAME)
        - Message Input/Voice/Voice Bar/Waveform/Level[1] (RECTANGLE)
        - Message Input/Voice/Voice Bar/Waveform/Level[2] (RECTANGLE)
        - Message Input/Voice/Voice Bar/Waveform/Level[3] (RECTANGLE)
        - Message Input/Voice/Voice Bar/Waveform/Level[4] (RECTANGLE)
        - Message Input/Voice/Voice Bar/Waveform/Level[5] (RECTANGLE)
        - Message Input/Voice/Voice Bar/Waveform/Level[6] (RECTANGLE)
        - Message Input/Voice/Voice Bar/Waveform/Level[7] (RECTANGLE)
        - Message Input/Voice/Voice Bar/Waveform/Level[8] (RECTANGLE)
        - Message Input/Voice/Voice Bar/Waveform/Level[9] (RECTANGLE)
        - Message Input/Voice/Voice Bar/Waveform/Level[10] (RECTANGLE)
        - Message Input/Voice/Voice Bar/Waveform/Level[11] (RECTANGLE)
        - Message Input/Voice/Voice Bar/Waveform/Level[12] (RECTANGLE)
        - Message Input/Voice/Voice Bar/Waveform/Level[13] (RECTANGLE)
        - Message Input/Voice/Voice Bar/Waveform/Level[14] (RECTANGLE)
        - Message Input/Voice/Voice Bar/Waveform/Level[15] (RECTANGLE)
        - Message Input/Voice/Voice Bar/Waveform/Level[16] (RECTANGLE)
        - Message Input/Voice/Voice Bar/Waveform/Level[17] (RECTANGLE)
        - Message Input/Voice/Voice Bar/Waveform/Level[18] (RECTANGLE)
        - Message Input/Voice/Voice Bar/Waveform/Level[19] (RECTANGLE)
        - Message Input/Voice/Voice Bar/Waveform/Level[20] (RECTANGLE)
        - Message Input/Voice/Voice Bar/Waveform/Level[21] (RECTANGLE)
        - Message Input/Voice/Voice Bar/Waveform/Level[22] (RECTANGLE)
        - Message Input/Voice/Voice Bar/Waveform/Level[23] (RECTANGLE)
        - Message Input/Voice/Voice Bar/Waveform/Level[24] (RECTANGLE)
      - Message Input/Voice/Voice Bar/Label (TEXT)
      - Message Input/Voice/Voice Bar/Time (TEXT)
      - Message Input/Voice/Voice Bar/Cancel dictation (INSTANCE)
      - Message Input/Voice/Voice Bar/Progress Circle (INSTANCE)
      - Message Input/Voice/Voice Bar/Cancel transcription (INSTANCE)
      - Message Input/Voice/Voice Bar/Recording Dot (ELLIPSE)
      - Message Input/Voice/Voice Bar/Discard recording (INSTANCE)
      - Message Input/Voice/Voice Bar/Play (INSTANCE)
      - Message Input/Voice/Voice Bar/Record again (INSTANCE)
      - Message Input/Voice/Voice Bar/Delete voice message (INSTANCE)
    - Message Input/Voice/Hint (TEXT)
  - Message Input/Attachment Slot (FRAME)
    - Message Input/Attachment Slot/Assist Chip (INSTANCE)
  - Message Input/Speaking (FRAME)
    - Message Input/Speaking/Orb (FRAME)
      - Message Input/Speaking/Orb/Ring 1 (ELLIPSE)
      - Message Input/Speaking/Orb/Ring 2 (ELLIPSE)
      - Message Input/Speaking/Orb/Ring 3 (ELLIPSE)
      - Message Input/Speaking/Orb/Ring 4 (ELLIPSE)
      - Message Input/Speaking/Orb/Ring 5 (ELLIPSE)
      - Message Input/Speaking/Orb/Ring 6 (ELLIPSE)
    - Message Input/Speaking/Caption (TEXT)
    - Message Input/Speaking/Stop speaking (INSTANCE)

### Resolved tokens (default variant: State=empty)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Message Input | fill[0] | #ffffff | surface.card |
| Message Input | stroke[0] | #ced2db | border.default |
| Message Input | cornerRadius | 12 | radius.container |
| Message Input | strokeWeight | 1 | stroke.thin |
| Message Input | itemSpacing | 8 | space.sm |
| Message Input | padding.left | 12 | space.md |
| Message Input | padding.right | 12 | space.md |
| Message Input | padding.top | 12 | space.md |
| Message Input | padding.bottom | 12 | space.md |
| Message Input/Text | padding.left | 12 | space.md |
| Message Input/Text | padding.right | 12 | space.md |
| Message Input/Text | padding.top | 4 | space.xxs |
| Message Input/Text | padding.bottom | 4 | space.xxs |
| Message Input/Text/Value | fill[0] | #8d95a3 | foreground.disabled |
| Message Input/Text/Value | fontSize | 16 | body.medium.font size |
| Message Input/Text/Value | lineHeight | 24 | body.medium.line height |
| Message Input/Text/Value | letterSpacing | 0 | body.medium.letter spacing |
| Message Input/Toolbar | itemSpacing | 8 | — |
| Message Input/Toolbar/Tools | itemSpacing | 4 | space.xxs |
| Message Input/Toolbar/Tools/Attachment | itemSpacing | 4 | space.xxs |
| Message Input/Toolbar/Tools/More Tools Slot | itemSpacing | 4 | space.xxs |
| Message Input/Toolbar/Actions | itemSpacing | 4 | space.xxs |
| Message Input/Toolbar/Actions/Dictate | width | 36 | control.sm |
| Message Input/Toolbar/Actions/Dictate | height | 36 | control.sm |
| Message Input/Toolbar/Actions/Dictate | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| Message Input/Toolbar/Actions/Dictate | stroke[0] | #ced2db | interactive.neutral.border.default |
| Message Input/Toolbar/Actions/Dictate | cornerRadius | 9999 | radius.pill |
| Message Input/Toolbar/Actions/Dictate | strokeWeight | 0 | stroke.base |
| Message Input/Toolbar/Actions/Dictate | padding.left | 4 | space.xxs |
| Message Input/Toolbar/Actions/Dictate | padding.right | 4 | space.xxs |
| Message Input/Toolbar/Actions/Dictate | padding.top | 4 | space.xxs |
| Message Input/Toolbar/Actions/Dictate | padding.bottom | 4 | space.xxs |
| Message Input/Toolbar/Actions/Send | width | 36 | control.sm |
| Message Input/Toolbar/Actions/Send | height | 36 | control.sm |
| Message Input/Toolbar/Actions/Send | fill[0] | #e0e3e9 | interactive.primary.background.disabled |
| Message Input/Toolbar/Actions/Send | stroke[0] | #e0e3e9 | interactive.primary.border.disabled |
| Message Input/Toolbar/Actions/Send | cornerRadius | 9999 | radius.pill |
| Message Input/Toolbar/Actions/Send | strokeWeight | 0 | stroke.base |
| Message Input/Toolbar/Actions/Send | padding.left | 4 | space.xxs |
| Message Input/Toolbar/Actions/Send | padding.right | 4 | space.xxs |
| Message Input/Toolbar/Actions/Send | padding.top | 4 | space.xxs |
| Message Input/Toolbar/Actions/Send | padding.bottom | 4 | space.xxs |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| State | filled | Message Input/Text/Value | fill[0] | foreground.primary |
| State | filled | Message Input/Toolbar/Actions/Send | fill[0] | interactive.primary.background.default |
| State | filled | Message Input/Toolbar/Actions/Send | stroke[0] | interactive.primary.border.default |
| State | filled | Message Input/Attachment File Slot | itemSpacing | space.xxs |
| State | attachment-open | Message Input/Toolbar/Tools/More Tools Slot | itemSpacing | — |
| State | attachment-open | Message Input/Toolbar/Actions/Send | fill[0] | interactive.primary.background.default |
| State | attachment-open | Message Input/Toolbar/Actions/Send | stroke[0] | interactive.primary.border.default |
| State | attachment-open | Message Input/Attachment File Slot | itemSpacing | space.xxs |
| State | listening | Message Input/Text | padding.left | — |
| State | listening | Message Input/Text | padding.right | — |
| State | listening | Message Input/Text | padding.top | — |
| State | listening | Message Input/Text | padding.bottom | — |
| State | listening | Message Input/Text/Value | fill[0] | — |
| State | listening | Message Input/Text/Value | fontSize | — |
| State | listening | Message Input/Text/Value | lineHeight | — |
| State | listening | Message Input/Text/Value | letterSpacing | — |
| State | listening | Message Input/Toolbar/Tools/More Tools Slot | itemSpacing | — |
| State | listening | Message Input/Toolbar/Actions/Dictate | width | — |
| State | listening | Message Input/Toolbar/Actions/Dictate | height | — |
| State | listening | Message Input/Toolbar/Actions/Dictate | fill[0] | — |
| State | listening | Message Input/Toolbar/Actions/Dictate | stroke[0] | — |
| State | listening | Message Input/Toolbar/Actions/Dictate | cornerRadius | — |
| State | listening | Message Input/Toolbar/Actions/Dictate | strokeWeight | — |
| State | listening | Message Input/Toolbar/Actions/Dictate | padding.left | — |
| State | listening | Message Input/Toolbar/Actions/Dictate | padding.right | — |
| State | listening | Message Input/Toolbar/Actions/Dictate | padding.top | — |
| State | listening | Message Input/Toolbar/Actions/Dictate | padding.bottom | — |
| State | listening | Message Input/Voice | itemSpacing | space.sm |
| State | listening | Message Input/Voice/Voice Bar | fill[0] | surface.track |
| State | listening | Message Input/Voice/Voice Bar | cornerRadius | radius.element-md |
| State | listening | Message Input/Voice/Voice Bar | itemSpacing | space.sm |
| State | listening | Message Input/Voice/Voice Bar | padding.left | space.md |
| State | listening | Message Input/Voice/Voice Bar | padding.right | space.xxs |
| State | listening | Message Input/Voice/Voice Bar | padding.top | space.xxs |
| State | listening | Message Input/Voice/Voice Bar | padding.bottom | space.xxs |
| State | listening | Message Input/Voice/Voice Bar/Waveform | height | control.icon-md |
| State | listening | Message Input/Voice/Voice Bar/Waveform | itemSpacing | space.2xs |
| State | listening | Message Input/Voice/Voice Bar/Waveform/Level[1] | width | stroke.thick |
| State | listening | Message Input/Voice/Voice Bar/Waveform/Level[1] | fill[0] | foreground.primary |
| State | listening | Message Input/Voice/Voice Bar/Waveform/Level[1] | cornerRadius | radius.pill |
| State | listening | Message Input/Voice/Voice Bar/Waveform/Level[2] | width | stroke.thick |
| State | listening | Message Input/Voice/Voice Bar/Waveform/Level[2] | fill[0] | foreground.primary |
| State | listening | Message Input/Voice/Voice Bar/Waveform/Level[2] | cornerRadius | radius.pill |
| State | listening | Message Input/Voice/Voice Bar/Waveform/Level[3] | width | stroke.thick |
| State | listening | Message Input/Voice/Voice Bar/Waveform/Level[3] | fill[0] | foreground.primary |
| State | listening | Message Input/Voice/Voice Bar/Waveform/Level[3] | cornerRadius | radius.pill |
| State | listening | Message Input/Voice/Voice Bar/Waveform/Level[4] | width | stroke.thick |
| State | listening | Message Input/Voice/Voice Bar/Waveform/Level[4] | fill[0] | foreground.primary |
| State | listening | Message Input/Voice/Voice Bar/Waveform/Level[4] | cornerRadius | radius.pill |
| State | listening | Message Input/Voice/Voice Bar/Waveform/Level[5] | width | stroke.thick |
| State | listening | Message Input/Voice/Voice Bar/Waveform/Level[5] | fill[0] | foreground.primary |
| State | listening | Message Input/Voice/Voice Bar/Waveform/Level[5] | cornerRadius | radius.pill |
| State | listening | Message Input/Voice/Voice Bar/Waveform/Level[6] | width | stroke.thick |
| State | listening | Message Input/Voice/Voice Bar/Waveform/Level[6] | fill[0] | foreground.primary |
| State | listening | Message Input/Voice/Voice Bar/Waveform/Level[6] | cornerRadius | radius.pill |
| State | listening | Message Input/Voice/Voice Bar/Waveform/Level[7] | width | stroke.thick |
| State | listening | Message Input/Voice/Voice Bar/Waveform/Level[7] | fill[0] | foreground.primary |
| State | listening | Message Input/Voice/Voice Bar/Waveform/Level[7] | cornerRadius | radius.pill |
| State | listening | Message Input/Voice/Voice Bar/Waveform/Level[8] | width | stroke.thick |
| State | listening | Message Input/Voice/Voice Bar/Waveform/Level[8] | fill[0] | foreground.primary |
| State | listening | Message Input/Voice/Voice Bar/Waveform/Level[8] | cornerRadius | radius.pill |
| State | listening | Message Input/Voice/Voice Bar/Waveform/Level[9] | width | stroke.thick |
| State | listening | Message Input/Voice/Voice Bar/Waveform/Level[9] | fill[0] | foreground.primary |
| State | listening | Message Input/Voice/Voice Bar/Waveform/Level[9] | cornerRadius | radius.pill |
| State | listening | Message Input/Voice/Voice Bar/Label | fill[0] | foreground.primary |
| State | listening | Message Input/Voice/Voice Bar/Label | fontSize | body.medium.font size |
| State | listening | Message Input/Voice/Voice Bar/Label | lineHeight | body.medium.line height |
| State | listening | Message Input/Voice/Voice Bar/Label | letterSpacing | body.medium.letter spacing |
| State | listening | Message Input/Voice/Voice Bar/Time | fill[0] | foreground.secondary |
| State | listening | Message Input/Voice/Voice Bar/Time | fontSize | body.medium.font size |
| State | listening | Message Input/Voice/Voice Bar/Time | lineHeight | body.medium.line height |
| State | listening | Message Input/Voice/Voice Bar/Time | letterSpacing | body.medium.letter spacing |
| State | listening | Message Input/Voice/Voice Bar/Cancel dictation | width | control.sm |
| State | listening | Message Input/Voice/Voice Bar/Cancel dictation | height | control.sm |
| State | listening | Message Input/Voice/Voice Bar/Cancel dictation | fill[0] | interactive.ghost.background.default |
| State | listening | Message Input/Voice/Voice Bar/Cancel dictation | stroke[0] | interactive.neutral.border.default |
| State | listening | Message Input/Voice/Voice Bar/Cancel dictation | cornerRadius | radius.pill |
| State | listening | Message Input/Voice/Voice Bar/Cancel dictation | strokeWeight | stroke.base |
| State | listening | Message Input/Voice/Voice Bar/Cancel dictation | padding.left | space.xxs |
| State | listening | Message Input/Voice/Voice Bar/Cancel dictation | padding.right | space.xxs |
| State | listening | Message Input/Voice/Voice Bar/Cancel dictation | padding.top | space.xxs |
| State | listening | Message Input/Voice/Voice Bar/Cancel dictation | padding.bottom | space.xxs |
| State | listening | Message Input/Voice/Hint | fill[0] | foreground.secondary |
| State | listening | Message Input/Voice/Hint | fontSize | body.xsmall.font size |
| State | listening | Message Input/Voice/Hint | lineHeight | body.xsmall.line height |
| State | listening | Message Input/Voice/Hint | letterSpacing | body.xsmall.letter spacing |
| State | listening | Message Input/Toolbar/Actions/Stop | width | control.sm |
| State | listening | Message Input/Toolbar/Actions/Stop | height | control.sm |
| State | listening | Message Input/Toolbar/Actions/Stop | fill[0] | interactive.primary.background.default |
| State | listening | Message Input/Toolbar/Actions/Stop | stroke[0] | interactive.primary.border.default |
| State | listening | Message Input/Toolbar/Actions/Stop | cornerRadius | radius.pill |
| State | listening | Message Input/Toolbar/Actions/Stop | strokeWeight | stroke.base |
| State | listening | Message Input/Toolbar/Actions/Stop | padding.left | space.xxs |
| State | listening | Message Input/Toolbar/Actions/Stop | padding.right | space.xxs |
| State | listening | Message Input/Toolbar/Actions/Stop | padding.top | space.xxs |
| State | listening | Message Input/Toolbar/Actions/Stop | padding.bottom | space.xxs |
| State | transcribing | Message Input/Text | padding.left | — |
| State | transcribing | Message Input/Text | padding.right | — |
| State | transcribing | Message Input/Text | padding.top | — |
| State | transcribing | Message Input/Text | padding.bottom | — |
| State | transcribing | Message Input/Text/Value | fill[0] | — |
| State | transcribing | Message Input/Text/Value | fontSize | — |
| State | transcribing | Message Input/Text/Value | lineHeight | — |
| State | transcribing | Message Input/Text/Value | letterSpacing | — |
| State | transcribing | Message Input/Toolbar/Actions/Dictate | fill[0] | interactive.ghost.background.disabled |
| State | transcribing | Message Input/Toolbar/Actions/Dictate | stroke[0] | interactive.ghost.border.disabled |
| State | transcribing | Message Input/Voice | itemSpacing | space.sm |
| State | transcribing | Message Input/Voice/Voice Bar | fill[0] | surface.track |
| State | transcribing | Message Input/Voice/Voice Bar | cornerRadius | radius.element-md |
| State | transcribing | Message Input/Voice/Voice Bar | itemSpacing | space.sm |
| State | transcribing | Message Input/Voice/Voice Bar | padding.left | space.md |
| State | transcribing | Message Input/Voice/Voice Bar | padding.right | space.xxs |
| State | transcribing | Message Input/Voice/Voice Bar | padding.top | space.xxs |
| State | transcribing | Message Input/Voice/Voice Bar | padding.bottom | space.xxs |
| State | transcribing | Message Input/Voice/Voice Bar/Label | fill[0] | foreground.primary |
| State | transcribing | Message Input/Voice/Voice Bar/Label | fontSize | body.medium.font size |
| State | transcribing | Message Input/Voice/Voice Bar/Label | lineHeight | body.medium.line height |
| State | transcribing | Message Input/Voice/Voice Bar/Label | letterSpacing | body.medium.letter spacing |
| State | transcribing | Message Input/Voice/Voice Bar/Cancel transcription | width | control.sm |
| State | transcribing | Message Input/Voice/Voice Bar/Cancel transcription | height | control.sm |
| State | transcribing | Message Input/Voice/Voice Bar/Cancel transcription | fill[0] | interactive.ghost.background.default |
| State | transcribing | Message Input/Voice/Voice Bar/Cancel transcription | stroke[0] | interactive.neutral.border.default |
| State | transcribing | Message Input/Voice/Voice Bar/Cancel transcription | cornerRadius | radius.pill |
| State | transcribing | Message Input/Voice/Voice Bar/Cancel transcription | strokeWeight | stroke.base |
| State | transcribing | Message Input/Voice/Voice Bar/Cancel transcription | padding.left | space.xxs |
| State | transcribing | Message Input/Voice/Voice Bar/Cancel transcription | padding.right | space.xxs |
| State | transcribing | Message Input/Voice/Voice Bar/Cancel transcription | padding.top | space.xxs |
| State | transcribing | Message Input/Voice/Voice Bar/Cancel transcription | padding.bottom | space.xxs |
| State | transcribing | Message Input/Voice/Hint | fill[0] | foreground.secondary |
| State | transcribing | Message Input/Voice/Hint | fontSize | body.xsmall.font size |
| State | transcribing | Message Input/Voice/Hint | lineHeight | body.xsmall.line height |
| State | transcribing | Message Input/Voice/Hint | letterSpacing | body.xsmall.letter spacing |
| State | dictated | Message Input/Text/Value | fill[0] | foreground.primary |
| State | dictated | Message Input/Toolbar/Actions/Send | fill[0] | interactive.primary.background.default |
| State | dictated | Message Input/Toolbar/Actions/Send | stroke[0] | interactive.primary.border.default |
| State | dictated | Message Input/Attachment Slot | itemSpacing | space.xxs |
| State | dictated | Message Input/Attachment Slot/Assist Chip | fill[0] | interactive.neutral.background.default |
| State | dictated | Message Input/Attachment Slot/Assist Chip | stroke[0] | border.info |
| State | dictated | Message Input/Attachment Slot/Assist Chip | cornerRadius | radius.pill |
| State | dictated | Message Input/Attachment Slot/Assist Chip | strokeWeight | stroke.thin |
| State | dictated | Message Input/Attachment Slot/Assist Chip | itemSpacing | space.2xs |
| State | dictated | Message Input/Attachment Slot/Assist Chip | padding.left | space.sm |
| State | dictated | Message Input/Attachment Slot/Assist Chip | padding.right | space.sm |
| State | dictated | Message Input/Attachment Slot/Assist Chip | padding.top | space.xs |
| State | dictated | Message Input/Attachment Slot/Assist Chip | padding.bottom | space.xs |
| State | recording | Message Input/Text | padding.left | — |
| State | recording | Message Input/Text | padding.right | — |
| State | recording | Message Input/Text | padding.top | — |
| State | recording | Message Input/Text | padding.bottom | — |
| State | recording | Message Input/Text/Value | fill[0] | — |
| State | recording | Message Input/Text/Value | fontSize | — |
| State | recording | Message Input/Text/Value | lineHeight | — |
| State | recording | Message Input/Text/Value | letterSpacing | — |
| State | recording | Message Input/Toolbar/Actions/Dictate | width | — |
| State | recording | Message Input/Toolbar/Actions/Dictate | height | — |
| State | recording | Message Input/Toolbar/Actions/Dictate | fill[0] | — |
| State | recording | Message Input/Toolbar/Actions/Dictate | stroke[0] | — |
| State | recording | Message Input/Toolbar/Actions/Dictate | cornerRadius | — |
| State | recording | Message Input/Toolbar/Actions/Dictate | strokeWeight | — |
| State | recording | Message Input/Toolbar/Actions/Dictate | padding.left | — |
| State | recording | Message Input/Toolbar/Actions/Dictate | padding.right | — |
| State | recording | Message Input/Toolbar/Actions/Dictate | padding.top | — |
| State | recording | Message Input/Toolbar/Actions/Dictate | padding.bottom | — |
| State | recording | Message Input/Voice | itemSpacing | space.sm |
| State | recording | Message Input/Voice/Voice Bar | fill[0] | surface.track |
| State | recording | Message Input/Voice/Voice Bar | cornerRadius | radius.element-md |
| State | recording | Message Input/Voice/Voice Bar | itemSpacing | space.sm |
| State | recording | Message Input/Voice/Voice Bar | padding.left | space.md |
| State | recording | Message Input/Voice/Voice Bar | padding.right | space.xxs |
| State | recording | Message Input/Voice/Voice Bar | padding.top | space.xxs |
| State | recording | Message Input/Voice/Voice Bar | padding.bottom | space.xxs |
| State | recording | Message Input/Voice/Voice Bar/Recording Dot | width | space.sm |
| State | recording | Message Input/Voice/Voice Bar/Recording Dot | height | space.sm |
| State | recording | Message Input/Voice/Voice Bar/Recording Dot | fill[0] | foreground.error |
| State | recording | Message Input/Voice/Voice Bar/Waveform | height | control.icon-md |
| State | recording | Message Input/Voice/Voice Bar/Waveform | itemSpacing | space.2xs |
| State | recording | Message Input/Voice/Voice Bar/Waveform/Level[1] | width | stroke.thick |
| State | recording | Message Input/Voice/Voice Bar/Waveform/Level[1] | fill[0] | foreground.primary |
| State | recording | Message Input/Voice/Voice Bar/Waveform/Level[1] | cornerRadius | radius.pill |
| State | recording | Message Input/Voice/Voice Bar/Waveform/Level[2] | width | stroke.thick |
| State | recording | Message Input/Voice/Voice Bar/Waveform/Level[2] | fill[0] | foreground.primary |
| State | recording | Message Input/Voice/Voice Bar/Waveform/Level[2] | cornerRadius | radius.pill |
| State | recording | Message Input/Voice/Voice Bar/Waveform/Level[3] | width | stroke.thick |
| State | recording | Message Input/Voice/Voice Bar/Waveform/Level[3] | fill[0] | foreground.primary |
| State | recording | Message Input/Voice/Voice Bar/Waveform/Level[3] | cornerRadius | radius.pill |
| State | recording | Message Input/Voice/Voice Bar/Waveform/Level[4] | width | stroke.thick |
| State | recording | Message Input/Voice/Voice Bar/Waveform/Level[4] | fill[0] | foreground.primary |
| State | recording | Message Input/Voice/Voice Bar/Waveform/Level[4] | cornerRadius | radius.pill |
| State | recording | Message Input/Voice/Voice Bar/Waveform/Level[5] | width | stroke.thick |
| State | recording | Message Input/Voice/Voice Bar/Waveform/Level[5] | fill[0] | foreground.primary |
| State | recording | Message Input/Voice/Voice Bar/Waveform/Level[5] | cornerRadius | radius.pill |
| State | recording | Message Input/Voice/Voice Bar/Waveform/Level[6] | width | stroke.thick |
| State | recording | Message Input/Voice/Voice Bar/Waveform/Level[6] | fill[0] | foreground.primary |
| State | recording | Message Input/Voice/Voice Bar/Waveform/Level[6] | cornerRadius | radius.pill |
| State | recording | Message Input/Voice/Voice Bar/Waveform/Level[7] | width | stroke.thick |
| State | recording | Message Input/Voice/Voice Bar/Waveform/Level[7] | fill[0] | foreground.primary |
| State | recording | Message Input/Voice/Voice Bar/Waveform/Level[7] | cornerRadius | radius.pill |
| State | recording | Message Input/Voice/Voice Bar/Waveform/Level[8] | width | stroke.thick |
| State | recording | Message Input/Voice/Voice Bar/Waveform/Level[8] | fill[0] | foreground.primary |
| State | recording | Message Input/Voice/Voice Bar/Waveform/Level[8] | cornerRadius | radius.pill |
| State | recording | Message Input/Voice/Voice Bar/Waveform/Level[9] | width | stroke.thick |
| State | recording | Message Input/Voice/Voice Bar/Waveform/Level[9] | fill[0] | foreground.primary |
| State | recording | Message Input/Voice/Voice Bar/Waveform/Level[9] | cornerRadius | radius.pill |
| State | recording | Message Input/Voice/Voice Bar/Label | fill[0] | foreground.primary |
| State | recording | Message Input/Voice/Voice Bar/Label | fontSize | body.medium.font size |
| State | recording | Message Input/Voice/Voice Bar/Label | lineHeight | body.medium.line height |
| State | recording | Message Input/Voice/Voice Bar/Label | letterSpacing | body.medium.letter spacing |
| State | recording | Message Input/Voice/Voice Bar/Time | fill[0] | foreground.secondary |
| State | recording | Message Input/Voice/Voice Bar/Time | fontSize | body.medium.font size |
| State | recording | Message Input/Voice/Voice Bar/Time | lineHeight | body.medium.line height |
| State | recording | Message Input/Voice/Voice Bar/Time | letterSpacing | body.medium.letter spacing |
| State | recording | Message Input/Voice/Voice Bar/Discard recording | width | control.sm |
| State | recording | Message Input/Voice/Voice Bar/Discard recording | height | control.sm |
| State | recording | Message Input/Voice/Voice Bar/Discard recording | fill[0] | interactive.ghost.background.default |
| State | recording | Message Input/Voice/Voice Bar/Discard recording | stroke[0] | interactive.neutral.border.default |
| State | recording | Message Input/Voice/Voice Bar/Discard recording | cornerRadius | radius.pill |
| State | recording | Message Input/Voice/Voice Bar/Discard recording | strokeWeight | stroke.base |
| State | recording | Message Input/Voice/Voice Bar/Discard recording | padding.left | space.xxs |
| State | recording | Message Input/Voice/Voice Bar/Discard recording | padding.right | space.xxs |
| State | recording | Message Input/Voice/Voice Bar/Discard recording | padding.top | space.xxs |
| State | recording | Message Input/Voice/Voice Bar/Discard recording | padding.bottom | space.xxs |
| State | recording | Message Input/Voice/Hint | fill[0] | foreground.secondary |
| State | recording | Message Input/Voice/Hint | fontSize | body.xsmall.font size |
| State | recording | Message Input/Voice/Hint | lineHeight | body.xsmall.line height |
| State | recording | Message Input/Voice/Hint | letterSpacing | body.xsmall.letter spacing |
| State | recording | Message Input/Toolbar/Actions/Stop | width | control.sm |
| State | recording | Message Input/Toolbar/Actions/Stop | height | control.sm |
| State | recording | Message Input/Toolbar/Actions/Stop | fill[0] | interactive.primary.background.default |
| State | recording | Message Input/Toolbar/Actions/Stop | stroke[0] | interactive.primary.border.default |
| State | recording | Message Input/Toolbar/Actions/Stop | cornerRadius | radius.pill |
| State | recording | Message Input/Toolbar/Actions/Stop | strokeWeight | stroke.base |
| State | recording | Message Input/Toolbar/Actions/Stop | padding.left | space.xxs |
| State | recording | Message Input/Toolbar/Actions/Stop | padding.right | space.xxs |
| State | recording | Message Input/Toolbar/Actions/Stop | padding.top | space.xxs |
| State | recording | Message Input/Toolbar/Actions/Stop | padding.bottom | space.xxs |
| State | playback | Message Input/Text | padding.left | — |
| State | playback | Message Input/Text | padding.right | — |
| State | playback | Message Input/Text | padding.top | — |
| State | playback | Message Input/Text | padding.bottom | — |
| State | playback | Message Input/Text/Value | fill[0] | — |
| State | playback | Message Input/Text/Value | fontSize | — |
| State | playback | Message Input/Text/Value | lineHeight | — |
| State | playback | Message Input/Text/Value | letterSpacing | — |
| State | playback | Message Input/Toolbar/Actions/Dictate | width | — |
| State | playback | Message Input/Toolbar/Actions/Dictate | height | — |
| State | playback | Message Input/Toolbar/Actions/Dictate | fill[0] | — |
| State | playback | Message Input/Toolbar/Actions/Dictate | stroke[0] | — |
| State | playback | Message Input/Toolbar/Actions/Dictate | cornerRadius | — |
| State | playback | Message Input/Toolbar/Actions/Dictate | strokeWeight | — |
| State | playback | Message Input/Toolbar/Actions/Dictate | padding.left | — |
| State | playback | Message Input/Toolbar/Actions/Dictate | padding.right | — |
| State | playback | Message Input/Toolbar/Actions/Dictate | padding.top | — |
| State | playback | Message Input/Toolbar/Actions/Dictate | padding.bottom | — |
| State | playback | Message Input/Toolbar/Actions/Send | fill[0] | interactive.primary.background.default |
| State | playback | Message Input/Toolbar/Actions/Send | stroke[0] | interactive.primary.border.default |
| State | playback | Message Input/Voice | itemSpacing | space.sm |
| State | playback | Message Input/Voice/Voice Bar | fill[0] | surface.track |
| State | playback | Message Input/Voice/Voice Bar | cornerRadius | radius.element-md |
| State | playback | Message Input/Voice/Voice Bar | itemSpacing | space.sm |
| State | playback | Message Input/Voice/Voice Bar | padding.left | space.xxs |
| State | playback | Message Input/Voice/Voice Bar | padding.right | space.xxs |
| State | playback | Message Input/Voice/Voice Bar | padding.top | space.xxs |
| State | playback | Message Input/Voice/Voice Bar | padding.bottom | space.xxs |
| State | playback | Message Input/Voice/Voice Bar/Play | width | control.sm |
| State | playback | Message Input/Voice/Voice Bar/Play | height | control.sm |
| State | playback | Message Input/Voice/Voice Bar/Play | fill[0] | interactive.primary.background.default |
| State | playback | Message Input/Voice/Voice Bar/Play | stroke[0] | interactive.primary.border.default |
| State | playback | Message Input/Voice/Voice Bar/Play | cornerRadius | radius.pill |
| State | playback | Message Input/Voice/Voice Bar/Play | strokeWeight | stroke.base |
| State | playback | Message Input/Voice/Voice Bar/Play | padding.left | space.xxs |
| State | playback | Message Input/Voice/Voice Bar/Play | padding.right | space.xxs |
| State | playback | Message Input/Voice/Voice Bar/Play | padding.top | space.xxs |
| State | playback | Message Input/Voice/Voice Bar/Play | padding.bottom | space.xxs |
| State | playback | Message Input/Voice/Voice Bar/Waveform | height | control.icon-md |
| State | playback | Message Input/Voice/Voice Bar/Waveform | itemSpacing | space.2xs |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[1] | width | stroke.thick |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[1] | fill[0] | foreground.primary |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[1] | cornerRadius | radius.pill |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[2] | width | stroke.thick |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[2] | fill[0] | foreground.primary |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[2] | cornerRadius | radius.pill |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[3] | width | stroke.thick |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[3] | fill[0] | foreground.primary |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[3] | cornerRadius | radius.pill |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[4] | width | stroke.thick |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[4] | fill[0] | foreground.primary |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[4] | cornerRadius | radius.pill |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[5] | width | stroke.thick |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[5] | fill[0] | foreground.primary |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[5] | cornerRadius | radius.pill |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[6] | width | stroke.thick |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[6] | fill[0] | foreground.primary |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[6] | cornerRadius | radius.pill |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[7] | width | stroke.thick |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[7] | fill[0] | foreground.primary |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[7] | cornerRadius | radius.pill |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[8] | width | stroke.thick |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[8] | fill[0] | foreground.primary |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[8] | cornerRadius | radius.pill |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[9] | width | stroke.thick |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[9] | fill[0] | foreground.primary |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[9] | cornerRadius | radius.pill |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[10] | width | stroke.thick |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[10] | fill[0] | foreground.primary |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[10] | cornerRadius | radius.pill |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[11] | width | stroke.thick |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[11] | fill[0] | foreground.primary |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[11] | cornerRadius | radius.pill |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[12] | width | stroke.thick |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[12] | fill[0] | foreground.primary |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[12] | cornerRadius | radius.pill |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[13] | width | stroke.thick |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[13] | fill[0] | foreground.primary |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[13] | cornerRadius | radius.pill |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[14] | width | stroke.thick |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[14] | fill[0] | foreground.primary |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[14] | cornerRadius | radius.pill |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[15] | width | stroke.thick |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[15] | fill[0] | foreground.primary |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[15] | cornerRadius | radius.pill |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[16] | width | stroke.thick |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[16] | fill[0] | foreground.primary |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[16] | cornerRadius | radius.pill |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[17] | width | stroke.thick |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[17] | fill[0] | foreground.primary |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[17] | cornerRadius | radius.pill |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[18] | width | stroke.thick |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[18] | fill[0] | foreground.primary |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[18] | cornerRadius | radius.pill |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[19] | width | stroke.thick |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[19] | fill[0] | foreground.primary |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[19] | cornerRadius | radius.pill |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[20] | width | stroke.thick |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[20] | fill[0] | foreground.primary |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[20] | cornerRadius | radius.pill |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[21] | width | stroke.thick |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[21] | fill[0] | foreground.primary |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[21] | cornerRadius | radius.pill |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[22] | width | stroke.thick |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[22] | fill[0] | foreground.primary |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[22] | cornerRadius | radius.pill |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[23] | width | stroke.thick |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[23] | fill[0] | foreground.primary |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[23] | cornerRadius | radius.pill |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[24] | width | stroke.thick |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[24] | fill[0] | foreground.primary |
| State | playback | Message Input/Voice/Voice Bar/Waveform/Level[24] | cornerRadius | radius.pill |
| State | playback | Message Input/Voice/Voice Bar/Time | fill[0] | foreground.secondary |
| State | playback | Message Input/Voice/Voice Bar/Time | fontSize | body.medium.font size |
| State | playback | Message Input/Voice/Voice Bar/Time | lineHeight | body.medium.line height |
| State | playback | Message Input/Voice/Voice Bar/Time | letterSpacing | body.medium.letter spacing |
| State | playback | Message Input/Voice/Voice Bar/Record again | width | control.sm |
| State | playback | Message Input/Voice/Voice Bar/Record again | height | control.sm |
| State | playback | Message Input/Voice/Voice Bar/Record again | fill[0] | interactive.ghost.background.default |
| State | playback | Message Input/Voice/Voice Bar/Record again | stroke[0] | interactive.neutral.border.default |
| State | playback | Message Input/Voice/Voice Bar/Record again | cornerRadius | radius.pill |
| State | playback | Message Input/Voice/Voice Bar/Record again | strokeWeight | stroke.base |
| State | playback | Message Input/Voice/Voice Bar/Record again | padding.left | space.xxs |
| State | playback | Message Input/Voice/Voice Bar/Record again | padding.right | space.xxs |
| State | playback | Message Input/Voice/Voice Bar/Record again | padding.top | space.xxs |
| State | playback | Message Input/Voice/Voice Bar/Record again | padding.bottom | space.xxs |
| State | playback | Message Input/Voice/Voice Bar/Delete voice message | width | control.sm |
| State | playback | Message Input/Voice/Voice Bar/Delete voice message | height | control.sm |
| State | playback | Message Input/Voice/Voice Bar/Delete voice message | fill[0] | interactive.ghost.background.default |
| State | playback | Message Input/Voice/Voice Bar/Delete voice message | stroke[0] | interactive.neutral.border.default |
| State | playback | Message Input/Voice/Voice Bar/Delete voice message | cornerRadius | radius.pill |
| State | playback | Message Input/Voice/Voice Bar/Delete voice message | strokeWeight | stroke.base |
| State | playback | Message Input/Voice/Voice Bar/Delete voice message | padding.left | space.xxs |
| State | playback | Message Input/Voice/Voice Bar/Delete voice message | padding.right | space.xxs |
| State | playback | Message Input/Voice/Voice Bar/Delete voice message | padding.top | space.xxs |
| State | playback | Message Input/Voice/Voice Bar/Delete voice message | padding.bottom | space.xxs |
| State | playback | Message Input/Voice/Hint | fill[0] | foreground.secondary |
| State | playback | Message Input/Voice/Hint | fontSize | body.xsmall.font size |
| State | playback | Message Input/Voice/Hint | lineHeight | body.xsmall.line height |
| State | playback | Message Input/Voice/Hint | letterSpacing | body.xsmall.letter spacing |
| State | speaking | Message Input/Text | padding.left | — |
| State | speaking | Message Input/Text | padding.right | — |
| State | speaking | Message Input/Text | padding.top | — |
| State | speaking | Message Input/Text | padding.bottom | — |
| State | speaking | Message Input/Text/Value | fill[0] | — |
| State | speaking | Message Input/Text/Value | fontSize | — |
| State | speaking | Message Input/Text/Value | lineHeight | — |
| State | speaking | Message Input/Text/Value | letterSpacing | — |
| State | speaking | Message Input/Toolbar/Tools | itemSpacing | — |
| State | speaking | Message Input/Toolbar/Tools/Attachment | itemSpacing | — |
| State | speaking | Message Input/Toolbar/Tools/More Tools Slot | itemSpacing | — |
| State | speaking | Message Input/Toolbar/Actions | itemSpacing | — |
| State | speaking | Message Input/Toolbar/Actions/Dictate | width | — |
| State | speaking | Message Input/Toolbar/Actions/Dictate | height | — |
| State | speaking | Message Input/Toolbar/Actions/Dictate | fill[0] | — |
| State | speaking | Message Input/Toolbar/Actions/Dictate | stroke[0] | — |
| State | speaking | Message Input/Toolbar/Actions/Dictate | cornerRadius | — |
| State | speaking | Message Input/Toolbar/Actions/Dictate | strokeWeight | — |
| State | speaking | Message Input/Toolbar/Actions/Dictate | padding.left | — |
| State | speaking | Message Input/Toolbar/Actions/Dictate | padding.right | — |
| State | speaking | Message Input/Toolbar/Actions/Dictate | padding.top | — |
| State | speaking | Message Input/Toolbar/Actions/Dictate | padding.bottom | — |
| State | speaking | Message Input/Toolbar/Actions/Send | width | — |
| State | speaking | Message Input/Toolbar/Actions/Send | height | — |
| State | speaking | Message Input/Toolbar/Actions/Send | fill[0] | — |
| State | speaking | Message Input/Toolbar/Actions/Send | stroke[0] | — |
| State | speaking | Message Input/Toolbar/Actions/Send | cornerRadius | — |
| State | speaking | Message Input/Toolbar/Actions/Send | strokeWeight | — |
| State | speaking | Message Input/Toolbar/Actions/Send | padding.left | — |
| State | speaking | Message Input/Toolbar/Actions/Send | padding.right | — |
| State | speaking | Message Input/Toolbar/Actions/Send | padding.top | — |
| State | speaking | Message Input/Toolbar/Actions/Send | padding.bottom | — |
| State | speaking | Message Input/Speaking | itemSpacing | space.md |
| State | speaking | Message Input/Speaking | padding.top | space.md |
| State | speaking | Message Input/Speaking | padding.bottom | space.xxs |
| State | speaking | Message Input/Speaking/Orb/Ring 1 | stroke[0] | linear-gradient(90deg, surface.gradient.start 0%, surface.gradient.end 100%) |
| State | speaking | Message Input/Speaking/Orb/Ring 2 | stroke[0] | linear-gradient(90deg, surface.gradient.start 0%, surface.gradient.end 100%) |
| State | speaking | Message Input/Speaking/Orb/Ring 3 | stroke[0] | linear-gradient(90deg, surface.gradient.start 0%, surface.gradient.end 100%) |
| State | speaking | Message Input/Speaking/Orb/Ring 4 | stroke[0] | linear-gradient(90deg, surface.gradient.start 0%, surface.gradient.end 100%) |
| State | speaking | Message Input/Speaking/Orb/Ring 5 | stroke[0] | linear-gradient(90deg, surface.gradient.start 0%, surface.gradient.end 100%) |
| State | speaking | Message Input/Speaking/Orb/Ring 6 | stroke[0] | linear-gradient(90deg, surface.gradient.start 0%, surface.gradient.end 100%) |
| State | speaking | Message Input/Speaking/Caption | fill[0] | foreground.primary |
| State | speaking | Message Input/Speaking/Caption | fontSize | body.medium.font size |
| State | speaking | Message Input/Speaking/Caption | lineHeight | body.medium.line height |
| State | speaking | Message Input/Speaking/Caption | letterSpacing | body.medium.letter spacing |
| State | speaking | Message Input/Speaking/Stop speaking | width | control.sm |
| State | speaking | Message Input/Speaking/Stop speaking | height | control.sm |
| State | speaking | Message Input/Speaking/Stop speaking | fill[0] | surface.track |
| State | speaking | Message Input/Speaking/Stop speaking | cornerRadius | radius.pill |
| State | speaking | Message Input/Speaking/Stop speaking | padding.left | space.xxs |
| State | speaking | Message Input/Speaking/Stop speaking | padding.right | space.xxs |
| State | speaking | Message Input/Speaking/Stop speaking | padding.top | space.xxs |
| State | speaking | Message Input/Speaking/Stop speaking | padding.bottom | space.xxs |
| State | disabled | Message Input | fill[0] | interactive.neutral.background.disabled |
| State | disabled | Message Input | stroke[0] | border.disabled |
| State | disabled | Message Input/Toolbar/Actions/Dictate | fill[0] | interactive.ghost.background.disabled |
| State | disabled | Message Input/Toolbar/Actions/Dictate | stroke[0] | interactive.ghost.border.disabled |

## Attachment

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=6683-11946&m=dev

### Overview

The attachment control in Message Input's toolbar. Closed it is a single add button. Open it expands into a row of attachment type controls the product supplies through a slot.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Open | false | true | The resting control, one button. Use it wherever the choices are not needed on screen. |
| Open | true | - | The tray is showing its choices. Transient, because the toolbar loses its other tools while it is open. |
| Attachment Control Slot | slot | — | The attachment types the product offers. Left empty it opens onto nothing. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| Open=false | Resting | — | A single add control. |
| Open=true | Control pressed | — | The glyph becomes close, the button takes its pressed surface and the slot appears. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | No transition is defined. Opening is a swap, not an animation. |
| Toolbar cost | Open, it takes the room the More Tools slot would use, and the parent drops that slot. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Attachment Control Slot | slot, product filled | Takes one icon control per attachment type. Four fit at the drawn width. |
| Toggle control | nested Icon Button | Drawn by the component. Its glyph flips between add and close with Open. |

### Anatomy

1. **Toggle** — The add control, becoming close while the tray is open.
2. **Control slot** — Where the product puts its attachment types.
3. **Open width** — Closed it is one control. Open it is the toggle plus the slot.

### How to use

**Do:**
- Fill the slot with the types the product supports. An open tray with nothing in it is a dead end.
- Close the tray once a type is chosen. It costs the toolbar its other tools while open.

**Don't:**
- Don't leave it open as a resting state. The More Tools slot disappears while it is.
- Don't put labelled buttons in the slot. It is sized for icon controls at the toolbar's height.

### Accessibility & Content Guidelines

- The toggle is an icon with no text. It needs a name, and the name changes with Open.
- Opening the tray reveals controls without moving focus. That change has to be announced.
- Each control in the slot is an icon only, so every one needs a name saying what it attaches.
- The tray and the toolbar share a row. Keyboard order has to follow what a person sees.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Size | Fixed per Open | 36 square closed, 196 by 36 open. |
| Toggle control | Fixed | A 36 Icon Button at Shape=full, Flavour=subtle. |
| Control slot | Fixed | 156 by 36 when open, sized for four 36 controls. |
| Surface | Theming | The toggle takes interactive/ghost/background, default closed and pressed open. |

### Layer structure

- Attachment (COMPONENT)
  - Attachment/Icon Button (INSTANCE)
  - Attachment/Attachment Control Slot (SLOT)

### Resolved tokens (default variant: Open=false)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Attachment | itemSpacing | 4 | space.xxs |
| Attachment/Icon Button | height | 36 | control.sm |
| Attachment/Icon Button | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| Attachment/Icon Button | stroke[0] | #ced2db | interactive.neutral.border.default |
| Attachment/Icon Button | cornerRadius | 9999 | radius.pill |
| Attachment/Icon Button | strokeWeight | 0 | stroke.base |
| Attachment/Icon Button | padding.left | 4 | space.xxs |
| Attachment/Icon Button | padding.right | 4 | space.xxs |
| Attachment/Icon Button | padding.top | 4 | space.xxs |
| Attachment/Icon Button | padding.bottom | 4 | space.xxs |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Open | true | Attachment/Icon Button | fill[0] | interactive.ghost.background.pressed |
| Open | true | Attachment/Attachment Control Slot | itemSpacing | space.xxs |
