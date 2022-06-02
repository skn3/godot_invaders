@tool
extends Node2D
class_name Alien

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#api
func getBounds(offset:Vector2) -> Rect2:
	#override this method for different alien types
	var radius = $Shape.shape.radius;
	return Rect2(offset.x-radius, offset.y-radius, radius*2, radius*2);


func _on_alien_area_entered(area):
	pass # Replace with function body.
