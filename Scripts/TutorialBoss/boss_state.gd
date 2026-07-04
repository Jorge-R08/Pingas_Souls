extends CharacterState
class_name BossState

var boss: BaseBoss

func _enter() -> void:
	super()

	boss = char as BaseBoss
	if boss == null:
		push_error("BossState needs agent to be Boss1")
		return
		
func _update(delta : float) -> void:
	super(delta)
