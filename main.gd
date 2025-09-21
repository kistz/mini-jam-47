extends Control


@onready
var start_button:Button = $Button

func _ready() -> void:
	start_button.pressed.connect(on_start_pressed)


func on_start_pressed():
	get_tree().change_scene_to_file("res://Floor1.tscn")
