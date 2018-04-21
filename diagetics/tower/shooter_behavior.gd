extends Node2D

var bullet_scene = preload("res://diagetics/bullet/bullet.tscn")

var tower
var target = null
var bullet_impulse = 1000

func _ready():
	tower = get_parent()
	$firing_interval.connect("timeout", self, "shoot_at_target")

func _process(delta):
	if target == null or !target.get_ref():
		find_new_target()

func find_new_target():
	for body in tower.get_zone().get_overlapping_bodies():
		if body.has_method("is_enemy") and body.is_enemy():
			target = weakref(body)
			shoot_at_target()
			$firing_interval.start()

func shoot_at_target():
	if target == null or !target.get_ref():
		$firing_interval.stop()
		return
	
	var direction = target.get_ref().get_global_position() - get_global_position()
	var inst = bullet_scene.instance()
	inst.set_global_position(get_global_position())
	get_parent().get_parent().add_child(inst)
	inst.apply_impulse(Vector2(), direction.normalized() * bullet_impulse)
