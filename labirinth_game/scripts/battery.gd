extends Area2D
var energy = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#actions on taking battery
func _on_battery_body_entered(body):
	if body.name == "player":
		get_tree().queue_delete(self)
		var player = get_parent().get_node("player")
		player.energy = 100
		get_parent().get_node("player/Camera2D/ProgressBar").set_value(100)

