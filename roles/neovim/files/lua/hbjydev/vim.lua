local function set_augroup()
  vim.cmd[[
    augroup WrapInMarkdown
      autocmd!
      autocmd FileType markdown setlocal wrap
    augroup END
  ]]

  vim.cmd[[
    autocmd BufWritePre *.go lua vim.lsp.buf.format()
  ]]

  vim.cmd[[
    set sw=2 ts=2 sts=2 " Default

    augroup AutoTabConfig
      autocmd!
      autocmd FileType html :setlocal sw=2 ts=2 sts=2
      autocmd FileType javascript :setlocal sw=2 ts=2 sts=2
      autocmd FileType python :setlocal sw=4 ts=4 sts=4
      autocmd FileType go :setlocal sw=4 ts=4 sts=4
      autocmd FileType rust :setlocal sw=4 ts=4 sts=4
      autocmd FileType php :setlocal sw=4 ts=4 sts=4
    augroup END
  ]]
end

local function set_vim_g()
  local settings = {
    mapleader = " ",

    -- netrw
    netrw_keepdir = 0,
    netrw_winsize = 30,
    netrw_banner = 0,
    netrw_localcopydircmd = 'cp -r'
  }

  for k, v in pairs(settings) do
    vim.g[k] = v
  end
end

local function set_vim_o()
  local settings = {
    backup = false,
    errorbells = false,
    expandtab = true,
    hidden = true,
    scrolloff = 3,
    softtabstop = 2,
    showmode = false,
    termguicolors = true,
    clipboard = 'unnamedplus',
  }

  -- Generic vim.o
  for k, v in pairs(settings) do
    vim.o[k] = v
  end

  vim.o.shortmess = vim.o.shortmess .. 'c'

  -- Not yet in vim.o
  vim.cmd('set encoding=utf8')
  vim.cmd('set nowritebackup')
  vim.cmd('set shiftwidth=2')
  vim.cmd('set secure')
  vim.cmd('set splitright')
  vim.cmd('set tabstop=2')
  vim.cmd('set updatetime=300')
end

local function set_vim_wo()
  vim.wo.number = true
  vim.wo.relativenumber = true
  vim.wo.wrap = false
end

local function set_keymaps()
  local map = vim.api.nvim_set_keymap

  local options = { noremap = false }

  map('n', '<leader>h', '<CMD>wincmd h<CR>', options)
  map('n', '<leader>j', '<CMD>wincmd j<CR>', options)
  map('n', '<leader>k', '<CMD>wincmd k<CR>', options)
  map('n', '<leader>l', '<CMD>wincmd l<CR>', options)

  map('n', '<leader>pv', '<CMD>Ex<CR>', options)
end

local function init()
  set_augroup()
  set_vim_g()
  set_vim_o()
  set_vim_wo()
  set_keymaps()
end

return {
  init = init
}

