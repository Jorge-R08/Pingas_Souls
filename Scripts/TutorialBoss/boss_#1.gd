class_name BaseBoss
extends baseChar


#region DEFS
#region CONSTANTS
#endregion

#region @EXPORTS
@export var freeze : bool = false
@export var target: CharacterBody2D
@onready var hsm : LimboHSM = $HSM
#endregion

#region @ONREADY
#endregion

#region VARS
var idle_wait : float
#endregion
#endregion

#region FUNCS

func _ready() -> void:
	super()
	
	hsm.initial_state = %idle_state
	
	hsm.add_transition(%move_state, %idle_state, &"to_idle")
	hsm.add_transition(%teleport_state, %idle_state, &"to_idle")
	hsm.add_transition(%slash1_state, %idle_state, &"to_idle")
	hsm.add_transition(%slash2_state, %idle_state, &"to_idle")
	hsm.add_transition(%slash3_state, %idle_state, &"to_idle")

	hsm.add_transition(%idle_state, %move_state, &"to_move")
	hsm.add_transition(%teleport_state, %move_state, &"to_move")

	hsm.add_transition(%idle_state, %slash1_state, &"to_slash1_state")
	hsm.add_transition(%move_state, %slash1_state, &"to_slash1_state")
	hsm.add_transition(%slash1_state, %slash2_state, &"to_slash2_state")
	hsm.add_transition(%slash2_state, %slash3_state, &"to_slash3_state")

	hsm.add_transition(hsm.ANYSTATE, %teleport_state, &"to_teleport")
	
	hsm.initialize(self)
	hsm.set_active(true)
