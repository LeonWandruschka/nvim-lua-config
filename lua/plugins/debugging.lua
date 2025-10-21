-- NVIM config for debugging
-- Requires: mason-nvim-dap and mason installed

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "stevearc/overseer.nvim",
    "nvim-neotest/nvim-nio",
    "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local overseer = require("overseer")
    local mason_dap = require("mason-nvim-dap")

    -- ╭──────────────────────────────────────────────╮
    -- │ Mason DAP Setup                              │
    -- ╰──────────────────────────────────────────────╯
    mason_dap.setup({
      ensure_installed = { "cppdbg" },
      automatic_installation = true,
      handlers = {
        function(config)
          mason_dap.default_setup(config)
        end,
      },
    })

    -- ╭──────────────────────────────────────────────╮
    -- │ cppdbg Adapter (Microsoft C++ DAP)           │
    -- ╰──────────────────────────────────────────────╯
    dap.adapters.cppdbg = {
      id = "cppdbg",
      type = "executable",
      command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
    }

    -- ╭──────────────────────────────────────────────╮
    -- │ Debug Configurations for C/C++               │
    -- ╰──────────────────────────────────────────────╯
    dap.configurations.c = {
      {
        name = "Launch file (cppdbg)",
        type = "cppdbg",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = false,
        MIMode = "lldb", -- or "gdb" if you prefer
        miDebuggerPath = "/opt/homebrew/opt/llvm/bin/lldb", -- adjust for macOS
      },
      {  name = "Attach to OpenOCD (RP2040)",
        type = "cppdbg",
        request = "launch", -- MUST remain "launch" for bare metal
        MIMode = "gdb",
        miDebuggerPath = "/opt/homebrew/bin/arm-none-eabi-gdb",
        miDebuggerServerAddress = "localhost:3333",
        cwd = "${workspaceFolder}",
        stopAtEntry = true,
        runInTerminal = false,
        targetArchitecture = "arm", -- ✅ Cortex-M0+ (RP2040)
        program = function()
          return vim.fn.input(
            "Path to ELF: ", vim.fn.getcwd() .. "/build/A0.elf", "file")
        end,
        -- preLaunchTask = "monitor reset",
        --[[setupCommands = {
          { text = "monitor reset", description = "Reset target" },
          { text = "break main", description = "Set breakpoint" },
        },]]--
        setupCommands = {
          {
            text = "monitor reset", -- optional alternative for RP2040
            description = "Initialize target",
            ignoreFailures = true,
          },
          {
            text = "break main", -- optional: break at main
            description = "Set breakpoint at main",
            ignoreFailures = true,
          },
        },
      },
    }
    dap.configurations.cpp = dap.configurations.c

    -- ╭──────────────────────────────────────────────╮
    -- │ Overseer, UI, Signs, Keymaps                 │
    -- ╰──────────────────────────────────────────────╯

    overseer.setup()

    -- Add keymap to trigger Overseer build/run tasks
    vim.keymap.set(
      "n",
      "<leader>bb",
      ":OverseerRun<CR>",
      { noremap = true, silent = true, desc = "Run build task (Overseer)" }
    )

    dapui.setup()
    require("nvim-dap-virtual-text").setup()

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
    vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticInfo" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "✖", texthl = "DiagnosticError" })

    local map = vim.keymap.set
    map("n", "<leader>dc", dap.continue, { desc = "Start/Continue Debugging" })
    map("n", "<leader>do", dap.step_over, { desc = "Step Over" })
    map("n", "<leader>di", dap.step_into, { desc = "Step Into" })
    map("n", "<leader>du", dap.step_out, { desc = "Step Out" })
    map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
    map("n", "<leader>B", function()
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "Conditional Breakpoint" })
    map("n", "<leader>dr", dap.repl.open, { desc = "Open DAP REPL" })
    map("n", "<leader>dl", dap.run_last, { desc = "Run Last Debug Session" })
    map("n", "<leader>dut", dapui.toggle, { desc = "Toggle DAP UI" })
  end,
}

