extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_bullet_body_enter( body ):
	if(body.is_in_group("enemy")):
		body.get_node("health").apply_damage(10);
		queue_free();
	pass # replace with function body
