extends baseChar
class_name player

#TODO MOVEMENT/CONTROL: FIX DASH OFF LEDGE, ADD INPUT BUFFERING

#region DEFS
#region CONSTANTS
const MAX_STAMINA : int = 120
const DASH_STAMINA_COST = 40
const JUMP_VELOCITY : int = -400
const SPEED : int = 300
#endregion

#region @EXPORTS
@export var boss_target: CharacterBody2D
#endregion

#region @ONREADY
@onready var body_hitbox: CollisionShape2D = $body_hitbox
@onready var stamina_bar: ProgressBar = %stamina_bar
@onready var stamina_regen_timer : Timer = %stamina_regen_timer
@onready var mana_meter : ProgressBar = %mana_meter
@onready var coyote_time_buffer: Timer = %coyote_time_buffer

@onready var aggro_hsm: LimboHSM = $aggro_HSM
@onready var chill_hsm: LimboHSM = $chill_HSM
@onready var berk_hsm: LimboHSM = $berk_HSM
@onready var curr_hsm : LimboHSM = $aggro_HSM

#endregion

#region VARS
var curr_stamina : float = MAX_STAMINA
var stamina_regen : bool = false
var curr_mana : int = 1
#endregion



#endregion
	
func _ready():
	super()
	stamina_regen_timer.timeout.connect(_on_stamina_regen_timer_timeout)
	mana_meter.value = curr_mana
	
	initiate_aggro_state_machine()
	initiate_chill_state_machine()
	curr_hsm.set_active(true)
	
	print("PLAYER READY")

func _process(delta : float) -> void:
	#super(delta)
	if stamina_regen:
		gain_stamina(delta*10)
	
	if Input.is_action_just_pressed("gain_mana"):
		gain_mana(1)
	elif Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	elif Input.is_action_just_pressed("gain_stamina"):
		gain_stamina(40)
	elif Input.is_action_just_pressed("secret_debug_funny_button'"):
		scale.x = 2
		take_damage(5, 1)
	#TODO: Should not be able to interrupt an action by switching stances
	elif Input.is_action_just_pressed("stance_switch"):
		if curr_hsm == aggro_hsm:
			switch_hsms(aggro_hsm, chill_hsm)
		else:
			switch_hsms(chill_hsm, aggro_hsm)


func take_damage(_dmg: int, _dmg_dir: int) -> void:
	curr_hsm.get_active_state().take_damage(_dmg, _dmg_dir)

func _on_stamina_regen_timer_timeout() -> void:
	stamina_regen = true
	
func gain_stamina(amnt : float):
	curr_stamina = min(curr_stamina+amnt, stamina_bar.max_value)
	stamina_bar.value = curr_stamina
	
func spend_stamina(cost : int):
	curr_stamina -= cost
	stamina_regen_timer.start()
	stamina_regen = false
	stamina_bar.value = curr_stamina
	
func gain_mana(amnt : int):
	curr_mana = min(curr_mana+amnt, mana_meter.max_value)
	mana_meter.value = curr_mana
	
func spend_mana(amnt : int) -> bool:
	if curr_mana >= amnt:
		curr_mana -= amnt
		mana_meter.value = curr_mana
		return true
	else:
		print("NOT ENOUGH MANA")
		return false

func initiate_aggro_state_machine():
	aggro_hsm.initial_state = %A_idle_state
	
	aggro_hsm.add_transition(%A_running_state, %A_idle_state, &"to_idle")
	aggro_hsm.add_transition(%A_hurt_state, %A_idle_state, &"to_idle")
	aggro_hsm.add_transition(%A_combo1_state, %A_idle_state, &"to_idle")
	aggro_hsm.add_transition(%A_combo2_state, %A_idle_state, &"to_idle")
	aggro_hsm.add_transition(%A_combo3_state, %A_idle_state, &"to_idle")
	aggro_hsm.add_transition(%A_airborne_state, %A_idle_state, &"to_idle")
	aggro_hsm.add_transition(%A_dash_state, %A_idle_state, &"to_idle")
	aggro_hsm.add_transition(%A_parry_state, %A_idle_state, &"to_idle")
	aggro_hsm.add_transition(%A_riposte_state, %A_idle_state, &"to_idle")

	aggro_hsm.add_transition(%A_idle_state, %A_running_state, &"to_running")
	
	aggro_hsm.add_transition(%A_idle_state, %A_dash_state, &"to_dash")
	aggro_hsm.add_transition(%A_running_state, %A_dash_state, &"to_dash")
	
	aggro_hsm.add_transition(%A_idle_state, %A_airborne_state, &"to_airborne")
	aggro_hsm.add_transition(%A_running_state, %A_airborne_state, &"to_airborne")	

	aggro_hsm.add_transition(%A_running_state, %A_hurt_state, &"to_hurt")
	aggro_hsm.add_transition(%A_combo1_state, %A_hurt_state, &"to_hurt")
	aggro_hsm.add_transition(%A_combo2_state, %A_hurt_state, &"to_hurt")
	aggro_hsm.add_transition(%A_combo3_state, %A_hurt_state, &"to_hurt")
	aggro_hsm.add_transition(%A_idle_state, %A_hurt_state, &"to_hurt")
	aggro_hsm.add_transition(%A_parry_state, %A_hurt_state, &"to_hurt")
	aggro_hsm.add_transition(%A_riposte_state, %A_hurt_state, &"to_hurt")
	aggro_hsm.add_event_handler(&"to_hurt", %A_hurt_state._on_hurt_enter)
	
	aggro_hsm.add_transition(%A_running_state, %A_combo1_state, &"to_A_combo1_state")
	aggro_hsm.add_transition(%A_idle_state, %A_combo1_state, &"to_A_combo1_state")
	aggro_hsm.add_transition(%A_combo1_state, %A_combo2_state, &"to_A_combo2_state")
	aggro_hsm.add_transition(%A_combo2_state, %A_combo3_state, &"to_A_combo3_state")
	aggro_hsm.add_transition(%A_dash_state, %A_combo2_state, &"to_A_combo2_state")
	aggro_hsm.add_transition(%A_combo2_state, %A_post_parry_state, &"to_parry")
	aggro_hsm.add_transition(%A_parry_state, %A_riposte_state, &"to_A_riposte_state")
	
	aggro_hsm.add_transition(%A_hurt_state, %A_death_state, &"to_death")
		
	aggro_hsm.initialize(self)
	
