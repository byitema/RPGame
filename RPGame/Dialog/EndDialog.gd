extends Control

var dialog = [
	"Don\'t try to trick me, Foxic!",
	"Collect all runes and get back!"
]

var dialogPart = 0
var dialogFinished = false

func _ready():
	load_dialog()

func load_dialog():
	if dialogPart < dialog.size():
		dialogFinished = false
		$RichTextLabel.bbcode_text = dialog[dialogPart]
		$RichTextLabel.percent_visible = 0
		$Tween.interpolate_property($RichTextLabel, "percent_visible", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
	else:
		get_parent().queue_free()
	
	dialogPart += 1

func _process(delta):
	$"next-indicator".visible = dialogFinished
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog()

func _on_Tween_tween_completed(object, key):
	dialogFinished = true
