-- debug.lua
-- Shows how to use the DAP plugin to debug your code.

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'mxsdev/nvim-dap-vscode-js',
    {
      'microsoft/vscode-js-debug',
      lazy = true,
      build = 'npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out',
    },
    {
      'Joakker/lua-json5',
      build = './install.sh'
    }
  },

  config = function()
    local dap, dapui = require 'dap', require 'dapui'

    -- https://github.com/neovim/neovim/issues/21749#issuecomment-1378720864
    -- Fix loading of json5
    table.insert(vim._so_trails, '/?.dylib')

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'node-debug2-adapter',
        'js-debug-adapter',
      },
      automatic_installation = true,
    }
    -- Install javascript specific config
    require('dap-vscode-js').setup({
      debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
      adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
    })
    -- javascript application debugging configuration
    local js_based_languages = { "typescript", "javascript", "typescriptreact" }

    for _, language in ipairs(js_based_languages) do
      dap.configurations[language] = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach to process',
          processId = require 'dap.utils'.pick_process,
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-chrome',
          request = 'launch',
          name = 'Start Chrome with \'localhost\'',
          url = 'http://localhost:3000',
          webRoot = '${workspaceFolder}',
          userDataDir = '${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir'
        },
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Debug Brainbirds Middleware Local',
          port = 9229,
          restart = true,
          localRoot = '${workspaceFolder}',
          remoteRoot = '${workspaceFolder}',
          cwd = '${workspaceFolder}',
          -- skipFiles = [
          --   '<node_internals>/**/*.js',
          --   '${workspaceFolder}/node_modules/**/*.js'
          -- ]
        }
      }
    end
    -- Load configurations from launch.json - but I can't figure out how to configure the node adapter
    -- require('dap.ext.vscode').load_launchjs(nil, {
    --   node = js_based_languages,
    --   ['pwa-node'] = js_based_languages,
    --   chrome = js_based_languages,
    --   ['pwa-chrome'] = js_based_languages,
    -- })

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Debug: Start/[C]ontinue' })
    vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Debug: Step [I]nto' })
    vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'Debug: Step [O]ver' })
    vim.keymap.set('n', '<leader>dr', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle [B]reakpoint' })
    vim.keymap.set('n', '<leader>dB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set [B]reakpoint' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<leader>dt', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
  end,
}
