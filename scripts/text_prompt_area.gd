extends Area2D

@onready var label = $Label
var counter=0

func _process(delta):
	
	
	if ((label.visible==true) and (Input.is_action_just_pressed("interact"))):
		counter=counter+1
		label.text="you pressed 'E' " + str(counter) + " times!"
		print(str(counter))

func _ready():
	label.visible=false



func _on_body_entered(body):
	label.visible=true
	
	

func _on_body_exited(body):
	label.hide()
