extends Control

#vars:
var to : String
var go : bool = true


#funcs:
func _ready():
	
	$AnimationPlayer.play("fade_in")


func _on_AnimationPlayer_animation_finished(anim_name):
	
	if anim_name == 'fade_out':
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/start_screen.tscn")



func _on_back_pressed():
	if go == true:
		$click.play()
		$AnimationPlayer.play("fade_out")
		go = false
