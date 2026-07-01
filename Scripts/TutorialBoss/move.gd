class_name Move
extends BossState

func _update(delta: float) -> void:
	if boss == null or boss.target == null:
		return

	var x_diff: float = boss.target.global_position.x - boss.global_position.x
	var direction_x: float = sign(x_diff)

	boss.sprite.flip_h = direction_x > 0
	boss.velocity = Vector2(direction_x * boss.speed, 0)

	var ray_length: float = 200.0
	var direction_left: Vector2 = (boss.target.global_position - boss.ray_cast_left.global_position).normalized()
	var direction_right: Vector2 = (boss.target.global_position - boss.ray_cast_right.global_position).normalized()

	if boss.sprite.flip_h:
		boss.ray_cast_right.target_position = direction_right * ray_length
		boss.ray_cast_right.force_raycast_update()
	else:
		boss.ray_cast_left.target_position = direction_left * ray_length
		boss.ray_cast_left.force_raycast_update()

	boss.move_and_slide()
