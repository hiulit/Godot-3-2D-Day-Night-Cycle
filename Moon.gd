extends Light2D

export (float) var state_dawn_energy = 0.5
export (float) var state_day_energy = 0
export (float) var state_dusk_energy = 0.5
export (float) var state_night_energy = 1

export (float) var state_transition_duration = 1 # In hours

export (bool) var move = true

export (bool) var on = true

var state
var new_state

var energy_start
var energy_end

var transition_duration

var window_x = ProjectSettings.get_setting("display/window/size/width")
var window_y = ProjectSettings.get_setting("display/window/size/height")

var pos = Vector2(window_x / 2, window_y / 2)
var radius_x = (window_x / 2)
var radius_y = radius_x / 2

var path = Curve2D.new()

var speed
var hour_step
var midnight_step
var baked_points_pos

func _ready():
	if not on:
		queue_free()

	if !Global.DayNight:
		return
	
	Global.Moon = self

	energy = 0

	transition_duration = Global.DayNight.transition_duration if Global.DayNight else state_transition_duration

	path.add_point(pos + Vector2(radius_x, 0), Vector2(0, -radius_y))
	path.add_point(pos + Vector2(0, radius_y), Vector2(radius_x, 0))
	path.add_point(pos + Vector2(-radius_x, 0), Vector2(0, radius_y))
	path.add_point(pos + Vector2(0, -radius_y), Vector2(-radius_x, 0))
	path.add_point(pos + Vector2(radius_x, 0), Vector2(0, -radius_y))

	path.set_bake_interval(1)

	speed = (path.get_baked_points().size() / Global.DayNight.day_duration) * 60 # Match speed with day duration

	midnight_step = ((path.get_baked_points().size()) * 18 / 24)
	hour_step = path.get_baked_points().size() / 24
	baked_points_pos = midnight_step + (hour_step * Global.DayNight.day_start_hour)


func _physics_process(delta):
	if move:
		if Global.DayNight:
			move_moon(delta)


func change_state(new_state):
	if state != new_state:
		energy_start = state
		energy_end = new_state

		state = new_state

		$Tween.interpolate_property(self, "energy", energy_start, energy_end, transition_duration, Tween.TRANS_SINE, Tween.EASE_OUT)
		$Tween.start()


func move_moon(delta):
	if baked_points_pos + (delta * speed) >= path.get_baked_points().size():
		baked_points_pos += (delta * speed) - path.get_baked_points().size()
	else:
		position = path.get_baked_points()[baked_points_pos]
		baked_points_pos += delta * speed
