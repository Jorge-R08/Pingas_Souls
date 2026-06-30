extends BehaviorTreeState

var tutorial_boss: TutorialBoss

func _enter() -> void:
	super()
	tutorial_boss = boss as TutorialBoss

func _tick(delta: float) -> Status:
	if tutorial_boss == null:
		return FAILURE
	
	if tutorial_boss.hsm.get_active_state().name == "Slash":
		return SUCCESS

	if tutorial_boss.ray_cast_left.is_colliding():
		if tutorial_boss.ray_cast_left.get_collider() == tutorial_boss.target:
			tutorial_boss.hsm.dispatch(&"slash")
			return SUCCESS

	if tutorial_boss.ray_cast_right.is_colliding():
		if tutorial_boss.ray_cast_right.get_collider() == tutorial_boss.target:
			tutorial_boss.hsm.dispatch(&"slash")
			return SUCCESS

	return FAILURE
