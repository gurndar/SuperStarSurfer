extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (Array, PackedScene) var pool_scenes
export (Array, int) var pool_sizes
var pools = {}
var _pool_container
# Called when the node enters the scene tree for the first time.
func _ready():
	_pool_container = Node.new()
	_pool_container.name = "PoolContainer"
	add_child(_pool_container)
	
	for i in range(pool_scenes.size()):
		var scene = pool_scenes[i]
		var size = pool_sizes[i]
		
		if scene == null or size <= 0:
			continue
		var pool_name = scene.get_path().get_file().replace(".tscn", "")
		pools[pool_name] = []
		
		for j in range(size):
			var node = scene.instance()
			_pool_container.add_child(node)
			disable_node(node)
			pools[pool_name].push_back(node)
func get_object(pool_name):
	if pools.has(pool_name) and not pools[pool_name].empty():
		var node = pools[pool_name].pop_front()
		return node
	else:
		print("pool is empty or does not exist")
		return null

func return_object(node):
	var pool_name = node.filename.get_file().replace(".tscn", "")
	if pools.has(pool_name):
		disable_node(node)
		pools[pool_name].push_back(node)
	else:
		print("warning:", pool_name, " is not management object, declaring queue_free...")
		node.queue_free()
		
func disable_node(node):
	node.visible = false
	node.set_physics_process(false)
	
	# 충돌체(CollisionShape2D)가 있으면 그것도 비활성화
	if node.has_node("CollisionShape2D"):
		node.get_node("CollisionShape2D").set_deferred("disabled", true)
		print(node.name, "disabled")
	if node is Area2D:
		node.get_node("CollisionShape2D").set_deferred("monitoring", false)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
