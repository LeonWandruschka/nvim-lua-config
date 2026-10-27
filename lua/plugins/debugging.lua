return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    "stevearc/overseer.nvim",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    require("mason-nvim-dap").setup({
      ensure_installed = { "cppdbg" },
      automatic_installation = true,
    })
    dap.adapters.cppdbg = {
      id = "cppdbg",
      type = "executable",
      command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
    }
    require("dap.ext.vscode").type_to_filetypes.cppdbg = { "c", "cpp" }

    require("overseer").setup()
    dapui.setup()
    require("nvim-dap-virtual-text").setup()

    dap.listeners.before.attach.ui = function() dapui.open() end
    dap.listeners.before.launch.ui = function() dapui.open() end
    dap.listeners.before.event_terminated.ui = function() dapui.close() end
    dap.listeners.before.event_exited.ui = function() dapui.close() end

    vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
    vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticInfo" })

    local map = vim.keymap.set
    map("n", "<leader>bb", "<cmd>OverseerRun<cr>", { desc = "Run build task" })
    map("n", "<leader>dc", dap.continue, { desc = "Start / continue" })
    map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
    map("n", "<leader>dB", function()
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "Conditional breakpoint" })
    map("n", "<leader>do", dap.step_over, { desc = "Step over" })
    map("n", "<leader>di", dap.step_into, { desc = "Step into" })
    map("n", "<leader>du", dap.step_out, { desc = "Step out" })
    map("n", "<leader>dp", dap.pause, { desc = "Pause" })
    map("n", "<leader>dt", dap.terminate, { desc = "Terminate" })
    map("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
    map("n", "<leader>dl", dap.run_last, { desc = "Run last" })
    map("n", "<leader>dut", dapui.toggle, { desc = "Toggle debug UI" })
  end,
}
