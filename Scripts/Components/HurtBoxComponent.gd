extends Area2D
class_name HurtBoxComponent

@export var HealthComponent : HealthComponent

func _ready():
	
	area_entered.connect(_on_area_entered)
	
func _on_area_entered(area : Area2D):
	
	if area is HitBoxComponent and get_parent() != area.get_parent():
		
		HealthComponent.take_damage(area.damage)
