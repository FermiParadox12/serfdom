extends Control

const FADE = 1.0

onready var timer = $Timer
export(PackedScene) var Start_Scene

func _ready():
	modulate = Color(0, 0, 0, 1) #Darken Screen
	fade_in(true)
	

func _on_Start_button_up():
	timer.set_wait_time(FADE)#Initialize timer length to FADE
	fade_out()
	timer.start()
	

func _on_Quit_button_up():
	get_tree().quit()
	

func _on_Timer_timeout():
	get_tree().change_scene_to(Start_Scene) #Switch scenes after fade-out
	

func fade_in(i):
	var tween = get_node(".").create_tween() #create tween
	if i == true: #first bootup
		tween.tween_property(self, "modulate", Color(1, 1, 1, 1), 3.0).from_current()
	else:
		tween.tween_property(self, "modulate", Color(1, 1, 1, 1), FADE).from_current()
	

func fade_out():
	var tween = get_node(".").create_tween() #create tween
	tween.tween_property(self, "modulate", Color(0, 0, 0, 1), FADE).from_current() #slowly modulate scene to black
	
