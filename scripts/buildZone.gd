extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var mouse_entered = false;
func _ready():
	Globals.set("buildZone", self);
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func ismouseselected():
	return mouse_entered;
	pass;

func _on_buildZoneArea_mouse_enter():
	pass # replace with function body


func _on_buildZoneArea_mouse_exit():
	pass # replace with function body
