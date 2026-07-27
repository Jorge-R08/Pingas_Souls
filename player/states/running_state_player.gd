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
	player.coyote_time_buffer.timeout.connect(_on_coyote_time_buffer_timeout)

func _update(delta : float) -> void:
	super(delta)
	player.dir = Input.get_axis("left", "right")
	if player.dir:
		player.velocity.x = player.dir * SPEED
	else:
		dispatch("to_idle")
		
	if !player.is_on_floor() and player.coyote_time_buffer.is_stopped():
		player.coyote_time_buffer.start()
	elif !player.is_on_floor() and !player.coyote_time_buffer.is_stopped():
		player.velocity += player.get_gravity() * delta
		
	player.move_and_slide()
	player._flip_sprite()
	
func _exit() -> void:
	super()
	player.coyote_time_buffer.timeout.disconnect(_on_coyote_time_buffer_timeout)

func _on_coyote_time_buffer_timeout() -> void:
	dispatch("to_airborne")
