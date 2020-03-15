function docker-pyenv -a container_id --description "Create python environment from docker container"
	if not test -n "$container_id"
		# Use latest container
		set container_id (docker ps -lq)
	end
	docker exec -it $container_id /home/docker/venv3.6/bin/pip freeze > /tmp/requirements.txt
end
