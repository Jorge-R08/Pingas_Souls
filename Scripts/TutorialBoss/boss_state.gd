class_name BossState
extends CharacterState

var boss: BaseBoss

func _enter() -> void:
	super()

	boss = char as BaseBoss
	if boss == null:
		push_error("BossState needs agent to be Boss1")
		return
