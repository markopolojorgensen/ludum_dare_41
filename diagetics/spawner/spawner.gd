extends Node2D

export(bool) var flip = false
export(float) var spawn_rate = 2.2

var enemy_scene = preload("res://diagetics/enemy/enemy.tscn")
var maximum_enemies = 200

var active_cores = 0

func _ready():
	$spawn_interval.connect("timeout", self, "spawn")
	add_to_group("core_listeners")
	update_interval()
	$Sprite.set_flip_h(flip)

func spawn():
	if global.enemy_count >= maximum_enemies:
		return
	
	var inst = enemy_scene.instance()
	inst.set_global_position(get_global_position())
	if flip:
		inst.flip()
	get_parent().add_child(inst)

func core_activated(core_name):
	active_cores += 1
	update_interval()

func core_deactivated(core_name):
	active_cores -= 1
	update_interval()

func update_interval():
	var new_interval = spawn_rate * pow(0.9, active_cores)
	# print("new spawn interval: " + str(new_interval))
	$spawn_interval.set_wait_time(new_interval)


