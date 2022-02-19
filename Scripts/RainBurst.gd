extends AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.volumeOn == true:
		$AudioStreamPlayer.play()
	play("Explosion") # Replace with function body.

func _on_AnimatedSprite_animation_finished():
	queue_free()
