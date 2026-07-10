extends CharacterState
class_name PlayerState

#region DEFS
#region CONSTANTS
#endregion

#region @EXPORTS
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
	char = agent as player


func _update(delta : float) -> void:
	super(delta)
	
func take_damage(_dmg: int, _dmg_dir: int) -> void:
	dispatch(&"to_hurt", {"dmg":_dmg,"dmg_dir":_dmg_dir})

#endregion
