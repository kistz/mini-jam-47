extends Area2D


func _ready() -> void:
	body_entered.connect(on_body_entered)
	body_exited.connect(on_player_exited)
	$popup.visible=false
	
	
	
func on_body_entered(player: Player):
	if GM.get_player().has_egg:
		$popup.visible=true

func on_player_exited(_d:Player):
	$popup.visible=false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if $popup.visible && GM.get_player().has_egg:
			GM.get_player().give_egg()
			$popup.visible=false
