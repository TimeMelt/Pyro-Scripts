extends Node2D

var volumeOn = loadVolumeState()
var hardcoreModeOn = false
var currentScore = 0
var finalScore = 0
onready var highScore = loadScore()
onready var highScoreHardcore = loadHardcoreScore()

signal scoreAdded
signal volumeStateChanged

# add 1 to in game score
func addToCurrScore():
	currentScore += 1
	emit_signal('scoreAdded')

# emit signal for volume change
func emitVolChange():
	emit_signal('volumeStateChanged')

# determine/change highscore
func defHighScore():
	finalScore = currentScore
	if hardcoreModeOn == true:
		if finalScore > highScoreHardcore:
			highScoreHardcore = finalScore	
	else:
		if finalScore > highScore:
			highScore = finalScore
	return

# save highscore to storage
func save():
	var file = File.new()
	file.open("user://highscore.dat", File.WRITE)
	file.store_16(highScore)
	file.close()

# save hardcore highscore
func saveHardcore():
	var file = File.new()
	file.open("user://highscoreHardcore.dat", File.WRITE)
	file.store_16(highScoreHardcore)
	file.close()

# save sound effect volume settings
func saveVolumeState():
	var file = File.new()
	file.open("user://volumeState.dat", File.WRITE)
	file.store_16(int(volumeOn))
	file.close()

# load score from storage
func loadScore():
	var file = File.new()
	if file.file_exists("user://highscore.dat"):
		file.open("user://highscore.dat", File.READ)
		var content = file.get_16()
		file.close()
		return content
	else:
		return 0

# load hardcore highscore from storage
func loadHardcoreScore():
	var file = File.new()
	if file.file_exists("user://highscoreHardcore.dat"):
		file.open("user://highscoreHardcore.dat", File.READ)
		var content = file.get_16()
		file.close()
		return content
	else:
		return 0

# load volume state of sound effects
func loadVolumeState():
	var file = File.new()
	if file.file_exists("user://volumeState.dat"):
		file.open("user://volumeState.dat", File.READ)
		var content = file.get_16()
		var finalContent = bool(content)
		file.close()
		return finalContent
	else:
		return true

# enter gameplay scene
func goToGame():
	currentScore = 0
	hardcoreModeOn = false
	return Transit.change_scene("res://Scenes/GameScene.tscn") 

# enter gameplay scene
func goToHardcoreGame():
	currentScore = 0
	hardcoreModeOn = true
	return Transit.change_scene("res://Scenes/GameScene.tscn") 

# go to info page
func goToInfo():
	return Transit.change_scene("res://Scenes/InfoPage.tscn") 

# go to game over page
func goToGameOver():
	if hardcoreModeOn == true:
		return Transit.change_scene("res://Scenes/HardcoreGameOverScreen.tscn")
	else:
		return Transit.change_scene("res://Scenes/GameOverScreen.tscn")

# go to main page
func goToHome():
	return Transit.change_scene("res://Scenes/LandingPage.tscn")
