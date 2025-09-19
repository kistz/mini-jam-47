extends Node2D



enum CameraFrames {
	Back= 13,
	BackL= 12,
	BackR= 12,
	Left =44,
	Right =44,
	Front =77,
	FrontL =76,
	FrontR =76,
}

#Back 13 0
#BackL 12 0
#BackR 12 0 flipped
#Left 12 1
#Right 12 1 flipped
#Front 13 2
#FrontL 12 2 
#FrontR 12 2 flipped

@export
var rotation_freedom:float= 90
@export
var rotation_speed:float =1

@onready
var start_rot=rotation

func _ready() -> void:
	var tween= get_tree().create_tween()
	rotation= deg_to_rad(-rotation_freedom/2)
	tween.tween_property($PointLight2D,"rotation",deg_to_rad(rotation_freedom),5.0*rotation_speed).as_relative().set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel(false)
	tween.tween_property($PointLight2D,"rotation",deg_to_rad(-rotation_freedom),5.0*rotation_speed).as_relative().set_ease(Tween.EASE_IN_OUT)
	tween.set_loops()
	
	

func _process(delta: float) -> void:
	if global_rotation_degrees < -22.5 && global_rotation_degrees > 22.5:
		$Sprite2D.frame = CameraFrames.Front
		$Sprite2D.h_flip = false
	if global_rotation_degrees < -67.5 && global_rotation_degrees > -22.5:
		$Sprite2D.frame = CameraFrames.FrontL
		$Sprite2D.h_flip = false
	if global_rotation_degrees < -67.5-45  && global_rotation_degrees > -67.5:
		$Sprite2D.frame = CameraFrames.Left
		$Sprite2D.h_flip = false
	if global_rotation_degrees < -67.5-90  && global_rotation_degrees > -67.5-45:
		$Sprite2D.frame = CameraFrames.BackL
		$Sprite2D.h_flip = false
	if global_rotation_degrees < -67.5-90  && global_rotation_degrees > -67.5-45:
		$Sprite2D.frame = CameraFrames.Back
		$Sprite2D.h_flip = false
