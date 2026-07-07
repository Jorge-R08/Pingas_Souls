extends PlayerState

#region DEFS
#region CONSTANTS
const STOP_SPEED : int = 10
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _update(delta: float) -> void:
	if not char.is_on_floor():
		char.velocity += char.get_gravity() * delta
	else:
		dispatch("to_idle")
	
	char.dir = Input.get_axis("left", "right")
	if char.dir:
		char.velocity.x = char.dir * SPEED
	else:
		char.velocity.x = move_toward(char.velocity.x, 0, STOP_SPEED)
	
	char.move_and_slide()
	char._flip_sprite()
