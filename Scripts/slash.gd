class_name Slash
extends CharacterState

func _enter() -> void:
	super()

	await get_tree().create_timer(1.5).timeout
	dispatch(&"move")
