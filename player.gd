extends CharacterBody2D
class_name Player

const speed= 50.0

var has_egg = false

@onready
var egg_slot = $backpack_egg

@onready
var animation = $AnimatedSprite2D

@onready
var respawn_anim = $AnimationPlayer

@onready
var respwaning: bool = true

@onready
var start_position = global_position

const empty_slot:int= 250

func _ready() -> void:
	animation.play("idle")
	respawn_anim.animation_finished.connect(func(_d): respwaning =false)
	respawn_anim.play("respawn")
	egg_slot.frame=empty_slot
	GM.set_player(self)


func _process(delta: float) -> void:
	if respwaning:
		return
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


# Egg Type comes from egg script enum but cant share the type sadly
func picked_up_egg(egg_type: GM.EggType):
	has_egg=true
	egg_slot.frame= egg_type
	print("egg")


#successfully delivered egg.
func give_egg():
	has_egg= false
	GM.delivered_egg(egg_slot.frame)
	egg_slot.frame= empty_slot

func drop_egg():
	has_egg=false
	var egg=load("res://objects/egg.tscn").instantiate()
	egg.egg = egg_slot.frame
	egg.global_position=global_position
	egg_slot.frame= empty_slot
	get_parent().add_child(egg)

func respawn():
	respwaning=true
	visible=false
	if has_egg:
		drop_egg()
	
	global_position=start_position
	await get_tree().create_timer(1, false, false, true).timeout
	respawn_anim.play("respawn")
	visible=true
