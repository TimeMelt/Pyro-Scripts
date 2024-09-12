extends Area2D

const ScoreConst = preload('res://Scripts/ScoreLabel.gd')
const RainBurst = preload('res://Animations/RainBurst.tscn')

@onready var ScoreLabel = ScoreConst.new()
var velocity = Vector2()

func _physics_process(delta):
	velocity.y += gravity * delta
	position.y += velocity.y * delta

func _ready():
	if Global.hardcoreModeOn == true:
		gravity = 500
	else:
		gravity = 100

# handle raindrop collisions
func _on_RainDrop_area_entered(area):
	if area.is_in_group('rain'):
		pass #ignore collision with other raindrops
	elif area.is_in_group('bullets'):
		var rBurst = RainBurst.instantiate()
		rBurst.set_position(self.get_position())
		get_parent().add_child(rBurst)
		queue_free()
		Global.addToCurrScore()
	elif area.is_in_group('ControlledSprite'):
		if bool(Global.volumeOn) == true:
			Transit.get_node("GameOverSad").play()
		Global.defHighScore()
		if Global.hardcoreModeOn == true:
			Global.saveHardcore()
		else:
			Global.save()
		Global.goToGameOver()	
