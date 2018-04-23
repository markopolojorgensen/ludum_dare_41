extends TextureButton

func _ready():
	connect("pressed", self, "pressed")

func pressed():
	get_tree().change_scene("res://intro.tscn")

