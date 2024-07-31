SERVERON = false
local function get_command(filetype, quickRun)
  -- Getting Dir and FileName
  local dir = vim.fn.expand '%:p:h'
  local fileName = vim.fn.expand '%:t'
  -- C/C++
  if filetype == 'cpp' or filetype == 'c' then
    if filetype == 'cpp' then
      RUN = 'bash ~/.config/nvim/lua/config/coderunner/clangcpp.bash -d "'
    else
      RUN = 'bash ~/.config/nvim/lua/config/coderunner/clangc.bash -d "'
    end
    if quickRun then
      RUNWITH = ' '
    else
      RUNWITH = string.lower(vim.fn.input 'Run(r)/Rebuild(b)/DebugCompile(d)/Compile(c)/CompileAndRun(cr): ')
    end
    if RUNWITH == 'r' or RUNWITH == 'cr' then
      local args = vim.fn.input 'If required, enter arguments in format (numOfArgs+1<space>argsSeparatedBySpaces): '
      return RUN .. dir .. '" -f "' .. fileName .. '" -r "' .. RUNWITH .. '"' .. args
    else
      return RUN .. dir .. '" -f "' .. fileName .. '" -r "' .. RUNWITH .. '"'
    end
  -- Python
  elseif filetype == 'python' then
    return 'bash ~/.config/nvim/lua/config/coderunner/pythonpy.bash -d "$dir" -f "$fileName"'
  -- JavaScript
  elseif filetype == 'javascript' then
    return 'bash ~/.config/nvim/lua/config/coderunner/javascriptjs.bash -d "$dir" -f "$fileName"'
  -- HTML
  elseif filetype == 'html' then
    return 'xdg-open "$file"' -- Running native Linux
    -- return 'sensible-browser "$file"' -- WSL
    -- return 'open "$file"' -- Mac OS
    -- SH
  elseif filetype == 'sh' then
    -- RUN = 'bash ~/.config/nvim/lua/config/coderunner/bashsh.bash -d "$dir" -f "$fileName"'
    -- if quickRun then
    --   return RUN
    -- else
    --   local args = vim.fn.input 'If required, enter space separated arguments: '
    --   return RUN .. args
    -- end
    return 'bash ~/.config/nvim/lua/config/coderunner/bashsh.bash -d "$dir" -f "$fileName"'
  else
    return nil
  end
end

vim.keymap.set('n', '<leader>r', function()
  local filetype = vim.bo.filetype
  local quickRun = false
  local command = get_command(filetype, quickRun)
  if command then
    require('code_runner').setup {
      filetype = {
        [filetype] = command,
      },
    }
    vim.cmd 'RunCode'
    if filetype == 'html' then
      vim.cmd 'q'
    end
  else
    print 'Unsupported filetype'
  end
end, { noremap = true, silent = false, desc = 'Run Code' })

vim.keymap.set('n', '<leader><CR>', function()
  local filetype = vim.bo.filetype
  local quickRun = true
  local command = get_command(filetype, quickRun)
  if command then
    require('code_runner').setup {
      filetype = {
        [filetype] = command,
      },
    }
    vim.cmd 'RunCode'
    if filetype == 'html' then
      vim.cmd 'q'
    end
  else
    print 'Unsupported filetype'
  end
end, { noremap = true, silent = false, desc = 'Quick Run Code' })
