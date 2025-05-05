extends CharacterBody2D

class_name Player

signal points_scored(points: int)
@export var actualPoints = 0

enum PlayerMode {small, big, shooting}
@onready var animated_sprite_2d = $Animacao as PlayerAnimatedSprite
@onready var area_2d = $Area2D
@onready var area_colisao = $Area2D/areaColisao
@onready var body_colisao = $BodyColisao

@export_group("Locomotion")
@export var run_speed_damping = 0.5
@export var speed = 150
@export var jump_velocity = -350

@export_group("Stomping Enemies")
@export var min_stomp_degree = 35
@export var max_stomp_degree = 145
@export var stomp_y_velocity = -150

var player_mode = PlayerMode.small
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const points_label_scene = preload("res://scenes/points_label.tscn")
var is_dead = false

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity.y += gravity * delta  

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity  # Removemos a animação direta, pois `trigger_animation` cuidará disso.

	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity *= 0.5  

	var direction = Input.get_axis("left", "right")

	if direction:
		velocity.x = lerp(velocity.x, speed * direction, run_speed_damping * delta)
	else: 
		velocity.x = move_toward(velocity.x, 0, speed * delta)
	
	move_and_slide()
	animated_sprite_2d.trigger_animation(velocity, direction, player_mode)

func _on_area_2d_area_entered(area):
	if area is Enemy:
		handle_enemy_collision(area)
		
func handle_enemy_collision(enemy: Enemy):
	if enemy == null || is_dead : 
		return
	
	if is_instance_of(enemy, Squirtle) and (enemy as Squirtle).in_shell:
		(enemy as Squirtle).on_stomp(global_position)
	else: 
		var angle_of_collision = rad_to_deg(position.angle_to_point(enemy.position))
		
		if angle_of_collision > min_stomp_degree && max_stomp_degree > angle_of_collision:
			enemy.die()
			on_enemy_stomped()
			spawn_points_label(enemy)
		else:
			die()
			
func on_enemy_stomped():
	velocity.y = stomp_y_velocity
		
func spawn_points_label(enemy):
	var points_label = points_label_scene.instantiate()
	points_label.position = enemy.position + Vector2(-20, -20)
	get_tree().root.add_child(points_label)
	points_scored.emit(100) 
	actualPoints += 100
	$Camera2D/pontos.text = str(actualPoints)
	
func die():
	
	if player_mode == PlayerMode.small:
		$LaprasCry.play()
		is_dead = true
		animated_sprite_2d.play("small_death")
		set_physics_process(false)
		
		var death_tween = get_tree().create_tween()
		death_tween.tween_property(self, "position", position + Vector2(0,-45), .5)
		death_tween.chain().tween_property(self, "position", position + Vector2(0, 500), 1)
		death_tween.tween_callback(func (): get_tree().reload_current_scene())
		
func _on_snorlax_area_entered(_area: Area2D) -> void:
	$WinSound.play()
	get_tree().change_scene_to_file("res://scenes/main2.tscn")	
	
func _on_snorlax_2_area_entered(_area: Area2D) -> void:
	if (actualPoints >= 300):
		get_tree().change_scene_to_file("res://scenes/win_screen.tscn")	
	

func _on_coin_area_entered(_area: Area2D) -> void:
	$PointSound.play()
	actualPoints = actualPoints + 50
	$Camera2D/pontos.text = str(actualPoints)

func _on_coin_2_area_entered(_area: Area2D) -> void:
	$PointSound.play()
	actualPoints = actualPoints + 50
	$Camera2D/pontos.text = str(actualPoints)

func _on_coin_3_area_entered(_area: Area2D) -> void:
	$PointSound.play()
	actualPoints = actualPoints + 50
	$Camera2D/pontos.text = str(actualPoints)

func _on_coin_4_area_entered(_area: Area2D) -> void:
	$PointSound.play()
	actualPoints = actualPoints + 50
	$Camera2D/pontos.text = str(actualPoints)

func _on_coin_5_area_entered(_area: Area2D) -> void:
	$PointSound.play()
	actualPoints = actualPoints + 50
	$Camera2D/pontos.text = str(actualPoints)

func _on_coin_6_area_entered(_area: Area2D) -> void:
	$PointSound.play()
	actualPoints = actualPoints + 50
	$Camera2D/pontos.text = str(actualPoints)

func _on_coin_7_area_entered(_area: Area2D) -> void:
	$PointSound.play()
	actualPoints = actualPoints + 50
	$Camera2D/pontos.text = str(actualPoints)

func _on_coin_8_area_entered(_area: Area2D) -> void:
	$PointSound.play()
	actualPoints = actualPoints + 50
	$Camera2D/pontos.text = str(actualPoints)
