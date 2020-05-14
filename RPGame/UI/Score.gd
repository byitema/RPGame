extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerStats.connect("score_changed", self, "change_text")

func change_text(value):
	$RichTextLabel.text = str(value)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
