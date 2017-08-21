extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var cloud = preload("res://objs/cloud.tscn");
func _ready():
	set_process(true);
	for i in range(30):
		var inst = cloud.instance();
		add_child(inst);
		inst.set_pos(Vector2(rand_range(-2000,2000), rand_range(-100,-50)*10));
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func _process(delta):
	if(!randi()%100):
		create_cloud();
	pass

func create_cloud():
	var inst = cloud.instance();
	get_parent().add_child(inst);
	inst.set_pos(Vector2(2500, rand_range(-100,-50)*10));