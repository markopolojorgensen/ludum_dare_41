extends Node2D

var enabled = false

var max_tower_count = 3

enum TOWER_TYPE {
	SHOOTER,
	AOE_SLOW,
	AMP,
}

var tower_scenes = {
	SHOOTER: preload("res://diagetics/tower/tower.tscn"),
	AOE_SLOW: preload("res://diagetics/tower/tower_aoe_slow.tscn"),
}

var tower_lists = {
	SHOOTER: [],
	AOE_SLOW: [],
	AMP: [],
}

func _ready():
	enabled = true #LUL

func _unhandled_input(event):
	if enabled and event.is_action_pressed("place_tower"):
		place_tower()

func place_tower():
	var tower_type = get_current_tower()
	var inst = tower_scenes[tower_type].instance()
	inst.set_global_position(get_global_mouse_position())
	get_parent().get_parent().add_child(inst)
	
	tower_lists[tower_type].append(inst)
	if tower_lists[tower_type].size() > max_tower_count:
		tower_lists[tower_type].pop_front().queue_free()
	

func get_current_tower():
	return AOE_SLOW

func enable():
	enabled = true

func disable():
	enabled = false
