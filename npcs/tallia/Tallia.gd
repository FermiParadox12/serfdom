extends Area2D

enum{
	SAFEROOM
	STARTED
	FAILED
	COMPLETED
}

const SCALETIME = 0.25

var lines_spoken = 0
var quest_progress
var in_range = false


func _ready():
	$Popup.scale = Vector2.ZERO

func _input(event):
	if event.is_action_pressed("interact") && in_range == true:
		$"Dialogue Box/Dialogue Box".say(speak(quest_progress, lines_spoken), name)
		
	if event.is_action_pressed("ui_accept"):
		print(speak(quest_progress, lines_spoken))


func speak(prog,lines):
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
			
		STARTED: #Tallia asks player to find mother
			pass
		FAILED: #Player says no
			pass
		COMPLETED: #Player finds mother & returns to Tallia
			pass
	
	lines_spoken += 1
	return(r)


func _on_Tallia_body_entered(body):
	if body.name == "Player":
		in_range = true
		var tween = get_node(".").create_tween() #create tween for popup's scale from 0->1 and ease in/out
		tween.tween_property($Popup, "scale", Vector2(1, 1), SCALETIME).from_current().set_ease(Tween.EASE_IN_OUT)

func _on_Tallia_body_exited(body):
	if body.name == "Player":
		in_range = false
		var tween = get_node(".").create_tween() #create tween for popup's scale from 1->0 and ease in/out
		tween.tween_property($Popup, "scale", Vector2.ZERO, SCALETIME).from_current().set_ease(Tween.EASE_IN_OUT)

