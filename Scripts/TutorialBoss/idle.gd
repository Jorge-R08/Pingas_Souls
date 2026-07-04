class_name Idle
extends CharacterState

func _enter(cargo_dict = null) -> void:
	super()

	await get_tree().create_timer(3.0).timeout
	dispatch(&"move")
