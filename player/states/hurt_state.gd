extends PlayerState

#region DEFS
#region CONSTANTS
#endregion

#region @EXPORTS
#endregion

#region @ONREADY
#endregion

#region VARS
#endregion
var dmg
var dmg_dir
#endregion

func _on_hurt_enter(_cargo_dict = null):
	dmg = _cargo_dict["dmg"]
	dmg_dir = _cargo_dict["dmg_dir"]
	
func _enter():
	super()
	char.curr_health = max(0, char.curr_health - dmg)
	print("DAMAGE TAKEN --- CURR HEALTH is: ", agent.curr_health)
	char.sprite.animation_finished.connect(_on_sprite_animation_finished)

func _update(delta : float) -> void:
	super(delta)
	
func _exit() -> void:
	super()
	
func _on_sprite_animation_finished():
	dispatch("to_idle")
