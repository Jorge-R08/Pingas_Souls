class_name Move
extends BossState

func _update(delta: float) -> void:
	if boss == null or boss.target == null:
		return

	var x_diff: float = boss.target.global_position.x - boss.global_position.x
	
	boss.dir = int(sign(x_diff))
	boss._flip_sprite()

	boss.velocity = Vector2(boss.dir * boss.speed, 0)

	var ray_length: float = 200.0
	var direction_right: Vector2 = (boss.target.global_position - boss.ray_cast_right.global_position).normalized()

	boss.ray_cast_right.target_position = direction_right * ray_length
	boss.ray_cast_right.force_raycast_update()

	boss.move_and_slide()
