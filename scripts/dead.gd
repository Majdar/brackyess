extends Area2D



func _on_dead_body_entered(body):
	if body.name == "player":
		get_tree().reload_current_scene()


func _on_bye_timeout():
	queue_free()
