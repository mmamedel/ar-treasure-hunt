# Animation System

This document explains how to add animations to 3D models in the AR treasure hunt.

## Overview

The animation system allows you to configure different animations for each treasure model directly in the `treasures.json` file. Animations are applied in real-time during the AR experience.

## Configuration

Add an `animation` property to any treasure in `treasures.json`:

```json
{
	"id": 0,
	"model": {
		"file": "model.glb",
		"scale": "0.5 0.5 0.5",
		"rotation": "0 0 0",
		"position": "0 0 0"
	},
	"animation": {
		"type": "rotation",
		"axis": "y",
		"speed": 0.5
	}
}
```

## Animation Types

### 1. Rotation

Continuously rotates the model around a specified axis.

```json
"animation": {
  "type": "rotation",
  "axis": "y",        // Options: "x", "y", "z"
  "speed": 0.5        // Rotation speed (0.1 = slow, 2.0 = fast)
}
```

**Example use cases:**

- Flying objects (birds, planes)
- Rotating coins or medallions
- Spinning wheels

### 2. Bobbing

Creates a smooth up-and-down floating motion.

```json
"animation": {
  "type": "bobbing",
  "speed": 1,         // Bobbing speed (0.5 = slow, 2.0 = fast)
  "amount": 0.15      // Height of the bobbing (0.05 = subtle, 0.3 = dramatic)
}
```

**Example use cases:**

- Floating objects
- Hovering items
- Breathing effects

### 3. Swing

Creates a pendulum/swinging motion around an axis.

```json
"animation": {
  "type": "swing",
  "axis": "z",        // Options: "x", "y", "z"
  "speed": 1,         // Swing speed (0.5 = slow, 2.0 = fast)
  "amount": 0.2       // Swing angle in radians (0.1 = subtle, 0.5 = dramatic)
}
```

**Example use cases:**

- Hanging objects (lanterns, ropes)
- Pendulums
- Swaying trees

### 4. Scale Pulse

Makes the model grow and shrink rhythmically.

```json
"animation": {
  "type": "scale-pulse",
  "speed": 1,         // Pulse speed (0.5 = slow, 2.0 = fast)
  "amount": 0.1       // Scale variation (0.05 = subtle, 0.3 = dramatic)
}
```

**Example use cases:**

- Heartbeats
- Breathing effects
- Attention-grabbing elements

## No Animation

If you don't want any animation for a model, simply omit the `animation` property or set it to `null`:

```json
{
	"id": 3,
	"model": {
		"file": "model.glb",
		"scale": "0.5 0.5 0.5"
	}
	// No animation property
}
```

## Current Treasure Animations

### Treasure 0: Serene_Flight_1120145255_texture

- **Animation**: Slow Y-axis rotation
- **Effect**: Model rotates slowly in place

### Treasure 1: Euphoria_by_the_Pool

- **Animation**: Bobbing
- **Effect**: Gentle up-and-down floating motion

### Treasure 2: wood_bucket2

- **Animation**: Swinging on Z-axis
- **Effect**: Pendulum-like swinging motion

### Treasures 3-5: Torah Scrolls

- **Animation**: None
- **Effect**: Static models

## Tips

1. **Speed values**: Start with `0.5` to `1.0` for most animations, then adjust based on the model
2. **Amount values**: Keep them subtle (0.1-0.3) for a professional look
3. **Rotation axis**:
   - Y-axis: Most common for vertical rotation
   - X-axis: Front-to-back rotation
   - Z-axis: Side-to-side tilt
4. **Combining effects**: Currently, only one animation can be applied per model

## Implementation Details

The animation system is implemented in `/static/ar-viewer.html` in the `applyAnimation()` function. Animations run at approximately 60fps during the AR session and only apply when the image target is detected.
