class_name PixelBlock extends StaticBody2D


var graveyard = Vector2(10000, 0)


func deactivate():
	position = graveyard
	for group in get_groups():
		remove_from_group(group)
	add_to_group('InactiveBlocks')


func activate(pos, group):
	position = pos
	remove_from_group('InactiveBlocks')
	add_to_group(group)
