extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerStats.connect("no_health", self, "death")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func death():
	if get_parent().get_parent().has_node("CanvasLayer/TextBox"):
		get_parent().get_parent().get_node("CanvasLayer/TextBox").visible = false
	if get_parent().get_parent().has_node("CanvasLayer/EndTextBox"):
		get_parent().get_parent().get_node("CanvasLayer/EndTextBox").visible = false
	if self.get_name() != "Died2":
		get_tree().paused = true
		visible = true

func _on_BlackOverlay_fade_finished1():
	get_tree().paused = false
	visible = false
	if get_parent().get_parent().has_node("CanvasLayer/TextBox"):
		get_parent().get_parent().get_node("CanvasLayer/TextBox").visible = true
	if get_parent().get_parent().has_node("CanvasLayer/EndTextBox"):
		get_parent().get_parent().get_node("CanvasLayer/EndTextBox").visible = true
	get_tree().change_scene("res://Menu/Menu.tscn")

func _on_MenuButton_pressed():
	$BlackOverlay.show()
	$BlackOverlay.fade_in()

func _on_Goal_body_entered(body):
	if self.get_name() == "Died2" and PlayerStats.score == 8:
		visible = true
		if get_parent().get_parent().has_node("CanvasLayer/TextBox"):
			get_parent().get_parent().get_node("CanvasLayer/TextBox").visible = false
		if get_parent().get_parent().has_node("CanvasLayer/EndTextBox"):
			get_parent().get_parent().get_node("CanvasLayer/EndTextBox").visible = false
