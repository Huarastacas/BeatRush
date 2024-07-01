extends CharacterBody2D

var speed = 300
var accel = 10

var can_dodge = true

func _physics_process(delta):
	player_moviment()
	move_and_slide()

func player_moviment():
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if direction:
		velocity.x = move_toward(velocity.x ,direction.x * speed, accel)
		velocity.y = move_toward(velocity.y, direction.y * speed, accel)
	else:
		velocity.x = move_toward(velocity.x, 0, accel)
		velocity.y = move_toward(velocity.y, 0, accel)
	
	if Input.is_action_pressed("ui_accept") and can_dodge:
		velocity.x = speed * 2 * direction.x
		velocity.y = speed * 2 * direction.y
		can_dodge = false
		$DodgeTimer.start(1)

func _on_dodge_timer_timeout():
	can_dodge = true
	velocity.x = 0
	velocity.y = 0
	$DodgeTimer.stop()

