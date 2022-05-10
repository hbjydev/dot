local function on_attach(client, bufnr)
  local opts = { noremap = true, silent = true }
  local function map(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- gotos
  map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

  -- context
  map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

  -- actions
  map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

  -- diagnostics
  map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  map('n', 'gl', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>', opts)
  map('n', ']d', '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)

  if client.server_capabilities.document_formatting then
    map('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  end

  if client.server_capabilities.document_range_formatting then
    map("v", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  if client.server_capabilities.document_highlight then
    vim.api.nvim_exec([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- config that activates keymaps and enables snippet support
local function make_config()
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    }
  }

  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
  }
end

local function init()
  local lspconfig_servers = {
--    "cssls",
--    "elixirls",
--    "jsonnet_ls",
--    "sqlls",
  }

  local lspcontainer_servers = {
    "bashls",
    "dockerls",
    "gopls",
    "html",
    "jsonls",
    "pylsp",
    "sumneko_lua",
    "terraformls",
    "tsserver",
    "yamlls"
  }

  for _, server in pairs(lspconfig_servers) do
    local config = make_config()

    require'lspconfig'[server].setup(config)
  end

  for _, server in pairs(lspcontainer_servers) do
    local config = make_config()

    require'hbjydev.plugins.lspcontainers'.setup(config, server)

    require'lspconfig'[server].setup(config)
  end
end

return {
  init = init
}

