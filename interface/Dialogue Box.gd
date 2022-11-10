extends Control

onready var npc_name = $"Name Background/Name"
onready var speech = $"Dialogue Background/Dialogue"
onready var diag_box = $"Dialogue Background"
onready var name_box = $"Name Background"
onready var button1 = $"Answer Button 1"
onready var button2 = $"Answer Button 2"
onready var npc = get_node("..")


func _ready():
	close()
	npc_name.bbcode_text = npc.name


func say(line):
	close()
	diag_box.visible = true
	if line == "null":
		speech.bbcode_text = "DIALOGUE NOT FOUND"
	else:
		speech.bbcode_text = line

func ask(line):
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
	npc.button_pressed(1)


func _on_Answer_Button_2_pressed():
	npc.button_pressed(2)
