extends Node2D
const SPEED =40
# Called when the node enters the scene tree for the first time.
var direction = -1
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_left_down = $RayCastLeftDown
@onready var ray_cast_right_down = $RayCastRightDown
@onready var ray_cast_down = $RayCastDown

@onready var animated_sprite = $AnimatedSprite2D
@onready var timer = $Timer


# Called when the node enters the scene tree for the first time.

	

func _process(delta):

	if !ray_cast_down.is_colliding():
		position.y += SPEED * delta
	else:
		if (ray_cast_right.is_colliding() || !ray_cast_right_down.is_colliding()) && direction != -1:
			direction = -1
			animated_sprite.flip_h = false
		if (ray_cast_left.is_colliding() || !ray_cast_left_down.is_colliding()) && direction != 1:
			direction = 1
			animated_sprite.flip_h = true
		position.x += direction * SPEED * delta



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
