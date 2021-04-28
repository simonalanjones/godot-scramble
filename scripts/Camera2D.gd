extends Camera2D

const MOVE_VECTOR = Vector2(1, 0)
const RESET_VECTOR = Vector2.ZERO

func reset() -> void:
	set_position(RESET_VECTOR)

func scroll_right() -> void:
	translate(MOVE_VECTOR)
