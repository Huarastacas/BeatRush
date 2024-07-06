extends CharacterBody2D

#varaiveis do player
var speed = 300
var accel = 10
var can_dodge = true

#var spawn da bala
var bullet_speed = 1000
var bullet = preload("res://bullet_test.tscn")


func fire():
	var bullet_instance = bullet.instantiate()
	bullet_instance.position = get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.linear_velocity = Vector2(bullet_speed,0).rotated(rotation)
	#bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed,0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child",bullet_instance)


func _physics_process(delta):
	player_moviment()
	move_and_slide()

func player_moviment():
	
	look_at(get_global_mouse_position())
	
	var direction = Input.get_vector("left", "right", "up", "down").normalized()
	
	if direction:
		velocity.x = move_toward(velocity.x ,direction.x * speed, accel)
		velocity.y = move_toward(velocity.y, direction.y * speed, accel)
	else:
		velocity.x = move_toward(velocity.x, 0, accel)
		velocity.y = move_toward(velocity.y, 0, accel)
	
	if Input.is_action_pressed("dodge") and can_dodge:
		velocity.x = speed * 2 * direction.x
		velocity.y = speed * 2 * direction.y
		can_dodge = false
		$DodgeTimer.start(1)
		
	if Input.is_action_just_pressed("shoot"):
		fire()

func _on_dodge_timer_timeout():
	can_dodge = true
	velocity.x = 0
	velocity.y = 0
	$DodgeTimer.stop()
	
	


