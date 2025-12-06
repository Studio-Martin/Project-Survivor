extends Area2D
class_name HitBoxComponent

var attack : Attack

@onready var collision_shape = $CollisionShape2D

func _ready():
	
	collision_shape.disabled = true
