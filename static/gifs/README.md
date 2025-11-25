# Treasure GIFs

This directory contains GIF animations for each treasure in the collection.

## Required Files

Create both a GIF and a static PNG for each treasure with the following naming pattern:

**Animated GIFs:**

- `treasure-0.gif` - Piscina (Batismo de Jesus)
- `treasure-1.gif` - Lava-olho (cura do cego)
- `treasure-2.gif` - Torneira (samaritana no poço)
- `treasure-3.gif` - Mirante (tentação no alto monte)
- `treasure-4.gif` - Karaokê (Jesus e discípulos cantaram)
- `treasure-5.gif` - Auditório (Jesus na sinagoga)

**Static Images (first frame):**

- `treasure-0-static.png` - Piscina (Batismo de Jesus)
- `treasure-1-static.png` - Lava-olho (cura do cego)
- `treasure-2-static.png` - Torneira (samaritana no poço)
- `treasure-3-static.png` - Mirante (tentação no alto monte)
- `treasure-4-static.png` - Karaokê (Jesus e discípulos cantaram)
- `treasure-5-static.png` - Auditório (Jesus na sinagoga)

## Recommendations

- **Size**: Keep GIFs under 2MB for optimal mobile performance
- **Dimensions**: 400x400px or similar square format works well
- **Duration**: 2-4 seconds looping animations
- **Content**: Show the 3D model rotating or an animated representation of the treasure

## Creating Static Images from GIFs

To extract the first frame from a GIF and save as PNG:

**Using ImageMagick:**

```bash
convert treasure-0.gif[0] treasure-0-static.png
```

**Using ffmpeg:**

```bash
ffmpeg -i treasure-0.gif -frames:v 1 treasure-0-static.png
```

**Using online tools:**

- ezgif.com/split
- Upload GIF, download first frame as PNG

## How It Works

- **Non-selected treasures**: Display the static PNG image (slightly dimmed)
- **Selected treasure**: Display the animated GIF (with fade-in animation)
- **Last found treasure**: Auto-selected on page load to celebrate achievement

## Fallback

If static images or GIFs are not found, the collection page will display the treasure's emoji instead.

## Future Enhancement (Phase 2)

Later, we'll add interactive 3D model viewing with:

- Full-screen modal
- Pinch-to-zoom
- Rotate on X-axis
- Touch gesture controls
