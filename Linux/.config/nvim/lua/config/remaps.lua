-- Leader Keys
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Eror Messages
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous error message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next error message' })
vim.keymap.set('n', '<leader>f', vim.diagnostic.setloclist, { desc = 'Show all error messages' })

-- File Management
vim.keymap.set('n', '<leader>e', vim.cmd.Ex, { desc = 'Open Netrw' })

-- Changes to file
vim.keymap.set('n', '<C-s>', vim.cmd.w, { desc = 'Save file' })
vim.keymap.set('i', '<C-s>', '<cmd>w<CR><C-c>', { desc = 'Save file' })
vim.keymap.set('i', '<C-z>', '<Esc>ua', { desc = 'Undo Changes' })

-- Exit vim
vim.keymap.set('n', '<leader>w', '<cmd>wqa<CR>', { desc = 'Save and quit' })
vim.keymap.set('n', '<leader>q', '<cmd>qa!<CR>', { desc = 'Quit without saving' })

-- Splits
vim.keymap.set('n', '<leader>c', '<C-w>c', { desc = 'Close highlighted split' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move to left split' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move to right split' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move to top split' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move to bottom split' })

-- Move Up and Down in visual mode
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move highlighted line up in visual mode' })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move highlighted line down in visual mode' })

-- Center C-u and C-d
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Page up but centered' })
vim.keymap.set('n', '<C-u>', '<C-u>', { desc = 'Page down but centered' })

-- Yank and Pastes
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'System Clipboard Paste' })
vim.keymap.set('v', '<leader>p', '"+p', { desc = 'System Clipboard Yank' })
vim.keymap.set('i', '<C-a>', '<Esc>pa', { desc = 'Paste in insert mode' })
vim.keymap.set('n', '<CR>', 'o<Esc>', { desc = 'Create new line without exiting normal mode' })

-- Tabs
vim.keymap.set('n', '<leader>1', '1gt', { desc = 'Swap to tab 1' })
vim.keymap.set('n', '<leader>2', '2gt', { desc = 'Swap to tab 2' })
vim.keymap.set('n', '<leader>3', '3gt', { desc = 'Swap to tab 3' })
vim.keymap.set('n', '<leader>4', '4gt', { desc = 'Swap to tab 4' })
vim.keymap.set('n', '<leader>5', '5gt', { desc = 'Swap to tab 5' })
vim.keymap.set('n', '<leader>6', '6gt', { desc = 'Swap to tab 6' })
vim.keymap.set('n', '<leader>7', '7gt', { desc = 'Swap to tab 7' })
vim.keymap.set('n', '<leader>8', '8gt', { desc = 'Swap to tab 8' })
vim.keymap.set('n', '<leader>9', '9gt', { desc = 'Swap to tab 9' })
vim.keymap.set('n', '<leader>tc', vim.cmd.tabclose, { desc = 'Close current tab' })
vim.keymap.set('n', '<leader>to', function()
  vim.cmd 'tabe'
  require('telescope.builtin').find_files {}
end, { desc = 'Open new tab' })

-- Exit terminal
vim.keymap.set('t', '<C-o>', '<C-\\><C-n>', { desc = 'Exit insert mode inside terminal' })

-- Telescope
local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader><space>', builtin.find_files, { desc = 'Show file search' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Show Help' })
vim.keymap.set('n', '<leader>/', builtin.live_grep, { desc = 'Search word between files' })
vim.keymap.set('n', '<leader>sn', function()
  builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Search Keymaps' })
vim.keymap.set('n', '<leader>.', builtin.oldfiles, { desc = 'Search Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Search between existing buffers' })

-- Undo Tree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Show undo tree' })

-- Vim Fugitive
vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = 'Git status' })

-- Code Runner
vim.keymap.set('n', '<leader>r', ':RunCode<CR>', { noremap = true, silent = false, desc = 'Run Code' })

-- LSP
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')
    map('gr', require('telescope.builtin').lsp_references, 'Goto References')
    map('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
    map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')
  end,
})

-- Format File
vim.keymap.set('n', '<leader>af', function()
  require('conform').format { async = true, lsp_fallback = true }
end, { desc = 'Format File' })

-- Todo Comments
vim.keymap.set('n', '<leader>t', '<cmd>TodoTelescope<CR>', { desc = 'Search for todo comments' })

-- Debugger
local dap = require 'dap'
local dapui = require 'dapui'
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint' })
vim.keymap.set('n', '<F1>', dap.continue, { desc = 'Start Dap(debugging)' })
vim.keymap.set('n', '<F2>', dap.step_into, { desc = 'Step into' })
vim.keymap.set('n', '<F3>', dap.step_over, { desc = 'Step over' })
vim.keymap.set('n', '<F5>', dap.step_out, { desc = 'Step out' })
vim.keymap.set('n', '<F5>', dap.step_back, { desc = 'Start back' })
vim.keymap.set('n', '<F9>', dapui.toggle, { desc = 'Toggle Dap(debugging) ui' })
vim.keymap.set('n', '<F10>', dap.disconnect, { desc = 'Stop/Kill Dap(debugging)' })
vim.keymap.set('n', '<F12>', dap.restart, { desc = 'Restart Dap(debugging)' })
vim.keymap.set('n', '<leader>?', function()
  require('dapui').eval(nil, { enter = true })
end, { desc = 'Show variabel info' })

-- Compile C/C++ Files
vim.keymap.set('n', '<leader>gp', '<cmd>!g++ -g % -o %:r<CR>', { desc = 'Compile C++ file' })
vim.keymap.set('n', '<leader>gc', '<cmd>!gcc -g % -o %:r<CR>', { desc = 'Compile C file' })
