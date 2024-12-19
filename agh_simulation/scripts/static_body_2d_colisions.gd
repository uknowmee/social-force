extends StaticBody2D

func _ready() -> void:
	for child in get_children():
		if child is Polygon2D:
			var polygon := child as Polygon2D
			var collision_polygon: CollisionPolygon2D = CollisionPolygon2D.new()
			collision_polygon.polygon = polygon.polygon
			add_child(collision_polygon)


func _process(_delta: float) -> void:
	pass
