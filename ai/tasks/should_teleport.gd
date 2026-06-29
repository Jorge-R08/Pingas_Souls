extends BehaviorTreeState

func _tick(delta: float) -> Status:
	if boss == null:
		return FAILURE
	
	var x_distance: float = abs(boss.target.global_position.x - boss.global_position.x)
	
	print(x_distance)
	
	if x_distance > 700.0:
		boss.hsm.dispatch(&"teleport")
		return SUCCESS

	return FAILURE
