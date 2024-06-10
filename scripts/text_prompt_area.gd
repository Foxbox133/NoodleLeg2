extends Area2D

@export var dialog_key=""
@onready var label = $Label
var counter=0
var area_active=false

func _process(delta):
	
	
	if ( area_active and (Input.is_action_just_pressed("interact"))):
		counter=counter+1
		Signalbus.emit_signal("display_dialog", dialog_key)
		#label.text="you pressed 'E' " + str(counter) + " times!"
		print("areea works")

func _ready():
	label.visible=false



func _on_body_entered(body):
	area_active=true
	label.visible=true
	
	

func _on_body_exited(body):
	area_active=false
	label.visible=false

func display_dialog():
	pass
