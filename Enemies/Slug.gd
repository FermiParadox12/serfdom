extends KinematicBody2D

var direction = Vector2.LEFT
var velocity = Vector2.ZERO

onready var ledgeCheck: = $LedgeCheck
#onready var ledgeCheckRight: = $LedgeCheckRight
onready var sprite: = $AnimatedSprite
onready var collision: = $CollisionPolygon2D

func _physics_process(delta):
	#ledge/wall check
	var found_wall = is_on_wall()
	var found_ledge = not ledgeCheck.is_colliding()# or not ledgeCheckRight.is_colliding()
	if found_wall or found_ledge:
		direction *= -1
		scale.x *= -1   
	
#	sprite.flip_h = direction.x > 0
	#movement
	velocity = direction * 25
	move_and_slide(velocity,Vector2.UP)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

