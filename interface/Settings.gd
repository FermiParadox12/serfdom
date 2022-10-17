extends Control



func _ready():
	pass

func _on_Enter_Settings_button_up():
	settings_screen()
	

func settings_screen():
	flip_vis($Background)
	flip_vis($"Enter Settings")
	flip_vis($Options)
	

func flip_vis(c):
	c.visible = not c.is_visible()
	


func _on_Back_button_up():
	settings_screen()
