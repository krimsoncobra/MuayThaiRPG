extends Node

@onready var player_health = $"../PlayerFighter/PlayerHealth"
@onready var opponent_health = $"../OpponentFighter/OpponentHealth"

var player_fighter : PlayerFighter
var opponent_fighter : OpponentFighter
var turn = "player" # or "opponent"
var combat_active = true


func start_combat(player: PlayerFighter, opponent: OpponentFighter):
	player_fighter = player
	opponent_fighter = opponent
	turn = "player"
	combat_active = true
	update_ui()
	

func process_turn(action):
	if turn == "player":
		execute_action(player_fighter, opponent_fighter, action)
		if check_end_conditions():
			return
		turn = "opponent"
		opponent_turn()
	elif turn == "opponent":
		var opp_action = opponent_fighter.choose_action()
		execute_action(opponent_fighter, player_fighter, opp_action)
		if check_end_conditions():
			return
		turn = "player"
	update_ui()

func execute_action(attacker, defender, action):
	var damage = calculate_damage(attacker, defender, action)
	defender.health -= damage
	apply_status_effects(attacker, defender, action)

func calculate_damage(attacker, defender, action):
	var base = attacker.power + action.power
	var reduction = defender.defense
	return max(1, base - reduction)

func apply_status_effects(attacker, defender, action):
	if action.status_effect:
		defender.apply_status(action.status_effect)

func check_end_conditions():
	if player_fighter.health <= 0:
		combat_active = false
		show_result("lose")
		return true
	elif opponent_fighter.health <= 0:
		combat_active = false
		show_result("win")
		return true 
	return false

func update_ui():
	player_health.value = player_fighter.health
	player_health.max_value = player_fighter.max_health

	opponent_health.value = opponent_fighter.health
	opponent_health.max_value = opponent_fighter.max_health

func show_result(result):
	if player_fighter.health <= 0:
		combat_active = false
		show_result("lose")
		return true
	elif opponent_fighter.health <= 0:
		combat_active = false
		show_result("win")
		return true 
