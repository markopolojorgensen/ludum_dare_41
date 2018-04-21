extends Node2D

var impulse_size = 5000
var max_speed = 600

var is_left
var is_right
var is_up
var is_down

func do_movement(body, state):
	is_left = Input.is_action_pressed("ui_left")
	is_right = Input.is_action_pressed("ui_right")
	is_up = Input.is_action_pressed("ui_up")
	is_down = Input.is_action_pressed("ui_down")
	
	# movement
	if is_right:
		body.apply_impulse(Vector2(), Vector2(impulse_size * state.step, 0))
	elif is_left:
		body.apply_impulse(Vector2(), Vector2(-impulse_size * state.step, 0))
	
	if is_down:
		body.apply_impulse(Vector2(), Vector2(0, impulse_size * state.step))
	
	# going too fast
	var lin_vel = state.get_linear_velocity()
	if lin_vel.length() > max_speed:
		# slow down
		var slow_down_impulse = -1 * (lin_vel.length() - max_speed) * lin_vel.normalized()
		body.apply_impulse(Vector2(), slow_down_impulse)
	
	# natural slowdown
	var no_input_pressed = not (is_left or is_right)
	var is_shooting = get_parent().is_shooting()
	if no_input_pressed and not is_shooting:
		var horiz_vector = Vector2(1, 0)
		var slow_down_impulse = -0.4 * lin_vel.dot(horiz_vector) * horiz_vector
		body.apply_impulse(Vector2(), slow_down_impulse)


