extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var allow_build = false;

var basehouseeffect = preload("res://scripts/houses/basehouse.gd");
var fishhouseeffect = preload("res://scripts/houses/fishhouse.gd");
var fieldeffect = preload("res://scripts/houses/field.gd");
var saweffect = preload("res://scripts/houses/sawmill.gd");
var mineeffect = preload("res://scripts/houses/mine.gd");

var basehousebody = preload("res://objs/houses/basehouse.tscn");
var fishhousebody = preload("res://objs/houses/fishhouse.tscn");
var fieldbody = preload("res://objs/houses/field.tscn");
var sawbody = preload("res://objs/houses/sawmill.tscn");
var minebody = preload("res://objs/houses/mine.tscn");

var effectNode = null;
export(int, "basehouse", "fishhouse", "plant", "sawmill", "mine") var type = 0
func build():
	remove_child(get_node("allow_build"));
	#set_z(get_pos().y/10-50);
	set_z(clamp((get_pos().y-200)/2, 0, 100));
	
	get_node("houseeffect").build();
func crush():
	get_node("basehouse").set_modulate(Color(0,0,0));

func _ready():
	var binst;
	if(type == 0):
		binst = basehousebody.instance();
		get_node("houseeffect").set_script(basehouseeffect);
	if(type == 1):
		binst = fishhousebody.instance();
		get_node("houseeffect").set_script(fishhouseeffect);
	if(type == 2):
		binst = fieldbody.instance();
		get_node("houseeffect").set_script(fieldeffect);
	if(type == 3):
		binst = sawbody.instance();
		get_node("houseeffect").set_script(saweffect);
	if(type == 4):
		binst = minebody.instance();
		get_node("houseeffect").set_script(mineeffect);
		
	var b = get_node("base");
	b.add_child(binst);
	
	var coll = CollisionShape2D.new();
	var shape = ConvexPolygonShape2D.new();
	shape.set_points(binst.get_node("CollisionPolygon2D").get_polygon());
	coll.set_shape(shape);
	b.set_pos(binst.get_node("CollisionPolygon2D").get_pos());
	binst.set_pos(-b.get_pos());
	b.add_shape(shape);
	b.add_child(coll);

func setType(t):
	type = t;
	
