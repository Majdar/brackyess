extends Control


#vars_save:
var file : ConfigFile = ConfigFile.new()
var save_path : String = 'res://game_files.json'



#func_ready():
func _ready():
	
# warning-ignore:return_value_discarded
	file.load(save_path)
	global.coins_you_have = file.get_value('all', 'coins', 0)
	global.high_score = file.get_value('all', 'score', 0)
	global.e_texture = file.get_value('all', 'equ', "res://assets/charcter sprites/normal.png")


#funcs:
func save():
	
	if global.high_score < global.score:
		global.high_score = global.score
	
	global.coins_you_have += global.coins
	
	file.set_value('all', 'coins', global.coins_you_have)
	file.set_value('all', 'score', global.high_score)
	file.set_value('all', 'equ', global.e_texture)
# warning-ignore:return_value_discarded
	file.save(save_path)
