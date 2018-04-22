extends Node

func _ready():
	add_to_group("core_listeners")

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func core_activated(core_name):
	if core_name == "weapon":
		$player.enable_shooting()
	


