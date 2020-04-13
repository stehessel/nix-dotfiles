function ls --description "ls alias"
	if command -v exa >/dev/null 2>&1
		exa --icons --group-directories-first $argv
	else
		/usr/bin/env ls $argv
	end
end
