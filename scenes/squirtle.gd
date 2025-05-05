extends Enemy

class_name Squirtle

const SQUIRTLE_FULL_SHAPE = preload("res://resources/collisionShapes/squirtle_full.tres")
const SQUIRTLE_SHELL_SHAPE = preload("res://resources/collisionShapes/squirtle_shell.tres")
const SQUIRTLE_SHELL_POSITION = Vector2(0,5)
@onready var collision_shape_2d = $CollisionShape2D
@export var slide_speed = 200
var in_shell = false

func _ready():
	collision_shape_2d.shape = SQUIRTLE_FULL_SHAPE

func die():
	if !in_shell:
		$SquirtleCry.play()
		super.die()
		
	collision_shape_2d.set_deferred("shape", SQUIRTLE_SHELL_SHAPE)
	collision_shape_2d.set_deferred("position", SQUIRTLE_SHELL_POSITION)
	in_shell = true
	
func on_stomp(player_position: Vector2):
	set_collision_layer_value(3, false)
	set_collision_mask_value(1, false)
	set_collision_layer_value(4, true)
	
	var movement_direction = 1 if player_position.x <= global_position.x else -1
	horizontal_speed = -movement_direction * slide_speed
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	pass # Replace with function body.
