extends Node2D

var impulse_size = 1000
var default_max_speed = 120
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
	
	var horiz_vector = Vector2(1, 0)
	var horiz_component = body.get_linear_velocity().dot(horiz_vector) * horiz_vector
	
	# going too fast
	if horiz_component.length() > max_speed:
		# slow down
		var slow_down_impulse = -1 * (horiz_component.length() - max_speed) * horiz_component.normalized()
		body.apply_impulse(Vector2(), slow_down_impulse)
	
	# natural slowdown
	var no_input_pressed = not (is_left or is_right)
	if no_input_pressed:
		var slow_down_impulse = -0.4 * horiz_component
		body.apply_impulse(Vector2(), slow_down_impulse)

func stop():
	is_left = false
	is_right = false

func slow(amount):
	slowed_amount += amount
	max_speed = default_max_speed - (slowed_amount * 20)

func unslow(amount):
	slowed_amount -= amount
	max_speed = default_max_speed - (slowed_amount * 20)

