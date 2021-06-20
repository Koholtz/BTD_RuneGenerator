extends Node2D

export var word_to_draw: String = "."
export var stroke_color: Color = Color(0, 0, 0, 1)
export var stroke_width: float = 10
var center  = Vector2(0, 0)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _draw():
	draw_word(word_to_draw)
	for i in range(10):
		stroke_circle(center + Vector2(100*i,0), 100)



func draw_word(word: String):
	pass

func stroke_circle(center, radius):
	var nb_of_points = int(radius*0.6)
	if nb_of_points < 32:
		nb_of_points = 32
	var angle_iteration = TAU / nb_of_points
	
	for n in range(nb_of_points):
		var width = (stroke_width - (stroke_width/nb_of_points)*n)
		var start = center + Vector2(cos(TAU + angle_iteration*n), sin(TAU + angle_iteration*n))*radius
		var end = center + Vector2(cos(TAU + angle_iteration*(n +1)), sin(TAU + angle_iteration*(n + 1)))*radius
		draw_line(start, end, stroke_color, width, true)

func stroke_arc(radius, angle, start):
	pass

func stroke_line(start: Vector2, end: Vector2):
	var nb_of_points: int = int(start.distance_to(end)/10)
	if nb_of_points < 10:
		nb_of_points = 10
	var path_iteration = (end - start)/(nb_of_points)
	
	for n in range(nb_of_points):
		var width = (stroke_width - (stroke_width/nb_of_points)*n)
		draw_line(start + path_iteration*n, start + path_iteration*(n+1), stroke_color, width, true)
