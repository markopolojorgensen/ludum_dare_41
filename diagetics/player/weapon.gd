extends Node2D

export(NodePath) var body_path
onready var body = get_node(body_path)

var amp_level = 0

var bullet_scene = preload("res://diagetics/bullet/bullet.tscn")

var enabled = false
var bullet_impulse = 1000

var booms = false

func _ready():
	$firing_interval.connect("timeout", self, "fire_ze_missile")

func _unhandled_input(event):
	if enabled and event.is_action_pressed("fire_weapon"):
		fire_ze_missile()
		$firing_interval.start()
	
	if event.is_action_released("fire_weapon"):
		$firing_interval.stop()

func fire_ze_missile():
	var direction = get_global_mouse_position() - get_global_position()
	var inst = bullet_scene.instance()
	inst.set_global_position(get_global_position())
	get_parent().get_parent().add_child(inst)
	inst.damage = 3
	inst.explode = booms
	inst.apply_impulse(Vector2(), direction.normalized() * bullet_impulse)
	body.apply_impulse(Vector2(), -direction.normalized() * bullet_impulse * 0.5)

func enable():
	enabled = true

func disable():
	enabled = false

func is_shooting():
	return not $firing_interval.is_stopped()

func get_amped():
	amp_level += 1
	update_amp_speed()

func get_un_amped():
	amp_level -= 1
	update_amp_speed()

func update_amp_speed():
	var firing_bonus = 1 * pow(0.80, amp_level)
	# print(firing_bonus)
	$firing_interval.set_wait_time(0.15 * firing_bonus)

func enable_booms():
	booms = true

func disable_booms():
	booms = false




