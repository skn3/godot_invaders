extends Area2D

var speed = 0.0;

func _on_animation_animation_finished(anim_name):
	get_parent().remove_child(self);
