extends CharacterBody2D

@export var speed : float = 10.0
@export var friction : float = 5.0  # Nouveau paramètre pour le lerp

@export var attack_damage : int = 2

@onready var hit_box_component = $HitBoxComponent
@onready var animation_player = $AnimationPlayer

var target
var target_in_range : bool = false

func _physics_process(delta):
	
	if target:
		
		# Calcule la direction vers la cible
		var direction : Vector2 = (target.global_position - global_position).normalized()
		
			# Flip selon la direction
		if direction.x < 0:
			scale.y = -1
			rotation += 180
		else:
			scale.y = 1
			rotation -= 180
		
		look_at(target.global_position)
		
		velocity = direction * speed
		
	if target_in_range:
		
		# Attaque si en portée
		attack()
		
	else:
		# Pas de cible, ralentit
		velocity = lerp(velocity, Vector2.ZERO, friction * delta)
	
	move_and_slide()

func _on_aggro_range_component_body_entered(body):
	
	if body.is_in_group("Player"):
		target = body as CharacterBody2D
		
	elif body.is_in_group("Ally"):
		target = body

func _on_attack_range_component_body_entered(body):
	if body == target:
		target_in_range = true

func _on_attack_range_component_body_exited(body):
	if body == target:
		target_in_range = false

func attack() -> void:
	
	var current_attack = Attack.new()
	current_attack.damageAmout = attack_damage
	
	hit_box_component.attack = current_attack
	
	animation_player.play("Attack")
	
	await animation_player.animation_finished
	
	hit_box_component.attack = null
	animation_player.play("RESET")
