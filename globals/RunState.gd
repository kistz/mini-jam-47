extends Resource
class_name RunState

#var run_time: float = 0.0
var player :Player =null

var dino_egg=false
var kinder_egg=false
var faberge_egg=false

#egg_count=

func has_egg(egg: GM.EggType):
	match egg:
		GM.EggType.Faberge:
			faberge_egg =true
		GM.EggType.Dinosaur:
			dino_egg =true
		GM.EggType.Kinder:
			kinder_egg =true
		GM.EggType.Faberge:
			faberge_egg =true
	print(egg , "yaa")
	#egg_count
