extends BTAction

func _tick(delta: float) -> Status:
	var mob: Boss1 = agent as Boss1
	if mob == null:
		return FAILURE

	mob.hsm.dispatch(&"move")
	return SUCCESS
