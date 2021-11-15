# Time

**Singleton**

**Extends**: `Node`

## Table of contents

### Constants

|Name|Type|Default|
|:-|:-|:-|
|[IN_GAME_SECONDS_PER_REAL_TIME_SECONDS](#in_game_seconds_per_real_time_seconds)|`int`|`5400`|

### Variables

|Name|Type|Default|
|:-|:-|:-|
|[game_start_hour](#game_start_hour)|`int`|`12`|
|[game_start_day](#game_start_day)|`int`|`1`|
|[game_start_month](#game_start_month)|`int`|`1`|
|[game_start_year](#game_start_year)|`int`|`2021`|
|[state_dawn_start_hour](#state_dawn_start_hour)|`int`|`5`|
|[state_day_start_hour](#state_day_start_hour)|`int`|`8`|
|[state_dusk_start_hour](#state_dusk_start_hour)|`int`|`16`|
|[state_night_start_hour](#state_night_start_hour)|`int`|`19`|
|[state_transition_seconds](#state_transition_seconds)|`int`|`3600`|
|[freeze_time](#freeze_time)|`bool`|`true`|

### Functions

|Name|Type|Default|
|:-|:-|:-|
|[set_current_hour](#set_current_hour)|`int`|-|
|[seconds_to_minutes](#seconds_to_minutes)|`float`|-|
|[seconds_to_hours](#seconds_to_hours)|`float`|-|
|[seconds_to_days](#seconds_to_days)|`float`|-|
|[seconds_to_months](#seconds_to_months)|`float`|-|
|[seconds_to_years](#seconds_to_years)|`float`|-|
|[minutes_to_seconds](#minutes_to_seconds)|`float`|-|
|[minutes_to_hours](#minutes_to_hours)|`float`|-|
|[hours_to_seconds](#hours_to_seconds)|`float`|-|
|[hours_to_days](#hours_to_days)|`float`|-|
|[days_to_months](#days_to_months)|`float`|-|
|[months_to_years](#months_to_years)|`float`|-|

## Constants

### IN_GAME_SECONDS_PER_REAL_TIME_SECONDS

```gdscript
const IN_GAME_SECONDS_PER_REAL_TIME_SECONDS: int = 5400
```

The amount of in-game seconds that should elapse for each real-time second.

 It has to be at least `60` so that `seconds_elapsed` can be stored as an `int`.

 > 90 minutes (5400 seconds) in game == 1 second in real time.

|Name|Type|Default|
|:-|:-|:-|
|`IN_GAME_SECONDS_PER_REAL_TIME_SECONDS`|`int`|`5400`|

## Variables

### game_start_hour

```gdscript
var game_start_hour: int = 12
```

The hour of the day at which the game starts (0-23).

|Name|Type|Default|
|:-|:-|:-|
|`game_start_hour`|`int`|`12`|

### game_start_day

```gdscript
var game_start_day: int = 1
```

The day of the month at which the game starts (1-30).

|Name|Type|Default|
|:-|:-|:-|
|`game_start_day`|`int`|`1`|

### game_start_month

```gdscript
var game_start_month: int = 1
```

The month at which the game starts (1-12).

|Name|Type|Default|
|:-|:-|:-|
|`game_start_month`|`int`|`1`|

### game_start_year

```gdscript
var game_start_year: int = 2021
```

The year at which the game starts (0-INF).

|Name|Type|Default|
|:-|:-|:-|
|`game_start_year`|`int`|`2021`|

### state_dawn_start_hour

```gdscript
var state_dawn_start_hour: int = 5
```

The starting hour of the dawn cycle state (0-23).

|Name|Type|Default|
|:-|:-|:-|
|`state_dawn_start_hour`|`int`|`5`|

### state_day_start_hour

```gdscript
var state_day_start_hour: int = 8
```

The starting hour of the day cycle state (0-23).

|Name|Type|Default|
|:-|:-|:-|
|`state_day_start_hour`|`int`|`8`|

### state_dusk_start_hour

```gdscript
var state_dusk_start_hour: int = 16
```

The starting hour of the dusk cycle state (0-23).

|Name|Type|Default|
|:-|:-|:-|
|`state_dusk_start_hour`|`int`|`16`|

### state_night_start_hour

```gdscript
var state_night_start_hour: int = 19
```

The starting hour of the night cycle state (0-23).

|Name|Type|Default|
|:-|:-|:-|
|`state_night_start_hour`|`int`|`19`|

### state_transition_seconds

```gdscript
var state_transition_seconds: int = 3600
```

The duration, in in-game seconds, of the time it takes to transition from one state to another.

|Name|Type|Default|
|:-|:-|:-|
|`state_transition_seconds`|`int`|`3600`|

### freeze_time

```gdscript
var freeze_time: bool = true setget _set_freeze_time
```

Stops the time.

|Name|Type|Default|Setter|
|:-|:-|:-|:-|
|`freeze_time`|`bool`|`true`|`_set_freeze_time`|

## Functions

### get_current_second

```gdscript
func get_current_second() -> int
```

Returns the current second.

**Returns**: `int`

### get_current_minute

```gdscript
func get_current_minute() -> int
```

Returns the current minute.

**Returns**: `int`

### get_current_hour

```gdscript
func get_current_hour() -> int
```

Returns the current hour.

**Returns**: `int`

### get_current_day

```gdscript
func get_current_day() -> int
```

Returns the current day.

**Returns**: `int`

### get_current_month

```gdscript
func get_current_month() -> int
```

Returns the current month.

**Returns**: `int`

### get_current_year

```gdscript
func get_current_year() -> int
```

Returns the current year.

**Returns**: `int`

### set_current_hour

```gdscript
func set_current_hour(hour: int)
```

Sets the current hour.

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`hour`|`int`|-|

### current_time_string

```gdscript
func current_time_string() -> String
```

Returns the current time in `H:M:S`.

**Returns**: `String`

### current_date_string

```gdscript
func current_date_string() -> String
```

Returns the current date in `D/M/Y`.

**Returns**: `String`

### current_cycle_to_string

```gdscript
func current_cycle_to_string() -> String
```

Returns the current cycle state in a `String` format.

**Returns**: `String`

### seconds_to_minutes

```gdscript
func seconds_to_minutes(seconds: float) -> float
```

Converts seconds into minutes.

**Returns**: `float`

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`seconds`|`float`|-|

### seconds_to_hours

```gdscript
func seconds_to_hours(seconds: float) -> float
```

Converts seconds into hours.

**Returns**: `float`

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`seconds`|`float`|-|

### seconds_to_days

```gdscript
func seconds_to_days(seconds: float) -> float
```

Converts seconds into days.

**Returns**: `float`

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`seconds`|`float`|-|

### seconds_to_months

```gdscript
func seconds_to_months(seconds: float) -> float
```

Converts seconds into months.

**Returns**: `float`

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`seconds`|`float`|-|

### seconds_to_years

```gdscript
func seconds_to_years(seconds: float) -> float
```

Converts seconds into years.

**Returns**: `float`

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`seconds`|`float`|-|

### minutes_to_seconds

```gdscript
func minutes_to_seconds(minutes: float) -> float
```

Converts minutes into seconds.

**Returns**: `float`

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`minutes`|`float`|-|

### minutes_to_hours

```gdscript
func minutes_to_hours(minutes: float) -> float
```

Converts minutes into hours.

**Returns**: `float`

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`minutes`|`float`|-|

### hours_to_seconds

```gdscript
func hours_to_seconds(hours: float) -> float
```

Converts hours into seconds.

**Returns**: `float`

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`hours`|`float`|-|

### hours_to_days

```gdscript
func hours_to_days(hours: float) -> float
```

Converts hours into days.

**Returns**: `float`

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`hours`|`float`|-|

### days_to_months

```gdscript
func days_to_months(days: float) -> float
```

Converts days into months.

**Returns**: `float`

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`days`|`float`|-|

### months_to_years

```gdscript
func months_to_years(months: float) -> float
```

Converts months into years.

**Returns**: `float`

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`months`|`float`|-|

---

Powered by [GDScriptify](https://github.com/hiulit/GDScriptify).
