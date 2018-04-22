extends HBoxContainer

export(int) var core_number = 0

func _ready():
	$number.set_text(str(core_number))
	hide()

func set_value(new_value):
	show()
	$shield_health.set_value(new_value)

