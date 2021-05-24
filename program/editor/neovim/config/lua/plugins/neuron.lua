require("vimp")
local neuron = require("neuron")
local cmd = require("neuron/cmd")
local telescope = require("neuron/telescope")

neuron.setup({
  virtual_titles = true,
  mappings = true,
  run = nil, -- function to run when in neuron dir
  neuron_dir = "~/doc/zettelkasten", -- the directory of all of your notes
  leader = "<leader>k", -- the leader key to for all mappings, remember with 'go zettel'
})

-- click enter on [[my_link]] or [[[my_link]]] to enter it
vimp.nnoremap({ "buffer" }, "<leader>kk", neuron.enter_link)

-- create a new note
vimp.nnoremap("<leader>kn", function()
  cmd.new_edit(neuron.config.neuron_dir)
end)

-- find your notes, click enter to create the note if there are not notes that match
vimp.nnoremap("<leader>kf", telescope.find_zettels)
-- insert the id of the note that is found
vimp.nnoremap("<leader>kF", function()
  telescope.find_zettels({ insert = true })
end)

-- find the backlinks of the current note all the note that link this note
vimp.nnoremap({ "buffer" }, "<leader>kb", telescope.find_backlinks)
-- same as above but insert the found id
vimp.nnoremap({ "buffer" }, "<leader>kB", function()
  telescope.find_backlinks({ insert = true })
end)

-- find all tags and insert
vimp.nnoremap("<leader>kt", telescope.find_tags)

-- start the neuron server and render markdown, auto reload on save
vimp.nnoremap("<leader>ks", function()
  neuron.rib({ address = "127.0.0.1:8200", verbose = true })
end)

-- go to next [[my_link]] or [[[my_link]]]
vimp.nnoremap({ "buffer" }, "<leader>k]", telescope.goto_next_extmark)
-- go to previous
-- vimp.nnoremap({"buffer"}, "<leader>k[", telescope.goto_prev_extmark)
