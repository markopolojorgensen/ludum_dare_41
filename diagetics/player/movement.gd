extends Node2D

var impulse_size = 5000
var max_speed = 600

var is_left
var is_right
var is_up
var is_down

var enabled = true

func do_movement(body, state):
	update_inputs()
	enforce_max_speed(body, state)
	natural_slowdown(body, state)
	
	if enabled:
		apply_movement(body, state)

func update_inputs():
	is_left = Input.is_action_pressed("move_left")
	is_right = Input.is_action_pressed("move_right")
	is_up = Input.is_action_pressed("move_up")
	is_down = Input.is_action_pressed("move_down")

func enforce_max_speed(body, state):
	# going too fast
	var lin_vel = state.get_linear_velocity()
	if lin_vel.length() > max_speed:
		# slow down
		var slow_down_impulse = -1 * (lin_vel.length() - max_speed) * lin_vel.normalized()
		body.apply_impulse(Vector2(), slow_down_impulse)

func natural_slowdown(body, state):
	# natural slowdown
	var no_input_pressed = not (is_left or is_right)
	var is_shooting = get_parent().is_shooting()
	if no_input_pressed:
		var lin_vel = state.get_linear_velocity()
		var horiz_vector = Vector2(1, 0)
		var slow_down_impulse = -1 * lin_vel.dot(horiz_vector) * horiz_vector
		
		if is_shooting:
			# don't gimp kickback
			slow_down_impulse *= 0.1
		else:
			slow_down_impulse *= 0.4
		
		body.apply_impulse(Vector2(), slow_down_impulse)

func apply_movement(body, state):
	if is_right:
		body.apply_impulse(Vector2(), Vector2(impulse_size * state.step, 0))
	elif is_left:
		body.apply_impulse(Vector2(), Vector2(-impulse_size * state.step, 0))
	
	if is_down and not Input.is_action_pressed("jump"):
		body.apply_impulse(Vector2(), Vector2(0, impulse_size * state.step))

func speed_up():
	max_speed += 200

func slow_down():
	max_speed -= 200

func disable():
	enabled = false

