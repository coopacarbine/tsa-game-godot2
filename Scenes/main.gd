extends Node2D

@onready var fog_sprite: Sprite2D = %fogsprite
@onready var ground_tiles: TileMapLayer = %FloorbasicL 
@onready var player: CharacterBody2D = %Player


var fog_image: Image
var vision_image: Image


func _ready() -> void:
	generate_fog()
	update_fog()
	
	
"""func _process(delta: float) -> void:
	if player.velocity.length():
		update_fog()"""
	
	


func generate_fog() -> void:
	var world_dimensions = ground_tiles.get_used_rect().size * ground_tiles.tile_set.tile_size
	var world_position = ground_tiles.get_used_rect().position * ground_tiles.tile_set.tile_size
	
	fog_image = Image.create(world_dimensions.x, world_dimensions.y, false, Image.Format.FORMAT_RGBAH)
	
	fog_image.fill(Color.BLACK)
	
	
	var fog_texture = ImageTexture.create_from_image(fog_image)
	fog_sprite.texture = fog_texture
	
	vision_image = player.vision_sprite.texture.get_image()
	vision_image.convert(Image.Format.FORMAT_RGBAH)


func _process(_delta: float) -> void:
	# Removed the velocity check so it updates immediately when the game starts
	update_fog()

func update_fog() -> void:
	# 1. Get the top-left corner of your actual tiles in world pixels
	var map_rect = ground_tiles.get_used_rect()
	var tile_size = ground_tiles.tile_set.tile_size
	var map_top_left_world = Vector2(map_rect.position) * Vector2(tile_size)
	
	# 2. Get the player's position relative to the top-left of the map
	# If the map starts at (100, 100) and player is at (150, 150), 
	# the local_pos is (50, 50).
	var player_local_to_map = player.global_position - map_top_left_world
	
	# 3. Center the vision circle
	# Subtract half the vision size so the circle's center is on the player
	var vision_size = Vector2(vision_image.get_size())
	var draw_pos = player_local_to_map - (vision_size / 2.0)
	
	# 4. Draw and Update
	var vision_rect = Rect2(Vector2.ZERO, vision_size)
	fog_image.blend_rect(vision_image, vision_rect, draw_pos)
	fog_sprite.texture.update(fog_image)
"""func update_fog() -> void:
	var vision_rect = Rect2(Vector2.ZERO, vision_image.get_size())
	fog_image.blend_rect(vision_image, vision_rect, player.global_position)
	var fog_texture = ImageTexture.create_from_image(fog_image)
	fog_sprite.texture = fog_texture"""
