extends Node2D

var impulse_size = 1000
var default_max_speed = 100
var max_speed = default_max_speed

var slowed_amount = 0

var is_left = true
var is_right = false

func do_movement(body, delta):
	# movement
	if is_right:
		body.apply_impulse(Vector2(), Vector2(impulse_size * delta, 0))
	elif is_left:
		body.apply_impulse(Vector2(), Vector2(-impulse_size * delta, 0))
	
	# going too fast
	var lin_vel = body.get_linear_velocity()
	if lin_vel.length() > max_speed:
		# slow down
		var slow_down_impulse = -1 * (lin_vel.length() - max_speed) * lin_vel.normalized()
		body.apply_impulse(Vector2(), slow_down_impulse)
	
	# natural slowdown
	var no_input_pressed = not (is_left or is_right)
	if no_input_pressed:
		var horiz_vector = Vector2(1, 0)
		var slow_down_impulse = -0.4 * lin_vel.dot(horiz_vector) * horiz_vector
		body.apply_impulse(Vector2(), slow_down_impulse)

func stop():
	is_left = false
	is_right = false

func slow():
	slowed_amount += 1
	max_speed = default_max_speed - (slowed_amount * 20)

func unslow():
	slowed_amount -= 1
	max_speed = default_max_speed - (slowed_amount * 20)

