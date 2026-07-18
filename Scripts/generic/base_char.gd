extends CharacterBody2D
class_name baseChar

#region DEFS

#region CONSTANTS
const MAX_HEALTH : int = 100
#endregion

#region @EXPORTS
@export var sprite : AnimatedSprite2D
@export var facing_right : bool = false
@export var hitzones : Node2D
@export var debug : bool = true
#endregion

#region @ONREADY
@onready var hsm: LimboHSM = $HSM
#endregion

#region VARS
var dir : int = 0
var curr_health : int = MAX_HEALTH
#endregion
#endregion

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dir = 1 if facing_right else -1
	initiate_state_machine()
	_flip_sprite()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _flip_sprite():
	if dir != 0:
		transform.x.x = dir
	
func initiate_state_machine():
	hsm.initial_state = $HSM/idle_state
	
	hsm.add_transition($HSM/running_state, $HSM/idle_state, &"to_idle")
	hsm.add_transition($HSM/hurt_state, $HSM/idle_state, &"to_idle")
	hsm.add_transition($HSM/combo1_state, $HSM/idle_state, &"to_idle")
	hsm.add_transition($HSM/combo2_state, $HSM/idle_state, &"to_idle")
	hsm.add_transition($HSM/combo3_state, $HSM/idle_state, &"to_idle")
	hsm.add_transition($HSM/airborne_state, $HSM/idle_state, &"to_idle")
	hsm.add_transition($HSM/dash_state, $HSM/idle_state, &"to_idle")

	hsm.add_transition($HSM/idle_state, $HSM/running_state, &"to_running")
	
	hsm.add_transition($HSM/idle_state, $HSM/dash_state, &"to_dash")
	hsm.add_transition($HSM/running_state, $HSM/dash_state, &"to_dash")
	
	hsm.add_transition($HSM/idle_state, $HSM/airborne_state, &"to_airborne")
	hsm.add_transition($HSM/running_state, $HSM/airborne_state, &"to_airborne")	

	hsm.add_transition($HSM/running_state, $HSM/hurt_state, &"to_hurt")
	hsm.add_transition($HSM/combo1_state, $HSM/hurt_state, &"to_hurt")
	hsm.add_transition($HSM/combo2_state, $HSM/hurt_state, &"to_hurt")
	hsm.add_transition($HSM/combo3_state, $HSM/hurt_state, &"to_hurt")
	hsm.add_transition($HSM/idle_state, $HSM/hurt_state, &"to_hurt")
	
	hsm.add_transition($HSM/hurt_state, $HSM/death_state, &"to_death")
		
	hsm.initialize(self)
	hsm.set_active(true)

func take_damage(_dmg: int, _dmg_direction: int) -> void:
	curr_health = max(0, curr_health - _dmg)
