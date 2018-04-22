extends CenterContainer

func _ready():
	unfocused()
	connect("focus_entered", self, "focused")
	connect("focus_exited", self, "unfocused")

func enable():
	$VBoxContainer/cc/symbol.show()

func disable():
	$VBoxContainer/cc/symbol.hide()
	$VBoxContainer/cc/reticle.hide()

func focused():
	$VBoxContainer/cc/reticle.show()

func unfocused():
	$VBoxContainer/cc/reticle.hide()

