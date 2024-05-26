extends Area2D

@onready var shooting_point = %ShootingPoint

@onready var gun_arm = $WeaponPivot/GunArm

@onready var noodle = $".."




# Called when the node enters the scene tree for the first time.
func _process(delta):
	var mousePosition = get_global_mouse_position()
	look_at(mousePosition)
	
	if ((mousePosition.x-noodle.global_position.x)>=0):
		
		gun_arm.flip_v=false
		gun_arm.flip_h=true
	else:
		gun_arm.flip_h=true
		gun_arm.flip_v=true
	
	if (Input.is_action_just_pressed("fire_weapon")):
		shoot()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func shoot():
	const BULLET = preload("res://scenes/bullet.tscn")
	var newBullet=BULLET.instantiate()
	newBullet.global_position=shooting_point.global_position
	newBullet.global_rotation=shooting_point.global_rotation
	shooting_point.add_child(newBullet)
	
		
