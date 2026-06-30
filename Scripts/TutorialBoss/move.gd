class_name Move
extends BossState

var tutorial_boss: TutorialBoss

func _enter() -> void:
	super()
	tutorial_boss = boss as TutorialBoss

func _update(delta: float) -> void:
	if tutorial_boss == null or tutorial_boss.target == null:
		return

	var x_diff: float = tutorial_boss.target.global_position.x - tutorial_boss.global_position.x
	var direction_x: float = sign(x_diff)

	tutorial_boss.sprite.flip_h = direction_x > 0
	tutorial_boss.velocity = Vector2(direction_x * tutorial_boss.speed, 0)

	var ray_length: float = 200.0
	var direction_left: Vector2 = (tutorial_boss.target.global_position - tutorial_boss.ray_cast_left.global_position).normalized()
	var direction_right: Vector2 = (tutorial_boss.target.global_position - tutorial_boss.ray_cast_right.global_position).normalized()

	if tutorial_boss.sprite.flip_h:
		tutorial_boss.ray_cast_right.target_position = direction_right * ray_length
		tutorial_boss.ray_cast_right.force_raycast_update()
	else:
		tutorial_boss.ray_cast_left.target_position = direction_left * ray_length
		tutorial_boss.ray_cast_left.force_raycast_update()

	tutorial_boss.move_and_slide()
