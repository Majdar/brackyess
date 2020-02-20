extends Area2D


var motion : Vector2 = Vector2()
var speed : int = 300


func _physics_process(delta):
	
	if get_parent().camera_move == true:
		motion.x = speed * 1 * delta
		translate(motion)


func _on_dead_body_entered(body):
	if body.name == "player":
		body.game_over()




