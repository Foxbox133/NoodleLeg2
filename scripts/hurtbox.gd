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
			var previousHealth=health.health
			print(health.health)
			print(hitbox.damage)
			health.health-=hitbox.damage
			print(health.health)
			if health.health==previousHealth:
				print("no healing needed")
			else:
				recievedDamage.emit(hitbox.damage)
				hitbox.queue_free()
	else:
		print("null!!!")
