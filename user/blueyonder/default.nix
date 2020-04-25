{ config, lib, pkgs, ... }:
{
	imports = [
		../common
	];

	programs.git = {
		userEmail = "stephan.hesselmann@blueyonder.com";
		userName = "Stephan Heßelmann (lgtf/39809)";
	};
}
