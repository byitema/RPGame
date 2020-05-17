extends Control

func _ready():
	pass

func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("pause") and get_parent().get_parent().get_node("CanvasLayer2/Died2").visible == false and get_parent().get_parent().get_node("CanvasLayer2/Died").visible == false:
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state
		if get_parent().has_node("TextBox"):
			get_parent().get_node("TextBox").visible = not new_pause_state
		if get_parent().has_node("EndTextBox"):
			get_parent().get_node("EndTextBox").visible = not new_pause_state

func _on_MenuButton_pressed():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state
	if get_parent().has_node("TextBox"):
		get_parent().get_node("TextBox").visible = true
	if get_parent().has_node("EndTextBox"):
		get_parent().get_node("EndTextBox").visible = true

func _on_Quit_pressed():
	$BlackOverlay.show()
	$BlackOverlay.fade_in()

func _on_BlackOverlay_fade_finished():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state
	if get_parent().has_node("TextBox"):
		get_parent().get_node("TextBox").visible = true
	if get_parent().has_node("EndTextBox"):
		get_parent().get_node("EndTextBox").visible = true
	get_tree().change_scene("res://Menu/Menu.tscn")
