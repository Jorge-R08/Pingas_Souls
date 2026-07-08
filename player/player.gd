extends baseChar
class_name player

#region DEFS
#region CONSTANTS
const MAX_STAMINA : int = 120
const DASH_STAMINA_COST = 40
#endregion

#region @EXPORTS
#endregion

#region @ONREADY
@onready var body_hitbox: CollisionShape2D = $body_hitbox
@onready var stamina_bar: ProgressBar = %stamina_bar
@onready var stamina_regen_timer : Timer = %stamina_regen_timer
@onready var mana_meter : ProgressBar = %mana_meter
@onready var coyote_time_buffer: Timer = %coyote_time_buffer

#endregion

#region VARS
var curr_stamina : float = MAX_STAMINA
var stamina_regen : bool = false
var curr_mana : int = 1
#endregion

#endregion

func _ready():
	super()
	hsm.add_event_handler(&"to_hurt", $HSM/hurt_state._on_hurt_enter)
	hsm.add_transition($HSM/combo2_state, $HSM/parry_state, "to_parry")
	hsm.add_transition($HSM/parry_state, $HSM/idle_state, "to_idle")
	hsm.add_transition($HSM/parry_state, $HSM/hurt_state, "to_hurt")
	hsm.add_transition($HSM/parry_state, $HSM/riposte_state, "to_riposte")
	hsm.add_transition($HSM/riposte_state, $HSM/idle_state, "to_idle")
	hsm.add_transition($HSM/riposte_state, $HSM/hurt_state, "to_hurt")
	hsm.add_transition($HSM/dash_state, $HSM/combo2_state, "to_combo2_state")
	
	hsm.add_transition($HSM/running_state, $HSM/combo1_state, &"to_combo1_state")
	hsm.add_transition($HSM/idle_state, $HSM/combo1_state, &"to_combo1_state")
	hsm.add_transition($HSM/combo1_state, $HSM/combo2_state, &"to_combo2_state")
	hsm.add_transition($HSM/combo2_state, $HSM/combo3_state, &"to_combo3_state")
	
	stamina_regen_timer.timeout.connect(_on_stamina_regen_timer_timeout)
	
	mana_meter.value = curr_mana
	
	print("PLAYER READY")

func _process(delta : float) -> void:
	#super(delta)
	if stamina_regen:
		curr_stamina = min(MAX_STAMINA, curr_stamina+delta*10)
	stamina_bar.value = curr_stamina
	
	if Input.is_action_just_pressed("gain_mana"):
		gain_mana(1)
	elif Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()

func take_damage(_dmg: int, _dmg_dir: int) -> void:
	super(_dmg, _dmg_dir)
	hsm.get_active_state().take_damage(_dmg, _dmg_dir)

func _on_stamina_regen_timer_timeout() -> void:
	stamina_regen = true
	
func spend_stamina(cost : int):
	curr_stamina -= cost
	stamina_regen_timer.start()
	stamina_regen = false
	
func gain_mana(amnt : int):
	curr_mana += min(curr_mana+amnt, mana_meter.max_value)
	mana_meter.value = curr_mana
	
func spend_mana(amnt : int) -> bool:
	if curr_mana >= amnt:
		curr_mana -= amnt
		mana_meter.value = curr_mana
		return true
	else:
		print("NOT ENOUGH MANA")
		return false
