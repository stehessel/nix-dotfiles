{ config, lib, pkgs, ... }:
let
	python = pkgs.python3;
	pypkg = pkgs.python3Packages;
in
{
	home.packages = [
		(python.buildEnv.override {
			extraLibs = with pypkg;
			[
				dask
				numpy
				pandas
				pyarrow
				pyls-black
				pyls-isort
				pyls-mypy
				python-language-server
				requests
			];
		})
	];
}
