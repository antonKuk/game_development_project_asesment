extends Area2D
 
#
#func _on_Exit_area_entered(area):
#	get_tree().change_scene("res://scenes/YouWon.tscn")
#	queue_free()


func _on_Exit_body_entered(body):
	if body.get_name() == "player":
		get_tree().change_scene("res://scenes/YouWon.tscn")
		queue_free()
