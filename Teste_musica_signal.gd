extends CharacterBody2D

var speed = 300
var accel = 100
var motion = Vector2()
var stun = false

@onready var healthbar = $HealthBar
var health
var is_alive = true

func _ready():
	health = 10
# on_dead = die
	healthbar.init_health(health)

func _physics_process(delta):
	
	if stun:
		velocity = lerp(velocity, Vector2.ZERO, 0.3)
		return
	
	var Player = get_parent().get_node("Player")
	position += (Player.position - position) / 50
	look_at(Player.position)
	
	move_and_collide(motion)
	
	#_shoot()
	#boss_moviment()
	#move_and_slide()

#func boss_moviment():
	#var direction = Input.get_vector("b_left", "b_right", "b_up", "b_down").normalized()
	#
	#if direction:
		#velocity.x = move_toward(velocity.x ,direction.x * speed, accel)
		#velocity.y = move_toward(velocity.y, direction.y * speed, accel)
	#else:
		#velocity.x = move_toward(velocity.x, 0, accel)
		#velocity.y = move_toward(velocity.y, 0, accel)

#func _shoot():
	#if Input.is_action_just_released("boss_shoot"):
		#
		#print("today is fwiday in carifornia")
		#await get_tree().create_timer(5.0).timeout
		#print("shoot")

func _die():
	queue_free()


#func para tomar dano...
func _set_health(health):
	#_set_health(value)
	print("set leath ativo")
	print(health)
	if health <= 0 && is_alive:
		_die()
	healthbar.health = health

func _on_area_2d_body_entered(body):
	if body.is_in_group("Bullets"):
		stun = true
		$Stun.start()
		body.queue_free()
		health -= 1
		_set_health(health)


func _on_stun_timeout():
	stun = false
