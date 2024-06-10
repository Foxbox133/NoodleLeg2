extends CanvasLayer


@export_file("*json") var dialog_text_file

var scene_text = {}
var current_selected_text = []
var reading_in_progress=false
@onready var background = $Background
@onready var label = $Label

func _ready():
	background.visible=false
	scene_text=load_scene_text()
	var signalbus=ProjectSettings.get_setting("Signalbus")
	if signalbus:
		signalbus.connect("display_dialog", self, "on_display_dialog")
	else:
		print("L")


func load_scene_text():
	var file=FileAccess.open(dialog_text_file, FileAccess.READ)
	if FileAccess.file_exists(dialog_text_file):
		return JSON.parse_string(file.get_as_text())
	
func show_text():
	label.text=current_selected_text.pop_front()
	
func next_line():
	if current_selected_text.size()>0:
		show_text()
		print("showing text: ")
	else:
		finish()	
		
func finish():
	label.text=""
	background.visible=false
	reading_in_progress=false
	get_tree().paused=false

func on_display_dialog(text_key):
	if reading_in_progress:
		next_line()
	else:
		get_tree().paused=true
		background.visible=true
		reading_in_progress=true
		current_selected_text = scene_text[text_key].duplicate()
		show_text()
	
