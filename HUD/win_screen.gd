extends CanvasLayer

func _ready():
	$CenterContainer.hide()

func win():
	$CenterContainer.show()
	$AnimationPlayer.play("fade in win screen")
	
