extends BossState
class_name Idle

#region DEFS
#region CONSTANTS
#endregion

#region @EXPORTS
@export var first_slash_state : BossAttackState
#endregion

#region @ONREADY@export var idle_wait_timer: Timer
@onready var idle_wait_timer: Timer = %idle_wait_timer
#endregion

#region VARS
#endregion
#endregion

#region FUNCS

func _enter() -> void:
	super()
	idle_wait_timer.timeout.connect(_on_idle_wait_timer_timeout)
	idle_wait_timer.wait_time = boss.idle_wait
	idle_wait_timer.start()
	
func _update(delta : float) -> void:
	super(delta)
	
	if not boss.is_on_floor():
		boss.velocity += boss.get_gravity() * delta
		
	boss.velocity.x = move_toward(boss.velocity.x, 0, 300)
	
func _exit() -> void:
	super()
	idle_wait_timer.timeout.disconnect(_on_idle_wait_timer_timeout)
	
func _on_sprite_animation_finished():
	pass

func _on_idle_wait_timer_timeout() -> void:
	if first_slash_state.hitzone.has_overlapping_bodies():
		dispatch("to_" + first_slash_state.name)
	else:
		dispatch(&"to_move")

#endregion
