extends CanvasModulate

var day_duration = 0.5 # In minutes
export (float) var day_start_hour = 10 # 24 hours time (0-23)
var day_start_number = 1

export var color_dawn = Color(0.86, 0.70, 0.70, 1.0)
export var color_day = Color(1.0, 1.0, 1.0, 1.0)
export var color_dusk = Color(0.59, 0.66, 0.78, 1.0)
export var color_night = Color(0.07, 0.09, 0.38, 1.0)

export (float) var dawn_state_start_hour = 5
export (float) var day_state_start_hour = 8
export (float) var dusk_state_start_hour = 16
export (float) var night_state_start_hour = 18

var current_time
var current_day_hour
var current_day_number

var transition_duration
var transition_duration_time = 1 # In hours

var cycle
enum cycle_state { NIGHT, DAWN, DAY, DUSK }

export (bool) var debug_mode = false

func _ready():
	day_duration = 60 * 60 * day_duration # Convert 'day_duration' from minutes to seconds

	current_day_number = day_start_number
	current_time = (day_duration / 24) * day_start_hour
	current_day_hour = current_time / (day_duration / 24)

	transition_duration = (((day_duration / 24) * transition_duration_time) / 60)

	if current_day_hour >= night_state_start_hour or current_day_hour < dawn_state_start_hour:
		cycle = cycle_state.NIGHT
		color = color_night
	elif current_day_hour >= dawn_state_start_hour and current_day_hour < day_state_start_hour:
		cycle = cycle_state.DAWN
		color = color_dawn
	elif current_day_hour >= day_state_start_hour and current_day_hour < dusk_state_start_hour:
		cycle = cycle_state.DAY
		color = color_day
	elif current_day_hour >= dusk_state_start_hour and current_day_hour < night_state_start_hour:
		cycle = cycle_state.DUSK
		color = color_dusk


func _physics_process(delta):
	day_cycle()
	current_time += 1


func day_cycle():
	current_day_hour = current_time / (day_duration / 24)

	if current_time >= day_duration:
		current_time = 0
		current_day_hour = 0
		current_day_number += 1
		
	if current_day_hour >= night_state_start_hour or current_day_hour < dawn_state_start_hour:
		cycle_test(cycle_state.NIGHT)
	elif current_day_hour >= dawn_state_start_hour and current_day_hour < day_state_start_hour:
		cycle_test(cycle_state.DAWN)
	elif current_day_hour >= day_state_start_hour and current_day_hour < dusk_state_start_hour:
		cycle_test(cycle_state.DAY)
	elif current_day_hour >= dusk_state_start_hour and current_day_hour < night_state_start_hour:
		cycle_test(cycle_state.DUSK)

	if debug_mode:
		print(str("Day ", current_day_number)  + " - " + str(int(current_day_hour), " h") + " - " + str(cycle_state.keys()[cycle]))


func cycle_test(new_cycle):
	if cycle != new_cycle:
		cycle = new_cycle

		if cycle == cycle_state.NIGHT:
#			Global.Moon.change_state(1)
			$Tween.interpolate_property(self, "color", color_dusk, color_night, transition_duration, Tween.TRANS_SINE, Tween.EASE_OUT)
			$Tween.start()

		if cycle == cycle_state.DAWN:
#			Global.Moon.change_state(0.5)
			$Tween.interpolate_property(self, "color", color_night, color_dawn, transition_duration, Tween.TRANS_SINE, Tween.EASE_OUT)
			$Tween.start()

		if cycle == cycle_state.DAY:
#			Global.Moon.change_state(0)
			$Tween.interpolate_property(self, "color", color_dawn, color_day, transition_duration, Tween.TRANS_SINE, Tween.EASE_OUT)
			$Tween.start()

		if cycle == cycle_state.DUSK:
#			Global.Moon.change_state(0.5)
			$Tween.interpolate_property(self, "color", color_day, color_dusk, transition_duration, Tween.TRANS_SINE, Tween.EASE_OUT)
			$Tween.start()
