extends Control

signal restartLevel
@onready var try_again_button = $CenterContainer/VBoxContainer/TryAgainButton




# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.

		
		


func _on_try_again_button_pressed():
	restartLevel.emit()
