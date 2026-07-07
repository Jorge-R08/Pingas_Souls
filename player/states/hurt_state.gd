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
#endregion

func _on_hurt_enter(_cargo_dict = null):
	print(_cargo_dict)
	print("IN HURT STATE --- CURR HEALTH is: ", agent.curr_health)
	print("damage: ", _cargo_dict["dmg"])
	print("damage_dir", _cargo_dict["dmg_dir"])
	
func _enter():
	super()
	char.sprite.animation_finished.connect(_on_sprite_animation_finished)

func _update(delta : float) -> void:
	super(delta)
	
func _on_sprite_animation_finished():
	char.sprite.animation_finished.disconnect(_on_sprite_animation_finished)
	dispatch("to_idle")
