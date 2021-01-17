# Time

## Parameters

### Game Start Hour

| Name | Type | Description | Default |
| - | - | - | - |
| `game_start_hour` | `int` | The hour of the day at which the game starts (0-23). | `12` |

### Game Start Day

| Name | Type | Description | Default |
| - | - | - | - |
| `game_start_day` | `int` | The day of the month at which the game starts (1-30). | `1` |

### Game Start Month

| Name | Type | Description | Default |
| - | - | - | - |
| `game_start_month` | `int` | The month at which the game starts (1-12). | `1` |

### Game Start Year

| Name | Type | Description | Default |
| - | - | - | - |
| `game_start_year` | `int` | The year at which the game starts (0-INF). | `2021` |

### State Dawn Start Hour

| Name | Type | Description | Default |
| - | - | - | - |
| `state_dawn_start_hour` | `int` | The starting hour of the dawn cycle state (0-23). | `5` |

### State Day Start Hour

| Name | Type | Description | Default |
| - | - | - | - |
| `state_day_start_hour` | `int` | The starting hour of the day cycle state (0-23). | `8` |

### State Dusk Start Hour

| Name | Type | Description | Default |
| - | - | - | - |
| `state_dusk_start_hour` | `int` | The starting hour of the dusk cycle state (0-23). | `16` |

### State Night Start Hour

| Name | Type | Description | Default |
| - | - | - | - |
| `state_night_start_hour` | `int` | The starting hour of the night cycle state (0-23). | `19` |

### State Transition Seconds

| Name | Type | Description | Default |
| - | - | - | - |
| `state_transition_seconds` | `int` | The duration, in in-game seconds, of the time it takes to transition from one state to another. | `3600` |

### Freeze time

| Name | Type | Description | Default |
| - | - | - | - |
| `freeze_time` | `bool` | Stops the time. | `true` |

## Public Functions

### Getters for particular units (m/s/h/etc.) of the current time.

- `get_current_second()`
- `get_current_minute()`
- `get_current_hour()`
- `get_current_day()`
- `get_current_month()`
- `get_current_year()`

### Setters for particular units (m/s/h/etc.) of the current time.

- `set_current_hour(hour)`

### General string conversion functions.

- `current_time_string()`
- `current_date_string()`
- `current_cycle_to_string()`

### General time unit conversion functions.

- `seconds_to_minutes(seconds)`
- `seconds_to_hours(seconds)`
- `seconds_to_days(seconds)`
- `seconds_to_months(seconds)`
- `seconds_to_years(seconds)`
- `minutes_to_seconds(minutes)`
- `minutes_to_hours(minutes)`
- `hours_to_seconds(hours)`
- `hours_to_days(hours)`
- `days_to_months(days)`
- `months_to_years(months)`
