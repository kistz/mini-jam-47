extends CharacterBody2D


const speed= 50.0

@onready
var animation = $AnimatedSprite2D


func _ready() -> void:
	animation.play("idle")


func _process(delta: float) -> void:
	if Input.is_action_pressed("up"):
		move_and_collide(Vector2(0,-speed) * delta)
	if Input.is_action_pressed("down"):
		move_and_collide(Vector2(0,speed) * delta)
	if Input.is_action_pressed("left"):
		move_and_collide(Vector2(-speed,0)* delta) 
		animation.flip_h = true
	if Input.is_action_pressed("right"):
		animation.flip_h = false
		move_and_collide(Vector2(speed,0)* delta)
