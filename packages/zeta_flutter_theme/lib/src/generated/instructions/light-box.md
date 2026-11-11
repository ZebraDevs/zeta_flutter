# Light Box

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=8181-9232&m=dev

## Lightbox

Source: https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5/The-Zebra-Design-System?node-id=8186-337&m=dev

### Overview

A full-size preview over the page, opened from the item being viewed. Images, videos and PDFs render themselves; anything else shows a drawn file sheet with the file's glyph and “No preview for this file”. A toolbar names the item and offers open in a new tab, download and close; previous, next and the arrow keys page through the list.

### Property Breakdown

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Kind | image | true | Never set by hand — derived from the item’s MIME type or extension. An image renders itself, capped at 70% of the viewport’s height, keeping its own ratio. |
| Kind | video | - | Fills the stage’s width where it can; the height cap contains it and the picture keeps its own ratio inside the player. |
| Kind | pdf | - | An embedded document at 70% of the viewport’s height. |
| Kind | other | - | No preview. A drawn file sheet carries the file’s glyph and “No preview for this file”. |
| Shape | rounded | true | The default, matching the system’s other rounded controls. Shape also picks the glyph family for every icon in the toolbar and navigation. |
| Shape | sharp | - | Square corners on the panel and stage, with the sharp glyph family. |
| Show Open In New | true | true | The toolbar offers open in a new tab. The action disables itself when the item has no URL rather than failing silently. |
| Show Open In New | false | - | Removes the action from the toolbar. |
| Show Download | true | true | The toolbar offers download, named after the item. It disables itself when the item has no URL. |
| Show Download | false | - | Removes the action from the toolbar. |
| Show Navigation | true | true | Previous and next float at the stage’s sides and the arrow keys page too. With a single item, navigation hides itself whatever this is set to. |
| Show Navigation | false | - | Hides paging even when several items are passed. |
| Animated | true | true | Paging slides and the stage’s height follows |
| Animated | false | - | Paging and the height change land instantly, with nothing in between. |

### States & Triggers

| State | Trigger | Duration | What changes |
| --- | --- | --- | --- |
| open | Index set on a closed lightbox | — | The backdrop fades in and the panel springs up from the bottom (animations/spring) with the stage already at the current frame’s height. The height never animates on open, and the first frame never slides in. |
| paging | Previous / next, or the arrow keys | 400ms | The track slides to the new frame — the old one glides out as the new one glides in — and the stage’s height follows on the same timing. An interrupted page glides on to the new target instead of restarting. |
| media sized | The current item’s media reports real dimensions | 400ms | The stage re-measures the frame and eases to its true height. Media sizes arrive after mount, so the first measure is never final. |
| reduced motion | OS motion preference | 0 | The whole motion block turns off: paging and height changes land instantly, whatever Animated says. |
| closed | Close, Escape or the backdrop | — | The dialog unmounts; offscreen videos are already paused, and the open-in-place reset arms for the next open. |

### Behavior & Motion Intent

| Type | Description |
| --- | --- |
| Motion | Paging is one transition on the track’s slide and one on the stage’s height: 400ms on cubic-bezier(0.33, 1, 0.68, 1), slower than the small controls’ 250ms because the frames are large and travel far — the slide reads as a scene change, not a flick. Transitions, not keyed animations: an interrupted page glides to the new target instead of restarting, and nothing remounts. |
| Opening | The panel enters from the bottom on animations/spring, carrying the stage at the first frame’s measured height. The height and track transitions arm only once the current frame has reported its real size, or on the first page — so opening never animates the height to meet late-loading media. Only real paging slides and eases. |
| Height response | The stage’s height follows the current frame on the paging timing, as a measured length. Both ends of a height transition must be real lengths — auto never interpolates — so the height is always written as a value, never left to the content. |
| Late media sizes | An image or video only knows its real size once it loads, and a PDF’s load event is unreliable. The stage re-measures when media gains dimensions and again when the panel mounts; never trust the first measure. |
| Track sizing | The track is pinned to the stage, never sized by its content. Sized by content, the tallest frame (a 70vh document) inflates it past the stage, it overflows, and every frame centres against the oversized box instead of the visible window. |
| Media caps | Media caps at 70% of the viewport’s height and keeps its own ratio. Video fills the stage’s width where it can; the cap contains it. The panel never grows wider than the viewport less space/page each side, nor taller than it less the same. |
| Offscreen media | A frame slid out of view pauses its video. Neighbouring frames stay mounted so paging never reloads — which also means they keep playing unless paused. |
| Reduced motion | Animated always yields to the reduced-motion preference: the motion block turns off entirely rather than shortening. |

### Content & Slot

