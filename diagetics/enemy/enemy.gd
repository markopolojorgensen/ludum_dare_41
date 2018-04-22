extends RigidBody2D

var max_time = 6
var health = 5

func _ready():
	var new_z_index = (randi() % 5) - 2
	set_z_index(new_z_index)
	$sprite.play("walk")
	global.enemy_count += 1

func _physics_process(delta):
	$movement.do_movement(self, delta)

func wander():
	$wander_timer.set_wait_time(randf() * max_time)
	$wander_timer.start()
	yield($wander_timer, "timeout")
	$movement.stop()
	if health > 0:
		$sprite.play("channel")

func hit_by_bullet():
	# TODO indication of damage
	health -= 1
	if health <= 0:
		die()

func die():
	$CollisionShape2D.set_disabled(true)
	$movement.stop()
	$sprite.play("death")
	$death_timer.start()
	yield($death_timer, "timeout")
	queue_free()
	global.enemy_count -= 1

func is_enemy():
	return true

func slow(amount):
	$movement.slow(amount)

func unslow(amount):
	$movement.unslow(amount)

func is_alive():
	return health > 0

