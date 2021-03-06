extends Node2D

func _ready():
	var zone = get_parent().get_zone()
	zone.connect("body_entered", self, "body_entered")
	zone.connect("body_exited", self, "body_exited")
	$sound.play()

func body_entered(body):
	if body.has_method("get_amped"):
		body.get_amped()

func body_exited(body):
	if body.has_method("get_un_amped"):
		body.get_un_amped()

func _process(delta):
	get_parent().get_zone().set_position(get_parent().get_zone().get_position())

