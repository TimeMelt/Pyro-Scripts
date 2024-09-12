extends RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	var score = Global.highScoreHardcore
	text = "Best Hardcore Score: %s" % score
