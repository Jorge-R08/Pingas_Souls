extends BehaviorTreeState

var tutorial_boss: TutorialBoss

func _enter() -> void:
	super()
	tutorial_boss = boss as TutorialBoss

func _tick(delta: float) -> Status:
	if tutorial_boss == null:
		return FAILURE
	
	var x_distance: float = abs(tutorial_boss.target.global_position.x - tutorial_boss.global_position.x)

	
	if x_distance > 700.0:
		tutorial_boss.hsm.dispatch(&"teleport")
		return SUCCESS

	return FAILURE
