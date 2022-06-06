extends Area2D
class_name Alien

signal alien_destroyed(alien);

@export var health = 1.0;

func _ready():
	pass

func _process(delta):
	pass
	
#events
func _on_shape_entered(area):
	#check for collision with bullet
	if area.is_in_group("player_bullet"):
		#apply damage to the alien
		applyDamage(area.damage);
		
		#destroy bullet
		if area.destroyOnContact:
			area.get_parent().remove_child(area);
		
#api
func destroy():
	#signal that this alien is destroyed
	alien_destroyed.emit(self);
	
func applyDamage(damage:float):
	#reduce health
	health -= damage;
	
	#check if destroyed
	if health <= 0.0:
		destroy();
	
func getBounds(offset:Vector2) -> Rect2:
	#override this method for different alien types
	var radius = $Shape.shape.radius;
	return Rect2(offset.x-radius, offset.y-radius, radius*2, radius*2)
