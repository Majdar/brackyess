extends Area2D

var real_sprite : Texture = preload("res://assets/holes/Poison/Hole with poison spikes.png")
var is_in : bool = false


func _on_psoion_body_entered(body):
	if body.name == 'player':
		$Sprite.texture = real_sprite
		$AnimationPlayer.play("go")



func _on_VisibilityNotifier2D_screen_entered():
	is_in = true


func _on_VisibilityNotifier2D_screen_exited():
	if is_in == true:
		$bye.start()


func _on_bye_timeout():
	queue_free()
