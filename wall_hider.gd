extends Node2D




func _ready() -> void:
	$RoomArea.body_entered.connect(player_entered)
	$RoomArea.body_exited.connect(player_left)
	modulate = Color(1.0,1.0,1.0,1.0)


func player_entered(_d:Node2D):
	modulate = Color(1.0,1.0,1.0,0.1)

func player_left(_d:Node2D):
	modulate = Color(1.0,1.0,1.0,1.0)
