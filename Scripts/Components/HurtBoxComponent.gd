extends Area2D
class_name HurtBoxComponent

@export var Health : HealthComponent

func _ready():
	
	area_entered.connect(_on_area_entered)
	
func _on_area_entered(area : Area2D):
	
	if area is HitBoxComponent and area.owner != owner and not area.owner.is_in_group("Ennemy"):
		
		Health.take_damage(area.attack)
