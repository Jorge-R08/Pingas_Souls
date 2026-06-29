extends CharacterState

#region DEFS
#region CONSTANTS
const JUMP_VELOCITY = -400.0
#endregion

#region @EXPORTS
#endregion

#region @ONREADY
#endregion

#region VARS
#endregion
#endregion

func _state_specific_enter():
	pass

func _update(delta : float) -> void:
	if Input.is_action_just_pressed("attack"):
		dispatch("to_combo1_state")
	elif Input.is_action_just_pressed("jump") and char.is_on_floor():
		char.velocity.y = JUMP_VELOCITY
		
	if !char.is_on_floor():
		dispatch("to_airborne")
		
	char.dir = Input.get_axis("left", "right")
	if char.dir:
		dispatch("to_running")
	else:
		char.velocity.x = move_toward(char.velocity.x, 0, 300)
	
	char.move_and_slide()
