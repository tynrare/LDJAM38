extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var text = preload("res://objs/popUpText.tscn");
var timer;
var power = 20;
var workers = 0;
func _enter_tree():
	# Called every time the node is added to the scene.
	# Initialization here
	
	pass

func build():
	get_parent().add_to_group("factory");
	
	if(get_node("../base").onGrass || get_node("../base").onFlat): power += 5;
	timer = Timer.new();
	timer.set_one_shot(false);
	timer.start();
	timer.connect("timeout", self, "timeout");
	timer.set_wait_time(5);
	add_child(timer);
	
	if(workers < 3 && Globals.get("world").trysetjob()): workers += 1;
	
	var tx = text.instance();
	tx.set_text("+" + str(workers*power) + " food/2d");
	add_child(tx);
	
var harvestTime = 0;
func timeout():
	harvestTime += 5;
	if(workers < 3 && Globals.get("world").trysetjob()):
		workers += 1;
		var tx = text.instance();
		tx.set_text("+" + str(workers*power) + " food/2d");
		add_child(tx);
	
	if(!workers || harvestTime < 240): return;
	harvestTime = 0;
	Globals.get("world").food += workers*power;
	var tx = text.instance();
	tx.set_text("+" + str(workers*power) + " food");
	add_child(tx);