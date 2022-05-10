local packer = nil

local fn = vim.fn
local cmd = vim.api.nvim_command

local function packer_verify()
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    cmd 'packadd packer.nvim'
  end
end

local function packer_startup()
  if packer == nil then
    packer = require'packer'
    packer.init()
  end

  local use = packer.use
  packer.reset()

  -- Packer
  use 'wbthomason/packer.nvim'

  -- Common Dependencies
  use 'nvim-lua/plenary.nvim'

  -- Theming
  use {
    'folke/tokyonight.nvim',
    config = function ()
      require'hbjydev.plugins.tokyonight'.init()
    end
  }

  -- Language Servers
  use {
    'lspcontainers/lspcontainers.nvim',
    requires = {
      'neovim/nvim-lspconfig',
      'nvim-lua/lsp_extensions.nvim',
      'folke/lsp-colors.nvim',
    },
    config = function()
      require'lspcontainers'.setup({
        ensure_installed = {
          'bashls',
          'dockerls',
          'gopls',
          'html',
          'pylsp',
          'sumneko_lua',
          'terraformls',
          'tsserver',
          'yamlls'
        }
      })

      require'hbjydev.plugins.lspconfig'.init()
    end
  }
  use 'hashivim/vim-terraform'

  use {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require"trouble".setup()
      vim.api.nvim_set_keymap("n", "<leader>hh", "<cmd>Trouble<cr>",
        {
          silent = true,
          noremap = true
        }
      )
    end
  }

  -- Completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
      'ray-x/cmp-treesitter',
      'onsails/lspkind-nvim'
    },
    config = function ()
      require'hbjydev.plugins.cmp'.init()
      require'hbjydev.plugins.lspkind'.init()
    end
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = 'TSUpdate',
    config = function()
      require'hbjydev.plugins.treesitter'.init()
    end
  }

  -- Telescope
  use 'nvim-lua/popup.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    --requires = 'rmagatti/session-lens',
    config = function ()
      require'hbjydev.plugins.telescope'.init()
    end
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = function ()
      require'hbjydev.plugins.gitsigns'.init()
    end
  }

  use {
    'hoob3rt/lualine.nvim',
    config = function ()
      require'hbjydev.plugins.lualine'.init()
    end
  }

end

local function init()
  packer_verify()
  packer_startup()
end

return {
  init = init,
}

