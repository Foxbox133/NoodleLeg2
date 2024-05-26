extends Control

@onready var score_label = $HBoxContainer/scoreLabel


func displayPoints(points):
	if (!points):
		points = 0
	if (!score_label):
		return
	score_label.text= str(points)




func _on_game_manager_update_points_score(points):
	displayPoints(points)
	
	
