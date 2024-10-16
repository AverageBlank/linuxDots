-- Setup Lazy Nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require('lazy').setup {
  spec = {
    { 'tpope/vim-commentary' },
    { 'tpope/vim-surround' },
    { 'mbbill/undotree' },
    { 'lukas-reineke/indent-blankline.nvim' },
    { 'brenoprata10/nvim-highlight-colors' },
    { 'CRAG666/code_runner.nvim' },
    { 'nvim-lua/plenary.nvim' },
    { 'ThePrimeagen/harpoon' },
    { 'stevearc/conform.nvim' },
    { 'windwp/nvim-ts-autotag' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'L3MON4D3/LuaSnip' },
    { 'nvim-pack/nvim-spectre' },
    { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
    {
      'NeogitOrg/neogit',
      dependencies = {
        'nvim-lua/plenary.nvim', -- required
        'sindrets/diffview.nvim', -- optional - Diff integration
        'nvim-telescope/telescope.nvim', -- optional
      },
      config = true,
    },
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {},
      dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    },
    {
      'iamcco/markdown-preview.nvim',
      cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
      build = 'cd app && npm install',
      init = function()
        vim.g.mkdp_filetypes = { 'markdown' }
      end,
      ft = { 'markdown' },
    },
    {
      'stevearc/oil.nvim',
      opts = {},
      dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    {
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      config = true,
    },
    {
      'rcarriga/nvim-dap-ui',
      dependencies = {
        'nvim-neotest/nvim-nio',
        'mfussenegger/nvim-dap',
        'theHamsta/nvim-dap-virtual-text',
      },
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      dependencies = {
        'nvim-telescope/telescope.nvim',
        'nvim-lua/plenary.nvim',
      },
      build = 'make',
    },
    {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
    },
    {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    {
      'folke/todo-comments.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
      opts = {},
    },
    {
      'folke/trouble.nvim',
      cmd = 'Trouble',
      opts = {}, -- for default options, refer to the configuration section for custom setup.
    },
  },
  install = { colorscheme = { 'catppuccin-mocha' } },
  checker = { enabled = true, notify = false },
}
