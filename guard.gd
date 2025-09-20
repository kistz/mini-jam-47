extends CharacterBody2D


var patrolling_speed: float = 10
var sprinting_speed: float= 20

@export 
var patrol_path: Path2D



enum GuardMode {
	Patrolling,
	Chasing
}

var following= PathFollow2D.new()

var guard_mode: GuardMode = GuardMode.Patrolling


@onready var agent: NavigationAgent2D = $NavigationAgent2D

@export
var back_and_forth: bool = false

var targets: Array[Vector2]
var cur_tartget= 0


func _ready() -> void:
	patrol_path.add_child(following)
	$AnimatedSprite2D.play("walking")
	
	agent.path_desired_distance = 4.0
	agent.target_desired_distance = 4.0
	
	agent.target_reached.connect(next_target)
	
	for child in get_node("targets").get_children():
		targets.push_back(child.global_position) 
	
	
	actor_setup.call_deferred()

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	agent.target_position=targets[cur_tartget]
	print(targets[cur_tartget])


func next_target():
	print("WTF")
	cur_tartget+=1
	if cur_tartget == targets.size():
		cur_tartget=0
	print(cur_tartget)
	print(targets[cur_tartget])
	agent.target_position = targets[cur_tartget]


func _get_configuration_warnings() -> PackedStringArray:
	if patrol_path == null:
		return PackedStringArray(["Pls select a Path"])
	else:
		return PackedStringArray()
		
#func _process(delta: float) -> void:
	#var old_pos= following.global_position
	#following.progress += patrolling_speed * delta
	#var new_pos = following.global_position
	
	#var vec=new_pos - old_pos
	#move_and_collide(vec)
	#if old_pos.x > new_pos.x:
	#	$AnimatedSprite2D.flip_h =true
	#else:
	#	$AnimatedSprite2D.flip_h =false
	
	#global_position=new_pos

func _physics_process(delta):
	if agent.is_navigation_finished():
		#print("finished")
		return
	#print(agent.is_target_reachable())
	
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = agent.get_next_path_position()
	
	velocity = current_agent_position.direction_to(next_path_position) * patrolling_speed
	
	if velocity.x >0:
		$AnimatedSprite2D.flip_h =true
	else:
		$AnimatedSprite2D.flip_h =false
	
	move_and_slide()
