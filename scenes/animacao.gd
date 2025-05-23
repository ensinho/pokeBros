extends AnimatedSprite2D

class_name PlayerAnimatedSprite

func trigger_animation(velocity: Vector2, direction: int, player_mode: Player.PlayerMode):
	var animation_prefix = Player.PlayerMode.keys()[player_mode].to_lower()

	if not get_parent().is_on_floor():
		play("%s_jump" %animation_prefix)
	elif sign(velocity.x) != sign(direction) && velocity.x != 0 && direction != 0:
		play("%s_slide" %animation_prefix)
		scale.x = direction * 0.45
	
	else:
		if scale.x == 1 && direction == -1:
			scale.x = -1
			#flip_h(true)
		elif scale.x == -1 && direction == 1:
			scale.x = 1
			
		if velocity.x != 0:
			play("%s_run" %animation_prefix)
		else:
			play("%s_idle" %animation_prefix)
