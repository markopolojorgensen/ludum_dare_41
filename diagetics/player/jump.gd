extends Node2D

var jump_impulse = 50
var enabled = true

func do_jump(body, state):
	if enabled and (Input.is_action_pressed("ui_accept") or Input.is_action_pressed("move_up")):
		body.apply_impulse(Vector2(), Vector2(0, -jump_impulse))

func disable():
	enabled = false

