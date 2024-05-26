extends Node

var points = 0



func add_point():
	points +=1
	var interface = get_node("Interface")
	print(interface)
	if (interface != null):
		interface.displayPoints(points)
	emit_signal("updatePointsScore", points)


signal updatePointsScore(points)
