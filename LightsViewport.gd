extends Viewport

var window_x = ProjectSettings.get_setting("display/window/size/width")
var window_y = ProjectSettings.get_setting("display/window/size/height")

func _ready():
	add_to_group("lights_viewport")
	
	size = Vector2(window_x, window_y)
	transparent_bg = true
	hdr = false
	disable_3d = true
	usage = USAGE_2D
	render_target_clear_mode = CLEAR_MODE_ALWAYS
	render_target_v_flip = true
	render_target_update_mode = UPDATE_ALWAYS
	pass