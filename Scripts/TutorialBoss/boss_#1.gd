class_name BaseBoss
extends baseChar

@export var speed: float = 100.0
@export var target: CharacterBody2D
@export var health: int

func _char_ready() -> void:
	hsm.add_transition($HSM/Idle, $HSM/Move, &"move")
	hsm.add_transition($HSM/Move, $HSM/Idle, &"idle")

	hsm.add_transition(hsm.ANYSTATE, $HSM/Slash, &"slash")
	hsm.add_transition($HSM/Slash, $HSM/Idle, &"idle")
	hsm.add_transition($HSM/Slash, $HSM/Move, &"move")

	hsm.add_transition(hsm.ANYSTATE, $HSM/Teleport, &"teleport")
	hsm.add_transition($HSM/Teleport, $HSM/Idle, &"idle")
	hsm.add_transition($HSM/Teleport, $HSM/Move, &"move")
