extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var scroll_speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func scroll_background():
	$Ocean.position.x -= scroll_speed 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
