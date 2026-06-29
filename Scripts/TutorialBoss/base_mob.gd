class_name Mob
extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hsm: LimboHSM = $LimboHSM

var previous_state: LimboState
var current_state: LimboState

func _ready() -> void:
	setup_hsm()
	hsm.set_active(true)

func setup_hsm() -> void:
	hsm.initialize(self)
	hsm.active_state_changed.connect(_on_active_state_changed)
	
func _on_active_state_changed(current: LimboState, previous: LimboState) -> void:
	previous_state = previous
	current_state = current
