extends playerState
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
	if !player.is_on_floor():
		dispatch("to_airborne")
	player.coyote_time_buffer.timeout.connect(_on_coyote_time_buffer_timeout)

func _update(delta : float) -> void:
	super(delta)

	if !player.is_on_floor() and player.coyote_time_buffer.is_stopped():
		player.coyote_time_buffer.start()
	elif !player.is_on_floor() and !player.coyote_time_buffer.is_stopped():
		player.velocity += player.get_gravity() * delta

	player.dir = Input.get_axis("left", "right")
	if player.dir:
		dispatch("to_running")
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, 300)
	
	player.move_and_slide()
	
func _exit() -> void:
	super()
	player.coyote_time_buffer.timeout.disconnect(_on_coyote_time_buffer_timeout)
	
func _on_coyote_time_buffer_timeout() -> void:
	dispatch("to_airborne")
