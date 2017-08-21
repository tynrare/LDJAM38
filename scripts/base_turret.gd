extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var bullet = preload("res://objs/bullet.tscn");
var lockedTarget;
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true);
	var timer = Timer.new()
	timer.set_wait_time(0.3);
	timer.connect("timeout",self,"timer_expired");
	timer.start();
	add_child(timer);
	pass

func _process(delta):
	
	pass;
	
func timer_expired():

	var mindist = 65535;
	
	for b in get_tree().get_nodes_in_group("in_planet_zone"):
		var newdist = (b.get_global_pos() - get_global_pos()).length();
		if(newdist < mindist):
				mindist = newdist;
				lockedTarget = b;
	if(lockedTarget && !weakref(lockedTarget).get_ref()): lockedTarget = null;
	
	if(lockedTarget && mindist != 65535):
		var inst = bullet.instance();
		Globals.get("world").add_child(inst);
		inst.set_global_pos(get_global_pos());
		inst.set_linear_velocity((lockedTarget.get_global_pos() - get_global_pos()).normalized()*3000);