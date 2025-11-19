extends Node2D


onready var viewport_rect = get_viewport_rect()
var spawn_x_position = 1124.0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
# [수정] GameManager가 호출할 '이름으로 스폰' 함수
func spawn_enemy(enemy_name):
	var enemy = ObjectPool.get_object(enemy_name)
	
	if enemy != null:
		var spawn_y = rand_range(viewport_rect.position.y, viewport_rect.end.y)
		var spawn_pos = Vector2(spawn_x_position, spawn_y)
		enemy.reset(spawn_pos)
	

func _on_SpawnTimer_timeout():
	## Unless no GameManager, so arbitrarily spawn
	spawn_enemy("EnemyBoat")
	pass # Replace with function body.
