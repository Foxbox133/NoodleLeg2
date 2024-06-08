extends Node

var points = 0
var PlayerHealth = 0
@onready var game_over_screen = %GameOverScreen



func add_point():
	points +=1
	#var interface = get_node("interface")
	#if (interface != null):
	#	interface.displayPoints(points)
	emit_signal("updatePointsScore", points)
	

func _input(_event):
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
	print("playterhealth is: ", PlayerHealth)
	PlayerHealth += damageTaken
	print("damage taken was: ", damageTaken)
	print("playterhealth is now: ", damageTaken)
	updatePlayerHealth.emit(PlayerHealth)


func _on_noodle_player_max_health_update(maxHealth):
	print("new play: ", PlayerHealth)
	PlayerHealth = maxHealth
	print("new play: ", PlayerHealth)
	updatePlayerHealth.emit(PlayerHealth)


func _on_game_over_screen_restart_level():
	get_tree().reload_current_scene()




