extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var text = preload("res://objs/popUpText.tscn");
var timer;
var power = 10;
var hasworker = false;
func _enter_tree():
	# Called every time the node is added to the scene.
	# Initialization here
	
	pass

func build():
	get_parent().add_to_group("factory");
	
	if(get_node("../base").onCliff): power += 10;
	if(get_node("../base").onSand): power -= 10;
	if(get_node("../base").onFlat): power += 5;
	timer = Timer.new();
	timer.set_one_shot(false);
	timer.start();
	timer.connect("timeout", self, "timeout");
	timer.set_wait_time(5);
	add_child(timer);
	
	hasworker = Globals.get("world").trysetjob();
	
	var tx = text.instance();
	tx.set_text("+" + str(power*hasworker) + " stone/d");
	add_child(tx);
	
var harvestTime = 0;
func timeout():
	harvestTime += 5;
	
	if(!hasworker && Globals.get("world").trysetjob()):
		harvestTime = 0;
		hasworker = true;
		var tx = text.instance();
		tx.set_text("+" + str(power*hasworker) + " stone/d");
		add_child(tx);
		
	if(!hasworker || harvestTime < 120): return;
	
	harvestTime = 0;
	Globals.get("world").stone += power;
	var tx = text.instance();
	tx.set_text("+" + str(power) + " stone");
	add_child(tx);