extends CanvasModulate

export (Color) var color_night = Color(0.07, 0.09, 0.38, 1.0)
export (Color) var color_dawn = Color(0.86, 0.70, 0.70, 1.0)
export (Color) var color_day = Color(1.0, 1.0, 1.0, 1.0)
export (Color) var color_dusk = Color(0.59, 0.66, 0.78, 1.0)

onready var color_transition_tween = $color_transition_tween

func _ready():
	var connect_current_cycle_changed_signal = Time.connect("current_cycle_changed", self, "_on_current_cycle_changed")
	if connect_current_cycle_changed_signal != OK:
		printerr(connect_current_cycle_changed_signal)

	match Time.current_cycle:
		Time.cycle_state.NIGHT:
			color = color_night
		Time.cycle_state.DAWN:
			color = color_dawn
		Time.cycle_state.DAY:
			color = color_day
		Time.cycle_state.DUSK:
			color = color_dusk


func _on_current_cycle_changed():
	match Time.current_cycle:
		Time.cycle_state.NIGHT:
			if not Time.changing_time_manually:
				color_transition_tween.interpolate_property(
					self,
					"color",
					color_dusk,
					color_night,
					Time.state_transition_duration,
					Tween.TRANS_SINE,
					Tween.EASE_OUT
				)
				color_transition_tween.start()
			else:
				color_transition_tween.stop_all()
				color = color_night
		Time.cycle_state.DAWN:
			if not Time.changing_time_manually:
				color_transition_tween.interpolate_property(
					self,
					"color",
					color_night,
					color_dawn,
					Time.state_transition_duration,
					Tween.TRANS_SINE,
					Tween.EASE_OUT
				)
				color_transition_tween.start()
			else:
				color_transition_tween.stop_all()
				color = color_dawn
		Time.cycle_state.DAY:
			if not Time.changing_time_manually:
				color_transition_tween.interpolate_property(
					self,
					"color",
					color_dawn,
					color_day,
					Time.state_transition_duration,
					Tween.TRANS_SINE,
					Tween.EASE_OUT
				)
				color_transition_tween.start()
			else:
				color_transition_tween.stop_all()
				color = color_day
		Time.cycle_state.DUSK:
			if not Time.changing_time_manually:
				color_transition_tween.interpolate_property(
					self,
					"color",
					color_day,
					color_dusk,
					Time.state_transition_duration,
					Tween.TRANS_SINE,
					Tween.EASE_OUT
				)
				color_transition_tween.stop_all()
				color_transition_tween.start()
			else:
				color = color_dusk
