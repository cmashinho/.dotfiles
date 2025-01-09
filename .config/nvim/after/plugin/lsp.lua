require("lazydev").setup()

local cmp = require "cmp"
local lspkind = require "lspkind"
local luasnip = require('luasnip')
local kata_plugin = require "cmashinho.plugins.kata_package_picker"
-- TODO: move to other place?
kata_plugin.setup()
local kata_root_dirs = kata_plugin.get_all_python_sources()

lspkind.init {
  preset = "codicons",
}

require('luasnip.loaders.from_vscode').load()


local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = cmp.mapping.preset.insert {
  ["<C-p>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item(cmp_select)
    elseif luasnip.locally_jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end, { 'i', 's' }),
  ["<C-n>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item(cmp_select)
    elseif luasnip.locally_jumpable(1) then
      luasnip.jump(1)
    else
      fallback()
    end
  end, { 'i', 's' }),
  ["<C-y>"] = cmp.mapping(function()
    cmp.confirm({ select = true })
  end),
  ["<C-Space>"] = cmp.mapping.complete(),
  ["<Tab>"] = nil,
  ["<S-Tab>"] = nil,
}

cmp.setup {
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "luasnip" },
  },
  mapping = cmp_mappings,
  formatting = {
    format = lspkind.cmp_format {},
  },
  window = {
    completion = cmp.config.window.bordered { border = "rounded" },
    documentation = cmp.config.window.bordered { border = "rounded" },
  },
}

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("mason").setup {}
require("mason-lspconfig").setup {
  ensure_installed = { "lua_ls", "pylsp" },
  handlers = {
    function(server_name)
      require("lspconfig")[server_name].setup {}
    end,

    clangd = function()
      require('lspconfig').clangd.setup({})
    end,
    pylsp = function()
      require("lspconfig").pylsp.setup {
        capabilities = capabilities,
        settings = {
          pylsp = {
            plugins = {
              pycodestyle = {
                enabled = false,
              },
              pyflakes = {
                enabled = false,
              },
              flake8 = {
                enabled = true,
                -- config = "/home/sheldyaev/code/job/kata-dev4.0-poc/.flake8",
                extendSelect = { "WPS" },
              },
              pylint = {
                enabled = true,
                -- args = { "--rcfile /home/sheldyaev/code/job/kata-dev4.0-poc/.pylintrc" },
                args = { "--disable=C,W,R" }
              },
              pylsp_mypy = {
                live_mode = false,
                dmypy = true,
                dmypy_status_file = "/tmp/.dmypy.json",
                report_progress = true,
                overrides = {
                  true,
                  -- "--config-file",
                  -- "/home/sheldyaev/code/job/kata-dev4.0-poc/.mypy.ini",
                  "--disallow-untyped-defs",
                  "--disallow-any-generics",
                  "--warn-redundant-cast",
                  "--warn-unreachable",
                  "--warn-unused-ignores",
                  "--strict-equality",
                  "--enable-error-code",
                  "redundant-expr",
                  "--ignore-missing-imports",
                  -- "--follow-imports",
                  -- "silent",
                  "--exclude=tests/**",
                  "--check-untyped-defs",
                },
              },
              jedi = {
                extra_paths = kata_root_dirs,
                prioritize_extra_paths = true,
              },
              jedi_completion = {
                include_params = true,
              }
            },
            configurationSources = { "flake8" },
          },
        },
      }
    end,
    lua_ls = function()
      require("lspconfig").lua_ls.setup {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      }
    end,
  },
}

local autocmd = require("cmashinho.auto").autocmd
local autocmd_clear = vim.api.nvim_clear_autocmds
local augroup_highlight = vim.api.nvim_create_augroup("custom-lsp-references", { clear = true })


local lspconfig_defaults = require("lspconfig").util.default_config
lspconfig_defaults.capabilities =
    vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local bufnr = event.buf
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "<leader>rr", "<cmd>LspRestart<CR>", { buffer = false })

    vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts)
    vim.keymap.set("n", "gD", function()
      vim.lsp.buf.declaration()
    end, opts)
    vim.keymap.set("n", "gT", function()
      vim.lsp.buf.type_declaration()
    end, opts)
    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover({ border = "single" })
    end, opts)
    vim.keymap.set("n", "<leader>vws", function()
      vim.lsp.buf.workspace_symbol()
    end, opts)
    vim.keymap.set("n", "<leader>vd", function()
      vim.diagnostic.open_float()
    end, opts)
    vim.keymap.set("n", "<M-j>", function()
      vim.diagnostic.goto_next()
    end, opts)
    vim.keymap.set("n", "<M-k>", function()
      vim.diagnostic.goto_prev()
    end, opts)
    vim.keymap.set("n", "<leader>ca", function()
      vim.lsp.buf.code_action()
    end, opts)
    vim.keymap.set("n", "<leader>cr", function()
      vim.lsp.buf.rename()
    end, opts)
    vim.keymap.set("n", "<leader>vrr", "<cmd>Telescope lsp_references<cr>", { buffer = bufnr })
    vim.keymap.set("i", "<C-k>", function()
      vim.lsp.buf.signature_help { border = "rounded" }
    end, opts)

    local id = vim.tbl_get(event, "data", "client_id")
    local client = id and vim.lsp.get_client_by_id(id)
    if client == nil then
      return
    end

    if client.server_capabilities.documentHighlightProvider then
      autocmd_clear { group = augroup_highlight, buffer = bufnr }
      autocmd { "CursorHold", augroup_highlight, vim.lsp.buf.document_highlight, bufnr }
      autocmd { "CursorMoved", augroup_highlight, vim.lsp.buf.clear_references, bufnr }
    end
  end,
})

vim.diagnostic.config {
  virtual_text = true,
}
