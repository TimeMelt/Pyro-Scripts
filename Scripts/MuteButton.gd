extends TouchScreenButton

func _on_SoundButton_pressed():
	if bool(Global.volumeOn) == true:
		$SelectSound.play()
	position.y = position.y + 8


func _on_SoundButton_released():
	Global.volumeOn = false
	Global.saveVolumeState()
	Global.emitVolChange()
	position.y = position.y - 8
