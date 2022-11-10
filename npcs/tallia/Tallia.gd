extends Area2D

onready var Diag_Sys = $"Dialogue Box"
onready var player = $"../Player"

enum{
	SAFEROOM
	STARTED
	FAILED
	COMPLETED
}

const SCALETIME = 0.25

var questions_asked = 0
var lines_spoken = 0
var quest_progress
var in_range = false
var line
var answers = ["a","b"]


func _ready():
	$Popup.scale = Vector2.ZERO
	quest_progress = SAFEROOM

func _input(event):
	if event.is_action_pressed("interact") && in_range == true:
		line = speak(quest_progress, lines_spoken)
		if line == "@":
			Diag_Sys.ask(answers)
		else:
			Diag_Sys.say(line)


func speak(prog, lines):
	var r = "null"
	match prog:
		SAFEROOM: #First meeting Tallia
			if lines == 0:
				r = "EEEEK! PLease don't hurt me!!"
			elif lines == 1:
				r = "..."
			elif lines == 2:
				r = "Wait, you're not a guard!"
			elif lines == 3:
				r = "Sorry about that... Who might you be?"
			elif lines == 4:
				r = "@"
				answers = ["Keep quiet.", "Introduce yourself."]
				questions_asked = 1
			
		STARTED: #Tallia asks player to find mother
			pass
		FAILED: #Player says no
			pass
		COMPLETED: #Player finds mother & returns to Tallia
			pass
	
	lines_spoken += 1
	print("Tallia: " + r)
	return(r)

func button_pressed(button):
	if questions_asked == 1:
		if button == 1:
			Diag_Sys.say("No worries... sorry for asking. I'm Tallia!")
		if button == 2:
			Diag_Sys.say("Oh! My name is Tallia!")
	elif questions_asked == 2:
		if button == 1:
			pass
		if button == 2:
			pass
	elif questions_asked == 3:
		if button == 1:
			pass
		if button == 2:
			pass

func _on_Tallia_body_entered(body):
	if body.name == "Player":
		show_prompt()

func _on_Tallia_body_exited(body):
	if body.name == "Player":
		hide_prompt()
		Diag_Sys.close()
	

func show_prompt():
	in_range = true
	var tween = get_node(".").create_tween() #create tween for popup's scale from 0->1 and ease in/out
	tween.tween_property($Popup, "scale", Vector2(1, 1), SCALETIME).from_current().set_ease(Tween.EASE_IN_OUT)

func hide_prompt():
	in_range = false
	var tween = get_node(".").create_tween() # create tween for popup's scale from 1->0 and ease in/out
	tween.tween_property($Popup, "scale", Vector2.ZERO, SCALETIME).from_current().set_ease(Tween.EASE_IN_OUT)
	
