extends CharacterBody2D

@export var speed : float = 10.0
@export var friction : float = 5.0  # Nouveau paramètre pour le lerp

@onready var hit_box_component = $HitBoxComponent
@onready var mele_attack_component = $MeleAttackComponent

var target
var target_in_range : bool = false

func _physics_process(delta):
	
	if target and not target_in_range:  # Ne bouge que si pas en portée d'attaque
		
		# Flip selon la direction
		if target.global_position.x < global_position.x:
			scale.x = -1
		else:
			scale.x = 1
		
		# Calcule la direction vers la cible
		var direction = (target.global_position - global_position).normalized()
		velocity = direction * speed
		
	elif target_in_range:
		# Attaque si en portée
		hit_box_component.look_at(target.global_position)
		
		if mele_attack_component.can_attack:
			
			mele_attack_component.attack()
		
		# Ralentit progressivement
		velocity = lerp(velocity, Vector2.ZERO, friction * delta)
		
	else:
		# Pas de cible, ralentit
		velocity = lerp(velocity, Vector2.ZERO, friction * delta)
	
	move_and_slide()

func _on_aggro_range_component_body_entered(body):
	if body.is_in_group("Player"):
		target = body as CharacterBody2D
	elif body.is_in_group("Structure"):
		target = body as StaticBody2D

func _on_attack_range_component_body_entered(body):
	if body == target:
		target_in_range = true

func _on_attack_range_component_body_exited(body):
	if body == target:
		target_in_range = false

func _on_aggro_range_component_body_exited(body):
	if body == target:
		target = null
		target_in_range = false
