extends Node2D

var damage = 1
var explode = false

func _ready():
	$area.connect("body_entered", self, "collision")
	$sprite.play("spawn")

func collision(body):
	hit_body(body)
	
	if body.has_method("is_enemy") and body.is_enemy():
		$hit.play()
	else:
		$miss.play()
	
	# don't collide with multiple enemies
	$area/CollisionShape2D.set_disabled(true)
	
	set_linear_velocity(get_linear_velocity() * 0.08)
	if explode:
		$sprite.play("boom")
		$boom.play()
		for body in $boom_area.get_overlapping_bodies():
			hit_body(body)
	else:
		$sprite.play("pop")
	
	$pop_timer.start()
	yield($pop_timer, "timeout")
	
	queue_free()

func hit_body(body):
	if body.has_method("is_enemy") and body.is_enemy():
		body.hit_by_bullet(damage)


