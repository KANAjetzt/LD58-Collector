class_name ComponentJobManager
extends Node


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
		step_index = 0


func start_task(index := 0) -> void:
	print("Starting %s" % [job.steps[index].name])
	job.steps[index].start()
	job.steps[index].completed.connect(
		func _on_job_completed() ->  void:
			step_index += 1
			if step_index < job.steps.size():
				start_task(step_index)
			else:
				stop()
	)
