extends RigidBody2D

func _ready():
	$sprite.play("idle")

func _process(delta):
	if get_linear_velocity().x > 0.1:
		$sprite.play("right")
	elif get_linear_velocity().x < -0.1:
		$sprite.play("left")
	else:
		$sprite.play("idle")

func _integrate_forces(state):
	$movement.do_movement(self, state)
	$jump.do_jump(self, state)

func enable_shooting():
	$weapon.enable()

func disable_shooting():
	$weapon.disable()

func enable_booms():
	$weapon.enable_booms()

func disable_booms():
	$weapon.disable_booms()

func is_shooting():
	return $weapon.is_shooting()

func get_amped():
	$weapon.get_amped()

func get_un_amped():
	$weapon.get_un_amped()

func speed_up():
	$movement.speed_up()

func slow_down():
	$movement.slow_down()



