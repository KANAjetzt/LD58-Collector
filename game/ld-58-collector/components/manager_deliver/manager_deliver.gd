class_name ComponentManagerDeliver
extends Node


@export var storages: Array[ComponentStorage]


# Return available Storage
func request(resource: DataResource, sub_resource: DataResource = null, request_handler: Callable = same_resource_and_not_full) -> ComponentStorage:
	if storages.size() == 0:
		push_error("Delivery requested but no storages defined in Manager!")
		return null

	return request_handler.call(storages, resource, sub_resource)


func same_resource_and_not_full(request_storages: Array[ComponentStorage], request_resource: DataResource, _request_sub_resource: DataResource) -> ComponentStorage:
	for request_storage in request_storages:
		if request_storage.resource == request_resource and request_storage.current < request_storage.maximum:
			return request_storage
	return null


# Return delivered amount
func deliver(storage: ComponentStorage, amount := 1) -> float:
	if storage.current + amount > storage.maximum:
		storage.current = storage.maximum
		return storage.maximum - storage.current
	else:
		storage.current += amount
		return amount
