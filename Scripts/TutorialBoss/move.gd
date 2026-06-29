class_name Move
extends CharacterState

func _enter() -> void:
	super()

func _update(delta: float) -> void:
	
	if mob == null or mob.target == null:
		return

	var x_diff: float = mob.target.global_position.x - mob.global_position.x
	var direction_x: float = sign(x_diff)

	mob.sprite.flip_h = direction_x > 0
	mob.velocity = Vector2(direction_x * mob.speed, 0)
	
	var ray_length := 200
	var direction_left := (mob.target.global_position - mob.ray_cast_left.global_position).normalized()
	var direction_right := (mob.target.global_position - mob.ray_cast_right.global_position).normalized()
	
	if mob.sprite.flip_h:
		mob.ray_cast_right.target_position = direction_right * ray_length
		mob.ray_cast_right.force_raycast_update()
	else:
		mob.ray_cast_left.target_position = direction_left * ray_length
		mob.ray_cast_left.force_raycast_update()
	
	mob.move_and_slide()
