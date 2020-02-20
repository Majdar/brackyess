extends Label

#sccore:
var sccore : int = 0

#nodes:
onready var player : KinematicBody2D = get_parent().get_parent().get_parent().get_node("player")

# warning-ignore:unused_argument
func _physics_process(delta):
	
	sccore = int(player.position.x / 2)
	
	text =  str(sccore)



