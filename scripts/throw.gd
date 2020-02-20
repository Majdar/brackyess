extends Area2D


#preloads:
onready var fire : PackedScene = preload("res://scenes/fire.tscn")
onready var snow : PackedScene = preload("res://scenes/ice.tscn")
onready var posion : PackedScene = preload("res://scenes/psoion.tscn")

#vars_holes:
var hole_tybe : int = 1

#var_bye:
var im_in : bool = false


func again():
	
	#fire_hole:
	if hole_tybe == 1:
		$fire.emitting = true
		var fire_p = fire.instance()
		get_parent().add_child(fire_p)
		fire_p.global_position = global_position
		fire_p.dad = self
		$go.start()
	
	#ice_ball:
	elif hole_tybe == 2:
		$ice.emitting = true
		var fire_p = snow.instance()
		get_parent().add_child(fire_p)
		fire_p.global_position = global_position
		fire_p.dad = self
		$go.start()
	
	#posion:
	elif hole_tybe == 3:
		$smell.emitting = true
		var fire_p = posion.instance()
		get_parent().add_child(fire_p)
		fire_p.global_position = Vector2(position.x + 47, position.y + 42)
		$go.start()


func _on_VisibilityNotifier2D_screen_entered():
	im_in = true
	again()


func _on_VisibilityNotifier2D_screen_exited():
	if im_in == true:
		queue_free()


func _on_go_timeout():
	again()
