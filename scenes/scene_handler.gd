extends Node

signal progress_changed(progress)
signal load_finished

var loading_screen: PackedScene = preload("uid://c18dsrah7aita")
var current_loading_screen_instance
var loaded_resource: PackedScene
var loaded_scene_instance: Node
var scene_path: String
var progress: Array = []
var use_sub_threads: bool = true
var prior_scene: Node


func _ready() -> void:
	pass


func to_next_scene_no_transition(_scene_path) -> void:
	start_load()


func transition_to_next_scene(_scene_path: String) -> void:
	if !current_loading_screen_instance:
		current_loading_screen_instance = loading_screen.instantiate()

	if not find_child("LoadingScreen"):
		add_child(current_loading_screen_instance)
		progress_changed.connect(current_loading_screen_instance._on_progress_changed)
		load_finished.connect(current_loading_screen_instance._on_load_finished)
	current_loading_screen_instance.visible = true
	await current_loading_screen_instance.loading_screen_ready
	start_load()

func start_load() -> void:
	var state = ResourceLoader.load_threaded_request(scene_path, "", use_sub_threads)
	if state == OK:
		set_process(true)

func _process(_delta:float) -> void:
	var load_status = ResourceLoader.load_threaded_get_status(scene_path, progress)

	progress_changed.emit(progress[0])
	$loading.value = progress[0]

	match load_status:
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			set_process(false)
		ResourceLoader.THREAD_LOAD_LOADED:
			loaded_resource = ResourceLoader.load_threaded_get(scene_path)
			loaded_scene_instance = loaded_resource.instantiate()
			if find_child(loaded_scene_instance.name):
				make_next_scene_visible(find_child(loaded_scene_instance.name))
			else:
				load_next_scene()

			prior_scene = loaded_scene_instance

func make_next_scene_visible(scene_in_question) -> void:
	prior_scene.visbile = false
	scene_in_question.visible = true

func load_next_scene() -> void:
	var tree: SceneTree = get_tree()
	add_child(loaded_scene_instance)
	if prior_scene:
		prior_scene.visible = false
	load_finished.emit()
