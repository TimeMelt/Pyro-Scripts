extends AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if bool(Global.volumeOn) == true:
		$AudioStreamPlayer.play()
	play("Explosion") 

func _on_AnimatedSprite_animation_finished():
	queue_free()
