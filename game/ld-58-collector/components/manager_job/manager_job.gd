class_name ComponentManagerJob
extends Node


signal jop_stoped

@export var parent: Unit

var job_origin: ComponentJobContainer
var job: ComponentJobContainer
var step_index := 0
var current_step: Node


func start(job_container: ComponentJobContainer) -> void:
	add_child(job_container.duplicate())
	job = get_child(0)
	job_origin = job_container

	job.unit = parent
	start_task()


func stop() -> void:
	if job:
		job_origin.unregister(parent)
		get_child(0).queue_free()
		job = null
		job_origin = null
		step_index = 0

		jop_stoped.emit()


func start_task(index := 0) -> void:
	print("Starting %s" % [job.steps[index].name])
	job.steps[index].completed.connect(_on_step_completed.bind(index))
	if job.steps[index].has_signal("aborted"):
		job.steps[index].completed.connect(_on_step_aborted.bind(index))
	job.steps[index].start()


func _on_step_completed(local_step_index := -1) ->  void:
	job.steps[local_step_index].completed.disconnect(_on_step_completed)
	local_step_index += 1
	if local_step_index < job.steps.size():
		start_task(local_step_index)
	else:
		if job.loop:
			step_index = 0
			start_task(step_index)
		else:
			stop()


func _on_step_aborted(local_step_index := -1) -> void:
	stop()
	job.steps[local_step_index].completed.disconnect(_on_step_aborted)
