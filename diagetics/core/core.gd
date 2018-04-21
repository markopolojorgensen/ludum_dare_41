extends Node2D

export(String) var core_name = "weapon"

var is_charging = false
var is_activated = false

var charge_rate = 25
var uncharge_rate = 0.1

var enemies = 0

func _ready():
	$shield.set_value(0)
	$zone.connect("body_entered", self, "body_entered")
	$zone.connect("body_exited", self, "body_exited")

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
		print("enemy exited")
		enemies -= 1

func _process(delta):
	if is_charging:
		$shield.value += charge_rate * delta
		if $shield.value >= $shield.max_value and not is_activated:
			get_tree().call_group("core_listeners", "core_activated", core_name)
	
	$shield.value -= uncharge_rate * enemies * delta


