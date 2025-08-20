extends CharacterBody2D

@export var speed = 400
@export var max_health = 100
var health : int

func _ready():
	health = max_health

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
