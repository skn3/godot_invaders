extends Node2D

#collision layers:
#1 walls
#2 player
#3 alien groups
#4 aliens
#5 player bullets
#6 alien bullets

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				var alien = preload("res://alien.tscn").instantiate();
				$AlienGroup.add_child(alien);
				alien.position = alien.to_local(event.position);
				$AlienGroup.addAlien(alien);
