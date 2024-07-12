local function get_command(filetype)
  -- Getting Dir and FileName
  local dir = vim.fn.expand '%:p:h'
  local fileName = vim.fn.expand '%:t'

  -- C++
  if filetype == 'cpp' then
    local runwith = string.lower(vim.fn.input 'Run(r)/Rebuild(b)/Compile(c)/CompileAndRun(cr): ')
    if runwith == 'r' or runwith == 'cr' then
      local cppargs =
        string.lower(vim.fn.input 'If required, enter arguments in format (numOfArgs+1<space>argsSeparatedBySpaces): ')
      return 'bash ~/.config/nvim/lua/config/coderunner/clangcpp.bash -d "'
        .. dir
        .. '" -f "'
        .. fileName
        .. '" -r "'
        .. runwith
        .. '" '
        .. cppargs
    else
      return 'bash ~/.config/nvim/lua/config/coderunner/clangcpp.bash -d "'
        .. dir
        .. '" -f "'
        .. fileName
        .. '" -r "'
        .. runwith
        .. '"'
    end
  -- C
  elseif filetype == 'c' then
    local runwith = string.lower(vim.fn.input 'Run(r)/Rebuild(b)/Compile(c)/CompileAndRun(cr): ')
    if runwith == 'r' or runwith == 'cr' then
      local cargs =
        string.lower(vim.fn.input 'If required, enter arguments in format (numOfArgs+1<space>argsSeparatedBySpaces): ')
      return 'bash ~/.config/nvim/lua/config/coderunner/clangc.bash -d "'
        .. dir
        .. '" -f "'
        .. fileName
        .. '" -r "'
        .. runwith
        .. '" '
        .. cargs
    else
      return 'bash ~/.config/nvim/lua/config/coderunner/clangc.bash -d "'
        .. dir
        .. '" -f "'
        .. fileName
        .. '" -r "'
        .. runwith
        .. '"'
    end
  -- Python
  elseif filetype == 'python' then
    return 'bash ~/.config/nvim/lua/config/coderunner/pythonpy.bash -d "$dir" -f "$fileName"'
  -- JavaScript
  elseif filetype == 'javascript' then
    return 'bash ~/.config/nvim/lua/config/coderunner/javascriptjs.bash -d "$dir" -f "$fileName"'
  else
    return nil
  end
end

vim.keymap.set('n', '<leader>r', function()
  local filetype = vim.bo.filetype
  local command = get_command(filetype)
  if command then
    require('code_runner').setup {
      filetype = {
        [filetype] = command,
      },
    }
    vim.cmd 'RunCode'
  else
    print 'Unsupported filetype'
  end
end, { noremap = true, silent = false, desc = 'Run Code' })
