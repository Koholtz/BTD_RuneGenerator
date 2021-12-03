extends Node2D

export var word_to_draw: String = '.'
export var stroke_color: Color = Color(0, 0, 0, 1)
export var stroke_width: float = 10
onready var node_center  = Vector2(0, 0)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _draw():
	draw_word(word_to_draw)
	emit_signal("draw")


func draw_word(word: String):
	word = word.to_upper()
	var layer_width = stroke_width + 5
	var layer_quantity = word.length()
	
	stroke_circle(node_center, layer_width * (layer_quantity*2 + 2))
	stroke_circle(node_center, layer_width * (layer_quantity + 1))
	for letra in layer_quantity:
		var layer = layer_quantity - letra
		if word[letra] in "ABCFHILMORST38":
			var radius = 0
			var angle = 0
			var start_angle = 0
			
			if word[letra] in "ABCFHILMORST":
				radius = (layer_quantity + 1 + layer) * layer_width
			elif word[letra] in "38":
				radius = layer * layer_width
			else:
				draw_circle(node_center, layer_width, stroke_color.inverted())
				break
			
			if word[letra] in "AHOR":
				angle = 90
			elif word[letra] in "BILS38":
				angle = 180
			elif word[letra] in "CFMT":
				angle = 270
			else:
				draw_circle(node_center, layer_width, stroke_color.inverted())
				break
			
			if word[letra] in "ABC":
				start_angle = 180
			elif word[letra] in "FHI8":
				start_angle = 270
			elif word[letra] in "LMO":
				start_angle = 0
			elif word[letra] in "RST3":
				start_angle = 90
			else:
				draw_circle(node_center, layer_width, stroke_color.inverted())
				break
			
			stroke_arc(radius, angle, start_angle)
			
		elif word[letra] in "DEJKPQVWXYZ14567":
			var start = node_center
			var end = node_center
			
			if word[letra] in "DE":
				start = start + (Vector2(cos(deg2rad(225)), sin(deg2rad(225))))*(layer_quantity + 1 + layer)*layer_width
			elif word[letra] in "JK":
				start = start + (Vector2(cos(deg2rad(315)), sin(deg2rad(315))))*(layer_quantity + 1 + layer)*layer_width
			elif word[letra] in "PQ":
				start = start + (Vector2(cos(deg2rad(45)), sin(deg2rad(45))))*(layer_quantity + 1 + layer)*layer_width
			elif word[letra] in "VW":
				start = start + (Vector2(cos(deg2rad(135)), sin(deg2rad(135))))*(layer_quantity + 1 + layer)*layer_width
			elif word[letra] in "XYZ1":
				start = start + Vector2(layer * layer_width * (-1), 0)
			elif word[letra] in "4567":
				start = start  + Vector2(layer * layer_width, 0)
			else:
				draw_circle(node_center, layer_width, stroke_color.inverted())
				break
				
			if word[letra] in "X4":
				end = end + (Vector2(cos(deg2rad(225)), sin(deg2rad(225))))*(layer_quantity + 1 + layer)*layer_width
			elif word[letra] in "Y5":
				end = end + (Vector2(cos(deg2rad(315)), sin(deg2rad(315))))*(layer_quantity + 1 + layer)*layer_width
			elif word[letra] in "Z6":
				end = end + (Vector2(cos(deg2rad(45)), sin(deg2rad(45))))*(layer_quantity + 1 + layer)*layer_width
			elif word[letra] in "17":
				end = end + (Vector2(cos(deg2rad(135)), sin(deg2rad(135))))*(layer_quantity + 1 + layer)*layer_width
			elif word[letra] in "DJPV":
				end = end + Vector2(layer * layer_width * (-1), 0)
			elif word[letra] in "EKQW":
				end = end + Vector2(layer * layer_width, 0)
			else:
				draw_circle(node_center, layer_width, stroke_color.inverted())
				break
			
			stroke_line(start, end)
			
		elif word[letra] in "0GNU29":
			var center = node_center
			var radius = layer_width
			
			if word[letra] == "0":
				center = center + Vector2((layer_quantity + 1 + layer)*(-1)*layer_width, 0)
			elif word[letra] == "G":
				center = center + Vector2(0, (layer_quantity + 1 + layer)*(-1)*layer_width)
			elif word[letra] == "N":
				center = center + Vector2((layer_quantity + 1 + layer)*layer_width, 0)
			elif word[letra] == "U":
				center = center + Vector2(0, (layer_quantity + 1 + layer)*layer_width)
			elif word[letra] == "2":
				center = center + Vector2(0, layer*layer_width)
			elif word[letra] == "9":
				center = center + Vector2(0, layer*layer_width*(-1))
			else:
				draw_circle(node_center, layer_width, stroke_color.inverted())
				break
			
			stroke_circle(center, radius)
			
		else:
			draw_circle(node_center, layer_width, stroke_color.inverted())
			break



func stroke_circle(center, radius):
	var nb_of_points = int(radius*0.6)
	if nb_of_points < 32:
		nb_of_points = 32
	var angle_iteration = TAU / nb_of_points
	
	draw_circle(center + Vector2(radius, 0), stroke_width/2, stroke_color)
	for n in range(nb_of_points):
		var width = (stroke_width - (stroke_width/nb_of_points)*n)
		var start = center + Vector2(cos(TAU + angle_iteration*n), sin(TAU + angle_iteration*n))*radius
		var end = center + Vector2(cos(TAU + angle_iteration*(n +1)), sin(TAU + angle_iteration*(n + 1)))*radius
		draw_line(start, end, stroke_color, width, true)

func stroke_arc(radius, angle: float, start_angle : float):
	var nb_of_points = int((radius*0.6)/(360/angle))
	if nb_of_points < 16:
		nb_of_points = 16
	var angle_iteration = deg2rad(angle / nb_of_points)
	start_angle = deg2rad(start_angle)
	
	draw_circle(node_center + Vector2(cos(start_angle), sin(start_angle))* radius, stroke_width/2, stroke_color)
	for n in range(nb_of_points):
		var width = (stroke_width - (stroke_width / nb_of_points)*n)
		var start = node_center + Vector2(cos(start_angle + angle_iteration * n), sin(start_angle + angle_iteration * n)) * radius
		var end = node_center + Vector2(cos(start_angle + angle_iteration * (n + 1)), sin(start_angle + angle_iteration * (n + 1))) * radius
		draw_line(start, end, stroke_color, width, true)

func stroke_line(start: Vector2, end: Vector2):
	var nb_of_points: int = int(start.distance_to(end)/10)
	if nb_of_points < 10:
		nb_of_points = 10
	var path_iteration = (end - start)/(nb_of_points)
	
	draw_circle(start, stroke_width/2, stroke_color)
	for n in range(nb_of_points):
		var width = (stroke_width - (stroke_width/nb_of_points)*n)
		draw_line(start + path_iteration*n, start + path_iteration*(n+1), stroke_color, width, true)
