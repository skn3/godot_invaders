extends PlayerBullet
class_name PlayerBulletBeam

var speed = 0.0;
var active = true;

#godot events
func _physics_process(delta):
	updateDetectWall();

#events
func _on_animation_finished(anim_name):
	active = false;

	#stop particles emitting
	$WallParticles.emitting = false;
	
	#disable child nodes
	remove_child($Shape);
	remove_child($Graphics);
	

#api
func updateDetectWall():
	if active and $DetectWall.is_colliding():
		var point = $DetectWall.get_collision_point();
		var size = global_position.y - point.y;
		
		#scale the graphics on y so that it hits the wall
		$Graphics.scale = Vector2($Graphics.scale.x, size);
		
		#modify the collision shape
		$Shape.position.y = -size/2;
		$Shape.shape.size.y = size;
		
		#move the wall particles to the hit location
		if point.y < 0.0:
			$WallParticles.emitting = false;
		else:
			$WallParticles.emitting = true;
			$WallParticles.position = point - global_position;
		
