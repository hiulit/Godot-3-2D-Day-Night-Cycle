extends CanvasModulate

export (Color) var color_night = Color(0.07, 0.09, 0.38, 1.0)
export (Color) var color_dawn = Color(0.86, 0.70, 0.70, 1.0)
export (Color) var color_day = Color(1.0, 1.0, 1.0, 1.0)
export (Color) var color_dusk = Color(0.59, 0.66, 0.78, 1.0)
export (int) var delay = 0

onready var color_transition_tween = $color_transition_tween

func _ready():
	var current_cycle_changed_signal = Time.connect(
		"current_cycle_changed",
		self,
		"_on_current_cycle_changed"
	)

	if current_cycle_changed_signal != OK:
		printerr(current_cycle_changed_signal)

	match Time.current_cycle:
		Time.CycleState.NIGHT:
			color = color_night
		Time.CycleState.DAWN:
			color = color_dawn
		Time.CycleState.DAY:
			color = color_day
		Time.CycleState.DUSK:
			color = color_dusk

	# Sync delay with in-game time.
	delay /= float(Time.IN_GAME_SECONDS_PER_REAL_TIME_SECONDS)


# CALLBACKS
# ---------
func _on_current_cycle_changed():
	match Time.current_cycle:
		Time.CycleState.NIGHT:
			if not Time.changing_time_manually:
				if delay > 0:
					yield(get_tree().create_timer(delay), "timeout")

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
		Time.CycleState.DAWN:
			if not Time.changing_time_manually:
				if delay > 0:
					yield(get_tree().create_timer(delay), "timeout")

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
		Time.CycleState.DAY:
			if not Time.changing_time_manually:
				if delay > 0:
					yield(get_tree().create_timer(delay), "timeout")

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
		Time.CycleState.DUSK:
			if not Time.changing_time_manually:
				if delay > 0:
					yield(get_tree().create_timer(delay), "timeout")

				color_transition_tween.interpolate_property(
					self,
					"color",
					color_day,
					color_dusk,
					Time.state_transition_duration,
					Tween.TRANS_SINE,
					Tween.EASE_OUT
				)
				color_transition_tween.start()
			else:
				color_transition_tween.stop_all()
				color = color_dusk
