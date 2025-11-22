return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    require("mason").setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- Set up diagnostic signs
    local signs = {
      { name = "DiagnosticSignError", text = "✖" },
      { name = "DiagnosticSignWarn", text = "⚠" },
      { name = "DiagnosticSignInfo", text = "ℹ" },
      { name = "DiagnosticSignHint", text = "➤" },
    }

    local sign_icons = {}
    for _, sign in ipairs(signs) do
      local severity_name = sign.name:match("DiagnosticSign(.+)")
      if severity_name then
        local severity = vim.diagnostic.severity[severity_name:upper()]
        if severity then
          sign_icons[severity] = sign.text
        end
      end
    end

    vim.diagnostic.config({
      signs = {
        text = sign_icons,
      },
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    -- LSP server configurations
    local servers = {
      html = {},
      cssls = {},
      jsonls = {},

      -- clang
      clangd = {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
        },
        capabilities = capabilities,
      },

      -- rust
      rust_analyzer = {
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              runBuildScripts = true,
            },
            checkOnSave = {
              command = "clippy",
            },
            procMacro = {
              enable = true,
            },
            inlayHints = {
              chainingHints = { enable = true },
              parameterHints = { enable = true },
              typeHints = { enable = true },
            },
          },
        },
      },

      -- python
      pyright = {
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
      },

      -- typescript/javascript
      ts_ls = {
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      },

      -- go
      gopls = {
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
            gofumpt = true,
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
      },

      -- bash
      bashls = {
        settings = {
          bashIde = {
            globPattern = "*@(.sh|.inc|.bash|.command)",
          },
        },
        filetypes = { "sh", "bash" },
      },

      -- zig
      zls = {
        settings = {
          zls = {
            enable_autofix = true,
            enable_snippets = true,
            enable_build_on_save = true,
            enable_inlay_hints = true,
            inlay_hints_show_builtin = true,
            inlay_hints_exclude_single_argument = false,
            warn_style = true,
            highlight_global_var_declarations = true,
          },
        },
      },

      -- lua
      lua_ls = {
        settings = {
          Lua = {
            format = {
              enable = true,
              defaultConfig = {
                indent_style = "space",
                indent_size = "2",
              },
            },
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME },
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      },
    }

    local ensure_installed = {
      "clangd",
      "rust-analyzer",
      "lua-language-server",
      "stylua",
      "eslint-lsp",
      "prettier",
      "emmet-language-server",
      "json-lsp",
      "selene",
      "shellcheck",
      "shfmt",
      "js-debug-adapter",
      "css-lsp",
      "tailwindcss-language-server",
      "typescript-language-server",
      "zls",
      "solargraph",
      "pyright",
      "gopls",
      "bash-language-server",
    }

    require("mason-tool-installer").setup({
      ensure_installed = ensure_installed,
      auto_update = false,
      run_on_start = true,
    })

    -- Set up LSP servers
    local lspconfig = require("lspconfig")
    for server_name, server_opts in pairs(servers) do
      local opts = vim.tbl_deep_extend("force", {
        capabilities = capabilities,
      }, server_opts or {})

      lspconfig[server_name].setup(opts)
    end

    -- LSP keymappings on attach
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Navigation
        map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
        map("gD", vim.lsp.buf.declaration, "Goto Declaration")
        map("gr", require("telescope.builtin").lsp_references, "Goto References")
        map("gI", require("telescope.builtin").lsp_implementations, "Goto Implementation")
        map("<leader>td", require("telescope.builtin").lsp_type_definitions, "Type Definition")
        map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
        map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")

        -- Refactoring
        map("<leader>rn", vim.lsp.buf.rename, "Rename")
        map("<leader>ca", vim.lsp.buf.code_action, "Code Action")

        -- signature help
        map("<C-k>", vim.lsp.buf.signature_help, "Signature Help")

        -- Documentation
        map("K", vim.lsp.buf.hover, "Hover Documentation")

        -- Formatting (if server supports it)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentFormattingProvider then
          map("<leader>f", function()
            vim.lsp.buf.format({ async = true })
          end, "Format Document")
        end

        -- Document highlight
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })
  end,
}
