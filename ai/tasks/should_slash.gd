extends BTAction

func _tick(delta: float) -> Status:
	var mob: Boss1 = agent as Boss1
	if mob == null:
		return FAILURE

	if mob.hsm.get_active_state().name == "Slash":
		return SUCCESS

	if mob.ray_cast_left.is_colliding():
		if mob.ray_cast_left.get_collider() == mob.target:
			mob.hsm.dispatch(&"slash")
			return SUCCESS

	if mob.ray_cast_right.is_colliding():
		if mob.ray_cast_right.get_collider() == mob.target:
			mob.hsm.dispatch(&"slash")
			return SUCCESS

	return FAILURE
