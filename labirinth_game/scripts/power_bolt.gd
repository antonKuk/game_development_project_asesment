extends RigidBody2D

var projectile_speed = 1000
var life_time = 3
var damage = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	apply_impulse(Vector2(), Vector2(projectile_speed, 0).rotated(rotation))
	SelfDestruct()
	
#function for cleaning power_bolts out
func SelfDestruct():
	yield(get_tree().create_timer(life_time),"timeout")
	queue_free()
 

#function called when bolt hit something
func _on_power_bolt_body_entered(body):
#	if power bolt hits enemy it lowers energy it's level
	if body.is_in_group("enemies"):
		get_node("CollisionShape2D").set_deferred("disabled", true)
		body.OnHit(damage)
		self.hide()
