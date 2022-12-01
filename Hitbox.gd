extends Area2D
#export (PackedScene) var Player

func _on_Area2D_body_entered(body):
	if body is Player:
		get_tree().reload_current_scene()
