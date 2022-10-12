extends Node2D

onready var setEnvi = $"Settings/Settings Envi"

func _ready():
	pass

func _on_Start_button_up():
	pass # Replace with function body.


func _on_Settings_button_up():
	setEnvi
	$"Settings/Settings Envi/Back".disabled(false)

func _on_Back_button_up():
	setEnvi
	$"Settings/Settings Envi/Back".disabled(true)

func _on_Quit_button_up():
	get_tree().quit()



