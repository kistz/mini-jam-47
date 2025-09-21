extends Control



func _ready() -> void:
	$VBoxContainer/HBoxContainer3/Button.pressed.connect(retry)
	$VBoxContainer/HBoxContainer3/Button2.pressed.connect(exit)
	$VBoxContainer/HBoxContainer/Label3.text = str(GM.egg_count)
	$VBoxContainer/HBoxContainer2/Label2.text = str(GM.run_time).pad_decimals(3)
	GM.dino_egg=false
	GM.kinder_egg=false
	GM.faberge_egg=false
	GM.ostrich_egg =false
	GM.chicken_egg=false
	GM.police_alerted=false
	GM.run_time =0.0
	GM.time_left= 66.6
	GM.egg_count=0


func retry():
	get_tree().change_scene_to_file("res://Floor1.tscn")
	
func exit():
	get_tree().change_scene_to_file("res://main.tscn")
