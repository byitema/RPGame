extends Area2D

signal invincibility_started
signal invincibility_ended

const HitEffect = preload("res://Effects/HitEffect.tscn")

var invincible = false setget set_invincible

onready var timer = $Timer

func set_invincible(value):
	invincible = value
	if invincible:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")

func start_invincibility(duration):
	self.invincible = true
	timer.start(duration)

func _ready():
	pass

func _process(delta):
	pass

func create_hit_effect():
	var effect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position# - Vector2(0, 8)

func _on_Timer_timeout():
	self.invincible = false

func _on_Hurtbox_invincibility_started():
	set_deferred("monitorable", false)

func _on_Hurtbox_invincibility_ended():
	monitorable = true
