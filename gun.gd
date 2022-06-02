@tool
extends Node2D
class_name Gun

@export var attachToPlayer = false;
@export var playerAnimation = "";
@export var reloadTime = 0.2;
@export var bulletSpeed = 0;
@export var automatic = false;
@export var bulletScene:PackedScene = null;
@export var pointRefs: Array[NodePath] = [];

#api
func fire() -> void:
	for pointRef in pointRefs:
		var point = get_node(pointRef);
		
		#create instance of bullet
		var bullet = bulletScene.instantiate();
		bullet.speed = bulletSpeed;
		
		if attachToPlayer:
			#attach to player
			bullet.transform = point.transform;
			add_child(bullet);
			
		else:
			#attach to scene
			bullet.transform = point.global_transform;
			get_tree().get_root().add_child(bullet);
