extends CharacterBody2D


#all ghost have 4 states, scatter, chase, frightened eaten

var speed = 150

var target: Vector2 = Vector2.ZERO


func scatter():
	pass
	#target one of the corners in the real game ill just chose a random direction for mine
	
	
	
func chase():
	#for red ghost we target the player during chase
	target = Global.player_position


func eaten():
	target = Global.ghost_house_position
	
	
func move_to_target():
		pass
