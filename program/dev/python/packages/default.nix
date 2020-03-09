{ config, lib, pkgs, ... }:
let
	python = pkgs.python3;
	pypkg = pkgs.python3Packages;

	pyrepl = pypkg.buildPythonPackage rec {
		pname = "pyrepl";
		version = "0.9.0";

		src = pypkg.fetchPypi {
			inherit pname version;
			sha256 = "292570f34b5502e871bbb966d639474f2b57fbfcd3373c2d6a2f3d56e681a775";
		};

		doCheck = false;

		meta = {
			homepage = "http://bitbucket.org/pypy/pyrepl";
			description = "A library for building flexible command line interfaces";
		};
	};
	fancycompleter = pypkg.buildPythonPackage rec {
		pname = "fancycompleter";
		version = "0.9.1";

		src = pypkg.fetchPypi {
			inherit pname version;
			sha256 = "09e0feb8ae242abdfd7ef2ba55069a46f011814a80fe5476be48f51b00247272";
		};

		buildInputs = [ pyrepl ];

		doCheck = false;

		meta = {
			homepage = "https://github.com/pdbpp/fancycompleter";
			description = "colorful TAB completion for Python prompt";
		};
	};
	pygments = pypkg.buildPythonPackage rec {
		pname = "Pygments";
		version = "2.6.1";

		src = pypkg.fetchPypi {
			inherit pname version;
			sha256 = "647344a061c249a3b74e230c739f434d7ea4d8b1d5f3721bc0f3558049b38f44";
		};

		doCheck = false;

		meta = {
			homepage = "https://pygments.org/";
			description = "Pygments is a syntax highlighting package written in Python";
		};
	};
	wmctrl = pypkg.buildPythonPackage rec {
		pname = "wmctrl";
		version = "0.3";

		src = pypkg.fetchPypi {
			inherit pname version;
			sha256 = "d806f65ac1554366b6e31d29d7be2e8893996c0acbb2824bbf2b1f49cf628a13";
		};

		doCheck = false;

		meta = {
			homepage = "http://bitbucket.org/antocuni/wmctrl";
			description = "A tool to programmatically control windows inside X";
		};
	};
	pdbpp = pypkg.buildPythonPackage rec {
		pname = "pdbpp";
		version = "0.10.2";

		src = pypkg.fetchPypi {
			inherit pname version;
			sha256 = "73ff220d5006e0ecdc3e2705d8328d8aa5ac27fef95cc06f6e42cd7d22d55eb8";
		};

		buildInputs = [ fancycompleter pygments pyrepl wmctrl ];

		doCheck = false;

		meta = {
			homepage = "http://github.com/antocuni/pdb";
			description = "pdb++, a drop-in replacement for pdb";
		};
	};
in
{
	home.packages = [
		(python.buildEnv.override {
			extraLibs = with pypkg;
			[
				dask
				numpy
				pandas
				pdbpp
				pyarrow
				pydantic
				pyls-black
				pyls-isort
				pyls-mypy
				python-language-server
				requests
				sqlalchemy
				tenacity
				toolz
			];
		})
	];
}
