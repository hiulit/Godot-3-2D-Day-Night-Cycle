# MoonLight

**Extends**: `Light2D`

## Table of contents

### Variables

|Name|Type|Default|
|:-|:-|:-|
|[color_night](#color_night)|`Color`|`Color(1.0, 1.0, 1.0, 1.0)`|
|[energy_night](#energy_night)|`float`|`1.0`|
|[color_dawn](#color_dawn)|`Color`|`Color(1.0, 1.0, 1.0, 1.0)`|
|[energy_dawn](#energy_dawn)|`float`|`0.0`|
|[color_day](#color_day)|`Color`|`Color(1.0, 1.0, 1.0, 1.0)`|
|[energy_day](#energy_day)|`float`|`0.0`|
|[color_dusk](#color_dusk)|`Color`|`Color(1.0, 1.0, 1.0, 1.0)`|
|[energy_dusk](#energy_dusk)|`float`|`0.0`|
|[move_moon](#move_moon)|`bool`|`false`|
|[cycle_sync_node_path](#cycle_sync_node_path)|`NodePath`|-|
|[static_moon](#static_moon)|`bool`|`true`|
|[use_hour_position](#use_hour_position)|`bool`|`false`|
|[hour_position](#hour_position)|`int`|`0`|
|[path](#path)|`Curve2D`|`Curve2D.new()`|

## Variables

### color_night

```gdscript
export (Color) var color_night = Color(1.0, 1.0, 1.0, 1.0)
```

The color of the night state.

|Name|Type|Default|
|:-|:-|:-|
|`color_night`|`Color`|`Color(1.0, 1.0, 1.0, 1.0)`|

### energy_night

```gdscript
export (float) var energy_night = 1.0
```

The energy value of the night state.

 The larger the value, the stronger the light.

|Name|Type|Default|
|:-|:-|:-|
|`energy_night`|`float`|`1.0`|

### color_dawn

```gdscript
export (Color) var color_dawn = Color(1.0, 1.0, 1.0, 1.0)
```

The color of the dawn state.

|Name|Type|Default|
|:-|:-|:-|
|`color_dawn`|`Color`|`Color(1.0, 1.0, 1.0, 1.0)`|

### energy_dawn

```gdscript
export (float) var energy_dawn = 0.0
```

The energy value of the dawn state.

 The larger the value, the stronger the light.

|Name|Type|Default|
|:-|:-|:-|
|`energy_dawn`|`float`|`0.0`|

### color_day

```gdscript
export (Color) var color_day = Color(1.0, 1.0, 1.0, 1.0)
```

The color of the day state.

|Name|Type|Default|
|:-|:-|:-|
|`color_day`|`Color`|`Color(1.0, 1.0, 1.0, 1.0)`|

### energy_day

```gdscript
export (float) var energy_day = 0.0
```

The energy value of the day state.

 The larger the value, the stronger the light.

|Name|Type|Default|
|:-|:-|:-|
|`energy_day`|`float`|`0.0`|

### color_dusk

```gdscript
export (Color) var color_dusk = Color(1.0, 1.0, 1.0, 1.0)
```

The color of the dusk state.

|Name|Type|Default|
|:-|:-|:-|
|`color_dusk`|`Color`|`Color(1.0, 1.0, 1.0, 1.0)`|

### energy_dusk

```gdscript
export (float) var energy_dusk = 0.0
```

The energy value of the dusk state.

 The larger the value, the stronger the light.

|Name|Type|Default|
|:-|:-|:-|
|`energy_dusk`|`float`|`0.0`|

### move_moon

```gdscript
export (bool) var move_moon = false
```

Enables the `MoonLight` node movement.

|Name|Type|Default|
|:-|:-|:-|
|`move_moon`|`bool`|`false`|

### cycle_sync_node_path

```gdscript
export (NodePath) var cycle_sync_node_path
```

The `DayNightCycle` node which the moon will sync with.

 The `MoonLight` node will only show if there is a `DayNightCycle` node assigned to it.

|Name|Type|Default|
|:-|:-|:-|
|`cycle_sync_node_path`|`NodePath`|-|

### static_moon

```gdscript
export (bool) var static_moon = true
```

Disables the `MoonLight` node movement.

|Name|Type|Default|
|:-|:-|:-|
|`static_moon`|`bool`|`true`|

### use_hour_position

```gdscript
export (bool) var use_hour_position = false
```

If `true`, the position of the `MoonLight` node is determined by [hour_position](#hour_position).

 If `false`, the position of the `MoonLight` node is determined by its position.

 It only works when [static_moon](#static_moon) is enabled.

|Name|Type|Default|
|:-|:-|:-|
|`use_hour_position`|`bool`|`false`|

### hour_position

```gdscript
export (int, 0, 23) var hour_position = 0
```

The hour of the day, in a 24-hour clock, to position the `MoonLight` node (0-23).

|Name|Type|Default|
|:-|:-|:-|
|`hour_position`|`int`|`0`|

### path

```gdscript
var path := Curve2D.new()
```

The moon light path is a `Curve2D`.

 The default path is like the one in the following image. ![](../../../example_images/moon_light_path.png)

 A new path can be set by changing the `Curve2D`.

|Name|Type|Default|
|:-|:-|:-|
|`path`|`Curve2D`|`Curve2D.new()`|

---

<sup><sub>Powered by [GDScriptify](https://github.com/hiulit/GDScriptify)</sup></sub>.
