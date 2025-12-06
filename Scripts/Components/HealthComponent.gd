extends Node
class_name HealthComponent

@export var maxHealth : int = 5

signal died

@onready var health : int = maxHealth

func take_damage(damage : int) -> void:
	
	print(get_parent().name, " take ", damage, " damage")
	
	health -= damage
	
	if health <= 0:
		
		died.emit()
		get_parent().queue_free()

func heal(amount : int) -> void:
	
	if health < maxHealth:
		
		health += amount
