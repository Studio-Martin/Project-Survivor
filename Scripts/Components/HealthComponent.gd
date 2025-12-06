extends Node
class_name HealthComponent

@export var maxHealth : int = 5

signal died

@onready var health : int = maxHealth

func take_damage(attack : Attack) -> void:
	
	print(owner.name, " take ", attack.damageAmout, " damage")
	
	health -= attack.damageAmout
	
	if health <= 0:
		
		died.emit()
		owner.queue_free()

func heal(amount : int) -> void:
	
	if health < maxHealth:
		
		health += amount
