extends Node2D

var enemy_scene = preload("res://diagetics/enemy/enemy.tscn")

func _ready():
	$spawn_interval.connect("timeout", self, "spawn")

func spawn():
	# for i in range(10):
	var inst = enemy_scene.instance()
	inst.set_global_position(get_global_position())
	get_parent().add_child(inst)
	# $spawn_interval.stop()

