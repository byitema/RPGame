extends Node

signal no_health
signal health_changed(value)
signal max_health_changed(value)
signal score_changed(value)

export var max_health = 5 setget set_max_health
var health = max_health setget set_health
var score = 0 setget set_score

func set_score(value):
	score = value
	emit_signal("score_changed", score)

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)

func set_health(value):
	health = value
	emit_signal("health_changed", health)
	
	if health <= 0:
		emit_signal("no_health")

func _ready():
	self.health = max_health

func _process(delta):
	pass
