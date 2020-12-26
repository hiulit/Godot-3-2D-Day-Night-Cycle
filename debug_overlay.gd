extends PopupPanel

onready var time_slider = $VBoxContainer/time_slider
onready var freeze_time_checkbox = $VBoxContainer/freeze_time_checkbox
onready var time_label = $VBoxContainer/time_label
onready var date_label = $VBoxContainer/date_label
onready var period_label = $VBoxContainer/period_label
onready var fps_label = $VBoxContainer/fps_label


func _ready():
#	var connect_current_second_changed_signal = Time.connect("current_second_changed", self, "_on_second_changed")
#	if connect_current_second_changed_signal != OK:
#		printerr(connect_current_second_changed_signal)

	var connect_current_minute_changed_signal = Time.connect("current_minute_changed", self, "_on_minute_changed")
	if connect_current_minute_changed_signal != OK:
		printerr(connect_current_minute_changed_signal)

	var connect_current_hour_changed_signal = Time.connect("current_hour_changed", self, "_on_hour_changed")
	if connect_current_hour_changed_signal != OK:
		printerr(connect_current_hour_changed_signal)

	var connect_current_cycle_changed_signal = Time.connect("current_cycle_changed", self, "_on_current_cycle_changed")
	if connect_current_cycle_changed_signal != OK:
		printerr(connect_current_cycle_changed_signal)

	freeze_time_checkbox.pressed = Time.freeze_time

	_update_time_slider()
	_update_time_labels()

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
#	set_block_signals(true)
	time_slider.value = current_hour_normalized * time_slider.max_value
#	set_block_signals(false)


# CALLBACKS
# ---------
#func _on_second_changed():
#	_update_time_labels()


func _on_minute_changed():
	_update_time_labels()


func _on_hour_changed():
	_update_time_labels()

#	if Time.changing_time_manually:
#		# Avoid recursion
#		return

	_update_time_slider()


func _on_current_cycle_changed():
	_update_time_labels()


func _on_time_slider_gui_input(event):
	if event is InputEventMouseButton:
		# Disable interpolation while we're dragging the slider.
		if event.is_pressed():
			Time.changing_time_manually = true
		else:
			Time.set_deferred("changing_time_manually", false)

			if not time_slider.editable:
				time_slider.editable = true


func _on_time_slider_value_changed(value):
	var hour = int((value / time_slider.max_value) * Time.HOURS_IN_A_DAY)

	if hour == -1 or hour == 24:
		time_slider.editable = false

	Time.set_current_hour(hour)


func _on_freeze_time_checkbox_toggled(button_pressed):
	Time.freeze_time = button_pressed
