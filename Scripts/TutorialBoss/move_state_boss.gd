extends BossState
class_name Move

#region DEFS
#region CONSTANTS
const MOVE_STOP_DIST : int = 150
#endregion

#region @EXPORTS
@export var SPEED : int = 100
@export var first_slash_state : BossAttackState
#endregion

#region @ONREADY
#endregion

#region VARS
#endregion
#endregion

#region FUNCS

func _enter() -> void:
	super()
	
func _update(delta: float) -> void:
	super(delta)

	var x_diff: float = boss.target.global_position.x - boss.global_position.x
	
	boss.dir = int(sign(x_diff))
	
	if not boss.is_on_floor():
		boss.velocity += boss.get_gravity() * delta
		
	if first_slash_state.hitzone.has_overlapping_bodies():
		dispatch("to_" + first_slash_state.name)
	elif not boss.freeze and abs(x_diff) > MOVE_STOP_DIST:
		boss.velocity.x = boss.dir * SPEED
	else:
		dispatch("to_idle")

	boss._flip_sprite()
	boss.move_and_slide()
	
func _exit() -> void:
	super()
	
func _on_sprite_animation_finished():
	pass

#endregion
