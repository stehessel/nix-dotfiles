function dotfiles --description "git alias for managing bare dotfile repo"
	git --git-dir=/home/stephan/.dotfiles --work-tree=/home/stephan
end
