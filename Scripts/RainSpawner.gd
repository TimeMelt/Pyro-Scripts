extends Node2D

onready var _timer = Timer.new() # create new timer
onready var rng = RandomNumberGenerator.new() # create new random number generator
const scene = preload('res://Entities/RainDrop.tscn') 

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(_timer)
	_timer.connect("timeout", self, "_spawnIt") # connect timer signal
	_spawnIt()

# spawn raindrop instance
func _spawnIt():
	var rain = scene.instance()
	add_child(rain)
	_spawnRand()
	
func _spawnRand():
	rng.randomize()
	var random_number = 0.0
	if Global.hardcoreModeOn == true:
		random_number = rng.randf_range(0.5, 2.0)
	else:
		random_number = rng.randf_range(0.5, 3.0)
	_timer.set_wait_time(random_number) # set timer wait time
	_timer.set_one_shot(false) # Make sure timer loops
	_timer.start() # start timer
