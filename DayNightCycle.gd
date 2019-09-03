extends CanvasModulate

export var color_dawn = Color(0.86, 0.70, 0.70, 1.0)
export var color_day = Color(1.0, 1.0, 1.0, 1.0)
export var color_dusk = Color(0.59, 0.66, 0.78, 1.0)
export var color_night = Color(0.07, 0.09, 0.38, 1.0)

export (float) var state_transition_duration = 1 # In hours

var transition_duration

func _ready():
#   Global.DayNight = self

	transition_duration = state_transition_duration

	match Time.current_cycle:
		Time.cycle_state.NIGHT:
			color = color_night
		Time.cycle_state.DAWN:
			color = color_dawn
		Time.cycle_state.DAY:
			color = color_day
		Time.cycle_state.DUSK:
			color = color_dusk

	Time.connect("current_cycle_changed", self, "_on_current_cycle_changed")

func _on_current_cycle_changed():
	match Time.current_cycle:
		Time.cycle_state.NIGHT:
			if (!Time.changing_time_manually):
				$Tween.interpolate_property(self, "color", color_dusk, color_night,
					transition_duration, Tween.TRANS_SINE, Tween.EASE_OUT)
				$Tween.start()
			else:
				set_color(color_night)
		Time.cycle_state.DAWN:
			if (!Time.changing_time_manually):
				$Tween.interpolate_property(self, "color", color_night, color_dawn,
					transition_duration, Tween.TRANS_SINE, Tween.EASE_OUT)
				$Tween.start()
			else:
				set_color(color_dawn)
		Time.cycle_state.DAY:
			if (!Time.changing_time_manually):
				$Tween.interpolate_property(self, "color", color_dawn, color_day,
					transition_duration, Tween.TRANS_SINE, Tween.EASE_OUT)
				$Tween.start()
			else:
				set_color(color_day)
		Time.cycle_state.DUSK:
			if (!Time.changing_time_manually):
				$Tween.interpolate_property(self, "color", color_day, color_dusk,
					transition_duration, Tween.TRANS_SINE, Tween.EASE_OUT)
				$Tween.start()
			else:
				set_color(color_dusk)