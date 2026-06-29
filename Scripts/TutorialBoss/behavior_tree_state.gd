class_name BehaviorTreeState
extends BTAction

var boss: Boss1

func _enter() -> void:
	boss = agent as Boss1

	if boss == null:
		push_error("BehaviorTreeState agent is not Boss1")
