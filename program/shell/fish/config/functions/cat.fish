function cat --description "cat alias"
	if command -q bat
		bat $argv
	else
		/usr/bin/env cat $argv
	end
end
