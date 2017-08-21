extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var health = 100;
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func apply_damage(dmg):
	health -= dmg;
	if(health <= 0):
		get_parent().queue_free();
