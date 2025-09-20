@tool
extends Node2D





@export var egg: GM.EggType = GM.EggType.Faberge:
	set(segg):
		$Sprite2D.frame = segg
		egg= segg

func _ready() -> void:
	$Sprite2D.frame = egg
	$Area2D.body_entered.connect(on_area_entered)
	$Area2D.body_exited.connect(on_area_exited)
	$popup.visible=false

func _process(delta: float) -> void:
	if !Engine.is_editor_hint() &&  Input.is_action_just_pressed("interact"):
		if $popup.visible:
			GM.get_player().picked_up_egg(egg)
			queue_free()
			
	
func on_area_entered(body: Player):
	$popup.visible=true


func on_area_exited(body: Node2D):
	$popup.visible=false
