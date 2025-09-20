extends Control




var run_time: float =0.0

var time_left: float= 30.0


func _process(delta: float) -> void:
	run_time+=delta
	if GM.police_alerted():
		time_left -= delta
		$time_left.text = str(time_left).pad_decimals(3)
