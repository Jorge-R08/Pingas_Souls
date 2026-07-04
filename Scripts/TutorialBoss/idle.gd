class_name Idle
extends CharacterState

func _enter() -> void:
	super()

	await get_tree().create_timer(3.0).timeout
	dispatch(&"move")
