extends Node

#vars_phy:
export var camera_speed : int = 300
var dir : int = 1

#vars_start:
export var camera_move : bool = false

#func_ready:
func _ready():
	
	pass

#func_phyices:
# warning-ignore:unused_argument
func _physics_process(delta):
	
	if camera_move == true:
		$camera_trans.move_and_slide($camera_trans.motion)
		$camera_trans.motion.x = camera_speed * dir
		


#game_starts:
func go():
	camera_move = true

