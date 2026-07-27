extends BossAttackState
class_name Slash

#region DEFS
#region CONSTANTS
#endregion

#region @EXPORTS
#endregion

#region @ONREADY
#endregion

#region VARS
#endregion
#endregion

#region FUNCS

func _enter() -> void:
	super()
	
func _update(delta : float) -> void:
	super(delta)
	
func _exit() -> void:
	super()
	
func _on_sprite_animation_finished():
	if next_attack != null and next_attack.hitzone.has_overlapping_bodies():
		dispatch("to_" + next_attack.name)
	else:
		dispatch("to_idle")

#endregion
