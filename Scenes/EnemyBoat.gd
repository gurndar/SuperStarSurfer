extends KinematicBody2D
export (int) var health = 20
export (int) var scroll_speed = 200
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2.ZERO
var max_health = 3
# Called when the node enters the scene tree for the first time.
func _ready():
	max_health = health
	pass # Replace with function body.
func take_damage(damage_amount):
	health -= damage_amount
	print("enemy health: ",health)
	if health <= 0:
		die()
func die():
	var fish = ObjectPool.get_object("Fish")
	# drop the exp
	if fish != null:
		fish.reset(self.global_position)
	ObjectPool.return_object(self)
	
func reset(spawn_position):
	self.global_position = spawn_position
	
	health = max_health
	velocity = Vector2(-scroll_speed, 0)
	visible = true
	set_physics_process(true)
	$CollisionShape2D.disabled = false 
func _physics_process(delta):
	velocity.x = -scroll_speed
	velocity = move_and_slide(velocity)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VisibilityNotifier2D_screen_exited():
	ObjectPool.return_object(self)
	pass # Replace with function body.
