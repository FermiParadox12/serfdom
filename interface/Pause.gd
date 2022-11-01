extends Control

export(PackedScene) var menu

func _ready():
	get_node("..").visible = false

func _input(event):
	if event.is_action_pressed("ui_cancel"): #when input = escape
		var pause_state = not get_tree().paused
		get_tree().paused = pause_state #switch pause state
		get_node("..").visible = pause_state


func _on_Game_Quit_button_up():
	get_tree().quit()


func _on_Menu_Quit_button_up():
	get_tree().change_scene_to(menu)
