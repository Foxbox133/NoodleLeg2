extends CharacterBody2D

#noodle ligger som top level för att inte hamna bakom t.ex. coins


const SPEED = 150.0
const JUMP_VELOCITY = -350.0
const PUSH_FORCE = 80
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var health: Health 
@export var startHealth: int = 5

var damageEnabled=false

@onready var noodleSprite = $AnimatedSprite2D
@onready var spawntimer = $Spawntimer

@onready var groundRayDown = $downGroundCast
@onready var groundRaySlopeLeft = $leftGroundCast
@onready var groundRaySlopeRight = $rightGroundCast
@onready var stepRayRight = $rightStairRayCasy
@onready var stepRayLeft = $leftStairRayCasy
@onready var stepRayRightLower = $rightStairLowerRayCast
@onready var stepRayLeftLower = $leftStairLowerRayCast




func _ready():
	spawntimer.start()
	health.setMaxHealth(startHealth)
	#$leftGroundCast/Line2D.add_point(groundRaySlopeLeft.position)
	#$leftGroundCast/Line2D.add_point(groundRaySlopeLeft.target_position)
	#$leftGroundCast/Line2D.width = 1
		#
	#$rightGroundCast/Line2D.add_point(groundRaySlopeRight.position)
	#$rightGroundCast/Line2D.add_point(groundRaySlopeRight.target_position)
	#$rightGroundCast/Line2D.default_color = Color.YELLOW
	#$rightGroundCast/Line2D.width = 1
		#
	#$downGroundCast/Line2D.add_point(groundRayDown.position)
	#$downGroundCast/Line2D.add_point(groundRayDown.target_position)
	#$downGroundCast/Line2D.default_color = Color.RED
	#$downGroundCast/Line2D.width = 1
	#
	#$leftStairRayCasy/Line2D.add_point(stepRayLeft.position)
	#$leftStairRayCasy/Line2D.add_point(stepRayLeft.target_position)
	#$leftStairRayCasy/Line2D.default_color = Color.MAGENTA
	#$leftStairRayCasy/Line2D.width = 1
	#
	#$rightStairRayCasy/Line2D.add_point(stepRayRight.position)
	#$rightStairRayCasy/Line2D.add_point(stepRayRight.target_position)
	#$rightStairRayCasy/Line2D.default_color = Color.MAGENTA
	#$rightStairRayCasy/Line2D.width = 1
	#
#
	#$leftStairLowerRayCast/Line2D.add_point(stepRayLeftLower.position)
	#$leftStairLowerRayCast/Line2D.add_point(stepRayLeftLower.target_position)
	#$leftStairLowerRayCast/Line2D.default_color = Color.MAGENTA
	#$leftStairLowerRayCast/Line2D.width = 1
	#
	#$rightStairLowerRayCast/Line2D.add_point(stepRayRightLower.position)
	#$rightStairLowerRayCast/Line2D.add_point(stepRayRightLower.target_position)
	#$rightStairLowerRayCast/Line2D.default_color = Color.MAGENTA
	#$rightStairLowerRayCast/Line2D.width = 1

	
	

func isFloor():
	#raycast hwhwwh
	var isOnFloor = is_on_floor()
	var isOnFloorRaycast = false

	if groundRayDown.is_colliding():
		isOnFloorRaycast = true
	return (isOnFloor && isOnFloorRaycast)
	
func checkSlope():
	var leftCollide = groundRaySlopeLeft.is_colliding()
	var rightCollide = groundRaySlopeRight.is_colliding()
	var downCollide = groundRayDown.is_colliding()
	var isCloseToSlope = (leftCollide || rightCollide)

	return isCloseToSlope or downCollide
	
func checkSlopeLeft():
	var isCloseToSlope = groundRaySlopeLeft.is_colliding()
	return isCloseToSlope
	
func checkSlopeRight():
	var isCloseToSlope = groundRaySlopeRight.is_colliding()
	return isCloseToSlope
	
	
func stairRight():
	var isCloseToWall = stepRayRight.is_colliding()
	var isCloseToStep = stepRayRightLower.is_colliding()
	
	return (!isCloseToWall) && isCloseToStep

func stairLeft():
	var isCloseToWall = stepRayLeft.is_colliding()
	var isCloseToStep = stepRayLeftLower.is_colliding()
	return (!isCloseToWall) && isCloseToStep





func _physics_process(delta):
	# Add the gravity.
	if not isFloor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	

	
	var direction = Input.get_axis("move_left", "move_right")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	if direction > 0:
		noodleSprite.flip_h=false
		
	elif direction <0:
		noodleSprite.flip_h=true
	if ( (!isFloor()) && !checkSlope()):
		noodleSprite.play("jump")
	else:
		if direction == 0:
			if (Input.is_action_pressed("crouch")) :
				#print("we are crou")
				noodleSprite.play("crouch")
			else:
				noodleSprite.play("idle")
		else:
			noodleSprite.play("running")	
			
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	##if (stairLeft() && direction == -1 && velocity.x != 0):
		# velocity.y += -20
		#print("Step Found left")
	##elif (stairRight() && direction == 1 && velocity.x != 0): 
		# velocity.y += -20
		#print("Step Found right")
	#else:
		#print("no step")

	move_and_slide()
	
	for i in get_slide_collision_count():

		var coliding_body=get_slide_collision(i)
		if coliding_body.get_collider() is RigidBody2D:
			#print("collision position = " + str(coliding_body.get_position().normalized()))
			#print("player position = " + str(position.normalized()))
			var difference_x = coliding_body.get_position().x - position.x
			var sideOfCollision = clamp(difference_x, -1, 1)
			#print(sideOfCollision)
			if coliding_body.get_position().dot(position) >= 0 && sideOfCollision == direction:
				coliding_body.get_collider().apply_central_impulse(-coliding_body.get_normal() * PUSH_FORCE)
			

signal playerMaxHealthUpdate(maxHealth)
func _on_health_max_health_changed(newMaxHealth):
	playerMaxHealthUpdate.emit(newMaxHealth)

signal playerHealthDepleted()
func _on_health_health_depleted():
	playerHealthDepleted.emit()

signal playerHealthUpdate(damageTaken)
func _on_health_health_changed(damageTaken):
	if damageTaken>0:
		print ("healing ", damageTaken, " hp")
	if damageEnabled:
		playerHealthUpdate.emit(damageTaken)


func _on_spawntimer_timeout():
	damageEnabled=true


