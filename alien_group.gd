@tool
extends Node2D
class_name AlienGroup

@export var speed = 128.0;
@export var rowHeight = 32;
@export var acceleration = 32.0;

var aliens = [];
var boundsRect:Rect2;
var direction = Vector2(1, 0);
var locked = 0;
var dirtyBounds = true;

#events
func _ready():
	#add all the initial children
	#this allows us to setup a group in the editor!
	lock();
	for child in get_children():
		if child.is_in_group("alien"):
			addAlien(child);
			
	unlock();

func _process(delta):
	pass
	
func _physics_process(delta):
	if not Engine.is_editor_hint():
		position += direction * speed * delta;
		
func _on_alien_group_area_entered(area):
	if area.is_in_group("wall"):
		direction = direction * -1;
		speed += acceleration;
		position.y += rowHeight

#internal
func calculateBounds():
	#calculate teh bounds of all contained aliens
	#then we can move the alien group as a whole, and it will intereact
	#with the game scene edges!
	if locked:
		dirtyBounds = true;
	else:
		dirtyBounds = false;
		
		#calculate all children
		boundsRect = Rect2();
		for alien in aliens:
			if boundsRect.has_no_area():
				boundsRect = alien.getBounds(alien.position);
			else:
				boundsRect = boundsRect.merge(alien.getBounds(alien.position));
			
		#var position = Vector2(boundsRect.position.x+boundsRect.size.x/2, boundsRect.position.y+boundsRect.size.y/2);
		var position = boundsRect.position;
		var size = boundsRect.size;
			
		#apply to collision shape
		$CollisionRect.position = position + size / 2;
		$CollisionRect.shape.size = size;
		
		#apply to editor rect
		$EditorRect.position = position;
		$EditorRect.size = size;
		
#alien events
func _on_alien_destroyed(alien) -> void:
	print("alien destroyed");
	removeAlien(alien);

#api
func lock():
	locked += 1;
	
func unlock():
	locked -= 1;
	
	#are we unlocking?
	if locked == 0:
		#handle dirty flags
		if dirtyBounds:
			calculateBounds();
	
func addAlien(alien):
	#register to here signals from this alien
	alien.connect("alien_destroyed", self._on_alien_destroyed)
	
	#add to lookup
	aliens.append(alien);
	
	#remove from previous parent
	if alien.get_parent() != null:
		alien.get_parent().remove_child(alien);
		
	#attach to this group
	add_child(alien);
	
	#recalculate the bounds of the group
	calculateBounds();

func removeAlien(alien):
	#remove from lookup
	aliens.erase(alien);
	
	#remove from the group
	remove_child(alien);
	
	#recalculate the bounds
	calculateBounds();
