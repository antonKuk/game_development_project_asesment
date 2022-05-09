extends StaticBody2D

var player_is_shot_at = false
var hp = 100
onready var hp_bar = get_node("HPBar2")
onready var player = get_parent().get_node("player")
var damage = 25
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("AnimatedSprite").play("stationary")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func OnHit(_damage):
	hp -= _damage
	hp_bar.value = hp
	print(hp)
	if hp <= 0:
		OnDeath()
		
func OnDeath():
	get_node("CollisionShape2D").set_deferred("disabled", true)
	hp_bar.hide()
	get_node("AnimatedSprite").play("grave")

#signal for player entering enemy's area
func _on_Area2D_body_exited(body):
	if body.get_name() == "player":
		if hp > 0:
			player_is_shot_at = false
			$AnimatedSprite.play("stationary")


func _on_Area2D_body_entered(body):
	if body.get_name() == "player":
		if hp <= 0:
			OnDeath()
		else:
			player_is_shot_at = true
			$AnimatedSprite.play("shooting")
		
