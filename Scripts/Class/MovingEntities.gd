extends CharacterBody2D

class_name MovingEntities

var health : int
var speed := 300.0
var maxHealth := 100

func takeDamage(amount : int):
	self.health -= amount
	print(owner.name, " take ",amount, "damage")
	if self.health <= 0 :
		owner.queue_free()
		print(owner.name, " died")
	
func Heal(amount : int):
	if self.maxHealth > self.health : 
		self.health += amount
		print(owner.name , "has received ", amount)
	if self.health > self.maxHealth :#On veut que la vie ne dépasse pas la vie max
		self.health = self.maxHealth
	
