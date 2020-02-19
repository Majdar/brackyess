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
export var rot_acc : float = 0.002
export var rot_speed : float = 0
export var max_rot_speed : float = 0.1
var in_air : bool = false

#funcs:
# warning-ignore:unused_argument
func _physics_process(delta):
	
	#on_ground:
	if is_on_floor():
		if in_air == true:
			
			#rot_speed:
			rot_speed = 0
			
			#plus:
			if 0 < $Sprite.rotation_degrees and $Sprite.rotation_degrees < 45:
				$Sprite.rotation_degrees = 0
			 
			elif 45 < $Sprite.rotation_degrees and $Sprite.rotation_degrees < 90:
				$Sprite.rotation_degrees = 90
			
			elif 90 < $Sprite.rotation_degrees and $Sprite.rotation_degrees < 135:
				$Sprite.rotation_degrees = 90
			
			elif 135 < $Sprite.rotation_degrees and $Sprite.rotation_degrees < 180:
				$Sprite.rotation_degrees = 180
			
			elif 180 < $Sprite.rotation_degrees and $Sprite.rotation_degrees < 225:
				$Sprite.rotation_degrees = 180
			
			elif 225 < $Sprite.rotation_degrees and $Sprite.rotation_degrees < 270:
				$Sprite.rotation_degrees = 270
			
			elif 270 < $Sprite.rotation_degrees and $Sprite.rotation_degrees < 310:
				$Sprite.rotation_degrees = 270
			
			elif 310 < $Sprite.rotation_degrees:
				$Sprite.rotation_degrees = 0
			
			#subtract:
			if 0 > $Sprite.rotation_degrees and $Sprite.rotation_degrees > -45:
				$Sprite.rotation_degrees = 0
			 
			elif -45 > $Sprite.rotation_degrees and $Sprite.rotation_degrees > -90:
				$Sprite.rotation_degrees = -90
			
			elif -90 > $Sprite.rotation_degrees and $Sprite.rotation_degrees >-135:
				$Sprite.rotation_degrees = -90
			
			elif -135 > $Sprite.rotation_degrees and $Sprite.rotation_degrees > -180:
				$Sprite.rotation_degrees = -180
			
			elif -180 > $Sprite.rotation_degrees and $Sprite.rotation_degrees > -225:
				$Sprite.rotation_degrees = -180
			
			elif -225 > $Sprite.rotation_degrees and $Sprite.rotation_degrees > -270:
				$Sprite.rotation_degrees = -270
			
			elif -270 > $Sprite.rotation_degrees and $Sprite.rotation_degrees > -310:
				$Sprite.rotation_degrees = -270
			
			elif -310 > $Sprite.rotation_degrees:
				$Sprite.rotation_degrees = 0
			
			
			in_air = false

	
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
	
	#in_air:
	else:
		in_air = true
		#rotate_right:
		if Input.is_action_pressed("ui_right"):
			rot_speed += rot_acc
			$Sprite.rotate(rot_speed)
			if rot_speed >= max_rot_speed:
				rot_speed = max_rot_speed
		
		#rotate_left:
		elif Input.is_action_pressed("ui_left"):
			rot_speed -= rot_acc
			$Sprite.rotate(rot_speed)
			if rot_speed <= -max_rot_speed:
				rot_speed = -max_rot_speed
		
		else:
			$Sprite.rotate(lerp(rot_speed, 0, 0.001))


#game_over:
func game_over():
	$game_over.start()
func _on_game_over_timeout():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()