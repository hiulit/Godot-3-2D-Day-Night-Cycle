extends Node

const seconds_in_a_minute = 60
const minutes_in_an_hour = 60
const hours_in_a_day = 24
const days_in_a_month = 30
const months_in_a_year = 12
var seconds_in_a_day = hours_in_a_day * minutes_in_an_hour * seconds_in_a_minute
var seconds_in_a_month = days_in_a_month * seconds_in_a_day

# The hour in the day in which the game starts (0-23).
# Note that unlike the other game_start_* variables,
# the value of this variable (in seconds) will be appended
# to seconds_elapsed on game start, and this is
# done to avoid not being able to move the debug time slider
# back to earlier hours in the day.
# Should be at least 1 to ensure that _update_current_cycle()
# gets called.
const game_start_hour = 10
# The day of the month in which the game starts (1-x).
const game_start_day = 1
# The month in which the game starts (1-12).
const game_start_month = 11
# The year in which the game starts.
const game_start_year = 2010

# Calculated below
var game_start_in_seconds = 0

var state_dawn_start_hour = 5
var state_day_start_hour = 8
var state_dusk_start_hour = 16
var state_night_start_hour = 19

# The seconds that have elapsed in-game since the game started.
var seconds_elapsed: int = 0
# Keeps track of fractions of a second that have elapsed so that
# we can store seconds_elapsed as an int without losing accuracy when
# multiplying by delta.
var seconds_elapsed_remainder: float = 0

# The amount of in-game seconds that should elapse for each real-time second.
# Has to be at least 60 so that we can store seconds_elapsed as an int.
const in_game_seconds_per_real_time_second = 1200 # 20 minutes in game == 1 minute in real time

enum cycle_state { NIGHT, DAWN, DAY, DUSK }
var current_cycle = cycle_state.NIGHT
# When changing the time via the debug controls, we should skip interpolation.
#warning-ignore:unused_class_variable
var changing_time_manually = false
var freeze_time = false

signal current_second_changed()
signal current_minute_changed()
signal current_hour_changed()
signal current_cycle_changed()

func _ready():
	var start_day_in_seconds = (game_start_day - 1) * seconds_in_a_day
	var start_month_in_seconds = (game_start_month - 1) * days_in_a_month * seconds_in_a_day
	var start_year_in_seconds = game_start_year * months_in_a_year * seconds_in_a_month
	game_start_in_seconds = start_year_in_seconds \
		+ start_month_in_seconds \
		+ start_day_in_seconds

	set_seconds_elapsed(hours_to_seconds(game_start_hour))

func _physics_process(_delta):
	print("_")
	if (changing_time_manually or freeze_time):
		# Don't update the time while the debug time slider handle is being dragged,
		# as it conflicts with what the dev is trying to set.
		return

	seconds_elapsed_remainder = _delta * in_game_seconds_per_real_time_second
	var seconds_to_add = int(seconds_elapsed_remainder)
	if (seconds_to_add >= 1):
		seconds_elapsed_remainder -= seconds_to_add
		set_seconds_elapsed(seconds_elapsed + seconds_to_add)

# Getters for particular units (m/s/h/etc.) of the current time.
func current_second():
	return seconds_elapsed % seconds_in_a_minute;

func current_minute():
	return seconds_to_minutes(seconds_elapsed) % minutes_in_an_hour

func current_hour():
	var hours_elapsed = minutes_to_hours(seconds_to_minutes(seconds_elapsed))
	return hours_elapsed % hours_in_a_day;

func current_day():
	var hours_elapsed = minutes_to_hours(seconds_to_minutes(seconds_elapsed))
	var days_elapsed = hours_to_days(hours_elapsed)
	return (game_start_day + days_elapsed) % days_in_a_month

func current_month():
	var hours_elapsed = minutes_to_hours(seconds_to_minutes(seconds_elapsed))
	var days_elapsed = hours_to_days(hours_elapsed)
	var months_elapsed = days_to_months(days_elapsed)
	return (game_start_month + months_elapsed) % months_in_a_year

func current_year():
	var hours_elapsed = minutes_to_hours(seconds_to_minutes(seconds_elapsed))
	var days_elapsed = hours_to_days(hours_elapsed)
	var months_elapsed = days_to_months(days_elapsed)
	return game_start_year + months_to_years(months_elapsed)

func current_time_string():
	var time_string = str(current_hour()) + ":" + str(current_minute()) + ":" + str(current_second())
	return time_string

func current_date_string():
	return str(current_day()) + "/" + str(current_month()) + "/" + str(current_year())

# General time unit conversion functions.
func seconds_to_minutes(seconds):
	return seconds / seconds_in_a_minute

func minutes_to_hours(minutes):
	return minutes / minutes_in_an_hour

func hours_to_days(hours):
	return hours / hours_in_a_day

func days_to_months(days):
	return days / days_in_a_month

func months_to_years(months):
	return months / months_in_a_year

func minutes_to_seconds(minutes):
	return minutes * seconds_in_a_minute

func hours_to_seconds(hours):
	return hours * minutes_in_an_hour * seconds_in_a_minute

func set_seconds_elapsed(seconds):
	if (seconds == seconds_elapsed):
		return

	if (seconds < 0):
		push_warning("Seconds cannot be less than zero (" + str(seconds) + ")")
		return

	var previous_minute = int(current_minute())
	var previous_hour = int(current_hour())

	seconds_elapsed = seconds

	emit_signal("current_second_changed")

	if (int(current_minute()) != previous_minute):
		emit_signal("current_minute_changed")

	if (int(current_hour()) != previous_hour):
		_update_current_cycle()
		emit_signal("current_hour_changed")

func set_current_hour(hour):
	var previous_hour = current_hour()
	if (hour == previous_hour):
		return

	var difference = hour - previous_hour
	var difference_in_seconds = hours_to_seconds(difference)
	set_seconds_elapsed(seconds_elapsed + difference_in_seconds)

#func get_artificial_light_strength():
#    # The light should be stronger the further it is from midday.
#    if (current_day_hour <= 11):
#        return (11.0 - current_day_hour) / 11.0
#    return (current_day_hour / 12.0) - 1.0

func current_cycle_to_string():
	return cycle_state.keys()[current_cycle]

func _update_current_cycle():
	var current_day_hour = current_hour()
	if (current_day_hour >= state_night_start_hour or current_day_hour < state_dawn_start_hour):
		_set_current_cycle(cycle_state.NIGHT)
	elif (current_day_hour >= state_dawn_start_hour and current_day_hour < state_day_start_hour):
		_set_current_cycle(cycle_state.DAWN)
	elif (current_day_hour >= state_day_start_hour and current_day_hour < state_dusk_start_hour):
		_set_current_cycle(cycle_state.DAY)
	elif (current_day_hour >= state_dusk_start_hour and current_day_hour < state_night_start_hour):
		_set_current_cycle(cycle_state.DUSK)

func _set_current_cycle(cycle):
	if (cycle == current_cycle):
		return

	current_cycle = cycle
	emit_signal("current_cycle_changed")