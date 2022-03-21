extends Area2D

signal hit

@export var speed = 300
var refractive_index = 1
var t0
var timecount = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	t0 = Time.get_ticks_msec()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2.UP.rotated(rotation) * speed * delta / refractive_index
	timecount += delta

func _on_photon_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print("collision!")
	# refractive index before and after
	var n1 = refractive_index
	var n2 = area.get_parent().refractive_index if n1 == 1 else 1
	print("n1, n2: ", n1, ", ", n2)
		
	# If we hit a wall we are done
	if n2 == INF:
		print((Time.get_ticks_msec() - t0)/float(1000))
		set_process(false)
		return
	
	# We use the "shape" of the edge we collided with to find the angle of the edge
	var segshape = area.shape_owner_get_owner(area.shape_find_owner(area_shape_index)).shape
	
	# We calculate the normal and ray angles in relation to the x-axis:
	# normal_angle is the angle of the normal to the edge we collided with
	var normal_angle = (segshape.b - segshape.a).rotated(area.get_parent().rotation).angle()
	# ray_angle is the angle that the photon is travelling at
	var ray_angle = rotation
	
	# Find the angle of incidence
	var angle_in = fmod(normal_angle - ray_angle - PI/2, PI) + PI - PI/2
	
	print("angle diff: ", rad2deg(angle_in))
	# The angle of refraction according to Snell's law:
	var snell_out = asin(sin(angle_in) * n1 / n2)
	print("snell out: ", rad2deg(snell_out))
	rotation += angle_in - snell_out
	# Set our current refractive_index to the material that we enter
	refractive_index = n2
