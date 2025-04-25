extends TextureRect


func _ready() -> void:
	get_viewport().size_changed.connect(_on_size_changed)
	expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	stretch_mode = TextureRect.STRETCH_TILE
	_on_size_changed()


func _on_size_changed() -> void:
	size = get_viewport().get_visible_rect().size
