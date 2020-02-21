extends Control


#vars_save:
var file : ConfigFile = ConfigFile.new()
var save_path : String = 'res://game_files.json'

onready var shop : Control = get_parent().get_node("CanvasLayer/shop")
onready var e : Control = get_parent().get_node("CanvasLayer/E")


#func_ready():
func _ready():
	
# warning-ignore:return_value_discarded
	file.load(save_path)
	global.coins_you_have = file.get_value('all', 'coins', 0)
	
	global.equ = file.get_value('all', 'equ', get_parent().get_node("CanvasLayer/shop/normal"))
	
	global.e_texture = file.get_value('all', 'equ', global.e_texture)
	
	#customs:
	shop.astro = file.get_value('all', 'astro', shop.astro)
	shop.cool = file.get_value('all', 'cool', shop.cool)
	shop.knight = file.get_value('all', 'knight', shop.knight)
	shop.pirate = file.get_value('all', 'pirate', shop.pirate)
	shop.surgeon = file.get_value('all', 'surg', shop.surgeon)
	shop.ninja = file.get_value('all', 'ninja', shop.ninja)
	
	e.texture = global.e_texture


#funcs:
func save():
	
	file.set_value('all', 'coins', global.coins_you_have)
	
	file.set_value('all', 'equ', global.e_texture)
	
	#customs:
	file.set_value('all', 'astro', shop.astro)
	file.set_value('all', 'knight', shop.knight)
	file.set_value('all', 'cool', shop.cool)
	file.set_value('all', 'surg', shop.surgeon)
	file.set_value('all', 'ninja', shop.ninja)
	file.set_value('all', 'pirate', shop.pirate)
	
# warning-ignore:return_value_discarded
	file.save(save_path)
