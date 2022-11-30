extends KinematicBody2D

var velocity = Vector2.ZERO
var fast_fell = false
export(int) var GRAVITY = 30
export(int) var ACCELERATION = 500
export(int) var FRICTION = 20
export(int) var MAX_SPEED =300
export(int) var ADDITIONAL_FALL_GRAVITY = 30
export(int) var JUMP_FORCE = 750
export(int) var JUMP_RELEASE_FORCE = 375
const up_direction = Vector2(0, -1)#normal vector for the floor
var max_jumps = 1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	$AnimatedSprite.playing = true
	#movement
	apply_gravity()
	var get_input = Vector2.ZERO
	get_input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if get_input.x == 0:
		apply_friction()
		$AnimatedSprite.animation = "Idle"
	else:
		apply_acceleration(get_input.x)
		$AnimatedSprite.animation = "Run"
		
		
	#jumping
	if is_on_floor():
		fast_fell = false
		max_jumps = 1
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = -JUMP_FORCE
	else:
		$AnimatedSprite.animation = "Jump"
		if max_jumps > 0 && Input.is_action_just_pressed("ui_up"):
			velocity.y = -JUMP_FORCE
			max_jumps -= 1
			
		if Input.is_action_just_released("ui_up") and velocity.y < -375:
			velocity.y = -JUMP_RELEASE_FORCE
		if velocity.y > 0:
			velocity.y += ADDITIONAL_FALL_GRAVITY
			if max_jumps > 0 && Input.is_action_just_pressed("ui_up"):
				velocity.y = -JUMP_FORCE
				max_jumps -= 1
			
	velocity = move_and_slide(velocity, up_direction)
	
	#attack
#	if Input.is_action_just_pressed("ui_accept"):
#		$AnimatedSprite.animation = "Attack"

func apply_gravity():
	velocity.y += GRAVITY

func apply_friction():
	velocity.x = move_toward(velocity.x, 0, FRICTION)
	pass
	
func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, MAX_SPEED * amount, ACCELERATION)
	if velocity.x > 0:
		$AnimatedSprite.flip_h = false
	elif velocity.x < 0:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = $AnimatedSprite.flip_h
	pass

