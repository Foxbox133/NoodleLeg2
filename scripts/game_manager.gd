extends Node

var points = 0
var PlayerHealth = 0
@onready var game_over_screen = %GameOverScreen



func add_point():
	points +=1
	var interface = get_node("Interface")
	print(interface)
	if (interface != null):
		interface.displayPoints(points)
	emit_signal("updatePointsScore", points)
	updatePointsScore.emit()

func _input(event):
	# Restart Scene on R press
	if Input.is_key_pressed(KEY_R):
		get_tree().reload_current_scene()

func killPlayer():
	# Implement that shit
	return


signal updatePointsScore(points)
signal updatePlayerHealth(health)


func _on_noodle_player_health_depleted():
	print("dead as fuck")
	game_over_screen.show()
	


func _on_noodle_player_health_update(damageTaken):
	print("playterhealth is:", PlayerHealth)
	
	PlayerHealth += damageTaken
	updatePlayerHealth.emit(PlayerHealth)


func _on_noodle_player_max_health_update(maxHealth):
	PlayerHealth = maxHealth
	print(PlayerHealth)
	updatePlayerHealth.emit(PlayerHealth)


func _on_game_over_screen_restart_level():
	get_tree().reload_current_scene()
