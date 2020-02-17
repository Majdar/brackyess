extends Node

#vars_pyh:
var motion : Vector2 = Vector2()
export var camera_speed : int = 300
var dir : int = 1

#vars_start:
var camera_move : bool = false


#func_ready:
func _ready():
	
	go()

#func_phyices:
func _physics_process(delta):
	
	if camera_move == true:
		motion.x = camera_speed * dir * delta
		$camera.translate(motion)


#game_starts:
func go():
	camera_move = true
