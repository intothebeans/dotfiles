require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "next todo" })

map("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "prev todo" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")


