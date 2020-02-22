extends Area2D

#nodes:
onready var bonc : Control = get_parent().get_node("bonc")

onready var test : Control = get_parent()

onready var camera : Control = get_parent().get_node("camera_trans/camera")

onready var cam : Control = get_parent().get_node("bonc/cam")

onready var bo : Control = get_parent().get_node("bo")

onready var player : KinematicBody2D = get_parent().get_node("player")

#var:
var last_pos : Vector2 = Vector2(600, 300)

func _on_go_back_body_entered(body):
	
	if body.name == 'player':
		
		body.gravity = 20
		
		body.global_position = last_pos
		
		bonc.cam_move = false
		
		cam.current = false
		
		camera.current = true
		
		test.no_sl = false
		
		$wait.start()
		
		bonc.restart()
		
		bo.start()
		



func _on_wait_timeout():
	test.go()

