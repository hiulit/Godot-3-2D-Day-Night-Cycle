extends ColorRect

export (float) var day_duration = 0.1 # In minutes
export (float) var day_start_hour = 10 # 24 hours time (0-23)
export (float) var day_start_number = 1

export var color_dawn = Color(0.86, 0.70, 0.70, 1.0)
export var color_day = Color(1.0, 1.0, 1.0, 1.0)
export var color_dusk = Color(0.59, 0.66, 0.78, 1.0)
export var color_night = Color(0.07, 0.09, 0.38, 1.0)

export (float) var state_dawn_start_hour = 5
export (float) var state_day_start_hour = 8
export (float) var state_dusk_start_hour = 16
export (float) var state_night_start_hour = 19

export (float) var state_transition_duration = 1 # In hours

export (bool) var debug_mode = false

export (bool) var on = true

var current_time
var current_day_hour
var current_day_number

var transition_duration

var cycle
enum cycle_state { NIGHT, DAWN, DAY, DUSK }

var cycle_color
var cycle_brightness
var cycle_contrast
var cycle_saturation
var cycle_pop_strength
var cycle_pop_threslhold

var cycles = {
	night = {
		color = color_night,
		brightness = 1.11,
		contrast = 0.7,
		saturation = 0.64,
		pop_strength = 1.67,
		pop_threslhold = 0.69
	},
	dawn = {
		color = color_dawn,
		brightness = 0.88,
		contrast = 1.3,
		saturation = 1.24,
		pop_strength = 1.0,
		pop_threslhold = 0.84
	},
	day = {
		color = color_day,
		brightness = 1.0,
		contrast = 1.0,
		saturation = 1.0,
		pop_strength = 1.0,
		pop_threslhold = 1.0
	},
	dusk = {
		color = color_dusk,
		brightness = 0.94,
		contrast = 1.24,
		saturation = 1.36,
		pop_strength = 1.0,
		pop_threslhold = 0.83
	}
}

var window_x = ProjectSettings.get_setting("display/window/size/width")
var window_y = ProjectSettings.get_setting("display/window/size/height")


func _ready():
	if not on:
		queue_free()

	Global.DayNight = self
	
	rect_size = Vector2(window_x, window_y)

	if material.get_shader_param("use_external_lights_tex") == true:
		material.set_shader_param("lights_tex", get_tree().get_nodes_in_group("lights_viewport")[0].get_texture())
		material.set_shader_param("use_external_lights_tex", false)

	day_duration = 60 * 60 * day_duration # Convert 'day_duration' from minutes to seconds

	current_day_number = day_start_number
	current_time = (day_duration / 24) * day_start_hour
	current_day_hour = current_time / (day_duration / 24)

	transition_duration = (((day_duration / 24) * state_transition_duration) / 60)

	if current_day_hour >= state_night_start_hour or current_day_hour < state_dawn_start_hour:
		cycle = cycle_state.NIGHT
	elif current_day_hour >= state_dawn_start_hour and current_day_hour < state_day_start_hour:
		cycle = cycle_state.DAWN
	elif current_day_hour >= state_day_start_hour and current_day_hour < state_dusk_start_hour:
		cycle = cycle_state.DAY
	elif current_day_hour >= state_dusk_start_hour and current_day_hour < state_night_start_hour:
		cycle = cycle_state.DUSK

	cycle_color = cycles[get_cycle_name(cycle).to_lower()].color
	cycle_brightness = cycles[get_cycle_name(cycle).to_lower()].brightness
	cycle_contrast = cycles[get_cycle_name(cycle).to_lower()].contrast
	cycle_saturation = cycles[get_cycle_name(cycle).to_lower()].saturation
	cycle_pop_strength = cycles[get_cycle_name(cycle).to_lower()].pop_strength
	cycle_pop_threslhold = cycles[get_cycle_name(cycle).to_lower()].pop_threslhold

#	material.set_shader_param("cycle_color", cycle_color)
#	material.set_shader_param("brightness", cycle_brightness)
#	material.set_shader_param("contrast", cycle_contrast)
#	material.set_shader_param("saturation", cycle_saturation)
#	material.set_shader_param("pop_strength", cycle_pop_strength)
#	material.set_shader_param("pop_threslhold", cycle_pop_threslhold)

	# Add a tween for each property
	for i in cycles.keys():
		for j in cycles[i].keys():
			cycles[i]["tween_" + j] = Tween.new()
			add_child(cycles[i]["tween_" + j])


func _process(delta):
	day_cycle()
	current_time += 1


func day_cycle():
	current_day_hour = current_time / (day_duration / 24)

	if current_time >= day_duration:
		current_time = 0
		current_day_hour = 0
		current_day_number += 1

	if current_day_hour >= state_night_start_hour or current_day_hour < state_dawn_start_hour:
		cycle(cycle_state.NIGHT)
	elif current_day_hour >= state_dawn_start_hour and current_day_hour < state_day_start_hour:
		cycle(cycle_state.DAWN)
	elif current_day_hour >= state_day_start_hour and current_day_hour < state_dusk_start_hour:
		cycle(cycle_state.DAY)
	elif current_day_hour >= state_dusk_start_hour and current_day_hour < state_night_start_hour:
		cycle(cycle_state.DUSK)

	material.set_shader_param("cycle_color", cycle_color)
	material.set_shader_param("brightness", cycle_brightness)
	material.set_shader_param("contrast", cycle_contrast)
	material.set_shader_param("saturation", cycle_saturation)
	material.set_shader_param("pop_strength", cycle_pop_strength)
	material.set_shader_param("pop_threslhold", cycle_pop_threslhold)

	if debug_mode:
		print(str("Day ", current_day_number)  + " - " + str(int(current_day_hour), " h") + " - " + get_cycle_name(cycle))


func cycle(new_cycle):
	if cycle != new_cycle:
		cycle = new_cycle

		if Global.Moon && obj_exists(Global.Moon):
			Global.Moon.change_state(Global.Moon.cycles[get_cycle_name(cycle).to_lower()].energy)

		var previous_cycle_props = cycles[get_cycle_name(cycle - 1).to_lower()]
		var current_cycle_props = cycles[get_cycle_name(cycle).to_lower()]

		for key in current_cycle_props.keys():
			if key.find("tween_"):
				current_cycle_props["tween_" + key].interpolate_property(
					self,
					"cycle_" + key,
					previous_cycle_props[key],
					current_cycle_props[key],
					transition_duration,
					Tween.TRANS_SINE,
					Tween.EASE_OUT
				)
				current_cycle_props["tween_" + key].start()


func get_cycle_name(cycle):
	return str(cycle_state.keys()[cycle])


func obj_exists(obj):
	if Engine.get_version_info().major >= 3 and Engine.get_version_info().minor == 1:
		return true if is_instance_valid(obj) else false
	if Engine.get_version_info().major <= 3 and Engine.get_version_info().minor == 0:
		return true if weakref(obj).get_ref() != null else false
