extends TouchScreenButton

func _on_SoundButton_pressed():
	if Global.volumeOn == false:
		$SelectSound.play()
	position.y = position.y + 8


func _on_SoundButton_released():
	Global.volumeOn = true
	Global.saveVolumeState()
	Global.emitVolChange()
	position.y = position.y - 8

