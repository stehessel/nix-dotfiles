function ls --description "ls alias"
	if command -q exa
		exa --icons --group-directories-first $argv
	else
		/usr/bin/env ls $argv
	end
end
