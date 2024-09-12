extends RichTextLabel


func _ready():
	var score = Global.finalScore
	text = "Score: %s" % score
