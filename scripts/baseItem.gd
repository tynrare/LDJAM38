extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var lastMousePos;
var startPos = null;
export var house = preload("res://objs/house.tscn");
export(int, "rand", "basehouse", "fishhouse", "plant", "sawmill", "mine") var exptype = 0;
var houseInst = null;

var houseType = 0;
func _ready():
	if(!exptype): houseType = randi()%5;
	else: houseType = exptype - 1;
	updateCostInfo();
	set_process(true);
	lastMousePos = get_global_pos();
	var image = house.instance();
	image.setType(houseType);
	image.set_scale(Vector2(2,2));
	image.set_draw_behind_parent(true);
	add_child(image);
	image.remove_child(image.get_node("allow_build"));
	# Called every time the node is added to the scene.
	# Initialization here
	pass

var mouseEntered = false;
var mouseHolded = false;
var planeted = false;

func _process(delta):
	if(planeted): processAsInGame(delta);
	else: processAsUI(delta);

func updateCostInfo():
	if(houseType == 0):
		get_node("costInfo").set_text("House\ncost: \n 20 wood");
	if(houseType == 1):
		get_node("costInfo").set_text("Fishhouse\ncost: \n 30 wood 10 stone");
	if(houseType == 2):
		get_node("costInfo").set_text("Field\ncost: \n 10 wood");
	if(houseType == 3):
		get_node("costInfo").set_text("Sawmill\ncost: \n 15 wood 15 stone");
	if(houseType == 4):
		get_node("costInfo").set_text("Mine\ncost: \n 20 wood 5 stone");

func payBuildConst():
	var w = Globals.get("world");
	if(houseType == 0):
		w.wood -= 20;
	if(houseType == 1):
		w.wood -= 30;
		w.stone -= 10;
	if(houseType == 2):
		w.wood -= 10;
	if(houseType == 3):
		w.wood -= 15;
		w.stone -= 15;
	if(houseType == 4):
		w.wood -= 20;
		w.stone -= 5;
		
func checkBuildCost():
	var w = Globals.get("world");
	if(houseType == 0):
		if(w.wood >= 20): return true
	if(houseType == 1):
		if(w.wood >= 30 && w.stone >= 10): return true
	if(houseType == 2):
		if(w.wood >= 10): return true
	if(houseType == 3):
		if(w.wood >= 15 && w.stone >= 15): return true
	if(houseType == 4):
		if(w.wood >= 20 && w.stone >= 5): return true
		
	return false;

func processAsUI(delta):
	var newscale;
	if(mouseEntered):
		newscale = lerp(get_scale().x, 1.7, 0.07);
		if(mouseHolded):
			set_global_pos(Vector2(lerp(get_global_pos().x, lastMousePos.x, 0.6), lerp(get_global_pos().y, lastMousePos.y, 0.6)));
			set_opacity(lerp(0.1, get_opacity(), 0.6));
			houseInst.set_opacity(lerp(1, houseInst.get_opacity(), 0.6));
			houseInst.set_pos(houseInst.get_global_mouse_pos());
			houseInst.set_z(clamp((houseInst.get_pos().y-200)/2, 0, 100));
	else:
		newscale = lerp(get_scale().x, 1, 0.3);
		set_opacity(lerp(1, get_opacity(), 0.3));
	set_scale(Vector2(newscale,newscale));
	
	if(!mouseHolded && startPos != null):
			set_pos(Vector2(lerp(get_pos().x, startPos.x, 0.2), lerp(get_pos().y, startPos.y, 0.2)));
	pass;
	
func processAsInGame(delta):
	var newscale = lerp(get_scale().x, 0.5, 0.3);
	set_scale(Vector2(newscale,newscale));
	if(get_scale().x > 0.6):
		set_rotation(get_rotation()+rand_range(5,10));
	pass;

func _on_Control_mouse_enter():
	mouseEntered = checkBuildCost();
	houseInst = house.instance();
	houseInst.setType(houseType);
	Globals.get("world").get_node("tree").add_child(houseInst);
	houseInst.set_global_pos(Globals.get("world").get_node("tree").get_global_mouse_pos());
	houseInst.set_opacity(0);
	pass # replace with function body


func _on_Control_mouse_exit():
	mouseEntered = false;
	if(houseInst):
		Globals.get("world").get_node("tree").remove_child(houseInst);
	pass # replace with function body


func _on_Control_input_event( ev ):
	if(planeted): return;
	if (ev.type == InputEvent.MOUSE_BUTTON):
		if(ev.button_index == BUTTON_LEFT && ev.is_pressed()):
			if(startPos == null):
				startPos = get_pos();
			mouseHolded = true;
			lastMousePos = ev.global_pos;
		elif(ev.button_index == BUTTON_LEFT):
			mouseHolded = false;
			mouseEntered = false;
			if(houseInst && houseInst.allow_build):
				houseInst.build();
				houseInst = null;
				payBuildConst();
				#get_parent().remove_child(self);

	if (ev.type == InputEvent.MOUSE_MOTION && mouseHolded):
		lastMousePos = ev.global_pos;
	pass # replace with function body
