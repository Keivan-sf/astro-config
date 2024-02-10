-- keep the clipboard after pasting over something
vim.keymap.set("x", "<leader>p", [["_dP]])
-- copy to clipboard
vim.keymap.set({"n", "v"}, "y", "y")
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
-- delete and put it into void register
vim.keymap.set({"n", "v"}, "<leader>d", '"_d')

-- move stuff around in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                 {virtual_text = false})
