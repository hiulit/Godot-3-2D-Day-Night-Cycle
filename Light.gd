tool
extends Node2D

export (float) var inner_radius = 5.0 setget _set_inner_radius
export (float) var shadow_radius = 50.0 setget _set_shadow_radius
export (float) var shadow_threshold = 0.0 setget _set_shadow_threshold
export (float) var steps = 10.0 setget _set_steps
export (Color) var color = Color(1, 1, 1, 1) setget _set_color

func _ready():
	add_to_group("lights")


func _draw():
	# Shadow
	for step in steps:
		var shadow_alpha = clamp((1 - shadow_threshold) - ((step - shadow_threshold) / steps), 0, 1)
		var step_radius = (((shadow_radius - inner_radius) / steps) / 2) * step
		draw_circle(Vector2(0, 0), inner_radius + step_radius, Color(color.r, color.g, color.b, shadow_alpha))
	
	# Light
	draw_circle(Vector2(0, 0), inner_radius, color)


func _set_inner_radius(new_inner_radius):
    if inner_radius != new_inner_radius:
        inner_radius = new_inner_radius
        update()


func _set_shadow_radius(new_shadow_radius):
    if shadow_radius != new_shadow_radius:
        shadow_radius = new_shadow_radius
        update()


func _set_shadow_threshold(new_shadow_threshold):
    if shadow_threshold != new_shadow_threshold:
        shadow_threshold = new_shadow_threshold
        update()


func _set_steps(new_steps):
    if steps != new_steps:
        steps = new_steps
        update()


func _set_color(new_color):
    if color != new_color:
        color = new_color
        update()
