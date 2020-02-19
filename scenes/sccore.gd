extends Label

#sccore:
var sccore : int = 0

#nodes:
onready var spawn : KinematicBody2D = get_parent().get_parent().get_parent().get_node("game_spawner")

func _on_xp_timeout():
	
	if spawn.dif == 0 or spawn.dif == 1:
		sccore += 5
	
	elif spawn.dif >= 2:
		sccore += 10 

func _physics_process(delta):
	
	text = "score : " + str(sccore)
