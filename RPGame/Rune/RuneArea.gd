extends Area2D

func _ready():
	pass

func _process(delta):
	pass

func _on_RuneArea_body_entered(body):
	PlayerStats.score += 1
	queue_free()
