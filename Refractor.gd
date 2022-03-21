extends Area2D

@export var refractive_index = 1.55

# Called when the node enters the scene tree for the first time.
func _ready():
	var poly = self.shape_owner_get_owner(self.shape_find_owner(0)).get_polygon()
	for i in range(poly.size()):
		var new_area = Area2D.new()
		var new_coll = CollisionShape2D.new()
		var shape = SegmentShape2D.new()
		shape.a = poly[i]
		shape.b = poly[(i + 1) % poly.size()]
		new_coll.shape = shape
		new_area.add_child(new_coll)
		add_child(new_area)
	
func _draw():
	var poly = self.shape_owner_get_owner(self.shape_find_owner(0)).get_polygon()
	for i in range(poly.size()):
		draw_line(poly[i], poly[(i + 1) % poly.size()], Color(255, 0, 0))
