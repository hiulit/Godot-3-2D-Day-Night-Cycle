# Moon Light

**Extends**: `Light2D`

## Table of contents

### Variables

- [color_night](#color_night)
- [energy_night](#energy_night)
- [color_dawn](#color_dawn)
- [energy_dawn](#energy_dawn)
- [color_day](#color_day)
- [energy_day](#energy_day)
- [color_dusk](#color_dusk)
- [energy_dusk](#energy_dusk)
- [move_moon](#move_moon)
- [cycle_sync_node_path](#cycle_sync_node_path)
- [static_moon](#static_moon)
- [use_hour_position](#use_hour_position)
- [hour_position](#hour_position)
- [path](#path)

## Variables

### color_night

The color of the night state.

```gdscript
export (Color) var color_night = Color(1.0, 1.0, 1.0, 1.0)
```

|Name|Type|Default|
|:-|:-|:-|
|`color_night`|`Color`|`Color(1.0, 1.0, 1.0, 1.0)`|

### energy_night

The energy value of the night state.
The larger the value, the stronger the light.

```gdscript
export (float) var energy_night = 1.0
```

|Name|Type|Default|
|:-|:-|:-|
|`energy_night`|`float`|`1.0`|

### color_dawn

The color of the dawn state.

```gdscript
export (Color) var color_dawn = Color(1.0, 1.0, 1.0, 1.0)
```

|Name|Type|Default|
|:-|:-|:-|
|`color_dawn`|`Color`|`Color(1.0, 1.0, 1.0, 1.0)`|

### energy_dawn

The energy value of the dawn state.
The larger the value, the stronger the light.

```gdscript
export (float) var energy_dawn = 0.0
```

|Name|Type|Default|
|:-|:-|:-|
|`energy_dawn`|`float`|`0.0`|

### color_day

The color of the day state.

```gdscript
export (Color) var color_day = Color(1.0, 1.0, 1.0, 1.0)
```

|Name|Type|Default|
|:-|:-|:-|
|`color_day`|`Color`|`Color(1.0, 1.0, 1.0, 1.0)`|

### energy_day

The energy value of the day state.
The larger the value, the stronger the light.

```gdscript
export (float) var energy_day = 0.0
```

|Name|Type|Default|
|:-|:-|:-|
|`energy_day`|`float`|`0.0`|

### color_dusk

The color of the dusk state.

```gdscript
export (Color) var color_dusk = Color(1.0, 1.0, 1.0, 1.0)
```

|Name|Type|Default|
|:-|:-|:-|
|`color_dusk`|`Color`|`Color(1.0, 1.0, 1.0, 1.0)`|

### energy_dusk

The energy value of the dusk state.
The larger the value, the stronger the light.

```gdscript
export (float) var energy_dusk = 0.0
```

|Name|Type|Default|
|:-|:-|:-|
|`energy_dusk`|`float`|`0.0`|

### move_moon

Enables the `MoonLight` node movement.

```gdscript
export (bool) var move_moon = false
```

|Name|Type|Default|
|:-|:-|:-|
|`move_moon`|`bool`|`false`|

### cycle_sync_node_path

The `DayNightCycle` node which the moon will sync with.

The `MoonLight` node will only show if there is a `DayNightCycle` node assigned to it.

```gdscript
export (NodePath) var cycle_sync_node_path
```

|Name|Type|Default|
|:-|:-|:-|
|`cycle_sync_node_path`|`NodePath`|-|

### static_moon

Disables the `MoonLight` node movement.

```gdscript
export (bool) var static_moon = true
```

|Name|Type|Default|
|:-|:-|:-|
|`static_moon`|`bool`|`true`|

### use_hour_position

If `true`, the position of the `MoonLight` node is determined by [hour_position](#hour_position).

If `false`, the position of the `MoonLight` node is determined by its position.

It only works when [static_moon](#static_moon) is enabled.

```gdscript
export (bool) var use_hour_position = false
```

|Name|Type|Default|
|:-|:-|:-|
|`use_hour_position`|`bool`|`false`|

### hour_position

The hour of the day, in a 24-hour clock, to position the `MoonLight` node (0-23).

```gdscript
export (int, 0, 23) var hour_position = 0
```

|Name|Type|Default|
|:-|:-|:-|
|`hour_position`|`int`|`0`|

### path

The moon light path is a `Curve2D`.

The default path is like the one in the following image.
![](../../example_images/moon_light_path.png)

A new path can be set by changing the `Curve2D`.

```gdscript
var path := Curve2D.new()
```

|Name|Type|Default|
|:-|:-|:-|
|`path`|`Curve2D`|`Curve2D.new()`|

Powered by [GDScriptify](https://github.com/hiulit/gdscriptify).
