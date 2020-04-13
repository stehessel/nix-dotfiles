function cat --description "cat alias"
	if command -v bat >/dev/null 2>&1
		bat $argv
	else
		/usr/bin/env cat $argv
	end
end
