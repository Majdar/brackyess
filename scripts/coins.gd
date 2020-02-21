extends Label

func _ready():
	
	global.coins = 0

# warning-ignore:unused_argument
func _process(delta):
	text =  str(global.coins)
