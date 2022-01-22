function tree --description "tree alias"
	if command -v exa >/dev/null 2>&1
		exa --tree --icons --git-ignore --ignore-glob __pycache__ $argv
	else
		/usr/bin/env tree $argv
	end
end
