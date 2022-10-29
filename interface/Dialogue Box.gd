extends Control

onready var player = $"../../../Player"


func _ready():
	visible = false


func say(line, npc):
	visible = true
	set_position(player.position)
	$"Speech Background/Name Background/Name".set_text(line)
	$"Speech Background/Speech".set_text(npc)
