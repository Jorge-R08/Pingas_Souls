extends BehaviorTreeState

var tutorial_boss: TutorialBoss

func _enter() -> void:
	super()
	tutorial_boss = boss as TutorialBoss

func _tick(delta: float) -> Status:
	if tutorial_boss == null:
		return FAILURE

	tutorial_boss.hsm.dispatch(&"move")
	return SUCCESS
