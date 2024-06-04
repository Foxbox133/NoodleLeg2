extends Control


func _ready():
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func open():
	show()
	
func close():
	hide()

signal resumeGame()

func _on_resume_pressed():
	print("resume pressed")
	resumeGame.emit()
	close()
