class_name Boss1
extends Mob

@export var speed: float = 100.0
@export var target: CharacterBody2D

@onready var ray_cast_left: RayCast2D = $RayCast2DLeft
@onready var ray_cast_right: RayCast2D = $RayCast2DRight

func setup_hsm() -> void:
	super()

	hsm.add_transition($LimboHSM/Idle, $LimboHSM/Move, &"move")
	hsm.add_transition($LimboHSM/Move, $LimboHSM/Idle, &"idle")
	hsm.add_transition(hsm.ANYSTATE, $LimboHSM/Slash, &"slash")
	hsm.add_transition($LimboHSM/Slash, $LimboHSM/Idle, &"idle")
	hsm.add_transition(hsm.ANYSTATE, $LimboHSM/Teleport, &"teleport")
	hsm.add_transition($LimboHSM/Teleport, $LimboHSM/Idle, &"idle")
	hsm.add_transition($LimboHSM/Slash, $LimboHSM/Move, &"move")
	hsm.add_transition($LimboHSM/Teleport, $LimboHSM/Move, &"move")
	hsm.add_transition($LimboHSM/Teleport, $LimboHSM/Move, &"move")
