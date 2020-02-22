extends Control

#nodes:
onready var player  : KinematicBody2D = get_parent().get_node("player")

#vars:
var cam_move : bool = false
var x : int = 494.453
var y : int = -10289.594

#prelods:
var coin : PackedScene = preload("res://scenes/coin.tscn")


func go():
	
	$cam.current = true
	
	cam_move = true
	player.gravity = 2
	
	for i in 28:
		
		var d = randi() % 3 + 1
		y += 300
		
		match d:
			1:
				
				if x < 1000:
					x += 100
				
				else:
					x += -100
			
			2:
				if x > 100:
					x += -100
					
				else:
					x += 100
			
			3:
# warning-ignore:standalone_expression
				null
		
		var coin_b = coin.instance()
		get_parent().call_deferred('add_child', coin_b)
		coin_b.global_position = Vector2(x, y)


func restart():
	cam_move = false
# warning-ignore:narrowing_conversion
	x = 494.453
# warning-ignore:narrowing_conversion
	y = -10289.594
	$cam.global_position = Vector2(506.165, -6400.3)

# warning-ignore:unused_argument
func _physics_process(delta):
	
	if cam_move == true:
		if is_instance_valid(player):
			$cam.global_position.y = player.global_position.y
