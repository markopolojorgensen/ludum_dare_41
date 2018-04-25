extends Node

export(bool) var mute = false


var active_cores = 0
var winner = false


func _ready():
	add_to_group("core_listeners")
	$win_gate.connect("body_entered", self, "win_gate_entered")
	
	$fade_layer/CenterContainer.show()
	$fade_layer/AnimationPlayer.play("fadein")
	
	if mute:
		$AudioStreamPlayer.set_volume_db(-50)
		$AudioStreamPlayer2.set_volume_db(-50)
		$AudioStreamPlayer3.set_volume_db(-50)
		$AudioStreamPlayer4.set_volume_db(-50)
		$AudioStreamPlayer5.set_volume_db(-50)
		$AudioStreamPlayer6.set_volume_db(-50)

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func core_activated(core_name):
	active_cores += 1
	update_music()
	
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
	active_cores -= 1
	update_music()
	
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

func update_music():
	if winner:
		return
	
	if active_cores == 1:
		if not $AudioStreamPlayer.is_playing():
			$AudioStreamPlayer.play()
		$AudioStreamPlayer2.stop()
		$AudioStreamPlayer3.stop()
		$AudioStreamPlayer4.stop()
		$AudioStreamPlayer5.stop()
		$AudioStreamPlayer6.stop()
	elif active_cores == 2:
		if not $AudioStreamPlayer2.is_playing():
			$AudioStreamPlayer2.play($AudioStreamPlayer.get_playback_position())
		$AudioStreamPlayer3.stop()
		$AudioStreamPlayer4.stop()
		$AudioStreamPlayer5.stop()
		$AudioStreamPlayer6.stop()
	elif active_cores == 3:
		if not $AudioStreamPlayer3.is_playing():
			$AudioStreamPlayer3.play($AudioStreamPlayer.get_playback_position())
		$AudioStreamPlayer4.stop()
		$AudioStreamPlayer5.stop()
		$AudioStreamPlayer6.stop()
	elif active_cores == 4:
		if not $AudioStreamPlayer4.is_playing():
			$AudioStreamPlayer4.play($AudioStreamPlayer.get_playback_position())
		$AudioStreamPlayer5.stop()
		$AudioStreamPlayer6.stop()
	elif active_cores == 5:
		if not $AudioStreamPlayer5.is_playing():
			$AudioStreamPlayer5.play($AudioStreamPlayer.get_playback_position())
		$AudioStreamPlayer6.stop()
	elif active_cores == 6:
		if not $AudioStreamPlayer6.is_playing():
			$AudioStreamPlayer6.play($AudioStreamPlayer.get_playback_position())

func win_gate_entered(body):
	if body.get_name() == "player":
		winner = true
		$player.lose_control()
		$win_screen.win()
		$HUD.win()




