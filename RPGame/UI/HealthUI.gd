extends Control

var max_hearts = 5 setget set_max_hearts
var hearts = 5 setget set_hearts

onready var emptyHeartUI = $EmptyHeartUI
onready var fullHeartUI = $FullHeartUI

func set_max_hearts(value):
	max_hearts = max(value, 1)
	self.hearts = min(hearts, max_hearts)
	
	if emptyHeartUI != null:
		emptyHeartUI.rect_size.x = max_hearts * 15

func set_hearts(value):
	hearts = clamp(value, 0, max_hearts)
	
	if fullHeartUI != null:
		fullHeartUI.rect_size.x = hearts * 15

func _ready():
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.health
	
	PlayerStats.connect("health_changed", self, "set_hearts")
	PlayerStats.connect("max_health_changed", self, "set_max_hearts")

func _process(delta):
	pass