| Property | Type | Description |
| --- | --- | --- |
| Name | text content | The item’s name in the toolbar, from its name, its file’s name or its URL; “Untitled” when none exists. |
| Counter | text content | “{index} of {count}”, shown only while paging through several items. |
| Items | code content | The list being previewed. Neighbouring items stay mounted either side of the current one, so paging never reloads media or flickers. |
| Media | Figma-only placeholder | The drawn media in the variants is a placeholder — the library ships no images. In code the real file renders. |

### Anatomy

1. **Panel** — The raised surface over the backdrop: surface/overlay with a border/default stroke and Dialog’s shadow/large on shadow/soft. Width defaults to control/lg × 16, never wider than the viewport less space/page each side.
2. **Toolbar** — Names the item, counts the pages and holds open in new, download and close — each behind its own property, every one an Icon Button.
3. **Stage** — The media well: surface/subtle sets the content apart from the panel, minimum height control/lg × 6. The track of frames slides inside it, clipped.
4. **Navigation** — Previous and next float at the stage’s sides, vertically centred, contrast flavour so they read over any media.

### How to use

**Do:**
- Open the lightbox from the thing being previewed — a thumbnail, an attachment row — and return focus there when it closes.
- Pass every related item in one list, so previous, next and the arrow keys page through the whole set without reopening.

**Don't:**
- Don’t page by swapping frames. The track slides what is already mounted; remounting reloads media and flickers.
- Don’t fix the stage’s height or leave it auto. It follows the current frame as a measured value — auto cannot animate, and a fixed height crops tall media.

### Accessibility & Content Guidelines

- Backdrop, focus trap, Escape and scroll lock come from Dialog, so focus cannot leave the panel while it is open.
- Previous and next are labelled buttons and the arrow keys page as well; with one item, navigation disappears entirely.
- Open in new and download disable themselves when the item has no URL rather than failing silently.
- Reduced motion turns all sliding off; nothing is communicated by motion alone.
- The file sheet names the file and says “No preview for this file”, so an unpreviewable item is still announced.
- A frame slid out of view pauses its video, so sound never continues behind another frame.

### Layout & Theming Intents

| Property | Type | Description |
| --- | --- | --- |
| Width | Fixed, overridable | control/lg × 16 by default, capped at the viewport less space/page each side. |
| Height | Content, capped | Fits its content up to the viewport less space/page top and bottom; the stage follows the current frame. |
| Stage | Min height | control/lg × 6 minimum. |
| Media | Capped | Up to 70% of the viewport’s height, keeping its ratio |
| Padding | Fixed | space/md around the panel, space/sm between toolbar and stage. |
| Radius | Per Shape | radius/element-md on the panel, radius/element-sm on the stage; radius/none everywhere when sharp. |
| Border | Fixed | stroke/thin on border/default around the panel. |
| Colour | Theming | surface/overlay panel, surface/subtle stage, foreground/primary text. Every value is a semantic token; nothing hardcodes a colour, so modes and extensions arrive free. |

### Layer structure

- Lightbox (COMPONENT)
  - Lightbox/Toolbar (FRAME)
    - Lightbox/Toolbar/Name (TEXT)
    - Lightbox/Toolbar/Counter (TEXT)
    - Lightbox/Toolbar/Actions (FRAME)
      - Lightbox/Toolbar/Actions/Open In New (INSTANCE)
      - Lightbox/Toolbar/Actions/Download (INSTANCE)
      - Lightbox/Toolbar/Actions/Close (INSTANCE)
  - Lightbox/Stage (FRAME)
    - Lightbox/Stage/Media (FRAME)
      - Lightbox/Stage/Media/Icon (INSTANCE, icon: image)
    - Lightbox/Stage/Previous (INSTANCE)
    - Lightbox/Stage/Next (INSTANCE)
    - Lightbox/Stage/Document (FRAME)
      - Lightbox/Stage/Document/Icon (INSTANCE, icon: document)
    - Lightbox/Stage/Unpreviewable (FRAME)
      - Lightbox/Stage/Unpreviewable/Sheet (FRAME)
        - Lightbox/Stage/Unpreviewable/Sheet/Icon (INSTANCE, icon: document)
        - Lightbox/Stage/Unpreviewable/Sheet/Fold (FRAME)
      - Lightbox/Stage/Unpreviewable/No Preview (TEXT)

### Resolved tokens (default variant: Kind=image, Shape=rounded)

