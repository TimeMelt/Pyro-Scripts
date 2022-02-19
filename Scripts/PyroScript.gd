extends KinematicBody2D

export (int) var speed = 600 

var velocity = Vector2()
const Bullet = preload("res://Entities/bullet.tscn")

var screen_size

var fire_rate : float = 4 #Fire rate 
onready var update_delta : float = 1 / fire_rate # update firerate based on delta
var current_time : float = 0

# grab keyboard/controller input
func get_input(delta):
	velocity = Vector2()
	current_time += delta
	if Input.is_action_pressed("right"):
		velocity.x += 1
		if (current_time < update_delta):
			pass
		else:
			shoot()
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		if (current_time < update_delta):
			pass
		else:
			shoot()
	velocity = velocity.normalized() * speed

func _input(event):
	if event is InputEventScreenDrag:
		position.x = event.position.x
		if (current_time < update_delta):
			pass
		else:
			shoot()

func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	get_input(delta)
	velocity = move_and_slide(velocity)

# keep player within screen bounds
func _process(_delta):
	position.x = clamp(position.x, 0, screen_size.x)

# shoor bullet 
func shoot():
	current_time = 0
	var bullet = Bullet.instance()
	bullet.global_position = global_position
	bullet.set_as_toplevel(true)
	add_child(bullet)

# handle Pyro collisions
func _on_Area2D_area_entered(area):
	if area.is_in_group('bullets'):
		pass # Replace with function body.
	if area.is_in_group('rain'):
		pass

