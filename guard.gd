extends CharacterBody2D


var patrolling_speed: float = 10
var sprinting_speed: float= 15

@export 
var patrol_path: Curve2D

@onready
var follow:PathFollow2D=$Path2D/PathFollow2D

enum GuardMode {
	Patrolling,
	Chasing
}


var guard_mode: GuardMode = GuardMode.Patrolling

func _ready() -> void:
	$Path2D.curve=patrol_path
	$AnimatedSprite2D.play("walking")
	pass


func _get_configuration_warnings() -> PackedStringArray:
	if patrol_path == null:
		return PackedStringArray(["Pls select a Path"])
	else:
		return PackedStringArray()
		
func _process(delta: float) -> void:
	var old_pos= follow.position
	follow.progress += patrolling_speed * delta
	var new_pos = follow.position
	
	if old_pos.x > new_pos.x:
		$AnimatedSprite2D.flip_h =true
	else:
		$AnimatedSprite2D.flip_h =false
	
	position=$Path2D/PathFollow2D.position
