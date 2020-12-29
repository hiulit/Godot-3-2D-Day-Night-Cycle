extends Node

signal current_second_changed
signal current_minute_changed
signal current_hour_changed
signal current_cycle_changed
signal time_manually_changed
signal time_freezed

enum cycle_state { NIGHT, DAWN, DAY, DUSK }

const SECONDS_IN_A_MINUTE = 60
const MINUTES_IN_AN_HOUR = 60
const HOURS_IN_A_DAY = 24
const DAYS_IN_A_WEEK = 7
const DAYS_IN_A_YEAR = 365
const MONTHS_IN_A_YEAR = 12

#const DAYS_IN_A_MONTH = DAYS_IN_A_YEAR / MONTHS_IN_A_YEAR
const DAYS_IN_A_MONTH = 30
#const WEEKS_IN_A_MONTH = DAYS_IN_A_MONTH / DAYS_IN_A_WEEK

const SECONDS_IN_AN_HOUR = SECONDS_IN_A_MINUTE * MINUTES_IN_AN_HOUR
const SECONDS_IN_A_DAY = SECONDS_IN_A_MINUTE * MINUTES_IN_AN_HOUR * HOURS_IN_A_DAY
#const SECONDS_IN_A_WEEK = SECONDS_IN_A_DAY * DAYS_IN_A_WEEK
const SECONDS_IN_A_MONTH = SECONDS_IN_A_DAY * DAYS_IN_A_MONTH
const SECONDS_IN_A_YEAR = SECONDS_IN_A_MONTH * MONTHS_IN_A_YEAR

# The amount of in-game seconds that should elapse for each real-time second.
# Has to be at least 60 so that we can store 'seconds_elapsed' as an 'int'.
const IN_GAME_SECONDS_PER_REAL_TIME_SECONDS = 5400 * 2 # 90 minutes in game == 1 second in real time.

# The hour in the day in which the game starts (0-23).
# ----
# Note that unlike the other 'game_start_*' variables,
# the value of this variable (in seconds) will be appended
# to 'seconds_elapsed' on game start.
# This is done to avoid not being able to move the debug time slider
# back to earlier hours in the day.
# Should be at least 1 to ensure that '_update_current_cycle()' gets called.
# ----
var game_start_hour = 12
# The day of the month in which the game starts (1-30).
var game_start_day = 30
# The month in which the game starts (1-12).
var game_start_month = 12
# The year in which the game starts (0-INF).
var game_start_year = 2020

# Seconds at the start of the game.
var epoch = 0

# The start hours of each cycle.
var state_dawn_start_hour = 5
var state_day_start_hour = 8
var state_dusk_start_hour = 16
var state_night_start_hour = 19

# The duration, in in-game hours, of the time it takes
# to transition from one state to another.
var state_transition_duration = 1

# The seconds that have elapsed in-game since the game started.
var seconds_elapsed: int = 0
# Keeps track of fractions of a second that have elapsed so that we can store
# 'seconds_elapsed' as an int without losing accuracy when multiplying by delta.
var seconds_elapsed_remainder: float = 0
# Keeps track of the seconds to add.
var seconds_to_add: int

# Keeps track of the current cycle.
var current_cycle: int #= cycle_state.DAY

# When changing the time via the debug controls, we should skip interpolation.
var changing_time_manually: bool = false setget _set_changing_time_manually
var freeze_time: bool = false setget _set_freeze_time

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

#	print("----")
#	print("SECONDS_IN_AN_HOUR: ", SECONDS_IN_AN_HOUR)
#	print("SECONDS_IN_A_DAY: ", SECONDS_IN_A_DAY)
##	print("SECONDS_IN_A_WEEK: ", SECONDS_IN_A_WEEK)
#	print("SECONDS_IN_A_MONTH: ", SECONDS_IN_A_MONTH)
#	print("SECONDS_IN_A_YEAR: ", SECONDS_IN_A_YEAR)
#	print("----")

	var start_hour_in_seconds = game_start_hour * SECONDS_IN_AN_HOUR
#	print("start_hour_in_seconds: ", start_hour_in_seconds)
#	print(seconds_elapsed_to_hour(start_hour_in_seconds))
	var start_day_in_seconds = (game_start_day - 1) * SECONDS_IN_A_DAY
