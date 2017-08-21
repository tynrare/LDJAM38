extends Camera2D

export var allowV = true;
export var allowH = true;

var mouseHolded = false;
var holdingStart = Vector2(0,0);
func _ready():
	set_process_input(true)
	set_process(true);

func _process(delta):
	if(Input.is_mouse_button_pressed(BUTTON_RIGHT)):
		mouseHolded = true;
	else:
		mouseHolded = false;

func _input( ev ):
	if (ev.type == InputEvent.MOUSE_BUTTON):
		if(ev.button_index == BUTTON_WHEEL_UP && get_zoom().x > 0.4):
			set_zoom(get_zoom()-Vector2(0.1,0.1));
		elif(ev.button_index == BUTTON_WHEEL_DOWN && get_zoom().x < 1.8):
			set_zoom(get_zoom()+Vector2(0.1,0.1));
		elif(ev.button_index == BUTTON_RIGHT && ev.pressed):
			holdingStart = get_global_mouse_pos();
	if(ev.type == InputEvent.MOUSE_MOTION && mouseHolded):
		var newpos = holdingStart - get_local_mouse_pos();
		if(!allowV): newpos.y = get_pos().y;
		if(!allowH): newpos.x = get_pos().x;
		if(newpos.x > -1000 && newpos.x < 1000):
			set_pos(newpos);
	pass # replace with function body
