extends Node
class_name MeleAttackComponent

@export var HitBox : HitBoxComponent
@export var damage : int = 1
@export var knockback_force : float = 100.0
@export var stun_time : float = 0.5
@export var attack_prep_time : float = 0.6
@export var attack_duration : float = 0.3
@export var attack_cooldown : float = 0.5  # Renommé pour clarté
@export var can_hit_flying : bool = false

var can_attack : bool = true

func attack() -> void:
	if not can_attack:
		return  # Sécurité au cas où appelé plusieurs fois
	
	can_attack = false
	
	var attack = Attack.new()
	attack.damageAmout = damage
	attack.knockback_force = knockback_force
	attack.knockback_position = owner.global_position
	attack.stun_time = stun_time
	attack.can_hit_flying = can_hit_flying
	
	# Phase de préparation
	await get_tree().create_timer(attack_prep_time).timeout
	
	# Active l'attaque
	HitBox.attack = attack
	HitBox.collision_shape.disabled = false
	
	# Durée de l'attaque active
	await get_tree().create_timer(attack_duration).timeout
	
	# Désactive l'attaque
	HitBox.collision_shape.disabled = true
	HitBox.attack = null  # Nettoie l'attaque
	
	# Cooldown avant la prochaine attaque
	await get_tree().create_timer(attack_cooldown).timeout
	
	can_attack = true

#Annule l'attaque en cours
func cancel_attack() -> void:
	if HitBox and HitBox.collision_shape:
		HitBox.collision_shape.disabled = true
		HitBox.attack = null
	can_attack = true
