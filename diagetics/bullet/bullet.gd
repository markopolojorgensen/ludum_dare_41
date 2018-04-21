extends Node2D

func _ready():
	$area.connect("body_entered", self, "collision")
	$sprite.play("spawn")

func collision(body):
	set_linear_velocity(get_linear_velocity() * 0.08)
	$sprite.play("pop")
	
	$pop_timer.start()
	yield($pop_timer, "timeout")
	
	queue_free()

