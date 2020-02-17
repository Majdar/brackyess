extends Control

#nodes:
onready var tiles : TileMap = get_parent().get_node("tiles")

#spawn_normal:
var level : int = 1
var x : int = 9
var y : int = 4
export var spawn_time : float = 0.5

#cell_num:
var left : int = 0
var mid : int = 1
var right : int = 2
var left_no_top : int = 3
var right_no_top : int = 4
var empty : int = 5

#spawn_info:
var were_am_i : int = 0
var how_many : int = 3
var spawnd : int = 0
var dif : int = 0


func _ready():
	
	randomize()
	var d = randi() % 2 + 1
	
	match d :
		
		1:
			level = 1
		
		2:
			level = 2
	
	spawn()
	pass


# warning-ignore:unused_argument
func _process(delta):
	$again.wait_time = spawn_time

#give_spawn_values:
func value(used : int):
	
	randomize()
	
	if used == 1:
		level = 2
		
		if dif == 0:
			how_many = 4
		
		spawn()
	
	
	elif used == 2:
		
		var d = randi() % 2 + 1
		
		match d :
			
			1:
				level = 3
			
			2:
				level = 1
		
		
		if dif == 0:
			how_many = 4
		
		spawn()
	
	
	elif used == 3:
		
		var d = randi() % 2 + 1
		
		match d :
			
			1:
				level = 2
			
			2:
				level = 4
		
		
		if dif == 0:
			how_many = 4
		
		spawn()
	
	
	elif used == 4:
		
		level = 3
		
		if dif == 0:
			how_many = 4
		
		spawn()







#spawn:
func spawn():
	
	#level_1:
	if level == 1:
		#were_am_i:
		if were_am_i == 0:
			#change_y:
			y = 4
			#set_cell:
			tiles.set_cell(x, y, left)
			#change_x:
			x += 1
			#change_were_am_i:
			were_am_i = 1
			#again:
			$again.start()
			
		elif were_am_i == 1:
			#change_y:
			y = 4
			#set_cell:
			tiles.set_cell(x, y, mid)
			#change_x:
			x += 1
			#change_were_am_i:
			if spawnd == how_many:
				were_am_i = 2
			spawnd = spawnd + 1
			#again:
			$again.start()
			
		elif were_am_i == 2:
			#change_y:
			y = 4
			#set_cell:
			tiles.set_cell(x, y, right)
			#change_x:
			x += 2
			#change_were_am_i:
			spawnd = 0
			were_am_i = 0
			value(1)
	
	
	#level_2:
	if level == 2:
		#were_am_i:
		if were_am_i == 0:
			#change_y:
			y = 4
			#set_2_cells:
			tiles.set_cell(x, y, left_no_top)
			#change_y_again:
			y = 3
			#set_2_cells:
			tiles.set_cell(x, y, left)
			#change_x:
			x += 1
			#change_were_am_i:
			were_am_i = 1
			#again:
			$again.start()
			
		elif were_am_i == 1:
			#change_y:
			y = 4
			#set_2_cells:
			tiles.set_cell(x, y, empty)
			#change_y_again:
			y = 3
			#set_2_cells:
			tiles.set_cell(x, y, mid)
			#change_x:
			x += 1
			#change_were_am_i:
			if spawnd == how_many:
				were_am_i = 2
			spawnd = spawnd + 1
			#again:
			$again.start()
			
		elif were_am_i == 2:
			#change_y:
			y = 4
			#set_2_cells:
			tiles.set_cell(x, y, right_no_top)
			#change_y_again:
			y = 3
			#set_2_cells:
			tiles.set_cell(x, y, right)
			#change_x:
			x += 2
			#change_were_am_i:
			spawnd = 0
			were_am_i = 0
			value(2)
	
	
	#level_3:
	if level == 3:
		#were_am_i:
		if were_am_i == 0:
			#change_y:
			y = 4
			#set_2_cells:
			tiles.set_cell(x, y, left_no_top)
			#change_y_again:
			y = 3
			#set_2_cells:
			tiles.set_cell(x, y, left_no_top)
			#change_y_again2:
			y = 2
			#set_2_cells:
			tiles.set_cell(x, y, left)
			#change_x:
			x += 1
			#change_were_am_i:
			were_am_i = 1
			#again:
			$again.start()
			
		elif were_am_i == 1:
			#change_y:
			y = 4
			#set_2_cells:
			tiles.set_cell(x, y, empty)
			#change_y_again:
			y = 3
			#set_2_cells:
			tiles.set_cell(x, y, empty)
			#change_y_again2:
			y = 2
			#set_2_cells:
			tiles.set_cell(x, y, mid)
			#change_x:
			x += 1
			#change_were_am_i:
			if spawnd == how_many:
				were_am_i = 2
			spawnd = spawnd + 1
			#again:
			$again.start()
			
		elif were_am_i == 2:
			#change_y:
			y = 4
			#set_2_cells:
			tiles.set_cell(x, y, right_no_top)
			#change_y_again:
			y = 3
			#set_2_cells:
			tiles.set_cell(x, y, right_no_top)
			#change_y_again2:
			y = 2
			#set_2_cells:
			tiles.set_cell(x, y, right)
			#change_x:
			x += 2
			#change_were_am_i:
			spawnd = 0
			were_am_i = 0
			value(3)
	
	
	#level_4:
	if level == 4:
		#were_am_i:
		if were_am_i == 0:
			#change_y:
			y = 4
			#set_2_cells:
			tiles.set_cell(x, y, left_no_top)
			#change_y_again:
			y = 3
			#set_2_cells:
			tiles.set_cell(x, y, left_no_top)
			#change_y_again2:
			y = 2
			#set_2_cells:
			tiles.set_cell(x, y, left_no_top)
			#change_y_again3:
			y = 1
			#set_2_cells:
			tiles.set_cell(x, y, left)
			#change_x:
			x += 1
			#change_were_am_i:
			were_am_i = 1
			#again:
			$again.start()
			
		elif were_am_i == 1:
			#change_y:
			y = 4
			#set_2_cells:
			tiles.set_cell(x, y, empty)
			#change_y_again:
			y = 3
			#set_2_cells:
			tiles.set_cell(x, y, empty)
			#change_y_again2:
			y = 2
			#set_2_cells:
			tiles.set_cell(x, y, empty)
			#change_y_again3:
			y = 1
			#set_2_cells:
			tiles.set_cell(x, y, mid)
			#change_x:
			x += 1
			#change_were_am_i:
			if spawnd == how_many:
				were_am_i = 2
			spawnd = spawnd + 1
			#again:
			$again.start()
			
		elif were_am_i == 2:
			#change_y:
			y = 4
			#set_2_cells:
			tiles.set_cell(x, y, right_no_top)
			#change_y_again:
			y = 3
			#set_2_cells:
			tiles.set_cell(x, y, right_no_top)
			#change_y_again2:
			y = 2
			#set_2_cells:
			tiles.set_cell(x, y, right_no_top)
			#change_y_again3:
			y = 1
			#set_2_cells:
			tiles.set_cell(x, y, right)
			#change_x:
			x += 2
			#change_were_am_i:
			spawnd = 0
			were_am_i = 0
			value(4)


func _on_again_timeout():
	spawn()






