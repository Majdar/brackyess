extends Node

#vars_phy:
export var camera_speed : int = 300
var dir : int = 1

#vars_start:
export var camera_move : bool = false
var go : bool = false
var were : String 

#func_ready:
func _ready():
	
	pass

#func_phyices:
# warning-ignore:unused_argument
func _physics_process(delta):
	
	if camera_move == true:
		$camera_trans.move_and_slide($camera_trans.motion)
		$camera_trans.motion.x = camera_speed 
		
	elif camera_move == false:
		$camera_trans.move_and_slide($camera_trans.motion)
		camera_speed = lerp(camera_speed, 0, 0.05)
		$camera_trans.motion.x = camera_speed 


#game_starts:
# warning-ignore:function_conflicts_variable
func go():
	camera_move = true

func dead():
	$camera_trans/CanvasLayer/lost/AnimationPlayer.play("gg")

#buttons:
func _on_again_b_pressed():
	if go == true:
		were = 'again'
		$camera_trans/CanvasLayer/lost/AnimationPlayer.play("fade_out")
		go = false


func _on_exit_b_pressed():
	if go == true:
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
