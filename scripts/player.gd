extends KinematicBody2D


#vars_phy:

#vectors:
var motion : Vector2 = Vector2()
var Floor : Vector2  = Vector2(0, -1)

#values:
export var max_speed : int = 600
export var acc = 15
export var gravity : int = 20
export var jump : int = -650
export var slidness : float = 0.005 

#funcs:
# warning-ignore:unused_argument
func _physics_process(delta):
	
	#input:
	inputt()
	
	#gravity:
	motion.y += gravity



func inputt():
	
	#movment:
	
	#move_and_slide:
	motion = move_and_slide(motion, Floor)
	
	#right:
	if Input.is_action_pressed("ui_right"):
		motion.x += acc
		if motion.x >= max_speed:
			motion.x = max_speed
	
	#left:
	elif Input.is_action_pressed("ui_left"):
		motion.x -= acc
		if motion.x <= -max_speed:
			motion.x = -max_speed
	
	#idel:
	else:
		motion.x = lerp(motion.x, 0, slidness)
	
	#jump:
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = jump

func game_over():
	$game_over.start()

func _on_game_over_timeout():
	get_tree().reload_current_scene()
