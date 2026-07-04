extends BossAttackState
class_name Slash

func _enter() -> void:
	super()

	await get_tree().create_timer(1.5).timeout
	dispatch(&"move")
	
func _update(delta : float) -> void:
	super(delta)
