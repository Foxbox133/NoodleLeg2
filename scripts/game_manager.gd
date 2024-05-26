extends Node

var points = 0



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


signal updatePointsScore(points)
