extends ColorRect

signal fade_finished
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func fade_in():
	$AnimationPlayer.play("fade_in")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("fade_finished")


func _on_BlackOverlay_fade_finished():
	pass # Replace with function body.
