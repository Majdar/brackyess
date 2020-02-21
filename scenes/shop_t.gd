extends Node

#vars_phy:
export var camera_speed : int = 300
var dir : int = 1

#vars_start:
export var camera_move : bool = false
var were : String 


#func_ready:
func _ready():
	
	$open.play()
	$CanvasLayer/AnimationPlayer.play("fade_in")
	pass

#func_phyices:
# warning-ignore:unused_argument
func _physics_process(delta):
	
	$camera_trans.move_and_slide($camera_trans.motion)
	$camera_trans.motion.x = camera_speed 


func _on_back_pressed():
	$CanvasLayer/AnimationPlayer.play("fade_out")


func _on_AnimationPlayer_animation_finished(anim_name):
	
	if anim_name == 'fade_out':
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/start_screen.tscn")
