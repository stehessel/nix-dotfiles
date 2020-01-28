{ config, lib, pkgs, ... }:

{
	programs.git = {
		enable = true;
		userEmail = "stephan@stehessel.de";
		userName = "stehessel";
	};

	services.mbsync = {
		enable = true;
		configFile = config/mbsync/mbsyncrc;
		frequency = "*:0/1";
	};
	xdg.configFile."mbsync/mbsyncrc".source = config/mbsync/mbsyncrc;

	imports = [ ../../service/calcurse ];
}
