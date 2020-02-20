extends Control

#preloads:
var fall : PackedScene = preload("res://scenes/dead.tscn")
var throw : PackedScene = preload("res://scenes/throw.tscn")
var coin : PackedScene = preload("res://scenes/coin.tscn")

#nodes:
onready var tiles : TileMap = get_parent().get_node("tiles")
onready var world : Node = get_parent()
onready var dead : Area2D = get_parent().get_node("dead")

#spawn_normal:
var level : int = 1
var x : int = 9
var y : int = 4
export var spawn_time : float = 0.4

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

#holes_values:
var hole_x : int = 1080
var hole_y : int = 92

#spawn_info:
var were_am_i : int = 0
var how_many : int = 3
var obst : int = 1
var spawnd : int = 0
var dif : int = 0

#game_over:
export var stop : bool = false

#spawn_fall:
var ex : int = 100

#coin_spawn:
var drop_coin : bool = false
var coin_x : int = 1208
var coin_y : int = 450

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
	
	randomize()
	
	#chose_to_drop_coins_or_not:
	var e = randi() % 4 + 1
	
	match e:
		1:
			drop_coin = false
	
		2:
			drop_coin = true
	
		3:
			drop_coin = false
	
		4:
			drop_coin = true
	
	
	#chose_a_hole_tybe:
	var r = randi() % 3 + 1
	
	match r:
		1:
			hole = 7
		
		2:
			hole = 9
		
		3:
			hole = 10
	
	
	#diculty:
	if dif == 0:
		
		#spawn_speed:
		spawn_time = 0.3
		
		#camera_speed:
		world.camera_speed = 300
		dead.speed = 298
		
		#how_many_tiles:
		how_many = 4
		
		#how_many_obstcals:
		obst = 1
	
	elif dif == 1:
		
		#camera_speed:
		world.camera_speed = 400
		dead.speed = 398
		
		#how_many_tiles:
		how_many = 3
		
		#how_many_obstcals:
		obst = 1
	
	
	elif dif == 2:
		
		#spawn_speed:
		spawn_time = 0.2
		
		#camera_speed:
		world.camera_speed = 450
		dead.speed = 448
		
		#how_many_tiles:
		how_many = 2
		
		#how_many_obstcals:
		obst = 2
	
	elif dif == 3:
		
		#spawn_speed:
		spawn_time = 0.1
		
		#camera_speed:
		world.camera_speed = 500
		dead.speed = 498
		
		#how_many_tiles:
		how_many = 1
		
		#how_many_obstcals:
		obst = 1
	
	elif dif == 4:
		
		#spawn_speed:
		spawn_time = 0.05
		
		#camera_speed:
		world.camera_speed = 550
		dead.speed = 548
		
		#how_many_tiles:
		how_many = 1
		
		#how_many_obstcals:
		obst = 3
	
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
			hole_y = 552
			#set_cell:
			tiles.set_cell(x, y, left)
			#change_x:
			x += 1
			hole_x += 128
			coin_x += 128
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
							hole_y = 553
							coin_y = 450
							#set_cell:
							tiles.set_cell(x, y, mid)
							
							#set_coin:
							if drop_coin == true:
								var coin_b = coin.instance()
								get_parent().add_child(coin_b)
								coin_b.global_position = Vector2(coin_x, coin_y)
							
							#change_x:
							x += 1
							hole_x += 128
							coin_x += 128
						
						2:
						#obstical
							obst -= 1
							y = 4
							hole_y = 533
							#set_cell:
							tiles.set_cell(x, y, hole)
							#change_x:
							x += 1
							hole_x += 128
							coin_x += 128
							#hole_type:
							
							#instince_thrower:
							var throw_p = throw.instance()
							get_parent().add_child(throw_p)
							throw_p.global_position = Vector2(hole_x, hole_y)
							
							#fire:
							if hole == 7:
								throw_p.hole_tybe = 1
							
							#snow:
							elif hole == 9:
								throw_p.hole_tybe = 2
							
							#posion:
							elif hole == 10:
								throw_p.hole_tybe = 3
							
						
						3:
						#change_y:
							y = 4
							hole_y = 553
							coin_y = 450
							#set_cell:
							tiles.set_cell(x, y, mid)
							
							#set_coin:
							if drop_coin == true:
								var coin_b = coin.instance()
								get_parent().add_child(coin_b)
								coin_b.global_position = Vector2(coin_x, coin_y)
							
							#change_x:
							x += 1
							hole_x += 128
							coin_x += 128

				
				else:
					#change_y:
							y = 4
							hole_y = 553
							coin_y = 450
							#set_cell:
							tiles.set_cell(x, y, mid)
							
							#set_coin:
							if drop_coin == true:
								var coin_b = coin.instance()
								get_parent().add_child(coin_b)
								coin_b.global_position = Vector2(coin_x, coin_y)
							
							#change_x:
							x += 1
							hole_x += 128
							coin_x += 128
	
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
			hole_y = 92
			#set_cell:
			tiles.set_cell(x, y, right)
			#change_x:
			x += 2
			hole_x += 256
			coin_x += 256
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
			hole_y = 400
			coin_y = 330
			#set_2_cells:
			tiles.set_cell(x, y, left_no_top)
			#change_y_again:
			y = 3
			#set_2_cells:
			tiles.set_cell(x, y, left)
			#change_x:
			x += 1
			hole_x += 128
			coin_x += 128
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
							hole_y = 400
							coin_y = 330
							#set_2_cells:
							tiles.set_cell(x, y, empty)
							#change_y_again:
							y = 3
							#set_2_cells:
							tiles.set_cell(x, y, mid)
							
							#set_coin:
							if drop_coin == true:
								var coin_b = coin.instance()
								get_parent().add_child(coin_b)
								coin_b.global_position = Vector2(coin_x, coin_y)
								
							#change_x:
							x += 1
							hole_x += 128
							coin_x += 128
						
						2:
							obst -= 1
							#obstcal:
							y = 4
							hole_y = 406
							#set_2_cells:
							tiles.set_cell(x, y, fell)
							#change_y_again:
							y = 3
							#set_2_cells:
							tiles.set_cell(x, y, hole)
							#change_x:
							x += 1
							hole_x += 128
							coin_x += 128
							#hole_type:
							
							#instince_thrower:
							var throw_p = throw.instance()
							get_parent().add_child(throw_p)
							throw_p.global_position = Vector2(hole_x, hole_y)
							
							#fire:
							if hole == 7:
								throw_p.hole_tybe = 1
							
							#snow:
							elif hole == 9:
								throw_p.hole_tybe = 2
							
							#posion:
							elif hole == 10:
								throw_p.hole_tybe = 3
							
						
						3:
							#change_y:
							y = 4
							hole_y = 400
							coin_y = 330
							#set_2_cells:
							tiles.set_cell(x, y, empty)
							#change_y_again:
							y = 3
							#set_2_cells:
							tiles.set_cell(x, y, mid)
							
							#set_coin:
							if drop_coin == true:
								var coin_b = coin.instance()
								get_parent().add_child(coin_b)
								coin_b.global_position = Vector2(coin_x, coin_y)
							#change_x:
							x += 1
							hole_x += 128
							coin_x += 128

				else:
					y = 4
					hole_y = 400
					coin_y = 330
					#set_2_cells:
					tiles.set_cell(x, y, empty)
					#change_y_again:
					y = 3
						#set_2_cells:
					tiles.set_cell(x, y, mid)
					
					#set_coin:
					if drop_coin == true:
						var coin_b = coin.instance()
						get_parent().add_child(coin_b)
						coin_b.global_position = Vector2(coin_x, coin_y)
					#change_x:
					x += 1
					hole_x += 128
					coin_x += 128

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
			hole_y = 400
			#set_2_cells:
			tiles.set_cell(x, y, right_no_top)
			#change_y_again:
			y = 3
			#set_2_cells:
			tiles.set_cell(x, y, right)
			#change_x:
			x += 2
			hole_x += 256
			coin_x += 256
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
			hole_y = 280
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
			hole_x += 128
			coin_x += 128
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
							hole_y = 280
							coin_y = 210
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
							
							#set_coin:
							if drop_coin == true:
								var coin_b = coin.instance()
								get_parent().add_child(coin_b)
								coin_b.global_position = Vector2(coin_x, coin_y)
							#change_x:
							x += 1
							hole_x += 128
							coin_x += 128
						
						2:
							obst -= 1
							#change_y:
							y = 4
							hole_y = 278
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
							hole_x += 128
							coin_x += 128
							
							#hole_type:
							
							#instince_thrower:
							var throw_p = throw.instance()
							get_parent().add_child(throw_p)
							throw_p.global_position = Vector2(hole_x, hole_y)
							
							#fire:
							if hole == 7:
								throw_p.hole_tybe = 1
							
							#snow:
							elif hole == 9:
								throw_p.hole_tybe = 2
							
							#posion:
							elif hole == 10:
								throw_p.hole_tybe = 3
						
						
						3:
							#change_y:
							y = 4
							hole_y = 280
							coin_y = 210
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
							
							#set_coin:
							if drop_coin == true:
								var coin_b = coin.instance()
								get_parent().add_child(coin_b)
								coin_b.global_position = Vector2(coin_x, coin_y)
							#change_x:
							x += 1
							hole_x += 128
							coin_x += 128

				else:
					#change_y:
					y = 4
					hole_y = 280
					coin_y = 210
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
					
					#set_coin:
					if drop_coin == true:
						var coin_b = coin.instance()
						get_parent().add_child(coin_b)
						coin_b.global_position = Vector2(coin_x, coin_y)
					#change_x:
					x += 1
					hole_x += 128
					coin_x += 128


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
			hole_y = 280
			coin_y = 210
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
			hole_x += 256
			coin_x += 256
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
			hole_y = 200
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
			hole_x += 128
			coin_x += 128
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
							hole_y = 200
							coin_y = 80
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
							
							#set_coin:
							if drop_coin == true:
								var coin_b = coin.instance()
								get_parent().add_child(coin_b)
								coin_b.global_position = Vector2(coin_x, coin_y)
							#change_x:
							x += 1
							hole_x += 128
							coin_x += 128
						
						2:
							obst -= 1
							#change_y:
							y = 4
							hole_y = 147
							coin_y = 80
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
							hole_x += 128
							coin_x += 128
							
							#hole_type:
							
							#instince_thrower:
							var throw_p = throw.instance()
							get_parent().add_child(throw_p)
							throw_p.global_position = Vector2(hole_x, hole_y)
							
							#fire:
							if hole == 7:
								throw_p.hole_tybe = 1
							
							#snow:
							elif hole == 9:
								throw_p.hole_tybe = 2
							
							#posion:
							elif hole == 10:
								throw_p.hole_tybe = 3
						
						3:
							#change_y:
							y = 4
							hole_y = 200
							coin_y = 80
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
							
							#set_coin:
							if drop_coin == true:
								var coin_b = coin.instance()
								get_parent().add_child(coin_b)
								coin_b.global_position = Vector2(coin_x, coin_y)
							#change_x:
							x += 1
							hole_x += 128
							coin_x += 128

				else:
					#change_y:
					y = 4
					hole_y = 200
					coin_y = 80
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
						
					#set_coin:
					if drop_coin == true:
						var coin_b = coin.instance()
						get_parent().add_child(coin_b)
						coin_b.global_position = Vector2(coin_x, coin_y)
					#change_x:
					x += 1
					hole_x += 128
					coin_x += 128

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
			hole_y = 200
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
			hole_x += 256
			coin_x += 256
			#change_were_am_i:
			spawnd = 0
			were_am_i = 0
			obst = 0
			value(4)


func _on_again_timeout():
	spawn()


#difeculty:
func _on_dif_timeout():
	if dif >= 4:
		$dif.stop()
		return
	
	dif += 1
	pass
