extends Control

#preloads:
var fall : PackedScene = preload("res://scenes/dead.tscn")

#nodes:
onready var tiles : TileMap = get_parent().get_node("tiles")
onready var world : Node = get_parent()

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

#holes:
var hole : int = 7
var fell : int = 8

#spawn_info:
var were_am_i : int = 0
var how_many : int = 3
var obst : int = 1
var spawnd : int = 0
var dif : int = 0

#game_over:
var stop : bool = false

#spawn_fall:
var ex : int = 100

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
	
	#game_over:
	if stop == true:
		return
	
	#diculty:
	if dif == 0:
		
		#spawn_speed:
		spawn_time = 0.3
		
		#camera_speed:
		world.camera_speed = 350
		
		#how_many_tiles:
		how_many = 4
		
		#how_many_obstcals:
		obst = 1
	
	elif dif == 1:
		
		#camera_speed:
		world.camera_speed = 400
		
		#how_many_tiles:
		how_many = 3
		
		#how_many_obstcals:
		obst = 1
	
	
	elif dif == 2:
		
		#spawn_speed:
		spawn_time = 0.2
		
		#camera_speed:
		world.camera_speed = 450
		
		#how_many_tiles:
		how_many = 2
		
		#how_many_obstcals:
		obst = 1
	
	elif dif == 3:
		
		#spawn_speed:
		spawn_time = 0.1
		
		#camera_speed:
		world.camera_speed = 500
		
		#how_many_tiles:
		how_many = 1
		
		#how_many_obstcals:
		obst = 1
	
	elif dif == 4:
		
		#spawn_speed:
		spawn_time = 0.05
		
		#camera_speed:
		world.camera_speed = 550
		
		#how_many_tiles:
		how_many = 0
		
		#how_many_obstcals:
		obst = 1
	
	randomize()
	
	if used == 1:
		var d = randi() % 3 + 1
		
		match d :
			
			1:
				level = 2
			
			2:
				level = 1
			
			3:
				level = 2
		
		spawn()
	
	
	elif used == 2:
		
		var d = randi() % 5 + 1
		
		match d :
			
			1:
				level = 3
			
			2:
				level = 1
			
			3:
				level = 2
			
			4:
				level = 1
			
			5:
				level = 3
		
		spawn()
	
	
	elif used == 3:
		
		var d = randi() % 5 + 1
		
		match d :
			
			1:
				level = 2
			
			2:
				level = 4
			
			3:
				level = 3
			
			4:
				level = 2
			
			5:
				level = 2
		
		spawn()
	
	
	elif used == 4:
		
		var d = randi() % 3 + 1
		
		match d :
			
			1:
				level = 3
			
			2:
				level = 4
			
			3:
				level = 3
		
		spawn()


#spawn:
func spawn():
	
	#game_over:
	if stop == true:
		return
	
	#spawn_death_fall:
	var fall_p = fall.instance()
	call_deferred('add_child', fall_p)
	fall_p.global_position = Vector2(ex, 640)
	ex += 184 * 2
	
	
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
			if how_many != 0:
				if obst > 0 :
					var d = randi() % 3 + 1
					match d:
						1:
						#change_y:
							y = 4
							#set_cell:
							tiles.set_cell(x, y, mid)
							#change_x:
							x += 1
						
						2:
						#obstical
							obst -= 1
							y = 4
							#set_cell:
							tiles.set_cell(x, y, hole)
							#change_x:
							x += 1
						
						3:
						#change_y:
							y = 4
							#set_cell:
							tiles.set_cell(x, y, mid)
							#change_x:
							x += 1

				
				else:
					#change_y:
						y = 4
						#set_cell:
						tiles.set_cell(x, y, mid)
						#change_x:
						x += 1
	
			#change_were_am_i:
			if spawnd == how_many:
				were_am_i = 2
			elif how_many == 0:
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
			obst = 0
			value(1)
			
		elif were_am_i == 3:
			pass
	
	
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
			if how_many != 0:
				if obst > 0:
					var d = randi() % 3 + 1
					match d:
					
						1:
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
						
						2:
							obst -= 1
							#obstcal:
							y = 4
							#set_2_cells:
							tiles.set_cell(x, y, fell)
							#change_y_again:
							y = 3
							#set_2_cells:
							tiles.set_cell(x, y, hole)
							#change_x:
							x += 1
						
						3:
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

				else:
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
			elif how_many == 0:
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
			obst = 0
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
			if how_many != 0:
				
				if obst > 0:
					var d = randi() % 3 + 1
					match d:
					
						1:
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
						
						2:
							obst -= 1
							#change_y:
							y = 4
							#set_2_cells:
							tiles.set_cell(x, y, fell)
							#change_y_again:
							y = 3
							#set_2_cells:
							tiles.set_cell(x, y, fell)
							#change_y_again2:
							y = 2
							#set_2_cells:
							tiles.set_cell(x, y, hole)
							#change_x:
							x += 1
						
						3:
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

				else:
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
			elif how_many == 0:
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
			obst = 0
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
			if how_many != 0:

				
				if obst > 0:
					var d = randi() % 3 + 1
					match d:
					
						1:
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
						
						2:
							obst -= 1
							#change_y:
							y = 4
							#set_2_cells:
							tiles.set_cell(x, y, fell)
							#change_y_again:
							y = 3
							#set_2_cells:
							tiles.set_cell(x, y, fell)
							#change_y_again2:
							y = 2
							#set_2_cells:
							tiles.set_cell(x, y, fell)
							#change_y_again3:
							y = 1
							#set_2_cells:
							tiles.set_cell(x, y, hole)
							#change_x:
							x += 1
						
						3:
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

				else:
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
			elif how_many == 0:
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
			obst = 0
			value(4)


func _on_again_timeout():
	spawn()


#difeculty:
func _on_dif_timeout():
	if dif >= 3:
		$dif.stop()
		return
	
	dif += 1
