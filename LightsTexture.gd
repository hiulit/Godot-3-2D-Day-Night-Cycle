extends Node2D

func _ready():
#	queue_free()
	for light in get_tree().get_nodes_in_group("lights"):
		# Duplicate the light
		var new_light_resource = PackedScene.new()
		new_light_resource.pack(light)
		var new_light = new_light_resource.instance()
		# Remove the old light
		light.queue_free()
		# Add new the new light
		add_child(new_light)
