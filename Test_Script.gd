extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var TestWord = preload("res://WordGeneration/Word_Generation.tscn")
export var TestPhrase = "Testando uma frase"
export var stroke_width = 10
export var stroke_color: Color = Color(0.34, 0.07, 0.07, 1)
export var phrase_arrenging : String  = "horizontal"

onready var p_view_cont = $PhraseControl/PhraseViewportContainer
onready var p_view = $PhraseControl/PhraseViewportContainer/PhraseViewport
onready var biggest_word = 0
onready var phrase_length = 0
onready var space_quantity = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	self.owner.get_node("Interface/LineEdit").connect("text_entered", self, "text_entered")


func text_entered(text):
#	for node in p_view.get_children():
	for node in get_children():
		node.free()
	
	biggest_word = 0
	phrase_length = 0
	TestPhrase = text
	
	var PhraseArray = TestPhrase.split(" ")
	
	for word in range(PhraseArray.size()-1, -1, -1):
		if PhraseArray[word].length() < 1:
			PhraseArray.remove(word)
	
	for word in range(PhraseArray.size()):
		var ThisWord = TestWord.instance()
#		p_view.add_child(ThisWord, true)
		add_child(ThisWord, true)
		connect("ready", ThisWord, "_ready")
		
		ThisWord.word_to_draw = PhraseArray[word]
		ThisWord.stroke_color = stroke_color
		ThisWord.stroke_width = stroke_width
	
#	for  word in PhraseArray:
#		if word.length() >  biggest_word:
#			biggest_word = word.length()
#		phrase_length =  phrase_length + word.length()
#	space_quantity = PhraseArray.size() - 1
	
	arrenge_text()
	
	emit_signal("ready")


func arrenge_text():
#	var layer_width = stroke_width + 5
#	var word_center = Vector2(0, 0)
	var word_center = Vector2(0, 0)
	
	if phrase_arrenging == "horizontal":
#		p_view_cont.set_anchors_preset(Control.PRESET_CENTER_LEFT)
#		p_view_cont.rect_size.y = 2 * layer_width * ((biggest_word + 1) * 2 + 2.5)
#		p_view_cont.rect_size.x = ((phrase_length * 4) + ((space_quantity + 1) * 4 ) + space_quantity) * layer_width
#		p_view.set_size(p_view_cont.rect_size)
#		word_center = Vector2(p_view_cont.margin_left, p_view_cont.margin_top + (p_view_cont.margin_bottom - p_view_cont.margin_top)/2)
		word_center = Vector2(0, get_viewport().size.y/2)
		
#		for word in p_view.get_children():
		for word in get_children():
			word.position = word_center + Vector2((word.word_to_draw.length() + 1) * 2 * (stroke_width + 5) + stroke_width , 0)
			word_center = word.position + Vector2((word.word_to_draw.length() + 1) * 2 * (stroke_width + 5), 0)
		
		
