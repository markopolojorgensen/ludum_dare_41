extends CenterContainer

func _ready():
	$intro_timer.connect("timeout", self, "exit_intro")
	$fade_timer.connect("timeout", self, "unblur")
	
	$AnimationPlayer.play("fade in")

func unblur():
	$Control/AnimatedSprite.play()

func exit_intro():
	get_tree().change_scene("res://game.tscn")

