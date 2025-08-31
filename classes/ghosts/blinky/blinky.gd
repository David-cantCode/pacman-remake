extends CharacterBody2D


#all ghost have 4 states, scatter, chase, frightened eaten

var speed = 100

var target: Vector2 = Vector2.ZERO
var direction: Vector2 = Vector2.ZERO
@onready var raycast: RayCast2D = $RayCast2D 


func scatter():
	pass
	#target one of the corners in the real game ill just chose a random direction for mine
	
	
	
func chase():
	#for red ghost we target the player during chase
	target = Global.player_position


func eaten():
	target = Global.ghost_house_position
	
	
func move_to_target():
	var dirs = [Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN]
	var best_dir: Vector2 = Vector2.ZERO
	var best_dist: float = INF

	for d in dirs:
		# don’t allow reversing direction
		if d == -direction:
			continue

		raycast.target_position = d 
		raycast.force_raycast_update()

		if not raycast.is_colliding():
			var next_pos = global_position + d 
			var dist = next_pos.distance_to(target)

			if dist < best_dist:
				best_dist = dist
				best_dir = d
	if best_dir != Vector2.ZERO:
		direction = best_dir

	velocity = direction * speed
	move_and_slide()


func _process(delta: float) -> void:
	chase()
	move_to_target()
