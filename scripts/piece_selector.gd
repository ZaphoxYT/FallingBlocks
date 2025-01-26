class_name PieceSelector extends Node2D


var next_piece: Piece

func _ready() -> void:
	next_piece = Piece.new()
	select_next_piece()
	add_child(next_piece)

func select_next_piece() -> void:
	#next_piece.initialize(["I", "O", "T", "L", "J", "S", "Z"].pick_random())
	next_piece.initialize(["O"].pick_random())
