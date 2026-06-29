class_name BehaviorTreeState
extends BTAction

var mob: Boss1

func _enter() -> void:
	mob = agent as Boss1
