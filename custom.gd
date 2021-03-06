extends Button

#nodes:
var shop : Control = get_parent()
var nam : String

#values:
var select : bool = false

export var price : int
export var texture: Texture

func _ready():
	
	texture = $Sprite.texture
	nam = self.name

# warning-ignore:unused_argument
func _process(delta):
	
	if get_parent().normal == false:
		
		modulate = Color(1, 1, 1, 0.5)
	
	elif get_parent().normal == true:
		
		modulate = Color(1, 1, 1, 1)

func _on_normal_pressed():
	
	if get_parent().normal == false:
		get_parent().equ = $pos
		get_parent().nam = nam
		get_parent().slec($pos, price, texture)
	
	else:
		get_parent().equ = $pos
		get_parent().nam = nam
		get_parent().select($pos, texture)
