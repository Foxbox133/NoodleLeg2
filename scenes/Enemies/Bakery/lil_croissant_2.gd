extends CharacterBody2D


@export var direction: int = -1
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_left_down = $RayCastLeftDown
@onready var ray_cast_right_down = $RayCastRightDown
@onready var ray_cast_down = $RayCastDown
@onready var animated_sprite = $AnimatedSprite2D
@onready var timer = $Timer
@export var checkForLedges: bool = true
var GRAVITY = 500
const SPEED =40

func _ready():
	if direction:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false
	
func _physics_process(delta):
	if (ray_cast_right.is_colliding() or 
	(checkForLedges and not ray_cast_right_down.is_colliding())) and direction != -1:
		direction = -1
		animated_sprite.flip_h = false
		
	if (ray_cast_left.is_colliding() or 
	(checkForLedges and not ray_cast_left_down.is_colliding())) and direction != 1:
		direction = 1
		animated_sprite.flip_h = true
		
	velocity.x = direction * SPEED
	velocity.y += GRAVITY * delta
	
	move_and_slide()
	
	if is_on_floor():
		velocity.y = 0
		
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
