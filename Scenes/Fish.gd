extends Area2D

export var scroll_speed = 200
export var xp_value = 1

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_position.x -= scroll_speed * delta
#	pass


func _on_Fish_body_entered(body):
	if body.is_in_group("Player"):
		if body.has_method("gain_xp"):
			body.gain_xp(xp_value)
		
		ObjectPool.return_object(self)
func reset(spawn_position):
	self.global_position = spawn_position
	visible = true
	set_physics_process(true)
	$CollisionShape2D.disabled = false
	monitoring = true

	pass # Replace with function body.
