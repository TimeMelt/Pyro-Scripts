extends RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	conn()
	var score = Global.currentScore
	text = "Score: %s" % score

# update visible score on in game scoreboard
func updateScore():
	var score = Global.currentScore
	text = "Score: %s" % score

# connect signal to increase score
func conn():
	return Global.connect('scoreAdded', Callable(self, 'updateScore'))

