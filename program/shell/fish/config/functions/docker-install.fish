function docker-install -a container_id --description "Install custom packages to docker container"
	if not test -n "$container_id"
		# Use latest container
		set container_id (docker ps -lq)
	end
	set pkgs_list fish kakoune
	set pypkgs_list pdbpp
	docker exec --user="root" -it $container_id apt-get install $pkgs_list -y
	docker exec -it $container_id pip install $pypkgs_list
end
