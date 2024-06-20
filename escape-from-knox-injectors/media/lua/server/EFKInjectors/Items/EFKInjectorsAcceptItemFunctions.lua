function AcceptItemFunction.InjectorCase(container, item)
	return item:hasTag("Injector") and container:getItems():size() < 9
end
