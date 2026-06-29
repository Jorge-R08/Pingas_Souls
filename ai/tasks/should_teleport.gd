extends BehaviorTreeState

func _tick(delta: float) -> Status:
	var x_distance: float = abs(mob.target.global_position.x - mob.global_position.x)
	
	print(x_distance)
	
	if x_distance > 700.0:
		mob.hsm.dispatch(&"teleport")
		return SUCCESS

	return FAILURE
