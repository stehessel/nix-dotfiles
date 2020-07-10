function raq-env --description "Create raq environment."
	conda deactivate
	conda env remove -n raq-env
	conda create -n raq-env python=3.6 -y
	conda activate raq-env

	conda install \
		debugpy \
		httpretty \
		ipython \
		jedi \
		pdbpp \
		pipdeptree \
		pre-commit \
		pylint \
		pynvim \
		rope \
		turbodbc \
		-y

	cd $HOME/git/raq
	set -x RAQ_SKIP_REQUIREMENTS nbsystem,psapp,nbpy,neurobayes_runtime,boost_gcc_5,vasco_payload_db_lite,nbsystem_local_executor,bydbaccess,turbodbc
	proxy
	./bootstrap
	raq rinstall numpy cython pybind11 pyarrow
	raq install data-catalog[test]
	proxy clear

	pip install \
		pytest-xdist \
		ropemode \
		ropevim
end
