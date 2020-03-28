local iron = require('iron')

iron.core.add_repl_definitions {
	python = {
		default = {
			command = {"ipython"}
		}
	}
}

iron.core.set_config {
	preferred = {
		python = "ipython"
	}
}
