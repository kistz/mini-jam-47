extends Node

var player :Player

enum PickupItems {
	Keycard,
	ExhibitionDoor,
	CeoKeycard,
	MiniStorageKey,
	SideEntrace,
	MainDoor
}

enum EggType {
	Faberge = 31,
	Dinosaur= 63,
	Ostrich=95,
	Chicken=127,
	Kinder=159,
}

signal collected_egg(egg:EggType)

# GLOBAL STATE
var global: GlobalState = GlobalState.new()

var dino_egg=false
var kinder_egg=false
var faberge_egg=false
var ostrich_egg =false
var chicken_egg=false
var egg_count=0

var police_alerted:bool=false

var run_time: float =0.0

var time_left: float= 66.6

func _ready() -> void:
	if not FileAccess.file_exists("user://savegame.save"):
		return
	var save=FileAccess.open("user://savegame.save", FileAccess.READ)
	var best_time=save.get_float()
	global.best_time = best_time

func set_egg(egg: GM.EggType):
	egg_count+=1
	match egg:
		GM.EggType.Ostrich:
			ostrich_egg =true
		GM.EggType.Dinosaur:
			dino_egg =true
		GM.EggType.Kinder:
			kinder_egg =true
		GM.EggType.Faberge:
			faberge_egg =true
		GM.EggType.Chicken:
			chicken_egg =true
	if faberge_egg && dino_egg && kinder_egg && faberge_egg && chicken_egg:
		GM.end_game()


func set_player(p:Player):
	player=p

func delivered_egg(egg: EggType):
	set_egg(egg)
	collected_egg.emit(egg)
	if !police_alerted:
		police_alerted=true
	
func get_player() -> Player:
	return player

	
func get_item_text(item: PickupItems) -> String:
	match item:
		PickupItems.Keycard:
			return "Keycard"
		PickupItems.ExhibitionDoor:
			return "Exhibition"
		PickupItems.CeoKeycard:
			return "CEO"
		PickupItems.MainDoor:
			return "Spare Key"
		PickupItems.SideEntrace:
			return "Staff Entrance"
		PickupItems.MiniStorageKey:
			return "Storage"
	return ""


func end_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var final_time= run_time
	if final_time < global.best_time:
		save_file.store_float(global.best_time)
	get_tree().change_scene_to_file("res://end_screen.tscn")
 
