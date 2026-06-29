extends CharacterBody2D
class_name baseChar

#region @EXPORTS
@export var sprite : AnimatedSprite2D
@export var facing_right : bool = false
#endregion

#region @ONREADY
@onready var hsm: LimboHSM = $HSM
#endregion

#region VARS
var dir : int = 0
#endregion

func _char_ready():
	push_error("WARNING MOB DID NOT OVERRIDE THE _mob_ready() FUNCTION")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_base_char_ready()
	_char_ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _flip_sprite():
	if dir == 1:
		sprite.flip_h = false
	elif dir == -1:
		sprite.flip_h = true
		
func _base_char_ready():
	sprite.flip_h = true if !facing_right else false
	initiate_state_machine()
	
func initiate_state_machine():
	hsm.initial_state = $HSM/idle_state
	
	hsm.add_transition($HSM/running_state, $HSM/idle_state, &"to_idle")
	hsm.add_transition($HSM/hurt_state, $HSM/idle_state, &"to_idle")
	hsm.add_transition($HSM/attack_state, $HSM/idle_state, &"to_idle")
	hsm.add_transition($HSM/airborne_state, $HSM/idle_state, &"to_idle")

	hsm.add_transition($HSM/idle_state, $HSM/running_state, &"to_running")
	
	hsm.add_transition($HSM/idle_state, $HSM/airborne_state, &"to_airborne")
	hsm.add_transition($HSM/running_state, $HSM/airborne_state, &"to_airborne")	
	
	hsm.add_transition($HSM/running_state, $HSM/attack_state, &"to_attack")
	hsm.add_transition($HSM/idle_state, $HSM/attack_state, &"to_attack")
	
	hsm.add_transition($HSM/running_state, $HSM/hurt_state, &"to_hurt")
	hsm.add_transition($HSM/attack_state, $HSM/hurt_state, &"to_hurt")
	hsm.add_transition($HSM/idle_state, $HSM/hurt_state, &"to_hurt")
	
	hsm.add_transition($HSM/hurt_state, $HSM/death_state, &"to_death")
	
	#hsm.add_event_handler(&"to_hurt", hurt_state._on_hurt_enter)
	
	hsm.initialize(self)
	hsm.set_active(true)
