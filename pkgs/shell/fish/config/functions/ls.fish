function ls --description "ls alias"
	if command -v eza >/dev/null 2>&1
		# Workaround for fzf.fish
		if test (count $argv) -gt 0; and test $argv[1] = "-A"
			set argv[1] "-a"
		end
		eza --icons --group-directories-first $argv
	else
		/usr/bin/env ls $argv
	end
end
