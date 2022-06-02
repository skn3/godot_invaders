extends Node2D
class_name PlayerBullet

@export var destroyOnContact = true;

#events
func _ready():
	pass;

func _process(delta):
	pass;


func _on_player_bullet_area_entered(area):
	if area.is_class("Wall"):
		get_parent().remove_child(self);
