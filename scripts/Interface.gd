extends Control

@onready var score_label = $VBoxContainer/HBoxContainer/scoreCounter
@onready var health_label = $VBoxContainer/HBoxContainer2/healthCounter

func displayPoints(points):
	if (!points):
		points = 0
	if (!score_label):
		return
	score_label.text= str(points)

func updateHealth(health):
	print("health is: ",health)
	if (!health):
		print("health changed: ",health)
		#health = -1
		print("health changed: ",health)
	if (!health_label):
		return
	print("health changed now is: ",health)
	health_label.text = str(health)


func _on_game_manager_update_points_score(points):
	displayPoints(points)
	
	
func _on_game_manager_update_player_health(health):
	updateHealth(health)


func _on_health_max_health_changed(health):
	updateHealth(health)
