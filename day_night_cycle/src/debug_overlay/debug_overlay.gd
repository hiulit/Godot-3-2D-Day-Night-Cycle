class_name DebugOverlay
extends PopupPanel

## If a `MoonLight` node is assigned,
## a **Show moon** checkbox will appear in the debug overlay to enable/disable the moon.
export (NodePath) var moon_light_node_path
## Enables/disables the debug overlay.
export (bool) var show = true

var moon_light_node

onready var time_slider = $VBoxContainer/TimeSlider
onready var freeze_time_checkbox = $VBoxContainer/FreezeTimeCheckbox
onready var show_moon_light_checkbox = $VBoxContainer/ShowMoonLightCheckbox
onready var time_label = $VBoxContainer/TimeLabel
onready var date_label = $VBoxContainer/DateLabel
onready var period_label = $VBoxContainer/PeriodLabel
onready var fps_label = $VBoxContainer/FPSLabel


func _ready():
	# Remove the debug overlay if 'show' is set to 'false'.
	if not show:
		# Unfreeze the time.
		Time.freeze_time = false
		queue_free()

	# Connect signals.
	var current_minute_changed_signal = Time.connect(
		"current_minute_changed", self, "_on_minute_changed"
	)

	var current_hour_changed_signal = Time.connect("current_hour_changed", self, "_on_hour_changed")

	var current_cycle_changed_signal = Time.connect(
		"current_cycle_changed", self, "_on_current_cycle_changed"
	)

	# Check if signals are connected correctly.
	if current_minute_changed_signal != OK:
		printerr(current_minute_changed_signal)

	if current_hour_changed_signal != OK:
		printerr(current_hour_changed_signal)

	if current_cycle_changed_signal != OK:
		printerr(current_cycle_changed_signal)

	# Set the debug overlay labels and checkboxes.
	freeze_time_checkbox.pressed = Time.freeze_time

	if moon_light_node_path:
		moon_light_node = get_node(moon_light_node_path)

		if (
			moon_light_node.static_moon and not moon_light_node.move_moon
			or moon_light_node.cycle_sync_node_path
		):
			show_moon_light_checkbox.pressed = true
		else:
			show_moon_light_checkbox.queue_free()
	else:
		show_moon_light_checkbox.queue_free()

	_update_time_slider()
	_update_time_labels()

	# Show the debug overlay.
	call_deferred("popup")


func _process(_delta):
	_update_fps_text()


# PRIVATE FUNCTIONS
# -----------------
func _update_time_labels():
	time_label.text = "Time: " + Time.current_time_string()
	date_label.text = "Date: " + Time.current_date_string()
	period_label.text = "Period: " + Time.current_cycle_to_string()


func _update_fps_text():
	fps_label.text = "FPS: " + str(Engine.get_frames_per_second())


func _update_time_slider():
	# Update the handle to reflect the current hour.
	var current_hour_normalized = Time.get_current_hour() / float(Time.HOURS_IN_A_DAY)

	time_slider.value = current_hour_normalized * time_slider.max_value


# CALLBACKS
# ---------
func _on_minute_changed():
	_update_time_labels()


func _on_hour_changed():
	_update_time_labels()
	_update_time_slider()


func _on_current_cycle_changed():
	_update_time_labels()


func _on_time_slider_gui_input(event):
	if event is InputEventMouseButton:
		# Disable interpolation while we're dragging the slider.
		if event.is_pressed():
			Time.changing_time_manually = true
		else:
			Time.changing_time_manually = false

			if not time_slider.editable:
				time_slider.editable = true


func _on_time_slider_value_changed(value):
	var hour = int((value / time_slider.max_value) * Time.HOURS_IN_A_DAY)

	if hour == -1 or hour == 24:
		time_slider.editable = false

	Time.set_current_hour(hour)


func _on_freeze_time_checkbox_toggled(button_pressed):
	Time.freeze_time = button_pressed


func _on_show_moon_checkbox_toggled(button_pressed):
	moon_light_node.visible = button_pressed
