 
class_name GameState

var game_started: bool = false
var bracelet_obtained: bool = false
var statue_seen: bool = false
var forest_seen: bool = false
var hallway_seen: bool = false
var joyfriend_has_gone_pee: bool = false
var has_danced: bool = false

func are_they_satisfied():
	if not bracelet_obtained:
		return -1
	var satisfied_points = 0
	if statue_seen:
		satisfied_points+=1
	if forest_seen:
		satisfied_points+=1
	if hallway_seen:
		satisfied_points+=1
	return satisfied_points