| Layer | Field | Raw | Token |
| --- | --- | --- | --- |
| Lightbox | fill[0] | #ffffff | surface.overlay |
| Lightbox | stroke[0] | #ced2db | border.default |
| Lightbox | cornerRadius | 6 | radius.element-md |
| Lightbox | strokeWeight | 1 | stroke.thin |
| Lightbox | itemSpacing | 8 | space.sm |
| Lightbox | padding.left | 12 | space.md |
| Lightbox | padding.right | 12 | space.md |
| Lightbox | padding.top | 12 | space.md |
| Lightbox | padding.bottom | 12 | space.md |
| Lightbox/Toolbar | itemSpacing | 8 | space.sm |
| Lightbox/Toolbar/Name | fill[0] | #0c0d0e | foreground.primary |
| Lightbox/Toolbar/Name | fontSize | 16 | title.medium.font size |
| Lightbox/Toolbar/Name | lineHeight | 20 | title.medium.line height |
| Lightbox/Toolbar/Name | letterSpacing | 0 | title.medium.letter spacing |
| Lightbox/Toolbar/Counter | fill[0] | #545963 | foreground.secondary |
| Lightbox/Toolbar/Counter | fontSize | 16 | body.medium.font size |
| Lightbox/Toolbar/Counter | lineHeight | 24 | body.medium.line height |
| Lightbox/Toolbar/Counter | letterSpacing | 0 | body.medium.letter spacing |
| Lightbox/Toolbar/Actions | itemSpacing | 4 | space.2xs |
| Lightbox/Toolbar/Actions/Open In New | width | 40 | control.md |
| Lightbox/Toolbar/Actions/Open In New | height | 40 | control.md |
| Lightbox/Toolbar/Actions/Open In New | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| Lightbox/Toolbar/Actions/Open In New | stroke[0] | #ced2db | interactive.neutral.border.default |
| Lightbox/Toolbar/Actions/Open In New | cornerRadius | 4 | radius.element-sm |
| Lightbox/Toolbar/Actions/Open In New | strokeWeight | 0 | stroke.base |
| Lightbox/Toolbar/Actions/Open In New | padding.left | 4 | space.2xs |
| Lightbox/Toolbar/Actions/Open In New | padding.right | 4 | space.2xs |
| Lightbox/Toolbar/Actions/Open In New | padding.top | 4 | space.2xs |
| Lightbox/Toolbar/Actions/Open In New | padding.bottom | 4 | space.2xs |
| Lightbox/Toolbar/Actions/Download | width | 40 | control.md |
| Lightbox/Toolbar/Actions/Download | height | 40 | control.md |
| Lightbox/Toolbar/Actions/Download | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| Lightbox/Toolbar/Actions/Download | stroke[0] | #ced2db | interactive.neutral.border.default |
| Lightbox/Toolbar/Actions/Download | cornerRadius | 4 | radius.element-sm |
| Lightbox/Toolbar/Actions/Download | strokeWeight | 0 | stroke.base |
| Lightbox/Toolbar/Actions/Download | padding.left | 4 | space.2xs |
| Lightbox/Toolbar/Actions/Download | padding.right | 4 | space.2xs |
| Lightbox/Toolbar/Actions/Download | padding.top | 4 | space.2xs |
| Lightbox/Toolbar/Actions/Download | padding.bottom | 4 | space.2xs |
| Lightbox/Toolbar/Actions/Close | width | 40 | control.md |
| Lightbox/Toolbar/Actions/Close | height | 40 | control.md |
| Lightbox/Toolbar/Actions/Close | fill[0] | #0c0d0e00 | interactive.ghost.background.default |
| Lightbox/Toolbar/Actions/Close | stroke[0] | #ced2db | interactive.neutral.border.default |
| Lightbox/Toolbar/Actions/Close | cornerRadius | 4 | radius.element-sm |
| Lightbox/Toolbar/Actions/Close | strokeWeight | 0 | stroke.base |
| Lightbox/Toolbar/Actions/Close | padding.left | 4 | space.2xs |
| Lightbox/Toolbar/Actions/Close | padding.right | 4 | space.2xs |
| Lightbox/Toolbar/Actions/Close | padding.top | 4 | space.2xs |
| Lightbox/Toolbar/Actions/Close | padding.bottom | 4 | space.2xs |
| Lightbox/Stage | fill[0] | #f3f6fa | surface.subtle |
| Lightbox/Stage | cornerRadius | 4 | radius.element-sm |
| Lightbox/Stage | padding.top | 16 | space.lg |
| Lightbox/Stage | padding.bottom | 16 | space.lg |
| Lightbox/Stage/Media | fill[0] | #ffffff | surface.card |
| Lightbox/Stage/Previous | width | 40 | control.md |
| Lightbox/Stage/Previous | height | 40 | control.md |
| Lightbox/Stage/Previous | fill[0] | #1d1e23 | interactive.inverse.background.default |
| Lightbox/Stage/Previous | stroke[0] | #1d1e23 | interactive.inverse.border.default |
| Lightbox/Stage/Previous | cornerRadius | 4 | radius.element-sm |
| Lightbox/Stage/Previous | strokeWeight | 0 | stroke.base |
| Lightbox/Stage/Previous | padding.left | 4 | space.2xs |
| Lightbox/Stage/Previous | padding.right | 4 | space.2xs |
| Lightbox/Stage/Previous | padding.top | 4 | space.2xs |
| Lightbox/Stage/Previous | padding.bottom | 4 | space.2xs |
| Lightbox/Stage/Next | width | 40 | control.md |
| Lightbox/Stage/Next | height | 40 | control.md |
| Lightbox/Stage/Next | fill[0] | #1d1e23 | interactive.inverse.background.default |
| Lightbox/Stage/Next | stroke[0] | #1d1e23 | interactive.inverse.border.default |
| Lightbox/Stage/Next | cornerRadius | 4 | radius.element-sm |
| Lightbox/Stage/Next | strokeWeight | 0 | stroke.base |
| Lightbox/Stage/Next | padding.left | 4 | space.2xs |
| Lightbox/Stage/Next | padding.right | 4 | space.2xs |
| Lightbox/Stage/Next | padding.top | 4 | space.2xs |
| Lightbox/Stage/Next | padding.bottom | 4 | space.2xs |

