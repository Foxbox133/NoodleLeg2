extends Control

signal restartLevel
@onready var try_again_button = $CenterContainer/VBoxContainer/TryAgainButton


func _on_try_again_button_pressed():
	restartLevel.emit()
