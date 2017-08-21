extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var buildZone;

var bad_contacts = 0;
var good_contacts = 0;

var onSand = 0;
var onGrass = 0;
var onFlat = 0;
var onCliff = 0;
func _ready():
	buildZone = Globals.get("buildZone");
	update_color();

	# Called every time the node is added to the scene.
	# Initialization here
	pass

func update_color():
	if(!get_node("../allow_build")): return;
	if(!bad_contacts && good_contacts):
		get_node("../allow_build").set_modulate(Color(0,255,0));
		get_parent().allow_build = true;
	else:
		get_node("../allow_build").set_modulate(Color(255,0,0));
		get_parent().allow_build = false;
		
func _on_base_area_enter_shape( area_id, area, area_shape, self_shape ):
	if(buildZone == area):
		if(area_shape >= buildZone.get_node("air").get_collision_object_first_shape() && area_shape <= buildZone.get_node("air").get_collision_object_last_shape()): 
			bad_contacts += 1;
		else: good_contacts += 1;
		
		if(area_shape >= buildZone.get_node("sand").get_collision_object_first_shape() && area_shape <= buildZone.get_node("sand").get_collision_object_last_shape()): 
			onSand += 1;
		elif(area_shape >= buildZone.get_node("grass").get_collision_object_first_shape() && area_shape <= buildZone.get_node("grass").get_collision_object_last_shape()): 
			onGrass += 1;
		elif(area_shape >= buildZone.get_node("flat").get_collision_object_first_shape() && area_shape <= buildZone.get_node("flat").get_collision_object_last_shape()): 
			onFlat += 1;
		elif(area_shape >= buildZone.get_node("cliff").get_collision_object_first_shape() && area_shape <= buildZone.get_node("cliff").get_collision_object_last_shape()): 
			onCliff += 1;
		update_color();
	else:
		bad_contacts += 1;
	pass # replace with function body


func _on_base_area_exit_shape( area_id, area, area_shape, self_shape ):
	if(buildZone == area):
		if(area_shape >= buildZone.get_node("air").get_collision_object_first_shape() && area_shape <= buildZone.get_node("air").get_collision_object_last_shape()): 
			bad_contacts -= 1;
		else: good_contacts -= 1;
		
		if(area_shape >= buildZone.get_node("sand").get_collision_object_first_shape() && area_shape <= buildZone.get_node("sand").get_collision_object_last_shape()): 
			onSand -= 1;
		elif(area_shape >= buildZone.get_node("grass").get_collision_object_first_shape() && area_shape <= buildZone.get_node("grass").get_collision_object_last_shape()):
			onGrass -= 1;
		elif(area_shape >= buildZone.get_node("flat").get_collision_object_first_shape() && area_shape <= buildZone.get_node("flat").get_collision_object_last_shape()): 
			onFlat -= 1;
		elif(area_shape >= buildZone.get_node("cliff").get_collision_object_first_shape() && area_shape <= buildZone.get_node("cliff").get_collision_object_last_shape()): 
			onCliff -= 1;
		update_color();
	else:
		bad_contacts -= 1;
	pass # replace with function body
