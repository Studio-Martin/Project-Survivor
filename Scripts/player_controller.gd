extends CharacterBody2D

@export var speed = 300.0

func _physics_process(delta):

	var direction = Input.get_vector("left","right","up","down")
	if direction:
		velocity = direction.normalized() * speed * delta
	else:
		velocity.y = move_toward(velocity.y, 0.0, speed)
		velocity.x = move_toward(velocity.x, 0.0, speed)

	move_and_slide()

func _unhandled_input(event):
	
	if event.is_action_pressed("quit"):
		get_tree().quit()
