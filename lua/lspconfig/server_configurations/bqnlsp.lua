local util = require 'lspconfig.util'

-- set os dependent library path
local function library_path(path)
  path = path or '/usr/local/lib'
  if vim.fn.has 'macunix' then
    return { DYLD_LIBRARY_PATH = path }
  elseif vim.fn.has 'linux' then
    return { LD_LIBRARY_PATH = path }
  end
end

return {
  default_config = {
    cmd = { 'bqnlsp' },
    filetypes = { 'bqn' },
    root_dir = util.find_git_ancestor,
    single_file_support = true,
    libcbqnPath = nil,
    on_new_config = function(new_config, _)
      if new_config.libcbqnPath then
        new_config.cmd_env = library_path(new_config.libcbqnPath)
      end
    end,
  },
  docs = {
    description = [[
https://git.sr.ht/~detegr/bqnlsp


`bqnlsp`, a language server for BQN.

The binary depends on the shared library of [CBQN](https://github.com/dzaima/CBQN) `libcbqn.so`.
If CBQN is installed system-wide (using `sudo make install` in its source directory) and `bqnlsp` errors that it can't find the shared library, update the linker cache by executing `sudo ldconfig`.
If CBQN has been installed in a non-standard directory or can't be installed globally pass `libcbqnPath = '/path/to/CBQN'` to the setup function.
This will set the environment variables `LD_LIBRARY_PATH` (Linux) or `DYLD_LIBRARY_PATH` (macOS) to the provided path.

  ]],
    default_config = {
      root_dir = [[util.find_git_ancestor]],
    },
  },
}
