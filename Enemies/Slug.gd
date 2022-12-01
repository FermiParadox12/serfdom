extends KinematicBody2D
class_name Enemy

var direction = Vector2.LEFT
var velocity = Vector2.ZERO

onready var ledgeCheck: = $LedgeCheck


func _physics_process(delta):
	#ledge/wall check

	var found_wall = is_on_wall()
	var found_ledge = not ledgeCheck.is_colliding()
	if found_wall or found_ledge:
		direction *= -1
		scale.x *= -1   
	
	#movement
	velocity = direction * 25
	move_and_slide(velocity,Vector2.UP)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

