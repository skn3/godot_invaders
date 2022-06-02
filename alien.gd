@tool
extends Node2D
class_name Alien

const PlayerBullet = preload("res://player_bullet.gd");

var group:AlienGroup

#events
func _ready():
	pass

func _process(delta):
	pass
	
func _on_alien_area_entered(area):
	if area.is_in_group("player_bullet"):
		#destroy bullet
		if area.destroyOnContact:
			area.get_parent().remove_child(area);
		
		#detroy alien
		group.removeAlien(self);
		

#api
func getBounds(offset:Vector2) -> Rect2:
	#override this method for different alien types
	var radius = $Shape.shape.radius;
	return Rect2(offset.x-radius, offset.y-radius, radius*2, radius*2);

