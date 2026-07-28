class_name BaseBoss
extends baseChar


#region DEFS
#region CONSTANTS
#endregion

#region @EXPORTS
@export var freeze : bool = false
@export var target: CharacterBody2D
#endregion

#region @ONREADY
@onready var hsm : LimboHSM = $HSM
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
	hsm.add_transition(%slash4_state, %idle_state, &"to_idle")
	hsm.add_transition(%dash_attack_state, %idle_state, &"to_idle")

	#hsm.add_transition(%idle_state, %move_state, &"to_move")
	hsm.add_transition(%teleport_state, %move_state, &"to_move")

	hsm.add_transition(%backstep_attack_state, %dash_attack_state, &"to_dash_attack_state")
	hsm.add_transition(%idle_state, %dash_attack_state, &"to_dash_attack_state")
	hsm.add_transition(%idle_state, %backstep_attack_state, &"to_backstep_attack_state")

	hsm.add_transition(%idle_state, %slash1_state, &"to_slash1_state")
	hsm.add_transition(%move_state, %slash1_state, &"to_slash1_state")
	hsm.add_transition(%slash1_state, %slash2_state, &"to_slash2_state")
	hsm.add_transition(%slash2_state, %slash3_state, &"to_slash3_state")
	hsm.add_transition(%slash3_state, %slash4_state, &"to_slash4_state")


	hsm.add_transition(hsm.ANYSTATE, %teleport_state, &"to_teleport")
	
	hsm.initialize(self)
	hsm.set_active(true)


func _process(delta: float) -> void:
	super(delta)
	if Input.is_action_just_pressed("secret_debug_funny_button'"):
		#hsm.dispatch("to_dash_attack_state")
		#animation_player.play("dash")
		#animation_player.play("backstep")
		hsm.dispatch("to_backstep_attack_state")
		
func set_position_relative(delta_vector : Vector2, duration : float) -> void:
	var tween = create_tween()
	tween.tween_property(self, "position", position + (delta_vector*dir), duration)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)
