class_name Health
extends Node


signal maxHealthChanged(health:int)
signal healthDepleted
signal healthChanged(damageTaken:int)

var immortalityTimer:Timer = null

@export var maxHealth: int = 30: set = setMaxHealth, get = getMaxHealth 
@export var immortality: bool = false: set = setImmortality, get = getImmortality 
@export var health: int = maxHealth: set = setHealth, get = getHealth 

func _ready():
	maxHealthChanged.emit(health)

func getHealth():
	return health
	
func setHealth(newHealth:int):
	if (newHealth<health and immortality):
		return

	var healthRange=clampi(newHealth,0,maxHealth)
	
	if (healthRange!=health):
		var difference = healthRange-health
		health=newHealth
		healthChanged.emit(difference)
		
		if (health<=0):
			healthDepleted.emit()

func getMaxHealth():
	return maxHealth

func setMaxHealth(newMaxHealth:int):
	newMaxHealth = 1 if newMaxHealth<=0 else newMaxHealth
	maxHealth=newMaxHealth
	print("newmaxHealth: ",newMaxHealth)
	maxHealthChanged.emit(newMaxHealth)
	if (health>maxHealth):
		health=maxHealth
	if (health == 0):
		health = maxHealth
			
func setImmortality(isImmortal:bool):
	immortality=isImmortal
	
func getImmortality():
	return immortality
	
func setTemporaryImmortality(time:float):
	if (immortalityTimer==null):
		immortalityTimer=Timer.new()
		immortalityTimer.one_shot=true
		add_child(immortalityTimer)
	
	if immortalityTimer.timeout.is_connected(setImmortality):
		immortalityTimer.timeout.disconnect(setImmortality)
		
	immortalityTimer.set_wait_time(time)
	immortalityTimer.timeout.connect(setImmortality.bind(false))
	immortality=true
	immortalityTimer.start()

	
	
