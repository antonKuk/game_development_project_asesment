extends MarginContainer

const first_scene = preload("res://scenes/world.tscn")


var current_selection = 0
onready var selector_one = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Selector
onready var selector_two = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Selector


func _ready():
	set_current_selection(0)

func _process(_delta):
	if Input.is_action_just_pressed("ui_down"):
		current_selection = 1
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("ui_up"):
		current_selection = 0
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("ui_accept"):
		handle_selection(current_selection)
	

func handle_selection(_current_selection):
	if _current_selection == 0:
		get_parent().add_child(first_scene.instance())
		queue_free()
	elif _current_selection == 1:
		get_tree().quit()


func set_current_selection(_current_selection):
	selector_one.text = " "
	selector_two.text = " "
	if current_selection == 0:
		selector_one.text = ">"
	elif current_selection == 1:
		selector_two.text = ">"
