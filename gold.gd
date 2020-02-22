extends Area2D

var is_in : bool = false

#nodes:
onready var bonc = get_parent().get_node('bonc')
onready var go_back = get_parent().get_node('go_back')

func _on_psoion_body_entered(body):
	if body.name == 'player':
		$AnimationPlayer.play("go")
		$CollisionShape2D.queue_free()



func _on_VisibilityNotifier2D_screen_entered():
	is_in = true


func _on_VisibilityNotifier2D_screen_exited():
	if is_in == true:
		$bye.start()


func _on_bonc_body_entered(body):
	
	if body.name == 'player':
		
		go_back.last_pos = Vector2(body.position.x + 92, - 10) 
		
		get_parent().stop()
		
		bonc.go()
		
		body.position = Vector2(517.664, -11553.609)
		
		$bonc.queue_free()



func _on_bye_timeout():
	queue_free()
