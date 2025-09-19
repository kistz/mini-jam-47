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

Back 13 0
BackL 12 0
BackR 12 0 flipped
Left 12 1
Right 12 1 flipped
Front 13 2
FrontL 12 2 
FrontR 12 2 flipped

@export
var rotation_freedom:float= 90
@export
var rotation_speed:float =1

func _physics_process(delta: float) -> void:
	rotation = sin(Time.get_ticks_msec() *0.01 * rotation_speed * delta) * rotation_freedom *delta
