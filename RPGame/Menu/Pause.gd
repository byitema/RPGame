extends Control

func _ready():
	pass

func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("pause"):
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state

func _on_MenuButton_pressed():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state

func _on_Quit_pressed():
	$BlackOverlay.show()
	$BlackOverlay.fade_in()

func _on_BlackOverlay_fade_finished():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state
	get_tree().change_scene("res://Menu/Menu.tscn")
