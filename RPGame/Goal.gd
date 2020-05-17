extends Area2D

var scene = preload("res://Dialog/EndTextBox.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerStats.score = 6


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Goal_body_entered(body):
	if PlayerStats.score == 7:
		if get_parent().has_node("CanvasLayer/TextBox"):
			get_parent().get_node("CanvasLayer/TextBox").queue_free()
		if get_parent().has_node("CanvasLayer/EndTextBox"):
			get_parent().get_node("CanvasLayer/EndTextBox").queue_free()
		get_tree().paused = true
	else:
		var instancedScene = scene.instance()
		if get_parent().has_node("CanvasLayer/TextBox"):
			get_parent().get_node("CanvasLayer").remove_child(get_parent().get_node("CanvasLayer/TextBox"))
		if get_parent().has_node("CanvasLayer/EndTextBox"):
			get_parent().get_node("CanvasLayer").remove_child(get_parent().get_node("CanvasLayer/EndTextBox"))
		get_parent().get_node("CanvasLayer").add_child(instancedScene)
