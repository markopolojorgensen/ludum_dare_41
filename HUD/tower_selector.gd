extends CenterContainer

var enabled = false

func _ready():
	disable()
	unfocused()
	connect("focus_entered", self, "focused")
	connect("focus_exited", self, "unfocused")

func enable():
	enabled = true
	show()

func disable():
	enabled = false
	hide()
	unfocused()

func focused():
	if enabled:
		$VBoxContainer/cc/reticle.show()

func unfocused():
	$VBoxContainer/cc/reticle.hide()

