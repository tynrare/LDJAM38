extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var text = preload("res://objs/popUpText.tscn");
var space = 3;
var freespace = 3;
var starving = 0;
var starvetime = 0;
func _enter_tree():
	# Called every time the node is added to the scene.
	# Initialization here
	
	pass

func build():
	get_parent().add_to_group("houses");
	
	var timer = Timer.new();
	timer.set_one_shot(false);
	timer.start();
	timer.connect("timeout", self, "timeout");
	timer.set_wait_time(5);
	add_child(timer);
	
	if(get_node("../base").onGrass): space += 2;
	
	Globals.get("world").freeSpace += space;
	freespace = space;
	var tx = text.instance();
	tx.set_text("+" + str(space) + " free space");
	add_child(tx);
	
func timeout():
	var w = Globals.get("world");
	if(w.homeless && freespace):
		var dec;
		if(freespace > w.homeless):
			add_dweller(w.homeless);
		else:
			add_dweller(freespace);
		return;
		
	if(freespace && !starving && !randi()%10 && Globals.get("world").woman && Globals.get("world").man):
		var new = 1;
		
		if(!randi()%100): new = 2;
		
		if(randi()%2): Globals.get("world").man += new;
		else: Globals.get("world").woman += new;

		Globals.get("world").homeless += new;
		if(freespace >= new): add_dweller(new);
		return;
	
	var timeaffect = 0;
	if(Globals.get("world").hours < 12): timeaffect = -4;
	else: timeaffect = 2;
	var totalate = space - freespace + timeaffect;
	if(totalate <= 0 || space - freespace <= 0): return;
	
	if(Globals.get("world").food <= space - freespace):
		if(!starving): 
			Globals.get("world").starving += space - freespace - Globals.get("world").food;
			starving = space - freespace;
		starvetime += 5;
		if(starvetime >= 120 && space - freespace > 0):
			Globals.get("world").killsomeone();
			freespace += 1;
			starving -= 1;
			Globals.get("world").starving -= 1;
		return;
	
	if(Globals.get("world").food < totalate):
		totalate = Globals.get("world").food;
	
	if(starving): 
		Globals.get("world").starving -= starving;
		starving = 0;
	
	if(starvetime > 0): starvetime -= 10;
	
	Globals.get("world").food -= totalate;
	var tx = text.instance();
	tx.set_text("-" + str(totalate) + " food");
	add_child(tx);
	
func add_dweller(d):
	Globals.get("world").freeSpace -= d;
	Globals.get("world").homeless -= d;
	freespace -= d;
	var tx = text.instance();
	tx.set_text("-" + str(d) + " free space");
	add_child(tx);