extends Light2D

export (Color) var color_night = Color(1.0, 1.0, 1.0, 1.0)
export (float) var energy_night = 1
export (Color) var color_dawn = Color(1.0, 1.0, 1.0, 1.0)
export (float) var energy_dawn = 0.5
export (Color) var color_day = Color(1.0, 1.0, 1.0, 1.0)
export (float) var energy_day = 0
export (Color) var color_dusk = Color(1.0, 1.0, 1.0, 1.0)
export (float) var energy_dusk = 0.5

var window_x = ProjectSettings.get_setting("display/window/size/width")
var window_y = ProjectSettings.get_setting("display/window/size/height")

var window_center = Vector2(window_x / 2, window_y / 2)
var radius_x = window_x / 1.5
var radius_y = radius_x / 1.5

var path = Curve2D.new()

var speed
var hour_step
var start_position
var moon_position

onready var color_transition_tween = $color_transition_tween
onready var energy_transition_tween = $energy_transition_tween

func _ready():
	var connect_current_cycle_changed_signal = Time.connect("current_cycle_changed", self, "_on_current_cycle_changed")
	if connect_current_cycle_changed_signal != OK:
		printerr(connect_current_cycle_changed_signal)

	path.add_point(window_center + Vector2(0, -radius_y), Vector2(-radius_x, 0))
	path.add_point(window_center + Vector2(radius_x, 0), Vector2(0, -radius_y))
	path.add_point(window_center + Vector2(0, radius_y), Vector2(radius_x, 0))
	path.add_point(window_center + Vector2(-radius_x, 0), Vector2(0, radius_y))
	path.add_point(window_center + Vector2(0, -radius_y), Vector2(-radius_x, 0))

	speed = path.get_baked_points().size() / float((Time.SECONDS_IN_A_DAY / Time.IN_GAME_SECONDS_PER_REAL_TIME_SECONDS))
	hour_step = path.get_baked_points().size() / float(Time.HOURS_IN_A_DAY)
	start_position = hour_step * Time.game_start_hour
	moon_position = start_position

	position = path.get_baked_points()[moon_position]

	match Time.current_cycle:
		Time.cycle_state.NIGHT:
			color = color_night
			energy = energy_night
		Time.cycle_state.DAWN:
			color = color_dawn
			energy = energy_dawn
		Time.cycle_state.DAY:
			color = color_day
			energy = energy_day
		Time.cycle_state.DUSK:
			color = color_dusk
			energy = energy_dusk


func _physics_process(delta):
	move_moon(delta)


func move_moon(delta):
	if moon_position + (delta * speed) >= path.get_baked_points().size():
		moon_position += (delta * speed) - path.get_baked_points().size()
	else:
		position = path.get_baked_points()[moon_position]
		moon_position += delta * speed


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

				energy_transition_tween.interpolate_property(
					self,
					"energy",
					energy_dusk,
					energy_night,
					Time.state_transition_duration,
					Tween.TRANS_SINE,
					Tween.EASE_OUT
				)
				energy_transition_tween.start()
			else:
				color = color_night
				energy = energy_night
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

				energy_transition_tween.interpolate_property(
					self,
					"energy",
					energy_night,
					energy_dawn,
					Time.state_transition_duration,
					Tween.TRANS_SINE,
					Tween.EASE_OUT
				)
				energy_transition_tween.start()
			else:
				color = color_dawn
				energy = energy_dawn
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

				energy_transition_tween.interpolate_property(
					self,
					"energy",
					energy_dawn,
					energy_day,
					Time.state_transition_duration,
					Tween.TRANS_SINE,
					Tween.EASE_OUT
				)
				energy_transition_tween.start()
			else:
				color = color_day
				energy = energy_day
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
				color_transition_tween.start()

				energy_transition_tween.interpolate_property(
					self,
					"energy",
					energy_day,
					energy_dusk,
					Time.state_transition_duration,
					Tween.TRANS_SINE,
					Tween.EASE_OUT
				)
				energy_transition_tween.start()
			else:
				color = color_dusk
				energy = energy_dusk
