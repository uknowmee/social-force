extends StaticBody2D

func _ready() -> void:
	for child in get_children():
		if child is CollisionPolygon2D:
			var polygon := child as CollisionPolygon2D
			var shape_polygon: Polygon2D = Polygon2D.new()
			shape_polygon.polygon = polygon.polygon
			add_child(shape_polygon)


func _process(_delta: float) -> void:
	pass
