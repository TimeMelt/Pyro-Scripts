extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	conn()
	checkVolumeState()


func checkVolumeState():
	if bool(Global.volumeOn) == true:
		$Indicator2.visible = true
		$Indicator.visible = false
	else:
		$Indicator2.visible = false
		$Indicator.visible = true

func conn():
	return Global.connect('volumeStateChanged', Callable(self, 'checkVolumeState'))
