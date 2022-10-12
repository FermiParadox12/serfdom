extends Node2D

onready var timer = $Timer
onready var setEnvi = $"Settings/Settings Envi"
export(PackedScene) var Start_Scene

func _ready():
	pass
	

func _on_Start_button_up():
	timer.set_wait_time(1.0)
	timer.start()
	

func _on_Settings_button_up():
	pass
	

func _on_Back_button_up():
	pass
	

func _on_Quit_button_up():
	get_tree().quit()
	

func _on_Timer_timeout():
	get_tree().change_scene_to(Start_Scene)
	
