`:noa w`: Save file without any auto command (useful for large files)

https://github.com/neovim/neovim/wiki/FAQ#backtrace-macos--osx
https://github.com/nvim-lua/plenary.nvim#plenaryprofile
How to dbg neovim: https://www.reddit.com/r/neovim/comments/lnd22u/comment/gnzz5ok/?utm_source=share&utm_medium=web2x&context=3

## Debugging

1. `<leader>db` to add a breakpoint.
2. If you have a `.vscode/launch.json` for your project, run `:DapLoadLaunchJSON` to load it.
3. `F5` to start the program.
4. `F10` step over
5. `F11` step into
6. `F12` step out

Make sure the program is compiled with debug support, for instance, a C project requires to be built with `-g` flag.
If there are any problems, enable the TRACE log level for the dap plugin and check the logs with `:DapShowLog`

If it logs an error like this:

```
Debug adapter didn't respond. Either the adapter is slow (then wait and ignore this) or there is a problem with your adapter ...
```

The debugger might be working fine, it just too slow to start. So, wait a bit more, something like a minute to confirm whether or not it is working.

## Updating dependencies

- To update all Neovim packages, run the command `:Lazy sync`.
- To update all Mason dependencies, run the command `:Mason` and hit `U`.

## Troubleshooting

Given this error:

```
Error executing vim.schedule lua callback: ...eovim/0.10.2_1/share/nvim/runtime/lua/vim/lsp/client.lua:771: Invalid 'data': Cannot convert given Lua table
stack traceback:
        [C]: in function 'nvim_exec_autocmds'
```

Possibly some lua lsp configuration is incorrect. Try commenting the whole options data in `lua_ls.lua` and uncomment parts of it to find out what is broken.

## Lua tips

To print table data in neovim use `print(vim.inspect(data))`.
`
