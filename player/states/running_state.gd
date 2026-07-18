extends PlayerState

#region DEFS
#region CONSTANTS
#endregion

#region @EXPORTS
@export var SPEED : int = 300
#endregion

#region @ONREADY
#endregion

#region VARS
#endregion
#endregion

func _enter():
	super()
	char.coyote_time_buffer.timeout.connect(_on_coyote_time_buffer_timeout)

func _update(delta : float) -> void:
	super(delta)
	char.dir = Input.get_axis("left", "right")
	if char.dir:
		char.velocity.x = char.dir * SPEED
	else:
		dispatch("to_idle")
		
	if !char.is_on_floor() and char.coyote_time_buffer.is_stopped():
		char.coyote_time_buffer.start()
	elif !char.is_on_floor() and !char.coyote_time_buffer.is_stopped():
		char.velocity += char.get_gravity() * delta
		
	char.move_and_slide()
	char._flip_sprite()
	
func _exit() -> void:
	super()
	char.coyote_time_buffer.timeout.disconnect(_on_coyote_time_buffer_timeout)

func _on_coyote_time_buffer_timeout() -> void:
	dispatch("to_airborne")

func _setup_exports():
	pass
