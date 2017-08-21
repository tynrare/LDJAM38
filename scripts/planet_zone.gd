extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_Area2D_body_enter( body ):
	if(body.is_in_group("enemy")):
		body.add_to_group("in_planet_zone");
	pass # replace with function body


func _on_Area2D_body_exit( body ):
	body.remove_from_group("in_planet_zone");
	pass # replace with function body
