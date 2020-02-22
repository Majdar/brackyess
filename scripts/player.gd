extends KinematicBody2D

#nodes:
onready var spawner : Control = get_parent().get_node("game_spawner")
onready var test : Node = get_parent()
onready var camera_trans : KinematicBody2D = get_parent().get_node("camera_trans")
onready var audio : AudioStreamPlayer = get_parent().get_node("audio1")
onready var audio2 : AudioStreamPlayer = get_parent().get_node("audio2")
onready var audio3 : AudioStreamPlayer = get_parent().get_node("audio3")
onready var sounds : AudioStreamPlayer = get_parent().get_node("sounds")
onready var save_system : Control = get_parent().get_node("save_system")

#preloads:
var ghost : PackedScene = preload("res://scenes/ghost.tscn")
var once : bool = false

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

#vars_player:
var hp : int = 3
var endr : bool = false
var one : bool = false

#funcs:

#ready:
func _ready():
	
	$Sprite.texture = global.e_texture


# warning-ignore:unused_argument
func _physics_process(delta):
	
	if one == false:
		if position.y > 700.788:
			game_over()
			one = true
	
	#partcles:
	if is_on_floor():
		if motion.x > 400:
			$left.emitting = true
			$right.emitting = false
		
		elif motion.x < -400:
			$left.emitting = false
			$right.emitting = true
		
		elif motion.x > -400 and motion.x < 400:
			$left.emitting = false
			$right.emitting = false
	
	else:
		$left.emitting = false
		$right.emitting = false
		
		if once == false:
			if motion.x >= 560 or motion.x <= -560:
				$ghost.start()
				once = true
	
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
			
			if is_on_floor() == false:
				if motion.x > 300:
					if once == false:
						$ghost.start()
						once = true

	
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
			$left.emitting = false
			$right.emitting = false
			motion.y = jump
			$sound.play()
	
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


#func hurt:
func hurt():
	if endr == false:
		hp -= 1
		endr = true
		$anim.play("hurt")
		$endr.start()
	
	
	if hp <= 0:
# warning-ignore:return_value_discarded
		game_over()



#game_over:
func game_over():
	$game_over.start()

func _on_game_over_timeout():
	
	hp = 0
	$CollisionShape2D.queue_free()
	spawner.stop = true
	test.camera_move = false
	test.dead()
	test.sound()
	camera_trans.go = false
	audio.stop()
	audio2.stop()
	audio3.stop()
	$Tween.interpolate_property(self, 'scale', scale, Vector2(0,0), 0.5,Tween.TRANS_CIRC,Tween.EASE_OUT )
	save_system.save()
	$Tween.start()


#holes_cause_problems:

#ice:
func cold():
	modulate = Color(0.2, 1, 1, 1)
	max_speed = 420
	acc = 7
	jump = - 450
	rot_acc = 0.001
	max_rot_speed = 0.03
	gravity = 25
	$back_to_normal.start()


func _on_back_to_normal_timeout():
	modulate = Color(1, 1, 1, 1)
	max_speed = 600
	acc = 15
	jump = -650
	rot_acc = 0.002
	max_rot_speed = 0.05
	gravity = 20

#endrence:
func _on_endr_timeout():
	$anim.stop()
	modulate = Color(1, 1, 1, 1)
	endr = false

#coins:
func coin():
	
	global.coins += 1


# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_Tween_tween_completed(object, key):
	queue_free()


func _on_ghost_timeout():
	var ghost_b = ghost.instance()
	get_parent().add_child(ghost_b)
	ghost_b.global_position = global_position
	ghost_b.texture = $Sprite.texture
	ghost_b.rotation_degrees = $Sprite.rotation_degrees
	ghost_b.scale = scale
	once = false
