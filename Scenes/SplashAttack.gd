extends Area2D


export (int) var speed = 800
var damage = 200

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += speed * delta
#	pass


func _on_Timer_timeout():
	queue_free()
	pass # Replace with function body.




func _on_SplashAttack_body_entered(body):
	if body.is_in_group("enemy"):
		if body.has_method("take_damage"):
			body.take_damage(damage)
			queue_free()
	print(body.name, "with splashattack")
			
	pass # Replace with function body.
