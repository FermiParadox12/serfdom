extends Area2D

onready var Diag_Sys = $"Dialogue Box"
onready var player = $"../Player"


enum{
	INTRO
	STARTABLE
	STARTED
	FAILED
	FOUND
	COMPLETED
}

const SCALETIME = 0.25

var cloth_in_range = false
var cloth_found = false
var questions_asked = 0
var lines_spoken = 0
var quest_progress
var in_range = false
var line
var answers = ["a","b"]


func _ready():
	quest_progress = INTRO

func _input(event):
	if event.is_action_pressed("interact") && in_range == true:
		if Diag_Sys.asking == false:
			line = speak(quest_progress, lines_spoken)
			if line == "@":
				Diag_Sys.ask(answers)
			else:
				Diag_Sys.say(line)
				
	elif event.is_action_pressed("interact") && cloth_in_range == true:
		cloth_found == true
		$Cloth.visible = false


func speak(prog, lines):
	var r = "null"
	match prog:
		INTRO: # first meeting Tallia
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
			
		STARTABLE: # tallia asks player if they can find her mother
			if lines == 0:
				r = "Excuse me... may I ask you something?"
			elif lines == 1:
				r = "My mother is missing, do you think you can find her for me?"
			elif lines >= 2:
				r = "@"
				answers = ["Accept.","Refuse."]
				questions_asked += 1
			
		STARTED: # tallia asks player if they found mother
			if lines % 2 == 0:
				r =  "Did you find her yet?"
			elif lines % 2 == 1:
				r = "@"
				answers = ["Yes","No"]
				
		FOUND:
			if lines == 0:
				r = "What...?"
			elif lines == 1:
				r = "I understand."
			elif lines == 2:
				r = "Thank you. Here, maybe this will be helpful on your quest."
				# KEY GET
			elif lines >= 3:
				r = "Thank you for bringing me closure."
			
		FAILED: # player says no 3 times, quest permanently failed
			if lines == 0:
				r = "No one wants to help me..."
			elif lines == 1:
				r = "Why did I even ask?"
			elif lines >= 2:
				r = "Stupid Tallia."
		COMPLETED: # player finds mother & returns to tallia, quest complete
			if player.morality >= 0:
				r = "Thank you... again. Youre a good person."
			if player.morality << 0:
				r = "GET AWAY! GET AWAY FROM ME!"
	
	lines_spoken += 1
	print("Tallia: " + r)
	return(r)

func button_pressed(button):
	if quest_progress == INTRO: # tallia asks player's name
		if button == 1: # player stays silent
			Diag_Sys.say("No worries... sorry for asking. I'm Tallia!") # neutral option
		if button == 2: # player tells her
			player.morality += 1
			Diag_Sys.say("Oh! My name is Tallia!") # good option
		quest_progress = STARTABLE
		lines_spoken = 0
		
	elif quest_progress == STARTABLE:
		if button == 1:
			Diag_Sys.say("Oh thank you greatly! Before the madness she worked in the kitchens.") # accept
			lines_spoken = 0
			quest_progress = STARTED
			
		if button == 2:
			Diag_Sys.say("Thats okay... forget I asked.") # refuse
			if questions_asked >= 3:
				quest_progress == FAILED
				lines_spoken = 0
				
	elif quest_progress == STARTED:
		if button == 1:
			Diag_Sys.say("Did you really?! Where is she?")
			if cloth_found == true:
				quest_progress = FOUND
				lines_spoken = 0
		if button == 2:
			Diag_Sys.say("Oh, okay. Let me know when you do!")

func _on_Tallia_body_entered(body):
	if body.name == "Player":
		Diag_Sys.show_prompt()

func _on_Tallia_body_exited(body):
	if body.name == "Player":
		Diag_Sys.hide_prompt()
		Diag_Sys.close()
	
	


func _on_Cloth_body_entered(body):
	if body.name == "Player":
		if cloth_found == false:
			cloth_in_range = true


func _on_Cloth_body_exited(body):
	if body.name == "Player":
		if cloth_found == false:
			cloth_in_range = false
