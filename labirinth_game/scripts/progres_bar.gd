extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var prog_bar = ProgressBar.new()
	prog_bar.set_percent_visible(100)
	prog_bar.set_value(90)
	prog_bar.set_size(Vector2(90,21))
	prog_bar.set_position(Vector2(120,120))
	var style = StyleBoxFlat.new()
	style.set_bg_color(Color.greenyellow)
	prog_bar.set("custom_styles/fg", style)
	.add_child(prog_bar)
