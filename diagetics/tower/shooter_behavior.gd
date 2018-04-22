extends Node2D

var bullet_scene = preload("res://diagetics/bullet/bullet.tscn")

var tower
var target = null
var bullet_impulse = 1000

var amp_level = 0

var default_fire_interval = 0.75

func _ready():
	tower = get_parent()
	$firing_interval.connect("timeout", self, "shoot_at_target")
	update_amp_speed()
	add_to_group("core_listeners")

func _process(delta):
	if target == null or not target.get_ref() or not target.get_ref().is_alive():
		find_new_target()

func find_new_target():
	var new_enemy = get_random_enemy()
	if new_enemy != null:
		target = weakref(new_enemy)
		shoot_at_target()
		$firing_interval.start()

func get_random_enemy():
	var bodies = tower.get_zone().get_overlapping_bodies()
	if bodies.size() == 0:
		return null
	var body = bodies[randi() % bodies.size()]
	var limit = 5
	while not (body.has_method("is_enemy") and body.is_enemy() and body.is_alive()) and limit > 0:
		body = bodies[randi() % bodies.size()]
		limit -= 1
	
	if limit == 0:
		return null
	else:
		return body

func shoot_at_target():
	if target == null or !target.get_ref():
		$firing_interval.stop()
		return
	
	var direction = target.get_ref().get_global_position() - get_global_position()
	var inst = bullet_scene.instance()
	inst.explode = global.booms
	inst.set_global_position(get_global_position())
	get_parent().get_parent().add_child(inst)
	inst.apply_impulse(Vector2(), direction.normalized() * bullet_impulse)

func get_amped():
	# print("shooter tower got amped")
	amp_level += 1
	update_amp_speed()

func get_un_amped():
	amp_level -= 1
	update_amp_speed()

func update_amp_speed():
	var firing_bonus = 1 * pow(0.85, amp_level)
	# print(firing_bonus)
	$firing_interval.set_wait_time(default_fire_interval * firing_bonus)

