{ config, lib, pkgs, ... }:

{
	programs.git = {
		enable = true;
		userEmail = "stephan@stehessel.de";
		userName = "stehessel";
	};
}
