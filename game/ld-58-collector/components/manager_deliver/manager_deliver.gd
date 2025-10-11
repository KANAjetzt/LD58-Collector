class_name ComponentManagerDeliver
extends Node


@export var storages: Array[ComponentStorage]


# Return available Storage
func request(resource: DataResource, request_handler: Callable = same_resource_and_not_full) -> ComponentStorage:
	if storages.size() == 0:
		push_error("Delivery requested but no storages defined in Manager!")
		return null

	return request_handler.call(storages, resource)


func request_sub_resource(storage: ComponentStorage, resource: DataResource, request_handler: Callable = handle_sub_resource) -> ComponentStorage:
	return request_handler.call(storage, resource)


func same_resource_and_not_full(request_storages: Array[ComponentStorage], request_resource: DataResource) -> ComponentStorage:
	for request_storage in request_storages:
		if request_storage.resource == request_resource and request_storage.current < request_storage.maximum:
			return request_storage
	return null


func handle_sub_resource(requested_storage: ComponentStorage, requested_sub_resource: DataResource) -> ComponentStorage:
	if requested_sub_resource and requested_storage is not ContainerStorage:
		push_error("Sub resource requested but requested storage is not a ContainerStorage.")
		return null

	if requested_storage.resource.sub_resource == requested_sub_resource:
		return requested_storage.get_first()

	return null


# Return delivered amount
func deliver(storage: ComponentStorage, amount := 1) -> int:
	if storage.current + amount > storage.maximum:
		storage.current = storage.maximum
		return storage.maximum - storage.current
	else:
		storage.current += amount
		return amount
