extends KinematicBody2D


#vars_pyh:
var motion : Vector2 = Vector2()

#nodes:
onready var player : KinematicBody2D = get_parent().get_node("player")
onready var h1 : Sprite = get_parent().get_node("camera_trans/CanvasLayer/health/1")
onready var h2 : Sprite = get_parent().get_node("camera_trans/CanvasLayer/health/2")
onready var h3 : Sprite = get_parent().get_node("camera_trans/CanvasLayer/health/3")

#preloads:
var empty : Texture = preload("res://assets/health/Empty Heart.png")

func _process(delta):
	
	if player.hp == 2:
		h3.texture = empty
	
	elif player.hp == 1:
		h3.texture = empty
		h2.texture = empty
	
	elif player.hp <= 0:
		h3.texture = empty
		h2.texture = empty
		h1.texture = empty
