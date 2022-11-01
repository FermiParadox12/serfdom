extends Control

onready var player = $"../../../Player"
onready var speech = $"Speech Background/Speech"
onready var npc_name = $"Name Background/Name"


func _ready():
	visible = false


func say(line, npc):
	visible = true
	set_position(player.position)
	npc_name.bbcode_text = npc
	if line == "null":
		speech.bbcode_text = "null"
	else:
		speech.bbcode_text = line
