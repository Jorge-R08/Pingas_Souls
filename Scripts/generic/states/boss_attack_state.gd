extends BossState
class_name BossAttackState

#region DEFS
#region CONSTANTS
#endregion

#region @EXPORTS
@export var hit_frame : int
@export var hitzone : Area2D
@export var dmg : int
@export var next_attack : BossAttackState
#endregion

#region @ONREADY
#endregion

#region VARS
#endregion
#endregion

#region FUNCS
# Called when the node enters the scene tree for the first time.
func _enter() -> void:
	super()
	hitzone.monitoring = true

func _update(delta : float) -> void:
	super(delta)
	if boss.sprite.frame == hit_frame and hitzone.monitoring:
		if hitzone.has_overlapping_bodies():
			hitzone.monitoring = false
			boss.target.take_damage(dmg, -1 if boss.sprite.flip_h else 1)

func _exit() -> void:
	super()
	hitzone.monitoring = true
	
#endregion
