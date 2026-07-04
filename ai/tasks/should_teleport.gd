extends BehaviorTreeState


func _tick(delta: float) -> Status:
	if boss == null:
		return FAILURE
	
	var x_distance: float = abs(boss.target.global_position.x - boss.global_position.x)

	
	if x_distance > 700.0:
		boss.hsm.dispatch(&"teleport")
		return SUCCESS

	return FAILURE
