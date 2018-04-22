extends Node

func _ready():
	add_to_group("core_listeners")

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func core_activated(core_name):
	if core_name == "weapon":
		$player.enable_shooting()
	elif core_name == "shooter":
		get_tree().call_group("tower_access", "tower_access_granted", global.TOWER_TYPE.SHOOTER)
	elif core_name == "speed":
		$player.speed_up()
	elif core_name == "amp":
		get_tree().call_group("tower_access", "tower_access_granted", global.TOWER_TYPE.AMP)
	elif core_name == "aoe_slow":
		get_tree().call_group("tower_access", "tower_access_granted", global.TOWER_TYPE.AOE_SLOW)
	elif core_name == "blast":
		$player.enable_booms()
		global.booms = true
	else:
		print("new core: " + str(core_name))
	

func core_deactivated(core_name):
	if core_name == "weapon":
		$player.disable_shooting()
	elif core_name == "shooter":
		get_tree().call_group("tower_access", "tower_access_revoked", global.TOWER_TYPE.SHOOTER)
	elif core_name == "speed":
		$player.slow_down()
	elif core_name == "amp":
		get_tree().call_group("tower_access", "tower_access_revoked", global.TOWER_TYPE.AMP)
	elif core_name == "aoe_slow":
		get_tree().call_group("tower_access", "tower_access_revoked", global.TOWER_TYPE.AOE_SLOW)
	elif core_name == "blast":
		$player.disable_booms()
		global.booms = false
	else:
		print("new core: " + str(core_name))
	


# get_tree().call_group("tower_access", "tower_access_granted", SHOOTER)
# get_tree().call_group("tower_access", "tower_access_revoked", SHOOTER)
