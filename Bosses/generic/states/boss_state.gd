extends characterState
class_name bossState

#region DEFS
#region CONSTANTS
#endregion

#region @EXPORTS
@export var wait_on_end : float = 0.5
#endregion

#region @ONREADY
#endregion

#region VARS
var boss: baseBoss
#endregion
#endregion

#region FUNCS

func _enter() -> void:
	super()
	boss = character as baseBoss
		
func _update(delta : float) -> void:
	super(delta)
	
func _exit() -> void:
	super()
	boss.idle_wait = wait_on_end
	
func _on_sprite_animation_finished():
	pass
