extends Node2D

onready var test : Node = get_parent().get_parent().get_parent()

export var go : bool = false

# warning-ignore:unused_argument
func _process(delta):
	
	if go == true:
		
		if Input.is_action_just_pressed("ui_accept"):
			
			test.again()
		
		elif Input.is_action_just_pressed("ui_end"):
			
			test.exit()
