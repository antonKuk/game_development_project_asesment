extends Area2D
var energy = 100

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_battery3_body_entered(body):
	if body.name == "player":
		get_tree().queue_delete(self)
		var player = get_parent().get_node("player")
		player.energy = 100
		get_parent().get_node("player/Camera2D/ProgressBar").set_value(100)
		

