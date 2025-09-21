extends Node2D


@export
var needs_unlock: bool = false

@export
var required_item: GM.PickupItems = GM.PickupItems.Keycard

@export
var is_horizontal:bool= true

@export
var is_opened: bool = false

enum DoorType {
	Wood,
	Steel,
}

@export
var door_type: DoorType = DoorType.Wood

@onready
var area:Area2D = $area

@onready
var door:Sprite2D= $door

@onready
var popup:Node2D= $popup


var collider: CollisionShape2D 

func _ready() -> void:
	area.body_entered.connect(entity_entered)
	area.body_exited.connect(entity_exited)
	
	if is_horizontal:
		collider = $StaticBody2D/hor_col
		$StaticBody2D/vert_col.set_deferred("disabled",true)
	else:
		collider = $StaticBody2D/vert_col
		$StaticBody2D/hor_col.set_deferred("disabled",true)
	
	set_door(is_opened)



func entity_entered(entity: CharacterBody2D):
	if entity.is_guard() && !is_opened:
		set_door(true)
	if !entity.is_guard() && !is_opened:
		popup.visible = true
		if needs_unlock:
			if !entity.has_unlock(required_item):
				popup.get_node("Label2").text = GM.get_item_text(required_item)
			else:
				popup.get_node("Label2").text = ""
		
func entity_exited(entity: CharacterBody2D):
	if entity.is_guard() && !is_opened:
		set_door(false)
	if !entity.is_guard() && !is_opened:
		popup.visible=false
		collider.set_deferred("disabled",false)
		set_door(false)
		
		
	
func set_door(openend: bool):
	if door_type == DoorType.Wood && is_horizontal:
		if openend:
			door.frame = 44
		else:
			door.frame = 12
	if door_type == DoorType.Wood && !is_horizontal:
		if openend:
			door.frame = 43
		else:
			door.frame = 11
	if door_type == DoorType.Steel && is_horizontal:
		if openend:
			door.frame = 46
		else:
			door.frame = 14
	if door_type == DoorType.Steel && !is_horizontal:
		if openend:
			door.frame = 45
		else:
			door.frame = 13
	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if $popup.visible:
			if needs_unlock && !GM.get_player().has_unlock(required_item):
				print("huh")
				return
			set_door(true)
			collider.set_deferred("disabled",true)
