extends Node2D


@export
var item: GM.PickupItems = GM.PickupItems.Keycard


func _ready() -> void:
	set_item()
	$Area2D.body_entered.connect(on_area_entered)
	$Area2D.body_exited.connect(on_area_exited)
	$popup/Label2.text =  GM.get_item_text(item)
	$popup.visible=false

func _process(delta: float) -> void:
	if !Engine.is_editor_hint() &&  Input.is_action_just_pressed("interact"):
		if $popup.visible:
			GM.get_player().pick_up_item(item)
			queue_free()
			
	
func on_area_entered(body: Player):
	$popup.visible=true


func on_area_exited(body: Node2D):
	$popup.visible=false

func set_item():
	if item == GM.PickupItems.Keycard:
		$Sprite2D.frame=62
	if item == GM.PickupItems.ExhibitionDoor:
		$Sprite2D.frame=30
	
