{ config, lib, pkgs, ... }:
{
	imports = [
		../common
	];

	programs.git = {
		userEmail = "stephan.hesselmann@jda.com";
		userName = "Stephan Heßelmann (lgtf/39809)";
	};
}
