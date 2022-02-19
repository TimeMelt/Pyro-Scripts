extends Area2D

export var speed = -500

func _physics_process(delta):
	var velocity = Vector2 (0, speed).rotated (global_rotation)
	global_position +=  velocity * delta

func _ready():
	if Global.volumeOn == true:
		$AudioStreamPlayer.play()

# handle bullet collisons
func _on_bullet_area_entered(area):
	if area.is_in_group('ControlledSprite'):
		pass
	else:
		queue_free()# Replace with function body.
