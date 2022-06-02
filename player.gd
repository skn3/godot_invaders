extends Area2D
class_name Player

@export var speed = 200.0;

@onready var guns = [$GunBasic, $GunSplit, $GunWave, $GunBeam];
var gunIndex = 0;

@onready var currentGun = null;
@onready var reloadTimer = $ReloadTimer;
@onready var reloadProgress = $ReloadProgress;
@onready var graphics = $Graphics;

var reloading = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	#set initial gun
	changeGun($GunBasic);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_handleInput(delta);
	
	reloadProgress.progress = 1.0 - ((1.0 / currentGun.reloadTime) * reloadTimer.time_left);
		
#internal
func _handleInput(delta):
	#horizontal movement
	if Input.is_action_pressed("left"):
		position.x -= speed * delta;
		
	elif Input.is_action_pressed("right"):
		position.x += speed * delta;
	
	#fire
	if Input.is_action_pressed("fire") and not reloading:
		fire();
		
	#change weapon
	if Input.is_action_just_pressed("next_weapon"):
		gunIndex += 1;
		if gunIndex >= guns.size():
			gunIndex = 0;
		
		changeGun(guns[gunIndex]);
		
	elif Input.is_action_just_pressed("previous_weapon"):
		gunIndex -= 1;
		if gunIndex < 0:
			gunIndex = guns.size()-1;
		
		changeGun(guns[gunIndex]);
		

#events
func _on_fire_timer_timeout():
	reloading = false;

#intrenal
func changeGun(gun):
	#set current
	currentGun = gun;
	
	#change animation
	graphics.play(currentGun.playerAnimation);
	
	#update index
	for index in guns.size():
		if guns[index] == gun:
			gunIndex = index;
			break;

#api
func fire() -> void:
	#fire the weapon
	currentGun.fire();
	
	#setup reloading
	reloading = true;
	reloadTimer.start(currentGun.reloadTime);

