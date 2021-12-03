extends Node2D

export var word_to_draw: String
export var stroke_color: Color
export var stroke_width: float

onready var view_cont = $WordControl/WordViewportContainer
onready var view = $WordControl/WordViewportContainer/WordViewport
onready var generator = $WordControl/WordViewportContainer/WordViewport/WordGenerator


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_parent(),"ready")
	
	var layer_width = stroke_width + 5
	var layer_quantity = word_to_draw.length()
	
	view_cont.rect_size = 2*Vector2(layer_width * (layer_quantity * 2 + 2.5), layer_width * (layer_quantity * 2 + 2.5))
	view_cont.rect_position = Vector2(-(view_cont.rect_size.x)/2, -(view_cont.rect_size.x)/2)
	view.set_size(view_cont.rect_size)
	
	generator.position = Vector2((view_cont.rect_size.x)/2, (view_cont.rect_size.x)/2)
	generator.word_to_draw = word_to_draw
	generator.stroke_color = stroke_color
	generator.stroke_width = stroke_width

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
