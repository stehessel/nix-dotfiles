function tree --description "tree alias"
	if command -q exa
		exa --tree --icons --git-ignore --ignore-glob __pycache__ $argv
	else
		/usr/bin/env tree $argv
	end
end
