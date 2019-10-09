extends Node2D

func _ready():
#	queue_free()
	pass


func _process(delta):
#	update()
	pass


func _draw():
	for moon in get_tree().get_nodes_in_group("moons"):
		# Duplicate the moon
		var new_moon_resource = PackedScene.new()
		new_moon_resource.pack(moon)
		var new_moon = new_moon_resource.instance()
		# Remove the old moon
		moon.queue_free()
		# Add new the new moon
		add_child(new_moon)
		
		print(moon.position)

		draw_set_transform(new_moon.position, 0.0, new_moon.scale)
		draw_texture(new_moon.texture, new_moon.position, new_moon.modulate)
#		print(new_moon.position)
#		print(new_moon.cycles)
	pass