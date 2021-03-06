extends Area2D

var motion : Vector2 = Vector2()
var speed : int = 300


func _physics_process(delta):
	
	motion.x = speed * 1 * delta
	translate(motion)


func _on_dead_body_entered(body):
	if body.name == "player":
		body.game_over()


func _on_bye_timeout():
	queue_free()


func _on_VisibilityNotifier2D_screen_entered():
	$bye.start()


