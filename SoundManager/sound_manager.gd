extends Node

@export var pool_size: int = 5

@onready var music_player = $MusicPlayer
@onready var sfx_pool = $SFXPool

var player_counter = 0


func _enter_tree():
	AudioServer.set_bus_layout(load("res://Resources/bus_layout.tres"))


func update_bus(bus_name, value) -> void:
	AudioServer.set_bus_mute(AudioServer.get_bus_index(bus_name), true if value == 0 else false)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus_name), linear_to_db(value / 100))


func play_music(path: String) -> void:
	if !FileAccess.file_exists(path):
		print("Cannot find " + path + "!")
		return
		
	music_player.stream = load(path)
	music_player.play()	


func stop_music() -> void:
	music_player.stop()
	

# Play new sounds, while removing the oldest currently playing if the pool is full.
# this results in the most satisfying outcome.
func play_sfx(path: String) -> void:
	if !FileAccess.file_exists(path):
		print("Cannot find " + path + "!")
		return
	
	if sfx_pool.get_children().size() >= pool_size:
		_stop_player(_get_oldest_player())
	
	var player = AudioStreamPlayer.new()
	player.bus = &"SFX"
	player.set_meta("path", path)
	player.set_meta("id", player_counter)
	player.stream = load(path)
	player.finished.connect(_on_player_finished.bind(player))
	player_counter += 1
	sfx_pool.add_child(player)
	player.play()


func stop_sfx(path: String) -> void:
	for player in sfx_pool.get_children():
		if player.get_meta("path") == path:
			player.stop()
			player.queue_free()
			return
			
			
func _stop_player(player: AudioStreamPlayer) -> void:
	player.stop()
	player.queue_free()


func _get_oldest_player() -> AudioStreamPlayer:
	if sfx_pool.get_child_count() == 0:
		return null
		
	var oldest_record = 0
	var oldest_player = sfx_pool.get_children()
	for player in sfx_pool.get_children():
		if player.get_meta("id") < oldest_record:
			oldest_player = player
			oldest_record = player.get_meta("id")
	
	return oldest_player


func _on_player_finished(player: AudioStreamPlayer) -> void:
	player.queue_free()
