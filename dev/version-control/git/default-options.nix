{
	enable = true;

	ignores = [
		"*~"
		"*.swp"
        "__pycache__"
        ".vim"
	];

	extraConfig = {
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
		core = {
			pager = "diff-so-fancy | less --tabs=4 -RFX";
        };
        pull = {
            ff = "only";
        };
	};
}
