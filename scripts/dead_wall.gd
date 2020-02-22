extends Area2D






func _on_dead_body_entered(body):
	if body.name == "player":
		body.game_over()




