extends CharacterBody2D

#varaiveis do player
var speed = 300
var accel = 10
var can_dodge = true
var is_alive = true

#var spawn da bala
var bullet_speed = 1000
var bullet = preload("res://bullet_test.tscn")

# var da barra de vida
@onready var healthbar = $HealthBar
var health

func _ready():
	health = 10
	healthbar.init_health(health)

func fire():
	var bullet_instance = bullet.instantiate()
	bullet_instance.position = get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.linear_velocity = Vector2(bullet_speed,0).rotated(rotation)
	get_tree().get_root().call_deferred("add_child",bullet_instance)


func _physics_process(delta):
	
	player_moviment()
	
	look_at(get_global_mouse_position())
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

func _die():
	get_tree().reload_current_scene()

#func para tomar dano...
func _set_health(health):
	#_set_health(value)
	print("set leath ativo")
	print(health)
	if health <= 0 && is_alive:
		_die()

	healthbar.health = health
	

func _on_hurt_box_body_entered(body):
	if "TesteBoss" in body.name:
		#_die()
		#print("dano 1")
		#print(health)
		health -= 1
		_set_health(health)

