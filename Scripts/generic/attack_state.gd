extends CharacterState

#region DEFS
#region CONSTANTS
#endregion

#region @EXPORTS
@export var damage : int
@export var next_attack : CharacterState = null
@export var combo_reset_timer : Timer
#endregion

#region @ONREADY
#endregion

#region VARS
#endregion
#endregion

func _state_specific_enter():
	char.sprite.animation_finished.connect(self._on_sprite_animation_finished)
	combo_reset_timer.timeout.connect(_on_combo_reset_timer_timeout)
	combo_reset_timer.stop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _update(delta: float) -> void:
	if Input.is_action_just_pressed("attack") and (next_attack != null) and !combo_reset_timer.is_stopped():
		print("XD")
		print(next_attack.name)
		dispatch("to_" + next_attack.name)
	
func _on_sprite_animation_finished():
	print("animation finished: ", char.sprite.animation)
	if next_attack:
		combo_reset_timer.start()
	else:
		dispatch("to_idle")

func _on_combo_reset_timer_timeout() -> void:
	dispatch("to_idle")
	
func _exit() -> void:
	char.sprite.animation_finished.disconnect(self._on_sprite_animation_finished)
	combo_reset_timer.timeout.disconnect(_on_combo_reset_timer_timeout)
	
