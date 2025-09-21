extends CharacterBody2D
class_name Player

const speed= 75.0

var has_egg = false

var crounching: bool =false

@onready
var egg_slot = $backpack_egg

@onready
var animation = $AnimatedSprite2D

@onready
var respawn_anim = $AnimationPlayer

var skin:int =1

@onready
var respwaning: bool = true

@onready
var start_position = global_position

var items: Dictionary = Dictionary()

var mission_briefing:bool=true

const empty_slot:int= 250

func _init() -> void:
	GM.set_player(self)

func _ready() -> void:
	play_hide()
	respawn_anim.animation_finished.connect(func(_d): respwaning =false)
	respawn_anim.play("respawn")
	egg_slot.frame=empty_slot


func _process(delta: float) -> void:
	if respwaning:
		return
	if mission_briefing:
		return
	if Input.is_action_pressed("up"):
		run()
		move_and_collide(Vector2(0,-speed) * delta)
	if Input.is_action_pressed("down"):
		run()
		move_and_collide(Vector2(0,speed) * delta)
	if Input.is_action_pressed("left"):
		run()
		move_and_collide(Vector2(-speed,0)* delta) 
		animation.flip_h = true
	if Input.is_action_pressed("right"):
		run()
		animation.flip_h = false
		move_and_collide(Vector2(speed,0)* delta)
	if !Input.is_action_pressed("up") &&!Input.is_action_pressed("down")&&!Input.is_action_pressed("left")&&!Input.is_action_pressed("right"):
		play_hide()
	
func run():
	animation.play("run_"+str(skin))
	crounching=false

func play_hide():
	if !crounching:
		animation.stop()
		animation.play("hide_"+str(skin))
		crounching=true

# Egg Type comes from egg script enum but cant share the type sadly
func picked_up_egg(egg_type: GM.EggType):
	has_egg=true
	egg_slot.frame= egg_type

func is_guard() -> bool:
	return false

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
	skin=(randi()%3)+1
	play_hide()
	
	visible=false
	if has_egg:
		drop_egg()
	
	global_position=start_position
	await get_tree().create_timer(1, false, false, true).timeout
	respawn_anim.play("respawn")
	visible=true


func has_unlock(item: GM.PickupItems) -> bool:
	if items.has(item):
		return true
	return false

func pick_up_item(item: GM.PickupItems):
	items.set(item,true)
