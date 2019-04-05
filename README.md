# Godot 3 2D Day/Night Cycle

A simple 2D ☀️Day / 🌑Night cycle using `CanvasModulate`.

![Godot 3 2D Day/Night Cycle GIF](day_night_cycle_godot_3.gif)

## Installation

* [Download](https://github.com/hiulit/Godot-3-2D-Day-Night-Cycle/archive/master.zip) the repository ZIP file.
* Copy `DayNightCycle.tscn` and `DayNightCycle.gd` in your project.

## Usage

* Instance `DayNightCycle.tscn` and  attach `DayNightCycle.gd` as a script.

You can change the **Day start hour** right from the Inspector.


### Tips

Instance one `DayNightCycle.tscn` in your background scene and another `DayNightCycle.tscn` in your main scene or level scene, etc. and set the **Day start hour** in the background scene a little after than the **Day start hour** in the main scene to have the effect that the background starts changing before the foreground (as seen on the GIF above).

```
Main
├── Background
│   └── DayNightCycle
├── Player
├── OtherStuff
└── DayNightCycle
```

#### Example

* Background scene - **Day start hour**: 10.3
* Main scene - **Day start hour**: 10

## Documentation

### Day duration

| Name | Type | Description |
| --- | --- | --- |
| `day_duration` | `float` | The duration of the day **in minutes**. |

### Day start hour

| Name | Type | Description |
| --- | --- | --- |
| `day_start_hour` | `float` | The starting hour of the day. **24 hours time (0-23)**. |

### Day start number

| Name | Type | Description |
| --- | --- | --- |
| `day_start_number` | `int` | The starting day number. |

### Color (DAWN)

| Name | Type | Description |
| --- | --- | --- |
| `color_dawn` | `Color` | The color of the DAWN state **in RGBA**. |

### Color (DAY)

| Name | Type | Description |
| --- | --- | --- |
| `color_day` | `Color` | The color of the DAY state **in RGBA**. |

### Color (DUSK)

| Name | Type | Description |
| --- | --- | --- |
| `color_dusk` | `Color` | The color of the DUSK state **in RGBA**. |

### Color (NIGHT)

| Name | Type | Description |
| --- | --- | --- |
| `color_night` | `Color` | The color of the NIGHT state **in RGBA**. |

### State (DAWN) start hour

| Name | Type | Description |
| --- | --- | --- |
| `state_dawn_start_hour` | `float` | The starting hour of the DAWN cycle state. **24 hours time (0-23)**. |

### State (DAY) start hour

| Name | Type | Description |
| --- | --- | --- |
| `state_day_start_hour` | `float` | The starting hour of the DAY cycle state. **24 hours time (0-23)**. |

### State (DUSK) start hour

| Name | Type | Description |
| --- | --- | --- |
| `state_dusk_start_hour` | `float` | The starting hour of the DUSK cycle state. **24 hours time (0-23)**. |

### State (NIGHT) start hour

| Name | Type | Description |
| --- | --- | --- |
| `state_night_start_hour` | `float` | The starting hour of the NIGHT cycle state. **24 hours time (0-23)**. |

### Debug mode

| Name | Type | Description |
| --- | --- | --- |
| `debug_mode` | `bool` | Enable/disable *debug mode*. Prints `current_day_number`, `current_day_hour` and `cycle_state`|

## Authors

Me 😛 [@hiulit](https://github.com/hiulit).

## Credits

Thanks to:

* **Solo CodeNet** for the [YouTube video tutorial](https://www.youtube.com/watch?v=sz8fyzvB6q0) that inspired me.

## License

[MIT License](/LICENSE).

