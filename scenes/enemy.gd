extends Area2D

class_name Enemy

signal points_scored(points: int)
const points_label_scene = preload("res://scenes/points_label.tscn")

@export var horizontal_speed = 20
@export var vertical_speed = 100

@onready var ray_cas_2d = $RayCast2D as RayCast2D
@onready var animated_sprite_2d = $AnimatedSprite2D as AnimatedSprite2D

func _process(delta):
	position.x -= horizontal_speed * delta

	if !ray_cas_2d.is_colliding():
		position.y += vertical_speed * delta

func die():
	horizontal_speed = 0
	vertical_speed = 0
	animated_sprite_2d.play("dead")
	
func die_from_hit():
	set_collision_layer_value(3, false) 
	set_collision_mask_value(1, false)
	
	rotation_degrees = 180
	horizontal_speed = 0 
	vertical_speed = 0
	
	var die_tween = get_tree().create_tween()
	die_tween.tween_property(self, "position", position + Vector2(0,-25), .2 )
	die_tween.chan().tween_property(self, "position", position + Vector2(0, 500), 4 )
	
	var points_label = points_label_scene.instantiate()
	points_label.position = self.position + Vector2(-20,-20)
	get_tree().root.add_child(points_label)
	points_scored.emit(100)
	
func _on_area_entered(area):
	if area is Goomba and (area as Goomba).in_shell and (area as Goomba).horizontal_speed != 0:
		die_from_hit()
	
func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
	
	
	
	
