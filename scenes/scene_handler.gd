extends Node

signal progress_changed(progress)
signal load_finished

var loading_screen: PackedScene = preload("uid://c18dsrah7aita")
var loaded_resource: PackedScene
var scene_path: String
var progress: Array = []
var use_sub_threads: bool = true

func _ready() -> void:
	set_process(false)
	add_child_scene_no_transition("uid://cn31opw5i4ovi")

func add_child_scene_no_transition(string_path) -> void:
	scene_path = string_path
	start_load()


func load_scene(_scene_path: String) -> void:
	scene_path = _scene_path
	var new_load_screen = loading_screen.instantiate()
	add_child(new_load_screen)
	progress_changed.connect(new_load_screen._on_progress_changed)
	load_finished.connect(new_load_screen._on_load_finished)

	await new_load_screen.loading_screen_ready

	start_load()

func start_load() -> void:
	var state = ResourceLoader.load_threaded_request(scene_path, "", use_sub_threads)
	if state == OK:
		set_process(true)

func _process(_delta:float) -> void:
	var load_status = ResourceLoader.load_threaded_get_status(scene_path, progress)

	progress_changed.emit(progress[0])

	match load_status:
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			set_process(false)
		ResourceLoader.THREAD_LOAD_LOADED:
			loaded_resource = ResourceLoader.load_threaded_get(scene_path)
			load_next_scene()

func load_next_scene() -> void:
	var tree: SceneTree = get_tree()
	add_child(loaded_resource.instantiate())
	load_finished.emit()
