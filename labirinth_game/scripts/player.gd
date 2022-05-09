extends KinematicBody2D

export  var speed = 400
var direction: Vector2
var shot = preload("res://scenes/power_bolt.tscn")
var rate_of_fire = 0.4
var can_fire = true
var shooting = false
export var energy = 40
onready var cannon = get_parent().get_node("cannon")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera2D/ProgressBar.set_value(energy)
	$Sprite.play("robot_left")
	
func _process(delta):
	SkillLoop()
	CannonCheck()
	death_check()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
#	taking user's input
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
#	setting sprite left or right direction with movement
	if direction.x < 0:
		$Sprite.flip_h = false
	elif direction.x > 0: 
		$Sprite.flip_h = true
		
#	substructing from energy value while moving
	if direction.x != 0 or direction.y != 0:
		energy = energy - 0.08
		$Camera2D/ProgressBar.set_value(energy)	
				
#	normalising
	if abs(direction.x) == 1 and abs(direction.y) == 1:
		direction = direction.normalized()
		
#	applying movement 
	var motion = direction*speed*delta
	move_and_collide(motion)
		
#function checks if player is dead and finishesd the game
func death_check():
	if energy <= 0:
		$Sprite.play("grave")
		#front_scene.get_node("MarginContainer/VBoxContainer/Label").text = "You are dead"
		get_tree().change_scene("res://scenes/GameOver.tscn")
		queue_free()
	
#checks if cannon is shooting at player and substacts energy if true
func CannonCheck():
	if cannon.player_is_shot_at == true:
		energy = energy - 0.08
		$Camera2D/ProgressBar.set_value(energy)

#function generates a energy ball instance	
func SkillLoop():
	if (Input.is_action_pressed("shoot") and can_fire) == true:
		can_fire = false
		shooting = true
		speed = 0
		get_node("TurnAxis").rotation = get_angle_to(get_global_mouse_position())
		var shot_instance = shot.instance()
		shot_instance.position = get_node("TurnAxis/CastPoint").get_global_position()
		shot_instance.rotation = get_angle_to(get_global_mouse_position())
		get_parent().add_child(shot_instance)
		yield(get_tree().create_timer(rate_of_fire),"timeout")
		can_fire = true
		shooting = false
		speed = 400	
	#	substructing from energy value after each shot
		energy = energy - 1
		$Camera2D/ProgressBar.set_value(energy)
