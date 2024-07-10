-- Telescope
require('telescope').setup()
require('telescope').load_extension('fzf')


-- Color Scheme
color = color or "rose-pine"
vim.cmd.colorscheme(color)
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })


-- Treesitter
require 'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all" (the listed parsers MUST always be installed)
    ensure_installed = { "c", "lua", "vim", "markdown", "cpp", "javascript", "typescript", "python" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    highlight = {
        enable = true,

        additional_vim_regex_highlighting = false,
    },
}


-- Auto Close Bracket
require("autoclose").setup()


-- LSP
local lsp = require('lsp-zero')

lsp.preset('recommended')


local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cpm_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cpm_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { "eslint", "tsserver", "pyright", "clangd", "lua_ls", "bashls", "emmet_language_server" },
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
    },
})
lsp.setup()


-- Autoclose html Tags
require('nvim-ts-autotag').setup()


-- Neo Tree
require("neo-tree").setup({
    window = {
        mappings = {
            ["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
        }
    }
})


-- Lua line
require("lualine").setup({
    options = { theme = "rose-pine" },
})


-- Highlight Indents
local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}
local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

vim.g.rainbow_delimiters = { highlight = highlight }
require("ibl").setup { scope = { highlight = highlight } }

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)


-- Code Runner
require('code_runner').setup({
    filetype = {
        javascript = "bash ~/.config/nvim/lua/coderunner/javascriptjs.bash -d $dir -f $fileName",
        python = "bash ~/.config/nvim/lua/coderunner/pythonpy.bash -d $dir -f $fileName",
        c = "bash ~/.config/nvim/lua/coderunner/clangc.bash -d $dir -f $fileName",
        cpp = "bash ~/.config/nvim/lua/coderunner/clangcpp.bash -d $dir -f $fileName",
    },
})


-- Conform (Auto Format)
require("conform").setup({
    notify_on_error = false,
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true
    },
    formatters_by_ft = {
        lua = { 'stylua' },
        python = { "black" },
        javascript = { { "prettierd", "prettier" } },
        html = { { "prettierd", "prettier" } },
        c = { "clang-format" },
        cpp = { "clang-format" }
    },

})
