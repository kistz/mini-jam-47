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

func _ready() -> void:
	area.body_entered.connect(entity_entered)
	area.body_exited.connect(entity_exited)
	
	set_door(is_opened)



func entity_entered(entity: CharacterBody2D):
	if entity.is_guard() && !is_opened:
		set_door(true)
	if !entity.is_guard() && !is_opened:
		if needs_unlock:
			if entity.has_unlock(required_item):
				popup.visible = true
		else:
			popup.visible = true
		
func entity_exited(entity: CharacterBody2D):
	if entity.is_guard() && !is_opened:
		set_door(false)
	if !entity.is_guard() && !is_opened:
		popup.visible=false
		set_door(false)
		
		
	
func set_door(openend: bool):
	if door_type == DoorType.Wood:
		if openend:
			door.frame = 44
		else:
			door.frame = 12
	
	

func _process(delta: float) -> void:
	if  Input.is_action_just_pressed("interact"):
		if $popup.visible:
			set_door(true)
