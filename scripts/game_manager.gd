extends Node

var points = 0
var PlayerHealth = 0


func add_point():
	points +=1
	var interface = get_node("Interface")
	print(interface)
	if (interface != null):
		interface.displayPoints(points)
	emit_signal("updatePointsScore", points)


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
		# Die
	pass # Replace with function body.


func _on_noodle_player_health_update(damageTaken):
	print("damage owieZowie")
	PlayerHealth += damageTaken
	updatePlayerHealth.emit(PlayerHealth)


func _on_noodle_player_max_health_update(maxHealth):
	PlayerHealth = maxHealth
	print(PlayerHealth)
	updatePlayerHealth.emit(PlayerHealth)
