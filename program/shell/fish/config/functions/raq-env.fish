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
		pylint \
		turbodbc \
		-y

	set -x RAQ_SKIP_REQUIREMENTS vasco_payload_db_lite,turbodbc,pyarrow
	pushd $HOME/git/raq
	./bootstrap
	popd
	proxy
	raq rinstall numpy cython pybind11
	raq install core-data-snapshotter:dev --install-separately
	proxy clear

	pip install \
		data-science-types \
		pre-commit \
		pycln \
		pytest-xdist \
		rope \
		ropemode \
		ropevim \
		sourcery-cli \
		sqlalchemy-stubs
end
