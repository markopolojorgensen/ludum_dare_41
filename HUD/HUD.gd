extends CanvasLayer

func _unhandled_input(event):
	if event.is_action_pressed("tower_selection_1"):
		$m_con/vbox_con/tower_selectors/tower_selector_shooter.grab_focus()
		get_tree().call_group("tower_selection_listeners", "tower_selected", global.TOWER_TYPE.SHOOTER)
	elif event.is_action_pressed("tower_selection_2"):
		$m_con/vbox_con/tower_selectors/tower_selector_aoe_slow.grab_focus()
		get_tree().call_group("tower_selection_listeners", "tower_selected", global.TOWER_TYPE.AOE_SLOW)
	elif event.is_action_pressed("tower_selection_3"):
		$m_con/vbox_con/tower_selectors/tower_selector_amp.grab_focus()
		get_tree().call_group("tower_selection_listeners", "tower_selected", global.TOWER_TYPE.AMP)