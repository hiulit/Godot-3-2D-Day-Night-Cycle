extends Light2D

export (float) var energy_night = 1
export (float) var energy_dawn = 0.5
export (float) var energy_day = 0
export (float) var energy_dusk = 0.5
export (float) var state_transition_duration = 1 # In in-game hours.

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
			energy = energy_night
		Time.cycle_state.DAWN:
			energy = energy_dawn
		Time.cycle_state.DAY:
			energy = energy_day
		Time.cycle_state.DUSK:
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
				set_color(energy_night)
		Time.cycle_state.DAWN:
			if not Time.changing_time_manually:
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
				set_color(energy_dawn)
		Time.cycle_state.DAY:
			if not Time.changing_time_manually:
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
				set_color(energy_day)
		Time.cycle_state.DUSK:
			if not Time.changing_time_manually:
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
				set_color(energy_dusk)
