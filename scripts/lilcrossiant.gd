extends Node2D
const SPEED =60
# Called when the node enters the scene tree for the first time.
var direction = 1
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.

	

func _process(delta):
	if ray_cast_right.is_colliding():
		direction= -1
		animated_sprite.flip_h=false
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h=true
	position.x+= direction * SPEED * delta
	


func _on_health_health_depleted():
	direction=0
	var probability =randf()
	if probability<=0.1:
		animated_sprite.play("brutal death")
	else:
		animated_sprite.play("death")
	timer.start()

	

	
	
	


func _on_timer_timeout():
	queue_free()
