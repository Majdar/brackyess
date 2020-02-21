extends Control


onready var c = get_parent().get_node("c")
onready var pe = get_parent().get_node("p")
onready var e : Control = get_parent().get_parent().get_node("CanvasLayer/E")

#values:
var selected
var equ
var nam : String

#you_have:
var normal : bool = true
var astro : bool = false
var cool : bool = false
var knight : bool = false
var ninja : bool = false
var pirate : bool = false
var surgeon : bool = false

#customs:
var price : int
var texture : Texture

func _ready():
	
	
	equ = global.equ



func slec(me, p, t):
	
	selected = me
	price = p
	texture = t
	
	$select.global_position = selected.global_position

func equp(me):
	
	equ = me
	
	global.equ = equ
	
	global.e_texture = texture
	
	get_parent().get_parent().get_node("save_system").save()
	
	$e.global_position = equ.global_position

func select(me, t):
	
	selected = me
	
	texture = t
	
	$select.global_position = selected.global_position

func bot():
	
	if nam == 'normal':
		normal = true
	
	elif nam == 'astro':
		astro = true
	
	if nam == 'knight':
		knight = true
	
	if nam == 'cool':
		cool = true
	
	if nam == 'surg':
		surgeon = true
	
	if nam == 'pirate':
		pirate = true
	
	if nam == 'ninja':
		ninja = true

func _on_buy_pressed():
	
	$click.play()
	
	if nam == 'normal':
		if normal == false:
			if selected != null:
				if global.coins_you_have > price:
					
					normal = true
					
					global.coins_you_have -= price
					
					bot()
					
					equp(selected)
	
	elif nam == 'astro':
		if astro == false:
			if selected != null:
				if global.coins_you_have > price:
					
					astro = true
					
					global.coins_you_have -= price
					
					bot()
					
					equp(selected)
	
	elif nam == 'knight':
		if knight == false:
			if selected != null:
				if global.coins_you_have > price:
					
					knight = true
					
					global.coins_you_have -= price
					
					bot()
					
					equp(selected)

	elif nam == 'pirate':
		if pirate == false:
			if selected != null:
				if global.coins_you_have > price:
					
					pirate = true
					
					global.coins_you_have -= price
					
					bot()
					
					equp(selected)

	elif nam == 'ninja':
		if ninja == false:
			if selected != null:
				if global.coins_you_have > price:
					
					ninja = true
					
					global.coins_you_have -= price
					
					bot()
					
					equp(selected)

	elif nam == 'cool':
		if cool == false:
			if selected != null:
				if global.coins_you_have > price:
					
					cool = true
					
					global.coins_you_have -= price
					
					bot()
					
					equp(selected)

	elif nam == 'surg':
		if surgeon == false:
			if selected != null:
				if global.coins_you_have > price:
					
					surgeon = true
					
					global.coins_you_have -= price
					
					bot()
					
					equp(selected)

	else:
		print('you_have')


func _on_eq_pressed():
	
	$click.play()
	
	if equ != null:
	
		if nam == 'normal':
			if normal != false:
				equp(equ)
		
		elif nam == 'astro':
			if astro != false:
				equp(equ)
		
		elif nam == 'knight':
			if knight != false:
				equp(equ)
	
		elif nam == 'pirate':
			if pirate != false:
				equp(equ)
	
		elif nam == 'ninja':
			if ninja != false:
				equp(equ)
	
		elif nam == 'cool':
			if cool != false:
				equp(equ)
	
		elif nam == 'surg':
			if surgeon != false:
				equp(equ)

# warning-ignore:unused_argument
func _process(delta):
	c.text = str(global.coins_you_have)
	pe.text = str(price)
	e.texture = global.e_texture
