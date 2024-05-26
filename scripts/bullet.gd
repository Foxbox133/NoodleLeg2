extends Area2D

var traveledDistance = 0
const  SPEED = 300
const RANGE= 400


func _physics_process(delta):
	var velocityVector = Vector2.RIGHT.rotated(rotation)
	position+=velocityVector*SPEED*delta
	traveledDistance+=SPEED*delta
	if (traveledDistance>RANGE):
		queue_free()


func _on_body_entered(body):
	queue_free()
	
	
	
