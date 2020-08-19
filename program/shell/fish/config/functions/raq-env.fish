function raq-env --description "Create raq environment."
	conda deactivate
	conda env remove -n raq-env
	conda create -n raq-env python=3.6 -y
	conda activate raq-env

	conda install \
		debugpy \
		httpretty \
		ipython \
		pdbpp \
		pipdeptree \
		pre-commit \
		pylint \
		turbodbc \
		-y

	set -x RAQ_SKIP_REQUIREMENTS nbsystem,psapp,nbpy,neurobayes_runtime,boost_gcc_5,vasco_payload_db_lite,nbsystem_local_executor,bydbaccess,turbodbc,pyarrow
	pushd $HOME/git/raq
	./bootstrap
	popd
	proxy
	raq rinstall numpy cython pybind11
	raq install core-data-snapshotter:dev
	proxy clear

	pip install pytest-xdist
end
