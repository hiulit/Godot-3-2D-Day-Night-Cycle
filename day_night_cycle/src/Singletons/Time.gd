extends Node

signal current_second_changed
signal current_minute_changed
signal current_hour_changed
signal current_cycle_changed
signal time_manually_changed
signal time_freezed

enum CycleState { NIGHT, DAWN, DAY, DUSK }

const SECONDS_IN_A_MINUTE: int = 60
const MINUTES_IN_AN_HOUR: int = 60
const HOURS_IN_A_DAY: int = 24
const DAYS_IN_A_WEEK: int = 7
const DAYS_IN_A_MONTH: int = 30
const DAYS_IN_A_YEAR: int = 365
const MONTHS_IN_A_YEAR: int = 12

const SECONDS_IN_AN_HOUR: int = SECONDS_IN_A_MINUTE * MINUTES_IN_AN_HOUR
const SECONDS_IN_A_DAY: int = SECONDS_IN_A_MINUTE * MINUTES_IN_AN_HOUR * HOURS_IN_A_DAY
const SECONDS_IN_A_MONTH: int = SECONDS_IN_A_DAY * DAYS_IN_A_MONTH
const SECONDS_IN_A_YEAR: int = SECONDS_IN_A_MONTH * MONTHS_IN_A_YEAR

# The amount of in-game seconds that should elapse for each real-time second.
# Has to be at least 60 so that we can store 'seconds_elapsed' as an 'int'.
# 90 minutes (5400 seconds) in game == 1 second in real time.
const IN_GAME_SECONDS_PER_REAL_TIME_SECONDS: int = 5400

# The hour of the day at which the game starts (0-23).
var game_start_hour: int = 12
# The day of the month at which the game starts (1-30).
var game_start_day: int = 1
# The month at which the game starts (1-12).
var game_start_month: int = 1
# The year at which the game starts (0-INF).
var game_start_year: int = 2021

# The start hours of each cycle.
var state_dawn_start_hour: int = 5
var state_day_start_hour: int = 8
var state_dusk_start_hour: int = 16
var state_night_start_hour: int = 19

# The duration, in in-game seconds, of the time it takes
# to transition from one state to another.
var state_transition_seconds: int = 3600
var state_transition_duration: float = state_transition_seconds / \
		float(IN_GAME_SECONDS_PER_REAL_TIME_SECONDS)

# The seconds that have elapsed in-game since the game started.
var seconds_elapsed: int = 0
# Keeps track of fractions of a second that have elapsed so that we can store
# 'seconds_elapsed' as an 'int' without losing accuracy when multiplying by delta.
var seconds_elapsed_remainder: float = 0
# Keeps track of the seconds to add.
var seconds_to_add: int

# Keeps track of the current cycle.
var current_cycle: int

# Seconds at the start of the game.
var game_epoch: int

# When changing the time via the debug controls, we should skip interpolation.
var changing_time_manually: bool = false setget _set_changing_time_manually
# Stops the time.
var freeze_time: bool = true setget _set_freeze_time

func _ready():
	if IN_GAME_SECONDS_PER_REAL_TIME_SECONDS < 60:
		printerr("--------------------")
		printerr("ERROR!")
		printerr("File: '%s.gd'."  % self.name)
		printerr("Message: The constant 'IN_GAME_SECONDS_PER_REAL_TIME_SECONDS' (" + \
				str(IN_GAME_SECONDS_PER_REAL_TIME_SECONDS) + ") must be set to >= 60.")
		printerr("--------------------")
		set_physics_process(false)
		return

	if game_start_hour < 0 or game_start_hour > 23:
		printerr("--------------------")
		printerr("ERROR!")
		printerr("File: '%s.gd.'"  % self.name)
		printerr("Message: The variable 'game_start_hour' (" + \
				str(game_start_hour) + ") must be set between >= 0 and <= 23.")
		printerr("--------------------")
		set_physics_process(false)
		return

	if game_start_day < 1 or game_start_day > 30:
		printerr("--------------------")
		printerr("ERROR!")
		printerr("File: '%s.gd.'"  % self.name)
		printerr("Message: The variable 'game_start_day' (" + \
				str(game_start_day) + ") must be set between >= 1 and <= 30.")
		printerr("--------------------")
		set_physics_process(false)
		return

	if game_start_month < 1 or game_start_month > 12:
		printerr("--------------------")
		printerr("ERROR!")
		printerr("File: '%s.gd.'"  % self.name)
		printerr("Message: The variable 'game_start_month' (" + \
				str(game_start_month) + ") must be set between >= 1 and <= 12.")
		printerr("--------------------")
		set_physics_process(false)
		return

	var start_hour_in_seconds: int = game_start_hour * SECONDS_IN_AN_HOUR
	var start_day_in_seconds: int  = (game_start_day - 1) * SECONDS_IN_A_DAY
	var start_month_in_seconds: int = (game_start_month - 1) * SECONDS_IN_A_MONTH
	var start_year_in_seconds:int  = game_start_year * SECONDS_IN_A_YEAR

	game_epoch = start_hour_in_seconds + \
			start_day_in_seconds + \
			start_month_in_seconds + \
			start_year_in_seconds

	_set_seconds_elapsed(game_epoch)


