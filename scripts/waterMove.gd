extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var t = 0;
var start_pos;
func _ready():
	start_pos = get_pos();
	t = rand_range(-100, 100)
	set_process(true);
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	t += delta;
	set_pos(start_pos + Vector2(sin(t)*10, cos(t)*10));
