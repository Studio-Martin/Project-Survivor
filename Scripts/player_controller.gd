extends Player

@onready var animated_sprite_2d = $AnimatedSprite2D


func _unhandled_input(event):
	
	if event.is_action_pressed("quit"):
		get_tree().quit()
