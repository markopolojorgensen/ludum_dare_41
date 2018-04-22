extends Node2D

var enabled = false

var max_tower_count = 3

var current_tower_type

var tower_scenes = {
	global.TOWER_TYPE.SHOOTER: preload("res://diagetics/tower/tower.tscn"),
	global.TOWER_TYPE.AOE_SLOW: preload("res://diagetics/tower/tower_aoe_slow.tscn"),
	global.TOWER_TYPE.AMP: preload("res://diagetics/tower/tower_amp.tscn"),
}

var tower_lists = {
	global.TOWER_TYPE.SHOOTER: [],
	global.TOWER_TYPE.AOE_SLOW: [],
	global.TOWER_TYPE.AMP: [],
}

func _ready():
	enabled = true #LUL
	add_to_group("tower_selection_listeners")

func _unhandled_input(event):
	if enabled and event.is_action_pressed("place_tower"):
		place_tower()

func place_tower():
	var inst = tower_scenes[current_tower_type].instance()
	inst.set_global_position(get_global_mouse_position())
	get_parent().get_parent().add_child(inst)
	
	tower_lists[current_tower_type].append(inst)
	if tower_lists[current_tower_type].size() > max_tower_count:
		tower_lists[current_tower_type].pop_front().queue_free()
	

func enable():
	enabled = true

func disable():
	enabled = false

func tower_selected(type):
	current_tower_type = type
