function update --description "Update everything"
	echo 'starting updates ...'
	if command --search trizen >/dev/null do
		echo 'updating pacman and aur ...'
		trizen -Syu
	end
	if command --search brew >/dev/null do
		echo 'updating homebrew ...'
		brew update
		brew upgrade
		brew cleanup
		echo 'updating Apple packages ...'
		/usr/sbin/softwareupdate -ia
	end
	echo 'updating fish shell ...'
	fisher
	fish_update_completions
end
