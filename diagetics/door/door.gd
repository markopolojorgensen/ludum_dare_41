extends Node2D

var active_cores = 0
var required_cores = 1 # 6

func _ready():
	add_to_group("core_listeners")

func core_activated(core_name):
	active_cores += 1
	update_open_status()

func core_deactivated(core_name):
	active_cores -= 1
	update_open_status()

func update_open_status():
	if active_cores >= required_cores:
		$sprite.play("open")
		$StaticBody2D/CollisionShape2D.set_disabled(true)
	else:
		$sprite.play("closed")
		$StaticBody2D/CollisionShape2D.set_disabled(false)