#	print("start_day_in_seconds: ", start_day_in_seconds)
#	print(seconds_elapsed_to_day(start_day_in_seconds))
	var start_month_in_seconds = (game_start_month - 1) * SECONDS_IN_A_MONTH
#	print("start_month_in_seconds: ", start_month_in_seconds)
#	print(seconds_elapsed_to_month(start_month_in_seconds))
	var start_year_in_seconds = game_start_year * SECONDS_IN_A_YEAR
#	print("start_year_in_seconds: ", start_year_in_seconds)
#	print(seconds_elapsed_to_year(start_year_in_seconds))
#	print("-------")

	epoch = start_hour_in_seconds + \
			start_day_in_seconds + \
			start_month_in_seconds + \
			start_year_in_seconds

#	print("-------")
#	print("epoch: ", epoch)
#	print("-------")

#	_update_current_cycle()
	_set_seconds_elapsed(epoch)

#	print("-------")
#	var current_hour = seconds_elapsed_to_hour(epoch)
#	print("current_hour: ", current_hour)
#	var current_day = seconds_elapsed_to_day(epoch)
#	print("current_day: ", current_day)
#	var current_month = seconds_elapsed_to_month(epoch)
#	print("current_month: ", current_month)
#	var current_year = seconds_elapsed_to_year(epoch)
#	print("current_year: ", current_year)
#	print("-------")


func _physics_process(delta):
	seconds_elapsed_remainder = delta * IN_GAME_SECONDS_PER_REAL_TIME_SECONDS

	seconds_to_add = int(seconds_elapsed_remainder)

	if seconds_to_add >= 1:
		seconds_elapsed_remainder -= seconds_to_add

		_set_seconds_elapsed(seconds_elapsed + seconds_to_add)


func seconds_elapsed_to_hour(seconds):
	return floor((((int(seconds) % int(SECONDS_IN_A_YEAR)) % int(SECONDS_IN_A_MONTH)) % int(SECONDS_IN_A_DAY)) / SECONDS_IN_AN_HOUR)


func seconds_elapsed_to_day(seconds):
	return floor((((int(seconds) % int(SECONDS_IN_A_YEAR)) % int(SECONDS_IN_A_MONTH)) + SECONDS_IN_A_DAY) / SECONDS_IN_A_DAY)


func seconds_elapsed_to_month(seconds):
	return floor(((int(seconds) % int(SECONDS_IN_A_YEAR)) + SECONDS_IN_A_MONTH) / SECONDS_IN_A_MONTH)


func seconds_elapsed_to_year(seconds):
	return floor(seconds / SECONDS_IN_A_YEAR)


# Getters for particular units (m/s/h/etc.) of the current time.
func get_current_second():
	return seconds_elapsed % SECONDS_IN_A_MINUTE;


func get_current_minute():
	var minutes_elapsed = seconds_to_minutes(seconds_elapsed)
	return minutes_elapsed % MINUTES_IN_AN_HOUR


func get_current_hour():
	return seconds_elapsed_to_hour(seconds_elapsed)


func get_current_day():
	return seconds_elapsed_to_day(seconds_elapsed)


func get_current_month():
	return seconds_elapsed_to_month(seconds_elapsed)


func get_current_year():
	return seconds_elapsed_to_year(seconds_elapsed)


# Setters for particular units (m/s/h/etc.) of the current time.
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
	return cycle_state.keys()[current_cycle]


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
func _update_current_cycle():
	var current_day_hour = get_current_hour()

	if current_day_hour >= state_night_start_hour or current_day_hour < state_dawn_start_hour:
		_set_current_cycle(cycle_state.NIGHT)
	elif current_day_hour >= state_dawn_start_hour and current_day_hour < state_day_start_hour:
		_set_current_cycle(cycle_state.DAWN)
	elif current_day_hour >= state_day_start_hour and current_day_hour < state_dusk_start_hour:
		_set_current_cycle(cycle_state.DAY)
	elif current_day_hour >= state_dusk_start_hour and current_day_hour < state_night_start_hour:
		_set_current_cycle(cycle_state.DUSK)


func _set_current_cycle(cycle):
	if not changing_time_manually:
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
