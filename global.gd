extends Node

enum TOWER_TYPE {
	SHOOTER,
	AOE_SLOW,
	AMP,
}

var enemy_count = 0

var booms = false

func reset():
	enemy_count = 0
	booms = false

