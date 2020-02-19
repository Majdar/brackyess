extends Area2D


#vars_phy:
var motion : Vector2 = Vector2()
export var speed : int = 250

#vars_needed:
var down : bool = false
var dad

#funcs:
func _physics_process(delta):
	
	rotate(0.1)
	
	if down == false:
		motion.y = speed * -1 * delta 
		translate(motion)
	
	else:
		motion.y = lerp(motion.y, 25, 0.01)
		translate(motion)


func _on_Timer_timeout():
	down = true


func _on_bye_timeout():
	queue_free()


func _on_fire_body_entered(body):
	if body.name == 'player':
		body.cold()
