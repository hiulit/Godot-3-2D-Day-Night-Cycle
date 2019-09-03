extends PopupPanel

func _ready():
	$VBoxContainer/TimeSlider.connect("value_changed", self, "_time_slider_moved")
	$VBoxContainer/TimeSlider.connect("gui_input", self, "_time_slider_input_event")
	$VBoxContainer/FreezeTimeCheckBox.connect("toggled", self, "_freeze_time_toggled")

	Time.connect("current_second_changed", self, "_on_current_second_changed")
	Time.connect("current_minute_changed", self, "_on_minute_changed")
	Time.connect("current_hour_changed", self, "_on_hour_changed")

	# Force it on startup.
	_on_hour_changed()

	popup()

func _time_slider_moved(value: float):
	var hour: int = int((value / 100.0) * 24)
	Time.set_current_hour(hour)

func _on_minute_changed():
	_update_time_labels()

func _on_hour_changed():
	_update_time_labels()

	if (Time.changing_time_manually):
		# Avoid recursion
		return

	# Update the handle to reflect to the current hour
	var current_hour_normalised = Time.current_hour() / float(Time.hours_in_a_day)
	set_block_signals(true)
	$VBoxContainer/TimeSlider.value = current_hour_normalised * 100
	set_block_signals(false)

func _update_time_labels():
	$VBoxContainer/TimeLabel.text = "Time: " + Time.current_time_string()
	$VBoxContainer/DateLabel.text = "Date: " + Time.current_date_string()
	$VBoxContainer/PeriodLabel.text = "Period: " + Time.current_cycle_to_string()

func _time_slider_input_event(event):
	if (event is InputEventMouseButton):
		# Disable interpolation while we're dragging the slider.
		if (event.is_pressed()):
			Time.changing_time_manually = true
		else:
			Time.set_deferred("changing_time_manually", false)

func _process(_delta):
	_update_fps_text()

func _update_fps_text():
	$VBoxContainer/FpsLabel.text = "FPS: " + str(Engine.get_frames_per_second())

func _freeze_time_toggled(checked):
	Time.freeze_time = checked