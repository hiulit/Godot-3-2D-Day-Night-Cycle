# Time

**Extends**: `Node`

## Table of contents

### Variables

- [game_start_hour](#game_start_hour)
- [game_start_day](#game_start_day)
- [game_start_month](#game_start_month)
- [game_start_year](#game_start_year)
- [state_dawn_start_hour](#state_dawn_start_hour)
- [state_day_start_hour](#state_day_start_hour)
- [state_dusk_start_hour](#state_dusk_start_hour)
- [state_night_start_hour](#state_night_start_hour)
- [state_transition_seconds](#state_transition_seconds)
- [freeze_time](#freeze_time)

### Functions

- [get_current_second](#get_current_second)
- [get_current_minute](#get_current_minute)
- [get_current_hour](#get_current_hour)
- [get_current_day](#get_current_day)
- [get_current_month](#get_current_month)
- [get_current_year](#get_current_year)
- [set_current_hour](#set_current_hour)
- [current_time_string](#current_time_string)
- [current_date_string](#current_date_string)
- [current_cycle_to_string](#current_cycle_to_string)
- [seconds_to_minutes](#seconds_to_minutes)
- [seconds_to_hours](#seconds_to_hours)
- [seconds_to_days](#seconds_to_days)
- [seconds_to_months](#seconds_to_months)
- [seconds_to_years](#seconds_to_years)
- [minutes_to_seconds](#minutes_to_seconds)
- [minutes_to_hours](#minutes_to_hours)
- [hours_to_seconds](#hours_to_seconds)
- [hours_to_days](#hours_to_days)
- [days_to_months](#days_to_months)
- [months_to_years](#months_to_years)

## Variables

### game_start_hour

The hour of the day at which the game starts (0-23).

```gdscript
var game_start_hour: int = 12
```

|Name|Type|Default|
|:-|:-|:-|
|`game_start_hour`|`int`|`12`|

### game_start_day

The day of the month at which the game starts (1-30).

```gdscript
var game_start_day: int = 1
```

|Name|Type|Default|
|:-|:-|:-|
|`game_start_day`|`int`|`1`|

### game_start_month

The month at which the game starts (1-12).

```gdscript
var game_start_month: int = 1
```

|Name|Type|Default|
|:-|:-|:-|
|`game_start_month`|`int`|`1`|

### game_start_year

The year at which the game starts (0-INF).

```gdscript
var game_start_year: int = 2021
```

|Name|Type|Default|
|:-|:-|:-|
|`game_start_year`|`int`|`2021`|

### state_dawn_start_hour

The starting hour of the dawn cycle state (0-23).

```gdscript
var state_dawn_start_hour: int = 5
```

|Name|Type|Default|
|:-|:-|:-|
|`state_dawn_start_hour`|`int`|`5`|

### state_day_start_hour

The starting hour of the day cycle state (0-23).

```gdscript
var state_day_start_hour: int = 8
```

|Name|Type|Default|
|:-|:-|:-|
|`state_day_start_hour`|`int`|`8`|

### state_dusk_start_hour

The starting hour of the dusk cycle state (0-23).

```gdscript
var state_dusk_start_hour: int = 16
```

|Name|Type|Default|
|:-|:-|:-|
|`state_dusk_start_hour`|`int`|`16`|

### state_night_start_hour

The starting hour of the night cycle state (0-23).

```gdscript
var state_night_start_hour: int = 19
```

|Name|Type|Default|
|:-|:-|:-|
|`state_night_start_hour`|`int`|`19`|

### state_transition_seconds

The duration, in in-game seconds, of the time it takes to transition from one state to another.

```gdscript
var state_transition_seconds: int = 3600
```

|Name|Type|Default|
|:-|:-|:-|
|`state_transition_seconds`|`int`|`3600`|

### freeze_time

Stops the time.

```gdscript
var freeze_time: bool = true setget _set_freeze_time
```

|Name|Type|Default|Setter|
|:-|:-|:-|:-|
|`freeze_time`|`bool`|`true`|`_set_freeze_time`|

## Functions

### get_current_second

Returns the current second.

**Returns**: `int`.

```gdscript
func get_current_second() -> int
```

### get_current_minute

Returns the current minute.

**Returns**: `int`.

```gdscript
func get_current_minute() -> int
```

### get_current_hour

Returns the current hour.

**Returns**: `int`.

```gdscript
func get_current_hour() -> int
```

### get_current_day

Returns the current day.

**Returns**: `int`.

```gdscript
func get_current_day() -> int
```

### get_current_month

Returns the current month.

**Returns**: `int`.

```gdscript
func get_current_month() -> int
```

### get_current_year

Returns the current year.

**Returns**: `int`.

```gdscript
func get_current_year() -> int
```

### set_current_hour

Sets the current hour.

```gdscript
func set_current_hour(hour: int)
```

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`hour`|`int`|-|

### current_time_string

Returns the current time in `H:M:S`.

**Returns**: `String`.

```gdscript
func current_time_string() -> String
```

### current_date_string

Returns the current date in `D/M/Y`.

**Returns**: `String`.

```gdscript
func current_date_string() -> String
```

### current_cycle_to_string

Returns the current cycle state in a `String` format.

**Returns**: `String`.

```gdscript
func current_cycle_to_string() -> String
```

### seconds_to_minutes

Converts seconds into minutes.

**Returns**: `float`.

```gdscript
func seconds_to_minutes(seconds: float) -> float
```

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`seconds`|`float`|-|

### seconds_to_hours

Converts seconds into hours.

**Returns**: `float`.

```gdscript
func seconds_to_hours(seconds: float) -> float
```

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`seconds`|`float`|-|

### seconds_to_days

Converts seconds into days.

**Returns**: `float`.

```gdscript
func seconds_to_days(seconds: float) -> float
```

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`seconds`|`float`|-|

### seconds_to_months

Converts seconds into months.

**Returns**: `float`.

```gdscript
func seconds_to_months(seconds: float) -> float
```

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`seconds`|`float`|-|

### seconds_to_years

Converts seconds into years.

**Returns**: `float`.

```gdscript
func seconds_to_years(seconds: float) -> float
```

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`seconds`|`float`|-|

### minutes_to_seconds

Converts minutes into seconds.

**Returns**: `float`.

```gdscript
func minutes_to_seconds(minutes: float) -> float
```

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`minutes`|`float`|-|

### minutes_to_hours

Converts minutes into hours.

**Returns**: `float`.

```gdscript
func minutes_to_hours(minutes: float) -> float
```

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`minutes`|`float`|-|

### hours_to_seconds

Converts hours into seconds.

**Returns**: `float`.

```gdscript
func hours_to_seconds(hours: float) -> float
```

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`hours`|`float`|-|

### hours_to_days

Converts hours into days.

**Returns**: `float`.

```gdscript
func hours_to_days(hours: float) -> float
```

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`hours`|`float`|-|

### days_to_months

Converts days into months.

**Returns**: `float`.

```gdscript
func days_to_months(days: float) -> float
```

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`days`|`float`|-|

### months_to_years

Converts months into years.

**Returns**: `float`.

```gdscript
func months_to_years(months: float) -> float
```

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`months`|`float`|-|

Powered by [GDScriptify](https://github.com/hiulit/gdscriptify).
