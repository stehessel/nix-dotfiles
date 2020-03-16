function docker-pyenv -a container_id --description "Create python environment from docker container"
	if not test -n "$container_id"
		# Use latest container
		set container_id (docker ps -lq)
	end

	docker exec -it $container_id /home/docker/venv3.6/bin/pip freeze \
		> /tmp/requirements.txt

	conda deactivate
	conda env remove -n docker
	conda create -n docker python=3.6 -y
	conda activate docker

	set index_url https://software.z.westeurope.blue-yonder.cloud/platform_dev/Debian_9/+simple
	cat /tmp/requirements.txt \
		| xargs -n 1 -L 1 \
		pip --cert $HOME/certs/Certificates.pem \
			--trusted-host pypi.org \
			--trusted-host files.pythonhosted.org \
			install \
				--extra-index-url $index_url
end
