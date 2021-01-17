extends Light2D

export (Color) var color_night = Color(1.0, 1.0, 1.0, 1.0)
export (float) var energy_night = 1.0
export (Color) var color_dawn = Color(1.0, 1.0, 1.0, 1.0)
export (float) var energy_dawn = 0.0
export (Color) var color_day = Color(1.0, 1.0, 1.0, 1.0)
export (float) var energy_day = 0.0
export (Color) var color_dusk = Color(1.0, 1.0, 1.0, 1.0)
export (float) var energy_dusk = 0.0
export (bool) var move_moon = false
export (NodePath) var cycle_sync_node_path
export (bool) var static_moon = true
export (bool) var use_hour_position = false
export (int, 0, 23) var hour_position = 0

var window_x: float = ProjectSettings.get_setting("display/window/size/width")
var window_y: float = ProjectSettings.get_setting("display/window/size/height")

var window_center := Vector2(window_x / 2, window_y / 2)
var radius_x: float = window_x / 2.10
var radius_y: float = window_y / 2.15

var path := Curve2D.new()

var speed: float
var hour_step: float
var moon_position: float

var cycle_sync_node: Node
var delay: float = 0.0

onready var color_transition_tween = $ColorTransitionTween
onready var energy_transition_tween = $EnergyTransitionTween

func _ready():
	if static_moon and move_moon or not static_moon and not move_moon:
		printerr("--------------------")
		printerr("ERROR!")
		printerr("File: '%s.gd'."  % self.name)
		printerr("Message: The 'static_moon' and 'move_moon' variables can't" + \
				" both be set to 'true' or 'false' at the same time.")
		printerr("--------------------")

		# Reset the path so in case there is a 'DebugOverlay' node,
		# there won't be any options for the 'MoonLight' node.
		cycle_sync_node_path = ""

		return

	# Connect signals.
	var current_hour_changed_signal = Time.connect(
		"current_hour_changed",
		self,
		"_on_current_hour_changed"
	)

	var current_cycle_changed_signal = Time.connect(
		"current_cycle_changed",
		self,
		"_on_current_cycle_changed"
	)

	var time_manually_changed_signal = Time.connect(
		"time_manually_changed",
		self,
		"_on_time_manually_changed"
	)

	var time_freezed_signal = Time.connect(
		"time_freezed",
		self,
		"_on_time_freezed"
	)

	# Check if signals are connected correctly.
	if current_hour_changed_signal != OK:
		printerr(current_hour_changed_signal)

	if current_cycle_changed_signal != OK:
		printerr(current_cycle_changed_signal)

	if time_manually_changed_signal != OK:
		printerr(time_manually_changed_signal)

	if time_freezed_signal != OK:
		printerr(time_freezed_signal)

	# Create the path.
	path.add_point(window_center + Vector2(0, -radius_y), Vector2(-radius_x, 0))
	path.add_point(window_center + Vector2(radius_x, 0), Vector2(0, -radius_y))
	path.add_point(window_center + Vector2(0, radius_y), Vector2(radius_x, 0))
	path.add_point(window_center + Vector2(-radius_x, 0), Vector2(0, radius_y))
	path.add_point(window_center + Vector2(0, -radius_y), Vector2(-radius_x, 0))

	# Sync the speed with in-game time.
	speed = path.get_baked_points().size() / \
			(float(Time.SECONDS_IN_A_DAY) / Time.IN_GAME_SECONDS_PER_REAL_TIME_SECONDS)

	# Divide the path into hours.
	hour_step = path.get_baked_points().size() / float(Time.HOURS_IN_A_DAY)

	if move_moon:
		if cycle_sync_node_path:
			cycle_sync_node = get_node(cycle_sync_node_path)

			# Sync the delay with the cycle.
			delay = cycle_sync_node.delay

			# Make it visible in case it's hidden in the editor.
			visible = true

			moon_position = hour_step * Time.get_current_hour()
			position = path.get_baked_points()[moon_position]
		else:
			printerr("--------------------")
			printerr("ERROR!")
			printerr("File: '%s.gd'."  % self.name)
			printerr("Message: The '" + str(self.name) + "' node isn't" + \
					" sync with any 'DayNightCycle' node." + \
					" Use the 'cycle_sync_node_path' variable in the '" + \
					str(self.name) + "' node to sync it with a 'DayNightCycle' node.")
			printerr("--------------------")

			visible = false

			return
	elif static_moon:
		set_physics_process(false)

		# Make it visible in case it's hidden in the editor.
		visible = true

		if use_hour_position:
			moon_position = hour_step * hour_position
			position = path.get_baked_points()[moon_position]

	# Set the current cycle state.
	match Time.current_cycle:
		Time.CycleState.NIGHT:
			color = color_night
			energy = energy_night
		Time.CycleState.DAWN:
			color = color_dawn
			energy = energy_dawn
		Time.CycleState.DAY:
			color = color_day
			energy = energy_day
		Time.CycleState.DUSK:
			color = color_dusk
			energy = energy_dusk


func _physics_process(delta):
	_move_moon(delta)


# PRIVATE FUNCTIONS
# -----------------
func _move_moon(delta):
	if moon_position + (delta * speed) >= path.get_baked_points().size():
		moon_position += (delta * speed) - path.get_baked_points().size()
	else:
		position = path.get_baked_points()[moon_position]
		moon_position += delta * speed


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
				color_transition_tween.stop_all()
				energy_transition_tween.stop_all()

				color = color_night
				energy = energy_night
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
				color_transition_tween.stop_all()
				energy_transition_tween.stop_all()

				color = color_dawn
				energy = energy_dawn
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
				color_transition_tween.stop_all()
				energy_transition_tween.stop_all()

				color = color_day
				energy = energy_day
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
				color_transition_tween.stop_all()
				energy_transition_tween.stop_all()

				color = color_dusk
				energy = energy_dusk


func _on_current_hour_changed():
	if Time.changing_time_manually and move_moon:
		moon_position = hour_step * Time.get_current_hour()
		position = path.get_baked_points()[moon_position]


func _on_time_manually_changed():
	if not Time.freeze_time and move_moon:
		set_physics_process(not Time.changing_time_manually)


func _on_time_freezed():
	if move_moon:
		set_physics_process(not Time.freeze_time)
