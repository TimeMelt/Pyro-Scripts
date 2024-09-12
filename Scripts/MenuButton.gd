extends TouchScreenButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_MenuButton_pressed():
	if bool(Global.volumeOn) == true:
		$PageChange.play()
	position.y = position.y + 8
	
func _on_MenuButton_released():
	Transit.get_node("GameOverSad").stop()
	Global.goToInfo()
