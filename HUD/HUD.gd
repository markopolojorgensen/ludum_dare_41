extends CanvasLayer

export(NodePath) var shooter_path
onready var shooter_widget = get_node(shooter_path)

export(NodePath) var aoe_slow_path
onready var aoe_slow_widget = get_node(aoe_slow_path)

export(NodePath) var amp_path
onready var amp_widget = get_node(amp_path)

func _ready():
	add_to_group("core_shield_value_listeners")
	add_to_group("tower_access")

func _unhandled_input(event):
	if event.is_action_pressed("tower_selection_1"):
		shooter_widget.grab_focus()
		get_tree().call_group("tower_selection_listeners", "tower_selected", global.TOWER_TYPE.SHOOTER)
	elif event.is_action_pressed("tower_selection_2"):
		aoe_slow_widget.grab_focus()
		get_tree().call_group("tower_selection_listeners", "tower_selected", global.TOWER_TYPE.AOE_SLOW)
	elif event.is_action_pressed("tower_selection_3"):
		amp_widget.grab_focus()
		get_tree().call_group("tower_selection_listeners", "tower_selected", global.TOWER_TYPE.AMP)

func core_shield_value_update(core_number, new_value):
	if core_number == 0:
		breakpoint
	get_node("m_con2/vbox_con/core_shield_widget" + str(core_number)).set_value(new_value)
	

func tower_access_granted(tower_type):
	if tower_type == global.TOWER_TYPE.SHOOTER:
		shooter_widget.enable()
	elif tower_type == global.TOWER_TYPE.AOE_SLOW:
		aoe_slow_widget.enable()
	elif tower_type == global.TOWER_TYPE.AMP:
		amp_widget.enable()
	else:
		print("TSNH: HUD: tower access granted: weird tower type: " + str(tower_type))

func tower_access_revoked(tower_type):
	if tower_type == global.TOWER_TYPE.SHOOTER:
		shooter_widget.disable()
	elif tower_type == global.TOWER_TYPE.AOE_SLOW:
		aoe_slow_widget.disable()
	elif tower_type == global.TOWER_TYPE.AMP:
		amp_widget.disable()
	else:
		print("TSNH: HUD: tower access granted: weird tower type: " + str(tower_type))

func win():
	$AnimationPlayer.play("fade_out")

