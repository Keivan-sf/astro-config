-- copy to clipboard
vim.keymap.set({"n", "v"}, "y", "y")
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- move stuff around in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                 {virtual_text = false})

-- harpoon
local harpoon = require("harpoon")
vim.keymap.set("n", "<leader>add", function() harpoon:list():append() end)
vim.keymap.set("n", "<C-e>",
               function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>aj", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>aa", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>as", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>ad", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
