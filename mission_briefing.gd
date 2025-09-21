extends Control


@onready
var text:Label= $"Briefing Text"

func _ready() -> void:
	var chars=text.get_total_character_count()
	var tween= get_tree().create_tween()
	tween.tween_property(text,"visible_characters",chars,7.0).set_ease(Tween.EASE_IN_OUT)
	tween.tween_callback(func(): GM.get_player().mission_briefing=false)
	tween.tween_callback(func(): $Panel.visible=false)
	tween.tween_property(self,"visible", false,3.0)
	
