function tree --description "tree alias"
	if command -v eza >/dev/null 2>&1
		eza --tree --icons --git-ignore --ignore-glob __pycache__ $argv
	else
		/usr/bin/env tree $argv
	end
end
