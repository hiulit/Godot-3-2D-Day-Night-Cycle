extends CanvasModulate

var day_duration = 0.5 # In minutes
export (float) var day_start_hour = 10 # 24 hours time (0-23)
var day_start_number = 1

var color_dawn = Color(0.86, 0.70, 0.70, 1.0)
var color_day = Color(1.0, 1.0, 1.0, 1.0)
var color_dusk = Color(0.59, 0.66, 0.78, 1.0)
var color_night = Color(0.07, 0.09, 0.38, 1.0)

var current_time
var current_day_hour
var current_day_number

var transition_duration
var transition_duration_time = 1 # In hours

var cycle
enum { NIGHT, DAWN, DAY, DUSK }

var debug_mode = true

func _ready():
	day_duration = 60 * 60 * day_duration # Convert 'day_duration' from minutes to seconds
	
	current_day_number = day_start_number
	current_time = (day_duration / 24) * day_start_hour
	current_day_hour = current_time / (day_duration / 24)
	
	transition_duration = (((day_duration / 24) * transition_duration_time) / 60)
	
	if current_day_hour >= 18 or current_day_hour <= 5:
		cycle = NIGHT
		color = color_night
	elif current_day_hour >= 5 and current_day_hour <= 8:
		cycle = DAWN
		color = color_dawn
	elif current_day_hour >= 8 and current_day_hour <= 16:
		cycle = DAY
		color = color_day
	elif current_day_hour >= 16 and current_day_hour <= 18:
		cycle = DUSK
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
		
	if current_day_hour >= 19 or current_day_hour <= 5:
		cycle_test(NIGHT)
	elif current_day_hour >= 5 and current_day_hour <= 8:
		cycle_test(DAWN)
	elif current_day_hour >= 8 and current_day_hour <= 16:
		cycle_test(DAY)
	elif current_day_hour >= 16 and current_day_hour <= 19:
		cycle_test(DUSK)

	if debug_mode == true:
		print(str(current_time) + " - " + str(int(current_day_hour)) + " - " + str(cycle) + " - " + str(current_day_number))
	

func cycle_test(new_cycle):
	if cycle != new_cycle:
		cycle = new_cycle

		if cycle == NIGHT:
			$Tween.interpolate_property(self, "color", color_dusk, color_night, transition_duration, Tween.TRANS_SINE, Tween.EASE_OUT)
			$Tween.start()
			
		if cycle == DAWN:
			$Tween.interpolate_property(self, "color", color_night, color_dawn, transition_duration, Tween.TRANS_SINE, Tween.EASE_OUT)
			$Tween.start()
	
		if cycle == DAY:
			$Tween.interpolate_property(self, "color", color_dawn, color_day, transition_duration, Tween.TRANS_SINE, Tween.EASE_OUT)
			$Tween.start()
	
		if cycle == DUSK:
			$Tween.interpolate_property(self, "color", color_day, color_dusk, transition_duration, Tween.TRANS_SINE, Tween.EASE_OUT)
			$Tween.start()
