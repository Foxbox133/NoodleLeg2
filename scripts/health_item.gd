extends Area2D

@onready var game_manager = %GameManager

@export var healthincrease: int=3

signal increasehealth(healthincrease)


func _on_body_entered(body):
	print("we ate bluberry for: ",healthincrease, " hp")
	increasehealth.emit()
	print("pogg")
	queue_free()




