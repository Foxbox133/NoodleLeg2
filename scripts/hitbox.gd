class_name HitBox
extends Area2D

@export var damage : int = 1 : set=setDamage, get=getDamage

func setDamage(newDamage:int):
	damage=newDamage
	 
	
func getDamage() -> int :
	return damage
