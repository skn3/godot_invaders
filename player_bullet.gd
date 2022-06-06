extends Node2D
class_name PlayerBullet

@export var damage = 1.0;
@export var life = 0.0;

#godot events
func _ready():
	pass;

func _process(delta):
	pass;

#events
func _on_shape_entered_area(area):
	#wall, ignore wall collisions if life is lower then 0
	#this allows for bullets that dont destroy
	if life > 0.0 and area.is_in_group("wall"):
			get_parent().remove_child(self);
