extends Node


enum EggType {
	Faberge = 31,
	Dinosaur= 63,
	Chicken=95,
	Kinder=127,
}

# GLOBAL STATE
var global: GlobalState

var run: RunState = RunState.new()


func restart_run():
	run= RunState.new()

func delivered_egg(egg: EggType):
	run.has_egg(egg)
	
func set_player(player:Player):
	run.player=player
	
func get_player() -> Player:
	return run.player

func police_alerted() -> bool:
	#TODO
	return true