### Token changes by property

| Property | Value | Layer | Field | Token |
| --- | --- | --- | --- | --- |
| Kind | video | Lightbox/Stage | padding.top | — |
| Kind | video | Lightbox/Stage | padding.bottom | — |
| Kind | video | Lightbox/Stage/Media | fill[0] | surface.inverse |
| Kind | pdf | Lightbox/Stage | padding.top | — |
| Kind | pdf | Lightbox/Stage | padding.bottom | — |
| Kind | pdf | Lightbox/Stage/Media | fill[0] | — |
| Kind | pdf | Lightbox/Stage/Document | fill[0] | surface.card |
| Kind | other | Lightbox/Stage | padding.top | — |
| Kind | other | Lightbox/Stage | padding.bottom | — |
| Kind | other | Lightbox/Stage/Media | fill[0] | — |
| Kind | other | Lightbox/Stage/Unpreviewable | itemSpacing | space.md |
| Kind | other | Lightbox/Stage/Unpreviewable | padding.left | space.xl |
| Kind | other | Lightbox/Stage/Unpreviewable | padding.right | space.xl |
| Kind | other | Lightbox/Stage/Unpreviewable | padding.top | space.3xl |
| Kind | other | Lightbox/Stage/Unpreviewable | padding.bottom | space.3xl |
| Kind | other | Lightbox/Stage/Unpreviewable/Sheet | fill[0] | surface.card |
| Kind | other | Lightbox/Stage/Unpreviewable/Sheet | stroke[0] | border.default |
| Kind | other | Lightbox/Stage/Unpreviewable/Sheet | cornerRadius | radius.element-md |
| Kind | other | Lightbox/Stage/Unpreviewable/Sheet | strokeWeight | stroke.thin |
| Kind | other | Lightbox/Stage/Unpreviewable/Sheet/Fold | width | space.lg |
| Kind | other | Lightbox/Stage/Unpreviewable/Sheet/Fold | height | space.lg |
| Kind | other | Lightbox/Stage/Unpreviewable/Sheet/Fold | fill[0] | surface.subtle |
| Kind | other | Lightbox/Stage/Unpreviewable/Sheet/Fold | stroke[0] | border.default |
| Kind | other | Lightbox/Stage/Unpreviewable/No Preview | fill[0] | foreground.secondary |
| Kind | other | Lightbox/Stage/Unpreviewable/No Preview | fontSize | body.medium.font size |
| Kind | other | Lightbox/Stage/Unpreviewable/No Preview | lineHeight | body.medium.line height |
| Kind | other | Lightbox/Stage/Unpreviewable/No Preview | letterSpacing | body.medium.letter spacing |
| Shape | sharp | Lightbox | cornerRadius | radius.none |
| Shape | sharp | Lightbox/Toolbar/Actions/Open In New | cornerRadius | radius.none |
| Shape | sharp | Lightbox/Toolbar/Actions/Download | cornerRadius | radius.none |
| Shape | sharp | Lightbox/Toolbar/Actions/Close | cornerRadius | radius.none |
| Shape | sharp | Lightbox/Stage | cornerRadius | radius.none |
| Shape | sharp | Lightbox/Stage/Previous | cornerRadius | radius.none |
| Shape | sharp | Lightbox/Stage/Next | cornerRadius | radius.none |
