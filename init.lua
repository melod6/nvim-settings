vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.pumheight = 10

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end

    if client:supports_method('textDocument/formatting') then
        vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = args.buf,
            callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 2000 })
            end,
        })
    end
    if client and client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { args.buf })
    end
    vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, { desc = 'Go to definition (LSP)' })
  end,
})

vim.lsp.enable('ols')

vim.pack.add({
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" }
})

require('nvim-treesitter').install({ 'odin' })

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'odin',
  callback = function()
    vim.treesitter.start()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'odin',
  callback = function()
    vim.treesitter.start()
    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

vim.cmd.colorscheme "catppuccin-nvim"

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  command = "resize 10",
})
