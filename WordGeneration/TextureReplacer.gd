extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_WordGenerator_draw():
	get_viewport().set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
	# Wait until the frame has finished before getting the texture.
	yield(VisualServer, "frame_post_draw")
	
	var img = get_viewport().get_texture().get_data()
	
	img.flip_y()
	
	var tex = ImageTexture.new()
	tex.create_from_image(img)
	
	texture = img
	
	get_parent().get_node("WordGenerator").visible = false
