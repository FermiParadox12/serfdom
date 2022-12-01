extends Control

onready var npc_name = $"Name Background/Name"
onready var speech = $"Dialogue Background/Dialogue"
onready var diag_box = $"Dialogue Background"
onready var name_box = $"Name Background"
onready var button1 = $"Answer Button 1"
onready var button2 = $"Answer Button 2"
onready var prompt = $Popup
onready var npc = get_node("..")

var asking = false

func _ready():
	prompt.scale = Vector2.ZERO
	close()
	npc_name.bbcode_text = npc.name


func say(line):
	close()
	prompt.scale = Vector2.ZERO
	diag_box.visible = true
	if line == "null":
		speech.bbcode_text = "DIALOGUE NOT FOUND"
	else:
		speech.bbcode_text = line

func ask(line):
	asking = true
	close()
	button1.visible = true
	button2.visible = true
	
	button1.text = line[0]
	button2.text = line[1]

func close():
	diag_box.visible = false
	button1.visible = false
	button2.visible = false


func _on_Answer_Button_1_pressed():
	asking = false
	npc.button_pressed(1)


func _on_Answer_Button_2_pressed():
	asking = false
	npc.button_pressed(2)


func show_prompt():
	npc.in_range = true
	if asking == true:
		button1.visible = true
		button2.visible = true
	else:
		var tween = get_node(".").create_tween() #create tween for popup's scale from 0->1 and ease in/out
		tween.tween_property(prompt, "scale", Vector2(1, 1), npc.SCALETIME).from_current().set_ease(Tween.EASE_IN_OUT)

func hide_prompt():
	npc.in_range = false
	var tween = get_node(".").create_tween() # create tween for popup's scale from 1->0 and ease in/out
	tween.tween_property(prompt, "scale", Vector2.ZERO, npc.SCALETIME).from_current().set_ease(Tween.EASE_IN_OUT)
