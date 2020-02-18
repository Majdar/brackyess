extends Area2D



func _on_dead_body_entered(body):
	if body.name == "player":
		body.game_over()


func _on_bye_timeout():
	print('bye')
	queue_free()


func _on_VisibilityNotifier2D_screen_entered():
	$bye.start()
