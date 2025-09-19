extends Node2D


const speed= 50.0

@onready
var animation = $AnimatedSprite2D


func _ready() -> void:
	animation.play("idle")


func _process(delta: float) -> void:
	if Input.is_action_pressed("up"):
		position.y += -speed * delta
	if Input.is_action_pressed("down"):
		position.y += speed * delta
	if Input.is_action_pressed("left"):
		position.x += -speed * delta
		animation.flip_h = true
	if Input.is_action_pressed("right"):
		animation.flip_h = false
		position.x += speed * delta
