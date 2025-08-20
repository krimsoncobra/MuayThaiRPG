extends Node

@onready var attack_popup = preload("res://Scenes/attacks.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(attack_popup)
	attack_popup.visible = false
	attack_popup.z_index = 100
	$"../CanvasLayer/Control/Att, Clinch/Attack".connect("pressed", Callable(self, "_on_attack_button_pressed"))

func on_attack_button_pressed():
	show_attack_popup()

func show_attack_popup():
	attack_popup.global_position = $"../Att, Clinch/Button2".global_position + Vector2(0, 0)
	attack_popup.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
