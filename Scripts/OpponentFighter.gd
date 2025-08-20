extends CharacterBody2D
class_name OpponentFighter

@export var speed = 400
@export var max_health = 100
var health : int

func _ready():
	health = max_health

func _physics_process(delta):
	move_and_slide()
