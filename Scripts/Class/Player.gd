extends AllyEntities

class_name Player

func _physics_process(delta):

	var direction = Input.get_vector("left","right","up","down")
	if direction:
		velocity = direction.normalized() * speed * delta
		'''animated_sprite_2d.play("Run")
		if direction.x < 0:
			animated_sprite_2d.flip_h = true
		else :
			animated_sprite_2d.flip_h = false'''
	else:
		velocity.y = move_toward(velocity.y, 0.0, speed)
		velocity.x = move_toward(velocity.x, 0.0, speed)
		
		#animated_sprite_2d.play("Idle")

	move_and_slide()
