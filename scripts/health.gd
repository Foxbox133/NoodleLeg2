class_name Health
extends Node

signal maxHealthChanged(newMaxHealth:int)
signal healthDepleted
signal healthChanged(damageTaken:int)

@export var maxHealth: int = 3: set = setMaxHealth, get = getMaxHealth 
@export var immortality: bool = false: set = setImmortality, get = getImmortality 


func getHealth():
	pass
	
func setHealth():
	#emit(damageTaken)
	pass

func getMaxHealth():
	pass

func setMaxHealth(value:int):
	pass
	
func setImmortality(value:bool):
	pass
	
func getImmortality():
	pass
	


func setTemporaryImmortality(time:float):
	pass
