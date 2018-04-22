extends Node2D

var enabled = false

var max_tower_count = 2
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

var tower_access = {
	global.TOWER_TYPE.SHOOTER: false,
	global.TOWER_TYPE.AOE_SLOW: false,
	global.TOWER_TYPE.AMP: false,
}

func _ready():
	add_to_group("tower_selection_listeners")
	add_to_group("tower_access")
	add_to_group("core_listeners")

func _unhandled_input(event):
	if enabled and event.is_action_pressed("place_tower"):
		place_tower()

func place_tower():
	if current_tower_type == null or not tower_access[current_tower_type]:
		# maybe play a meepmerp
		return
	
	var inst = tower_scenes[current_tower_type].instance()
	inst.set_global_position(get_global_mouse_position())
	get_parent().get_parent().add_child(inst)
	
	tower_lists[current_tower_type].append(inst)
	while tower_lists[current_tower_type].size() > max_tower_count:
		tower_lists[current_tower_type].pop_front().queue_free()

func enable():
	enabled = true

func disable():
	enabled = false

func tower_selected(type):
	current_tower_type = type

func tower_access_granted(tower_type):
	tower_access[tower_type] = true
	enable()

func tower_access_revoked(tower_type):
	# revoke access
	tower_access[tower_type] = false
	
	# delete revoked towers
	for tower in tower_lists[tower_type]:
		tower.queue_free()
	tower_lists[tower_type].clear()
	
	# decide whether to disable or not
	for access in tower_access.values():
		if access == true:
			return
	
	# all false
	disable()

func core_activated(core_name):
	max_tower_count += 1

func core_deactivated(core_name):
	max_tower_count -= 1


