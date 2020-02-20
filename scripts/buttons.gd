extends Control

#vars:
var to : String
var go : bool = false


#funcs:
func _ready():
	
	$AnimationPlayer.play("fade_in")

#start:
func _on_start_pressed():
	
	if go == true:
		to = 'start'
		$AnimationPlayer.play("fade_out")
		go = false

#shop:
func _on_shop_pressed():
	
	if go == true:
		to = 'shop'
		$AnimationPlayer.play("fade_out")
		go = false

#exit:
func _on_exit_pressed():
	
	if go == true:
		to = 'exit'
		$AnimationPlayer.play("fade_out")
		go = false


func _on_AnimationPlayer_animation_finished(anim_name):
	
	if anim_name == 'fade_in':
		go = true
	
	if anim_name == 'fade_out':
		
		if to == 'start':
# warning-ignore:return_value_discarded
			get_tree().change_scene("res://scenes/test.tscn")
		
		elif to == 'shop':
# warning-ignore:return_value_discarded
			get_tree().change_scene("res://scenes/shop.tscn")
		
		elif to == 'exit':
			get_tree().quit()
