extends Node2D

const SPEED =60
# Called when the node enters the scene tree for the first time.
var direction = 1

@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right = $RayCastRight
@onready var animated_sprite = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray_cast_right.is_colliding():
		direction= -1
		animated_sprite.flip_h=false
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h=true
	position.x+= direction * SPEED * delta



func _on_health_health_depleted():
	print("snail ded")
	queue_free()
