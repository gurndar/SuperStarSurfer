extends KinematicBody2D

export (int) var max_speed = 350
export (int) var acceleration = 10000
export (int) var drag_friction = 500
export (PackedScene) var SplashAttackScene

export (float) var carve_threshold = 150.0


var velocity = Vector2.ZERO
var is_carving = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():	
	pass # Replace with function body.
func _physics_process(delta):
	get_move_input(delta)
	velocity = move_and_slide(velocity)
	checking_for_collision()
	
	
func get_move_input(delta):
	var input_y = 0.0
	if Input.is_action_pressed("move_down"):
		input_y += 1
	if Input.is_action_pressed("move_up"):
		input_y -= 1
	check_for_carve(input_y)
	var target_velocity_y = input_y * max_speed
	if input_y != 0:
		velocity.y = move_toward(velocity.y, target_velocity_y, acceleration * delta)
	else:
		velocity.y = move_toward(velocity.y, 0, drag_friction * delta)
func check_for_carve(input_y):
	# 카빙 조건 정의
	var input_is_opposite = input_y != 0 and sign(input_y) != sign(velocity.y) and sign(velocity.y) != 0
	var is_moving_fast_enough = abs(velocity.y) > carve_threshold
	
	# [수정] 카빙 조건을 만족 '그리고' 현재 카빙 상태가 아닐 때
	if input_is_opposite and is_moving_fast_enough and not is_carving:
		# '사건' 발생!
		spawn_splash_attack()
		# '상태' 변경: 카빙이 시작됐으니 스위치를 내립니다.
		is_carving = true
	
	# [수정] 카빙 조건이 깨졌을 때 (예: 턴이 완료되거나 키를 뗐을 때)
	elif not (input_is_opposite and is_moving_fast_enough):
		# '상태' 리셋: 스위치를 다시 올려서 다음 카빙을 준비합니다.
		is_carving = false	
func spawn_splash_attack():
	#rint("Yeah!")
	if SplashAttackScene == null:
		print("error: SplashAttackScene is not assinged")
		return
	var splash = SplashAttackScene.instance()
	
	get_parent().add_child(splash)
	splash.global_position = self.global_position
	
	splash.get_node("Timer").start()
func damaged(taked_damage):
	print("oh!")
func checking_for_collision():
	var collision_count = get_slide_count()
	
	if collision_count > 0:
		for i in range(collision_count):
			var collision = get_slide_collision(i)
			if collision.collider.is_in_group("enemy"):
				damaged(0)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
