-- Leader Keys
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- File Management
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<CR>')

-- Changes to file
vim.keymap.set('n', '<C-s>', vim.cmd.w)
vim.keymap.set('i', '<C-s>', '<cmd>w<CR><C-c>')
vim.keymap.set('i', '<C-z>', '<C-u>')

-- Exit vim
vim.keymap.set('n', '<leader>w', '<cmd>wqa<CR>')
vim.keymap.set('n', '<leader>q', '<cmd>qa!<CR>')

-- Close pane
vim.keymap.set('n', '<leader>c', '<C-w>c')

-- Move Up and Down in visual mode
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")

-- Center C-u and C-d
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Yank and Paste from system clipboard
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>p', '"+p')

-- Tabs
vim.keymap.set('n', '<leader>1', '1gt')
vim.keymap.set('n', '<leader>2', '2gt')
vim.keymap.set('n', '<leader>3', '3gt')
vim.keymap.set('n', '<leader>4', '4gt')
vim.keymap.set('n', '<leader>5', '5gt')
vim.keymap.set('n', '<leader>6', '6gt')
vim.keymap.set('n', '<leader>7', '7gt')
vim.keymap.set('n', '<leader>8', '8gt')
vim.keymap.set('n', '<leader>9', '9gt')
vim.keymap.set('n', '<leader>tc', vim.cmd.tabclose)
vim.keymap.set('n', '<leader>to', function()
  vim.cmd 'tabe'
  require('telescope.builtin').find_files {}
end)

-- Exit terminal
vim.keymap.set('t', '<C-o>', '<C-\\><C-n>')

-- Change between splits
vim.keymap.set('n', '<C-h>', '<C-w><C-h>')
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')
vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')

-- Telescope
local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader><space>', builtin.find_files, { desc = 'Show file search' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Show Help' })
vim.keymap.set('n', '<leader>/', builtin.live_grep, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sn', function()
  builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = '[ ] Find existing buffers' })

-- Undo Tree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

-- Vim Fugitive
vim.keymap.set('n', '<leader>gs', vim.cmd.Git)

-- Code Runner
vim.keymap.set('n', '<leader>r', ':RunCode<CR>', { noremap = true, silent = false })

-- LSP
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  end,
})

-- Format File
vim.keymap.set('n', '<leader>f', function()
  require('conform').format { async = true, lsp_fallback = true }
end)

-- Todo Comments
vim.keymap.set('n', '<leader>t', '<cmd>TodoTelescope<CR>')

-- Debugger
local dap = require 'dap'
local dapui = require 'dapui'
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, {})
vim.keymap.set('n', '<F1>', dap.continue)
vim.keymap.set('n', '<F2>', dap.step_into)
vim.keymap.set('n', '<F3>', dap.step_over)
vim.keymap.set('n', '<F5>', dap.step_out)
vim.keymap.set('n', '<F5>', dap.step_back)
vim.keymap.set('n', '<F9>', dapui.toggle)
vim.keymap.set('n', '<F10>', dap.disconnect)
vim.keymap.set('n', '<F12>', dap.restart)
vim.keymap.set('n', '<leader>?', function()
  require('dapui').eval(nil, { enter = true })
end)

-- Compile C/C++ Files
vim.keymap.set('n', '<leader>cp', '<cmd>!g++ -g % -o %:r<CR>')
vim.keymap.set('n', '<leader>cc', '<cmd>!gcc -g % -o %:r<CR>')
