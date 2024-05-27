class_name HurtBox
extends Area2D

signal recievedDamage(damage:int)

@export var health: Health 
	

func _ready():
	connect("area_entered", _on_area_entered)

func _on_area_entered(hitbox:HitBox)-> void:
	if (hitbox!=null):

		if (health == null):
			print("nohealt")
		else:
			print("ochieochie")
			health.health-=hitbox.damage
			recievedDamage.emit(hitbox.damage)
	else:
		print("null!!!")
