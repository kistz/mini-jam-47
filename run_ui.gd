extends Control






func _ready() -> void:
	GM.collected_egg.connect(collected_egg)
	
	$time_left.visible=false
	

func collected_egg(egg: GM.EggType):
	match egg:
		GM.EggType.Faberge:
			$top_right/VBoxContainer/HBoxContainer5/CheckBox.button_pressed =true
		GM.EggType.Dinosaur:
			$top_right/VBoxContainer/HBoxContainer2/CheckBox.button_pressed =true
		GM.EggType.Kinder:
			$top_right/VBoxContainer/HBoxContainer3/CheckBox.button_pressed =true
		GM.EggType.Ostrich:
			$top_right/VBoxContainer/HBoxContainer/CheckBox.button_pressed =true
		GM.EggType.Chicken:
			$top_right/VBoxContainer/HBoxContainer4/CheckBox.button_pressed =true

func _process(delta: float) -> void:
	GM.run_time+=delta
	if GM.police_alerted:
		GM.time_left -= delta
		$time_left.visible=true
		$time_left.text = str(GM.time_left).pad_decimals(3)
		
