extends Area2D


var is_in : bool = false

func _on_coin_body_entered(body):
	if body.name == "player":
		body.coin()
		$audio.play()
		$AnimationPlayer.play("bye")

# warning-ignore:unused_argument
func _process(delta):
	$AnimatedSprite.play('go')


# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()


func _on_VisibilityNotifier2D_screen_entered():
	is_in = true


func _on_VisibilityNotifier2D_screen_exited():
	if is_in == true:
		queue_free()
