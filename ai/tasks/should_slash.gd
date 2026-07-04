extends BehaviorTreeState

func _tick(delta: float) -> Status:
	if boss == null:
		return FAILURE
	
	if boss.hsm.get_active_state().name == "Slash":
		return SUCCESS

	if boss.ray_cast_right.is_colliding():
		if boss.ray_cast_right.get_collider() == boss.target:
			boss.hsm.dispatch(&"slash")
			return SUCCESS

	return FAILURE
