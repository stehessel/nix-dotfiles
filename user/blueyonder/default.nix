{ config, lib, pkgs, ... }:
{
	imports = [
		../common
	];

	programs.git = {
		enable = true;
		userEmail = "stephan.hesselmann@jda.com";
		userName = "Stephan Heßelmann (lgtf/39809)";
		ignores = [
			"*~"
			"*.swp"
			"__pycache__"
		];
		extraConfig = {
			core = {
				pager = "diff-so-fancy | less --tabs=4 -RFX";
			};
			color = {
				ui = "true";
				diff-highlight = {
					oldNormal    = "red bold";
					oldHighlight = "red bold 52";
					newNormal    = "green bold";
					newHighlight = "green bold 22";
				};
				diff = {
					meta = "11";
					frag = "magenta bold";
					commit = "yellow bold";
					old = "red bold";
					new = "green bold";
					whitespace = "red reverse";
				};
			};
		};
	};
}
