extends PlayerState
class_name idleState

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

func _enter():
	super()
	if !char.is_on_floor():
		dispatch("to_airborne")
	char.coyote_time_buffer.timeout.connect(_on_coyote_time_buffer_timeout)

func _update(delta : float) -> void:
	super(delta)

	if !char.is_on_floor() and char.coyote_time_buffer.is_stopped():
		char.coyote_time_buffer.start()
	elif !char.is_on_floor() and !char.coyote_time_buffer.is_stopped():
		char.velocity += char.get_gravity() * delta

	char.dir = Input.get_axis("left", "right")
	if char.dir:
		dispatch("to_running")
	else:
		char.velocity.x = move_toward(char.velocity.x, 0, 300)
	
	char.move_and_slide()
	
func _exit() -> void:
	super()
	char.coyote_time_buffer.timeout.disconnect(_on_coyote_time_buffer_timeout)
	
func _on_coyote_time_buffer_timeout() -> void:
	dispatch("to_airborne")
