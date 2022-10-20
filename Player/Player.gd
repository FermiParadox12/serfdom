extends KinematicBody2D

enum{
	IDLE
	MOVE
}

var state
var velocity = Vector2.ZERO
const ACCELERATION = 500
const FRICTION = 500
const MAX_SPEED =100
var ipt_vector = Vector2.ZERO
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	ipt_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	ipt_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if ipt_vector !=Vector2.ZERO:
		state = MOVE
	else:
		state = IDLE
		
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		MOVE:
			velocity = velocity.move_toward(ipt_vector * MAX_SPEED, ACCELERATION * delta)
			
	move_and_slide(velocity)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
