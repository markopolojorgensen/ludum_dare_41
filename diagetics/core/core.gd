extends Node2D

export(String) var core_name = "weapon"
export(NodePath) var help_text_label_path
export(String) var help_text = "Left click to shoot."
export(int) var core_number = 0

var is_charging = false
var is_activated = false

var charge_rate = 25
var uncharge_rate = 0.1

var enemies = 0

var debug = false

func _ready():
	if debug:
		# speed mode :D
		charge_rate = 100
		uncharge_rate = 1
	
	$shield.set_value(0)
	$zone.connect("body_entered", self, "body_entered")
	$zone.connect("body_exited", self, "body_exited")
	$label_z/VBoxContainer/Label.set_text(str(core_number))

func body_entered(body):
	if body.get_name() == "player":
		is_charging = true
		$sprite.play("shine")
	elif body.has_method("is_enemy") and body.is_enemy():
		body.wander()
		enemies += 1

func body_exited(body):
	if body.get_name() == "player":
		is_charging = false
		$sprite.play("default")
	elif body.has_method("is_enemy") and body.is_enemy():
		enemies -= 1

func _process(delta):
	var old_shield = $shield.value
	
	if is_charging:
		$shield.value += charge_rate * delta
		if $shield.value >= $shield.max_value and not is_activated:
			is_activated = true
			get_tree().call_group("core_listeners", "core_activated", core_name)
			get_node(help_text_label_path).set_text(help_text)
	
	$shield.value -= uncharge_rate * enemies * delta
	if $shield.value <= 0 and old_shield > 0 and is_activated:
		is_activated = false
		get_tree().call_group("core_listeners", "core_deactivated", core_name)
		get_node(help_text_label_path).set_text("")
	
	if old_shield != $shield.value:
		get_tree().call_group("core_shield_value_listeners", "core_shield_value_update", core_number, $shield.value)


