extends CharacterBody2D

@export var speed: float = 75

var direction: Vector2 = Vector2.ZERO
var next_direction: Vector2 = Vector2.ZERO

@onready var raycast: RayCast2D = $wallcheck
@onready var ani: AnimationPlayer = $AnimationPlayer

func animations() -> void:
	if velocity.length() > 0:
		if not ani.is_playing():
			ani.play("moving")
	else:
		ani.stop()

func _physics_process(delta: float) -> void:
	# Input handling
	var input_dir = Vector2.ZERO
	if Input.is_action_pressed("right"):
		input_dir = Vector2.RIGHT
	elif Input.is_action_pressed("left"):
		input_dir = Vector2.LEFT
	elif Input.is_action_pressed("up"):
		input_dir = Vector2.UP
	elif Input.is_action_pressed("down"):
		input_dir = Vector2.DOWN
		
	if input_dir != Vector2.ZERO:
		next_direction = input_dir

	# Check if we can turn into the next direction
	if next_direction != Vector2.ZERO:
		raycast.target_position = next_direction 
		raycast.force_raycast_update()
		if not raycast.is_colliding():
			direction = next_direction

	# Try moving in the current direction
	if direction != Vector2.ZERO:
		raycast.target_position = direction
		raycast.force_raycast_update()
		if not raycast.is_colliding():
			velocity = direction * speed
			move_and_slide()

	
			rotation = direction.angle()
		else:
			velocity = Vector2.ZERO
	else:
		velocity = Vector2.ZERO

	animations()
