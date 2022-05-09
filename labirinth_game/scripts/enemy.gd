extends KinematicBody2D

var movement = Vector2.ZERO
var speed = 10
var hp = 100
onready var hp_bar = get_node("HPBar")
onready var player = get_parent().get_node("player")
onready var progress_bar = get_parent().get_node("player/Camera2D/ProgressBar")
var player_in_range
var player_in_sight
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("drone_move")
	
func _physics_process(delta):
	SightCheck()
	
#	movement = Vector2.ZERO
#		$AnimatedSprite.play("drone_attack")
#		movement = position.direction_to(player.position) * speed
#
#		#setting sprite left or right direction with movement
#		if movement.x < 0:
#			$AnimatedSprite.flip_h = true
#		elif movement.x > 0: 
#			$AnimatedSprite.flip_h = false
#	else:
#		$AnimatedSprite.play("drone_move")

#	movement = movement.normalized()
#	movement = move_and_collide(movement)

#function checks if there is a player in enemy's sight (and range)
func SightCheck():
	if hp > 0:
		if player_in_range == true:
			var space_state = get_world_2d().direct_space_state
			var sight_check = space_state.intersect_ray(position, player.position, [self], collision_mask)
			if sight_check.collider.name == "player":
				$AnimatedSprite.play("drone_attack")
				player.energy -= 0.08	
				progress_bar.set_value(player.energy)		
			else:
				player_in_sight = false
				$AnimatedSprite.play("drone_move")
			
func OnHit(damage):
	hp -= damage
	hp_bar.value = hp
	if hp <= 0:
		OnDeath()
		
func OnDeath():
	get_node("CollisionShape2D").set_deferred("disabled", true)
	hp_bar.hide()
	get_node("AnimatedSprite").play("drone_death")

#signal for player entering enemy's area
func _on_Area2D_body_entered(body):
	if body == player:
		player_in_range = true
			
#signal for player exiting enemy's area
func _on_Area2D_body_exited(body):
	if body == player:
		player_in_range = false
