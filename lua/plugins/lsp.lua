local root_files = {
  '.luarc.json',
  '.luarc.jsonc',
  '.luacheckrc',
  '.stylua.toml',
  'stylua.toml',
  'selene.toml',
  'selene.yml',
  '.git',
}

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "stevearc/conform.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "Saghen/blink.cmp",
    "j-hui/fidget.nvim",
    {
      "folke/lazydev.nvim",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },

  config = function()
    require("conform").setup({
      formatters_by_ft = {
      }
    })

    local capabilities = require('blink.cmp').get_lsp_capabilities()

    require("fidget").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "ruff",
        "clangd",
        "ocamllsp",
      },
      handlers = {
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities
          }
        end,

        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup {
            capabilities = capabilities,
          }
        end,

        ['ruff'] = function()
          local lspconfig = require("lspconfig")
          lspconfig.ruff.setup {
            capabilities = capabilities,
            root_dir = lspconfig.util.root_pattern(".git", "pyproject.toml", "setup.py", "requirements.txt"),
            settings = {
              args = {
                "--select", "E,F,W,C"
              }
            }
          }
        end,

        ["clangd"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.clangd.setup {
            capabilities = capabilities,
            root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git") or vim.loop.cwd,
          }
        end,

        ["ocamllsp"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.ocamllsp.setup {
            capabilities = capabilities,
            root_dir = lspconfig.util.root_pattern("*.opam", "dune-project", "dune", ".git") or vim.loop.cwd,
            filetypes = { "ocaml", "ocaml.menhir", "ocaml.interface", "reason" },
            settings = {
              codelens = { enable = true },
              inlayHints = { enable = true }
            }
          }
        end

      }
    })

    vim.diagnostic.config({
      -- update_in_insert = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        header = "",
        prefix = "",
      },
    })

    -- Keymaps for diagnostics
    local opts = { noremap = true, silent = true }
    vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts) -- Show diagnostics for current line
    -- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- Next diagnostic
    -- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- Previous diagnostic
    vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, opts) -- Populate location list with diagnostics
    vim.keymap.set("n", "<leader>lt", function()
      local config = vim.diagnostic.config()
      vim.diagnostic.config({ signs = not config.signs }) -- Toggle diagnostic signs
    end, opts)                                            -- Toggle diagnostic signs (e.g., W, E)
  end
}
