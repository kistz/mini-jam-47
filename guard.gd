extends CharacterBody2D


@export 
var patrol_path: Path2D

func _ready() -> void:
	pass


func _get_configuration_warnings() -> PackedStringArray:
	if patrol_path == null:
		return PackedStringArray(["Pls select a Path"])
	else:
		return PackedStringArray()
