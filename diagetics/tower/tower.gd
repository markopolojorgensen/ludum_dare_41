extends Node2D

func get_zone():
	return $zone

func get_amped():
	if $behavior.has_method("get_amped"):
		$behavior.get_amped()

func get_un_amped():
	if $behavior.has_method("get_un_amped"):
		$behavior.get_un_amped()

