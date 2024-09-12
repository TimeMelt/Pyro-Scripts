extends Node2D

var hardcoreModeOn = false
var currentScore = 0
var finalScore = 0
var config_path = "user://config.cfg"

signal scoreAdded
signal volumeStateChanged

@onready var dconf = setDefaultConfig()
@onready var highScore = loadScore()
@onready var highScoreHardcore = loadHardcoreScore()
@onready var volumeOn = loadVolumeState()

func setDefaultConfig():
	var config = ConfigFile.new()
	var config_values = config.load(config_path)
	if config_values != OK:
		config.set_value("volume", "state", true)
		config.set_value("local_player", "highscore", 0)
		config.set_value("local_player", "hardcore_highscore", 0)
		config.save(config_path)
	else:
		if config.has_section_key("local_player", "highscore"):
			pass
		else:
			config.set_value("local_player", "highscore", 0)
			config.save(config_path)
		if config.has_section_key("local_player", "hardcore_highscore"):
			pass
		else:
			config.set_value("local_player", "hardcore_highscore", 0)
			config.save(config_path)
		if config.has_section_key("volume", "state"):
			pass
		else:
			config.set_value("volume", "state", true)
			config.save(config_path)
	return 0

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
	var config = ConfigFile.new()
	config.set_value("local_player", "highscore", highScore)
	config.save(config_path)

# save hardcore highscore
func saveHardcore():
	var config = ConfigFile.new()
	config.set_value("local_player", "hardcore_highscore", highScoreHardcore)
	config.save(config_path)

# save sound effect volume settings
func saveVolumeState():
	var config = ConfigFile.new()
	config.set_value("volume", "state", int(volumeOn))
	config.save(config_path)

# load score from storage
func loadScore():
	var config = ConfigFile.new()
	var highscores = config.load(config_path)
	if highscores != OK:
		return 0
	else:
		return config.get_value("local_player", "highscore")

# load hardcore highscore from storage
func loadHardcoreScore():
	var config = ConfigFile.new()
	var highscores = config.load(config_path)
	if highscores != OK:
		return 0
	else:
		return config.get_value("local_player", "hardcore_highscore")

# load volume state of sound effects
func loadVolumeState():
	var config = ConfigFile.new()
	var volumestate = config.load(config_path)
	if volumestate != OK:
		return true
	else:
		return config.get_value("volume", "state")

# enter gameplay scene
func goToGame():
	currentScore = 0
	hardcoreModeOn = false
	return await Transit.change_scene_to_file("res://Scenes/GameScene.tscn") 

# enter gameplay scene
func goToHardcoreGame():
	currentScore = 0
	hardcoreModeOn = true
	return await Transit.change_scene_to_file("res://Scenes/GameScene.tscn") 

# go to info page
func goToInfo():
	return await Transit.change_scene_to_file("res://Scenes/InfoPage.tscn") 

# go to game over page
func goToGameOver():
	if hardcoreModeOn == true:
		return await Transit.change_scene_to_file("res://Scenes/HardcoreGameOverScreen.tscn")
	else:
		return await Transit.change_scene_to_file("res://Scenes/GameOverScreen.tscn")

# go to main page
func goToHome():
	return await Transit.change_scene_to_file("res://Scenes/LandingPage.tscn")
