class_name BehaviorTreeState
extends BTAction

var boss: BaseBoss

func _enter() -> void:
	boss = agent as BaseBoss

	if boss == null:
		push_error("BehaviorTreeState agent is not Boss1")
