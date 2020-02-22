extends Node

#vars_phy:
export var camera_speed : int = 300
var dir : int = 1

#vars_start:
export var camera_move : bool = false
var no_sl : bool = false
var go : bool = false
var were : String 

#nodes:
onready var a = get_node("camera_trans/CanvasLayer/health/1")
onready var b = get_node("camera_trans/CanvasLayer/health/2")
onready var c = get_node("camera_trans/CanvasLayer/health/3")
var empty : Texture = preload("res://assets/health/Heart_empty.png")



#func_ready:
func _ready():
	
	
	randomize()
	var d = randi() % 3 + 1
	match d:
		1:
			$audio1.play()
		2:
			$audio2.play()
		3:
			$audio3.play()
	pass

#func_phyices:
# warning-ignore:unused_argument
func _physics_process(delta):
	
	if camera_move == true:
		$camera_trans.move_and_slide($camera_trans.motion)
		$camera_trans.motion.x = camera_speed 
		
	elif camera_move == false:
		
		if no_sl == false:
			$camera_trans.move_and_slide($camera_trans.motion)
			camera_speed = lerp(camera_speed, 0, 0.05)
			$camera_trans.motion.x = camera_speed 
		
		elif no_sl == true:
			camera_speed = 0
			$camera_trans.motion.x = camera_speed 


#game_starts:
# warning-ignore:function_conflicts_variable
func go():
	camera_speed = 300
	camera_move = true
	$game_spawner.stop = false

func dead():
	
	if global.high_score >= global.score:
		$camera_trans/CanvasLayer/lost/AnimationPlayer.play("gg")
	
	elif global.high_score < global.score:
		$camera_trans/CanvasLayer/high/score.text = str(global.score)
		$camera_trans/CanvasLayer/high/AnimationPlayer2.play("new")
		$hs.play()

#buttons:
func _on_again_b_pressed():
	if go == true:
		$click.play()
		were = 'again'
		$camera_trans/CanvasLayer/lost/AnimationPlayer.play("fade_out")
		go = false


func _on_exit_b_pressed():
	if go == true:
		$click.play()
		were = 'start'
		$camera_trans/CanvasLayer/lost/AnimationPlayer.play("fade_out")
		go = false


func _on_AnimationPlayer_animation_finished(anim_name):
	
	if anim_name == 'fade_out':
# warning-ignore:return_value_discarded
		if were == 'start':
			get_tree().change_scene("res://scenes/start_screen.tscn")
		
		elif were == 'again':
# warning-ignore:return_value_discarded
			get_tree().reload_current_scene()
	
	if anim_name == 'gg':
		go = true



func _on_again_b_mouse_entered():
	$camera_trans/CanvasLayer/lost/again.modulate = Color(1, 1, 1, 0.6)
	$camera_trans/CanvasLayer/lost/again_b.modulate = Color(1, 1, 1, 0.6)


func _on_again_b_mouse_exited():
	$camera_trans/CanvasLayer/lost/again.modulate = Color(1, 1, 1, 1)
	$camera_trans/CanvasLayer/lost/again_b.modulate = Color(1, 1, 1, 1)


func _on_exit_b_mouse_entered():
	$camera_trans/CanvasLayer/lost/exit.modulate = Color(1, 1, 1, 0.6)
	$camera_trans/CanvasLayer/lost/exit_b.modulate = Color(1, 1, 1, 0.6)


func _on_exit_b_mouse_exited():
	$camera_trans/CanvasLayer/lost/exit.modulate = Color(1, 1, 1, 1)
	$camera_trans/CanvasLayer/lost/exit_b.modulate = Color(1, 1, 1, 1)

func sound():
	if $player.hp <= 0:
		$sounds.play()
		a.texture = empty
		b.texture = empty
		c.texture = empty


func _on_new_score_timeout():
	$camera_trans/CanvasLayer/high.modulate = Color(1, 1, 1, 0)
	$camera_trans/CanvasLayer/lost/AnimationPlayer.play("gg")


func _on_AnimationPlayer2_animation_finished(anim_name):
	
	if anim_name == 'new':
		$new_score.start()

func stop():
	no_sl = true
	camera_move = false
	$game_spawner.stop = false

