local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

local packer_bootstrap = false
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
  packer_bootstrap = true
end

-- setup file
local function get_setup(name)
  return string.format("require('setup.%s')", name)
end

local packer = require 'packer'
return packer.startup(function (use)
  use 'wbthomason/packer.nvim' -- have packer manage itself
  use 'nvim-lua/popup.nvim'

  use { 'preservim/nerdtree', config = get_setup('nerdtree') }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = get_setup('telescope')
  }
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    config = get_setup('telescope_fzf_native'),
    run = 'make'
  }

  use {
    'folke/tokyonight.nvim',
    event = 'VimEnter',
    config = get_setup('tokyonight')
  }

  -- lsp support
  use { 'neovim/nvim-lspconfig', config = get_setup('lsp') }
  use { 'williamboman/nvim-lsp-installer', config = get_setup('lsp-installer') }
  use 'hrsh7th/cmp-nvim-lsp' -- completion
  use 'hrsh7th/cmp-nvim-lua'

  -- snippets
  use {
    'L3MON4D3/LuaSnip',
    config = get_setup('luasnip')
  }
  use 'rafamadriz/friendly-snippets'
  use 'saadparwaiz1/cmp_luasnip' -- completion

  -- completion engine
  use { 'hrsh7th/nvim-cmp', config = get_setup('cmp') }
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = get_setup('treesitter')
  }

  if packer_bootstrap then
    packer.sync()
  end
end)