func initiate_chill_state_machine():
	chill_hsm.initial_state = %C_idle_state
	
	chill_hsm.add_transition(%C_running_state, %C_idle_state, &"to_idle")
	chill_hsm.add_transition(%C_hurt_state, %C_idle_state, &"to_idle")
	chill_hsm.add_transition(%C_combo1_state, %C_idle_state, &"to_idle")
	chill_hsm.add_transition(%C_combo2_state, %C_idle_state, &"to_idle")
	chill_hsm.add_transition(%C_charged_attack, %C_idle_state, &"to_idle")
	chill_hsm.add_transition(%C_airborne_state, %C_idle_state, &"to_idle")
	chill_hsm.add_transition(%C_dash_state, %C_idle_state, &"to_idle")
	chill_hsm.add_transition(%C_parry_state, %C_idle_state, &"to_idle")
	chill_hsm.add_transition(%C_riposte_state, %C_idle_state, &"to_idle")
	chill_hsm.add_transition(%C_idle_state, %C_running_state, &"to_running")
	
	chill_hsm.add_transition(%C_idle_state, %C_dash_state, &"to_dash")
	chill_hsm.add_transition(%C_running_state, %C_dash_state, &"to_dash")
	
	chill_hsm.add_transition(%C_idle_state, %C_airborne_state, &"to_airborne")
	chill_hsm.add_transition(%C_running_state, %C_airborne_state, &"to_airborne")	

	chill_hsm.add_transition(%C_running_state, %C_hurt_state, &"to_hurt")
	chill_hsm.add_transition(%C_combo1_state, %C_hurt_state, &"to_hurt")
	chill_hsm.add_transition(%C_combo2_state, %C_hurt_state, &"to_hurt")
	chill_hsm.add_transition(%C_idle_state, %C_hurt_state, &"to_hurt")
	chill_hsm.add_transition(%C_parry_state, %C_hurt_state, &"to_hurt")
	chill_hsm.add_transition(%C_riposte_state, %C_hurt_state, &"to_hurt")
	chill_hsm.add_transition(%C_charged_attack, %C_hurt_state, &"to_hurt")
	chill_hsm.add_event_handler(&"to_hurt", %C_hurt_state._on_hurt_enter)
	
	chill_hsm.add_transition(%C_running_state, %C_combo1_state, &"to_C_combo1_state")
	chill_hsm.add_transition(%C_idle_state, %C_combo1_state, &"to_C_combo1_state")
	chill_hsm.add_transition(%C_combo1_state, %C_combo2_state, &"to_C_combo2_state")
	chill_hsm.add_transition(%C_idle_state, %C_charged_attack, &"to_C_charged_attack")
	chill_hsm.add_transition(%C_running_state, %C_charged_attack, &"to_C_charged_attack")
	chill_hsm.add_transition(%C_idle_state, %C_parry_action_state, &"to_parry_action")
	chill_hsm.add_transition(%C_running_state, %C_parry_action_state, &"to_parry_action")
	chill_hsm.add_transition(%C_parry_action_state, %C_post_parry_state, &"to_parry")
	chill_hsm.add_transition(%C_parry_state, %C_riposte_state, &"to_C_riposte_state")
	
	chill_hsm.add_transition(%C_hurt_state, %C_death_state, &"to_death")
		
	chill_hsm.initialize(self)
	
func switch_hsms(prev_hsm : LimboHSM, new_hsm : LimboHSM):
	curr_hsm.set_active(false)
	curr_hsm = new_hsm
	curr_hsm.set_active(true)
	
