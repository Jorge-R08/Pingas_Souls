class_name BossState
extends CharacterState

var boss: Boss1

func _enter() -> void:
	super()

	boss = char as Boss1
	if boss == null:
		push_error("BossState needs agent to be Boss1")
		return
