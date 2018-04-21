extends Node2D

var jump_impulse = 50

func do_jump(body, state):
	if Input.is_action_pressed("ui_accept") or Input.is_action_pressed("ui_up"):
		body.apply_impulse(Vector2(), Vector2(0, -jump_impulse))

