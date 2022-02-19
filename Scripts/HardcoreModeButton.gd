extends TouchScreenButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_HardcoreModeButton_pressed():
	if Global.volumeOn == true:
		$PageChange.play()
	position.y = position.y + 8

func _on_HardcoreModeButton_released():
	Transit.get_node("GameOverSad").stop()
	Global.goToHardcoreGame()