func _physics_process(delta):
	seconds_elapsed_remainder = delta * IN_GAME_SECONDS_PER_REAL_TIME_SECONDS

	seconds_to_add = int(seconds_elapsed_remainder)

	if seconds_to_add >= 1:
		seconds_elapsed_remainder -= seconds_to_add

		_set_seconds_elapsed(seconds_elapsed + seconds_to_add)


# PUBLIC FUNCTIONS
# ----------------
# Getters for particular units (m/s/h/etc.) of the current time.
func get_current_second():
	return seconds_elapsed % SECONDS_IN_A_MINUTE


func get_current_minute():
	var minutes_elapsed = seconds_to_minutes(seconds_elapsed)
	return minutes_elapsed % MINUTES_IN_AN_HOUR


func get_current_hour():
	return _seconds_elapsed_to_hour(seconds_elapsed)


func get_current_day():
	return _seconds_elapsed_to_day(seconds_elapsed)


func get_current_month():
	return _seconds_elapsed_to_month(seconds_elapsed)


func get_current_year():
	return _seconds_elapsed_to_year(seconds_elapsed)


# Setters for particular units (m/s/h/etc.) of the current time.
func set_current_hour(hour):
	var previous_hour = get_current_hour()

	if hour == previous_hour:
		return

	var difference = hour - previous_hour
	var difference_in_seconds = hours_to_seconds(difference)

	_set_seconds_elapsed(seconds_elapsed + difference_in_seconds)


# General string conversion functions.
func current_time_string():
	var time_string = str("%02d" % get_current_hour()) + ":" + \
			str("%02d" % get_current_minute()) + ":" + \
			str("%02d" % get_current_second())

	return time_string


func current_date_string():
	return str("%02d" % get_current_day()) + "/" + \
			str("%02d" % get_current_month()) + "/" +\
			str("%02d" % get_current_year())


func current_cycle_to_string():
	return CycleState.keys()[current_cycle]


# General time unit conversion functions.
func seconds_to_minutes(seconds):
	return seconds / SECONDS_IN_A_MINUTE


func seconds_to_hours(seconds):
	return seconds / SECONDS_IN_AN_HOUR


func seconds_to_days(seconds):
	return seconds / SECONDS_IN_A_DAY


func seconds_to_months(seconds):
	return seconds / SECONDS_IN_A_MONTH


func seconds_to_years(seconds):
	return seconds / SECONDS_IN_A_YEAR


func minutes_to_seconds(minutes):
	return minutes * SECONDS_IN_A_MINUTE


func minutes_to_hours(minutes):
	return minutes / MINUTES_IN_AN_HOUR


func hours_to_seconds(hours):
	return hours * MINUTES_IN_AN_HOUR * SECONDS_IN_A_MINUTE


func hours_to_days(hours):
	return hours / HOURS_IN_A_DAY


func days_to_months(days):
	return days / DAYS_IN_A_MONTH


func months_to_years(months):
	return months / MONTHS_IN_A_YEAR


# PRIVATE FUNCTIONS
# -----------------
func _set_seconds_elapsed(seconds):
	if seconds == seconds_elapsed:
		return

	var previous_minute = int(get_current_minute())
	var previous_hour = int(get_current_hour())

	seconds_elapsed = seconds

	emit_signal("current_second_changed")

	if int(get_current_minute()) != previous_minute:
		emit_signal("current_minute_changed")

	if int(get_current_hour()) != previous_hour:
		emit_signal("current_hour_changed")

		_update_current_cycle()


func _seconds_elapsed_to_hour(seconds):
	return floor(
		(((seconds % SECONDS_IN_A_YEAR) % SECONDS_IN_A_MONTH) % SECONDS_IN_A_DAY) / \
				float(SECONDS_IN_AN_HOUR)
	)


func _seconds_elapsed_to_day(seconds):
	return floor(
		(((seconds % SECONDS_IN_A_YEAR) % SECONDS_IN_A_MONTH) + SECONDS_IN_A_DAY) / \
				float(SECONDS_IN_A_DAY)
	)


func _seconds_elapsed_to_month(seconds):
	return floor(
		((seconds % SECONDS_IN_A_YEAR) + SECONDS_IN_A_MONTH) / \
				float(SECONDS_IN_A_MONTH)
	)


func _seconds_elapsed_to_year(seconds):
	return floor(seconds / float(SECONDS_IN_A_YEAR))


func _update_current_cycle():
	var current_day_hour = get_current_hour()

	if current_day_hour >= state_night_start_hour or current_day_hour < state_dawn_start_hour:
		_set_current_cycle(CycleState.NIGHT)
	elif current_day_hour >= state_dawn_start_hour and current_day_hour < state_day_start_hour:
		_set_current_cycle(CycleState.DAWN)
	elif current_day_hour >= state_day_start_hour and current_day_hour < state_dusk_start_hour:
		_set_current_cycle(CycleState.DAY)
	elif current_day_hour >= state_dusk_start_hour and current_day_hour < state_night_start_hour:
		_set_current_cycle(CycleState.DUSK)


func _set_current_cycle(cycle):
	if cycle == current_cycle:
		return

	current_cycle = cycle

	emit_signal("current_cycle_changed")


func _set_changing_time_manually(new_value):
	changing_time_manually = new_value

	emit_signal("time_manually_changed")

	if not freeze_time:
		set_physics_process(not changing_time_manually)


func _set_freeze_time(new_value):
	freeze_time = new_value

	emit_signal("time_freezed")

	set_physics_process(not freeze_time)
