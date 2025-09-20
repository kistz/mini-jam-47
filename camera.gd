extends Node2D



enum CameraFrames {
	Back= 13,
	BackL= 12,
	#BackR= 12,
	Left =44,
	#Right =44,
	Front =77,
	FrontL =76,
	#FrontR =76,
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
var light: Node2D = $Node2D

@onready
var area: Area2D = $Node2D/Area2D

@onready
var cam: Sprite2D = $Sprite2D

func _ready() -> void:
	var tween= get_tree().create_tween()
	tween.tween_property(light,"rotation",deg_to_rad(rotation_freedom),5.0*rotation_speed).as_relative().set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel(false)
	tween.tween_property(light,"rotation",deg_to_rad(-rotation_freedom),5.0*rotation_speed).as_relative().set_ease(Tween.EASE_IN_OUT)
	tween.set_loops()
	
	area.body_entered.connect(on_player_detected)
	#area.body_entered(on_player_detected)
	
func on_player_detected(player:Player) :
		player.respawn()

func _process(delta: float) -> void:
	if light.global_rotation_degrees > 22.5+90 && light.global_rotation_degrees < 22.5+135:
		cam.frame = CameraFrames.FrontL
		cam.flip_h = false
	elif light.global_rotation_degrees > 22.5+45 && light.global_rotation_degrees < 22.5+90:
		cam.frame = CameraFrames.Front
		cam.flip_h = false
	elif light.global_rotation_degrees > 22.5 && light.global_rotation_degrees < 22.5+45:
		cam.frame = CameraFrames.FrontL
		cam.flip_h = true
	elif light.global_rotation_degrees > -22.5 && light.global_rotation_degrees < 22.5:
		cam.frame = CameraFrames.Left
		cam.flip_h = true
	elif light.global_rotation_degrees > -67.5 && light.global_rotation_degrees < -22.5:
		cam.frame = CameraFrames.BackL
		cam.flip_h = true
	elif light.global_rotation_degrees > -67.5-45  && light.global_rotation_degrees < -67.5:
		cam.frame = CameraFrames.Back
		cam.flip_h = false
	elif light.global_rotation_degrees > -67.5-90  && light.global_rotation_degrees < -67.5-45:
		cam.frame = CameraFrames.BackL
		cam.flip_h = false
	elif light.global_rotation_degrees > -67.5-90  && light.global_rotation_degrees < -67.5-45:
		cam.frame = CameraFrames.Left
		cam.flip_h = false
