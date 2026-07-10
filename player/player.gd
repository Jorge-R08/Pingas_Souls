extends baseChar
class_name player

#region DEFS
#region CONSTANTS
const MAX_STAMINA : int = 120
const DASH_STAMINA_COST = 40
#endregion

#region @EXPORTS
@export var boss_target: CharacterBody2D
#endregion

#region @ONREADY
@onready var body_hitbox: CollisionShape2D = $body_hitbox
@onready var stamina_bar: ProgressBar = %stamina_bar
@onready var stamina_regen_timer : Timer = %stamina_regen_timer
#endregion

#region VARS
var curr_stamina : float = MAX_STAMINA
var stamina_regen : bool = false
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
	
	stamina_regen_timer.timeout.connect(_on_stamina_regen_timer_timeout)
	
	print("PLAYER READY")

func _process(delta : float) -> void:
	#super(delta)
	if stamina_regen:
		print("AAAAAAAAAA")
		curr_stamina = min(MAX_STAMINA, curr_stamina+delta*10)
	#print(delta)
	#print(curr_stamina)
	stamina_bar.value = curr_stamina

func take_damage(_dmg: int, _dmg_dir: int) -> void:
	super(_dmg, _dmg_dir)
	hsm.get_active_state().take_damage(_dmg, _dmg_dir)

func _on_stamina_regen_timer_timeout() -> void:
	stamina_regen = true
	
func spend_stamina(cost : int):
	curr_stamina -= cost
	stamina_regen_timer.start()
	stamina_regen = false
