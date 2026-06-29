extends BehaviorTreeState

func _tick(delta: float) -> Status:
	if boss == null:
		return FAILURE

	boss.hsm.dispatch(&"move")
	return SUCCESS
