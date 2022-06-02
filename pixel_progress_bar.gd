@tool
extends TextureProgressBar

@export var progress:float = 0.0:
	set(multiplier):
		value = 100.0 * multiplier;
	get:
		return value / 100.0;
