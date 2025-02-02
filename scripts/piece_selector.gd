class_name PieceSelector extends Node2D


var next_piece: Piece
var all_shapes: Array[String] = ["I", "O", "T", "L", "J", "S", "Z"]


func _ready() -> void:
	next_piece = Piece.new()
	select_next_piece()
	add_child(next_piece)



func select_next_piece() -> void:
	if Globals.is_debug_mode_on:
		next_piece.initialize(Globals.debug_shapes.pick_random())
	else:
		next_piece.initialize(all_shapes.pick_random())
