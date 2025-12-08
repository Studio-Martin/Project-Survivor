extends GroundedEnnemy

class_name Golem

@export var Health : int = 20
@export var Damage: int = 2

var target
var is_target_in_range : bool = false



func _on_attack_range_body_entered(body: Node2D) -> void:#Il faut dire que le joueur est à porté
	is_target_in_range = body == target

func _on_attack_range_body_exited(body: Node2D) -> void:#Il faut dire que le joueur n'est plus à porté
	if body == target:
		is_target_in_range = false

func _on_aggro_range_body_entered(body: Node2D) -> void:
	if body is Player:
		target = body#Quand un joueur est dans la zone d'agro, il devient la cible du golem
