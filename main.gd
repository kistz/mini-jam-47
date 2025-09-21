extends Control


@onready
var start_button:Button = $Button

func _ready() -> void:
	start_button.pressed.connect(on_start_pressed)
	if GM.global.best_time != 5000.0:
		$Label3.text = "Best time: " + str(GM.global.best_time).pad_decimals(3)


func on_start_pressed():
	get_tree().change_scene_to_file("res://Floor1.tscn")
