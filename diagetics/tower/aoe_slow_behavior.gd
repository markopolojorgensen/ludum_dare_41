extends Node2D

var slow_amount = 1

func _ready():
	var zone = get_parent().get_zone()
	zone.connect("body_entered", self, "body_entered")
	zone.connect("body_exited", self, "body_exited")
	$sound.play()

func body_entered(body):
	if body.has_method("is_enemy") and body.is_enemy():
		body.slow(slow_amount)

func body_exited(body):
	if body.has_method("is_enemy") and body.is_enemy():
		body.unslow(slow_amount)

func get_amped():
	slow_amount = 2

func get_un_amped():
	slow_amount = 1
