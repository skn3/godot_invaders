extends PlayerBullet
class_name PlayerBulletBasic

var speed = 0.0;

func _physics_process(delta):
	position -= transform.y * speed * delta
