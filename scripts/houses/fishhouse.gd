extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var text = preload("res://objs/popUpText.tscn");
var timer;
var power = 1;
var hasworker = false;
func _enter_tree():
	# Called every time the node is added to the scene.
	# Initialization here
	
	pass

func build():
	get_parent().add_to_group("factory");
	
	if(get_node("../base").onSand): power += 2;
	timer = Timer.new();
	timer.set_one_shot(false);
	timer.start();
	timer.connect("timeout", self, "timeout");
	timer.set_wait_time(5);
	add_child(timer);
	
	hasworker = Globals.get("world").trysetjob();
	
	var tx = text.instance();
	tx.set_text("+" + str(power*hasworker) + " food/h");
	add_child(tx);
	
func timeout():
	if(!hasworker): hasworker = Globals.get("world").trysetjob();
	
	if(!hasworker): return;
	var timeaffect = 0;
	if(Globals.get("world").hours < 6 || Globals.get("world").hours > 21): timeaffect = -2;
	if(power + timeaffect <= 0): return;
	Globals.get("world").food += power + timeaffect;
	var tx = text.instance();
	tx.set_text("+" + str(power + timeaffect) + " food");
	add_child(tx);