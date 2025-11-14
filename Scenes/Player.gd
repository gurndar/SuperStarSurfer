extends KinematicBody2D

export (int) var max_speed = 350
export (int) var acceleration = 10000
export (int) var drag_friction = 500
export (int) var scroll_speed = 200

export (float) var carve_threshold = 150.0
var previous_y_velocity = 0.0

var velocity = Vector2.ZERO

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():	
	pass # Replace with function body.
func _physics_process(delta):
	get_move_input(delta)
	velocity = move_and_slide(velocity)
	check_for_carve()
	previous_y_velocity = velocity.y

func get_move_input(delta):
	var input_y = 0.0
	if Input.is_action_pressed("move_down"):
		input_y += 1
	if Input.is_action_pressed("move_up"):
		input_y -= 1
	var target_velocity_y = input_y * max_speed
	if input_y != 0:
		velocity.y = move_toward(velocity.y, target_velocity_y, acceleration * delta)
	else:
		velocity.y = move_toward(velocity.y, 0, drag_friction * delta)
	velocity.x = scroll_speed
func check_for_carve():
	var y_sign_changed = sign(velocity.y) != sign(previous_y_velocity)
	var was_moving_fast_enough = abs(previous_y_velocity) > carve_threshold
	
	if y_sign_changed and was_moving_fast_enough:
		spawn_splash_attack()
		
func spawn_splash_attack():
	print("Yeah!")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
