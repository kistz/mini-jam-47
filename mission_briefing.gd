extends Control


@onready
var text:Label= $"Briefing Text"

func _ready() -> void:
	var chars=text.get_total_character_count()
	var tween= get_tree().create_tween()
	tween.tween_property(text,"visible_characters",chars,5.0).set_ease(Tween.EASE_IN_OUT)
	
