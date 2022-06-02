extends PlayerBullet
class_name PlayerBulletPlasma

var speed = 0.0;

func _physics_process(delta):
	position -= transform.y * speed * delta

func _on_Bullet_body_entered(body):
	pass;
	#if body.is_in_group("mobs"):
	#    body.queue_free()
	#queue_free()


func _on_exited_screen():
	get_parent().remove_child(self);
