extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var radius;
var mouseOnSelf = false;
func _ready():
	radius = get_node("../body/shape").get_shape().get_radius();
	set_process_input(true);
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func _input( ev ):
	if(ev.type == InputEvent.MOUSE_MOTION):
		if(!mouseOnSelf && (get_global_mouse_pos() - get_global_pos()).length() < radius):
			Globals.set("selected_planet", self);
			mouseOnSelf = true;
		elif(mouseOnSelf && (get_global_mouse_pos() - get_global_pos()).length() > radius):
			Globals.set("selected_planet", null);
			mouseOnSelf = false;