function docker-pyenv -a container_id --description "Create python environment from docker container"
	if not test -n "$container_id"
		# Use latest container
		set container_id (docker ps -lq)
	end

	docker exec -it $container_id /home/docker/venv3.6/bin/pip freeze \
		| sed 's/==.*$//g' \
		| sed '/^#/d' \
		| sed '/^by.atalaia/d' \
		| sed '/^Bottleneck/d' \
		| sed '/^crick/d' \
		| sed '/^http-parser/d' \
		| sed '/^neurobayes-runtime/d' \
		| sed '/^ps-app/d' \
		| sed 's/^psycopg2/psycopg2-binary/g' \
		| sed "s+/home/docker/venv3.6+$HOME/pyenv+g" \
		> /tmp/requirements.txt

	conda deactivate
	conda env remove -n docker
	conda create -n docker python=3.6 -y
	conda activate docker
	conda install \
				black \
				cython \
				pdbpp \
				pipdeptree \
				pydantic \
				pynvim \
				python-language-server \
				turbodbc \
				-y

	set index_url https://software.z.westeurope.blue-yonder.cloud/platform_dev/Debian_9/+simple
	pip --cert $HOME/certs/Certificates.pem \
		--trusted-host pypi.org \
		--trusted-host files.pythonhosted.org \
		install \
			--extra-index-url $index_url \
			-r /tmp/requirements.txt
	pip --cert $HOME/certs/Certificates.pem \
		--trusted-host pypi.org \
		--trusted-host files.pythonhosted.org \
		install \
			--extra-index-url $index_url \
			byflow dataset_diff pricing-columns
end
