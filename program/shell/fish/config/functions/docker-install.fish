function docker-install --description "Install custom packages to the latest docker container"
	set container_id (docker ps -lq)
	set pkgs_list fish kakoune
	set pypkgs_list pdbpp
	docker exec --user="root" -it $container_id apt-get install $pkgs_list
	docker exec -it $container_id pip install $pypkgs_list
end
