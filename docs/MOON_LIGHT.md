# MoonLight

## Parameters

![Moon Inspector](../example_images/moon_inspector.png)

### Color Night

| Name | Type | Description | Default |
| - | - | - | - |
| `color_night` | `Color` | The color of the night state. | `Color(1.0, 1.0, 1.0, 1.0)` |

### Energy Night

| Name | Type | Description | Default |
| - | - | - | - |
| `energy_night` | `float` | The energy value of the night state. The larger the value, the stronger the light. | `1.0` |

### Color Dawn

| Name | Type | Description | Default |
| - | - | - | - |
| `color_dawn` | `Color` | The color of the dawn state. | `Color(1.0, 1.0, 1.0, 1.0)` |

### Energy Dawn

| Name | Type | Description | Default |
| - | - | - | - |
| `energy_dawn` | `float` | The energy value of the dawn state. The larger the value, the stronger the light. | `0.0` |

### Color Day

| Name | Type | Description | Default |
| - | - | - | - |
| `color_day` | `Color` | The color of the day state. | `Color(1.0, 1.0, 1.0, 1.0)` |

### Energy Day

| Name | Type | Description | Default |
| - | - | - | - |
| `energy_day` | `float` | The energy value of the day state. The larger the value, the stronger the light. | `0.0` |

### Color Dusk

| Name | Type | Description | Default |
| - | - | - | - |
| `color_dusk` | `Color` | The color of the dusk state. | `Color(1.0, 1.0, 1.0, 1.0)` |

### Energy Dusk

| Name | Type | Description | Default |
| - | - | - | - |
| `energy_dusk` | `float` | The energy value of the dusk state. The larger the value, the stronger the light. | `0.0` |

### Move

| Name | Type | Description | Default |
| - | - | - | - |
| `move` | `bool` | Enables/disables the moon movement. | `true` |

### Cycle Sync Node Path

| Name | Type | Description | Default |
| - | - | - | - |
| `cycle_sync_node_path` | `NodePath` | The `DayNightCycle` node which the moon will sync with. The `MoonLight` node will only show if there is a `DayNightCycle` node assigned to it. | `none` |
