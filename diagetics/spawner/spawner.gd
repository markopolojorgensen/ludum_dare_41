extends Node2D

var enemy_scene = preload("res://diagetics/enemy/enemy.tscn")
var maximum_enemies = 200

var active_cores = 0

func _ready():
	$spawn_interval.connect("timeout", self, "spawn")
	add_to_group("core_listeners")
	update_interval()

func spawn():
	if global.enemy_count >= maximum_enemies:
		return
	
	# for i in range(10):
	var inst = enemy_scene.instance()
	inst.set_global_position(get_global_position())
	get_parent().add_child(inst)
	# $spawn_interval.stop()

func core_activated(core_name):
	print("what")
	active_cores += 1
	update_interval()

func core_deactivated(core_name):
	print("wat")
	active_cores -= 1
	update_interval()

func update_interval():
	var new_interval = 2.2 - (0.15 * active_cores)
	print("new spawn interval: " + str(new_interval))
	$spawn_interval.set_wait_time(new_interval)


