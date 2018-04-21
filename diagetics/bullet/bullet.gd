extends Node2D

func _ready():
	$area.connect("body_entered", self, "collision")
	$sprite.play("spawn")

func collision(body):
	if body.has_method("is_enemy") and body.is_enemy():
		body.hit_by_bullet()
	
	# don't collide with multiple enemies
	$area/CollisionShape2D.set_disabled(true)
	
	set_linear_velocity(get_linear_velocity() * 0.08)
	$sprite.play("pop")
	
	$pop_timer.start()
	yield($pop_timer, "timeout")
	
	queue_free()

