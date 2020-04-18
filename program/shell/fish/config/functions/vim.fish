function vim --description "vim alias"
	if command -v nvim >/dev/null 2>&1
		nvim $argv
	else
		/usr/bin/env vim $argv
	end
end
