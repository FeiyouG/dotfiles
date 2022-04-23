local M = {
  "mickael-menu/zk-nvim",
  ft = { "markdown" },
}

M.config = function()
  local zk = require('zk')
  local map = vim.api.nvim_set_keymap
  local silent = { noremap = true, silent = true }


  ---- MARK: Key Mappings ----
  map("n", "<leader>zf", "<cmd>ZkNotes { sort = { 'modified' } }<CR>", silent)
  -- map( "n", "<leader>zj", "<cmd>ZkNotes { path = 'journal', sort = { 'created' } }<CR>", opts)
  map("n", "<leader>zt", "<cmd>ZkTags<CR>", silent)
  map("n", "<leader>zi", "<cmd>ZkIndex<CR>", silent)

  -- Search note that matches the selection under curosr
  map("v", "<leader>zm", "<cmd>'<,'>ZkMatch<CR>", silent)

  map("n", "<leader>zN", "<cmd>ZkNew { title = vim.fn.input('Zettel Title: ') }<CR>", silent)
  map("n", "<leader>zD", "<cmd>ZkNew { dir= 'journal/daily' }<CR>", silent)
  map("n", "<leader>zW", "<cmd>ZkNew { dir= 'journal/weekly' }<CR>", silent)
  map("v", "<leader>znt", ":'<,'>ZkNewFromTitleSelection<CR>", silent)
  map("v", "<leader>znc", ":'<,'>ZkNewFromContentSelection { itle = vim.fn.input('Zettel Title: ') }<CR>", silent)

  ---- MARK: Set up ----
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  zk.setup({
    picker = "telescope",

    lsp = {
      -- `config` is passed to `vim.lsp.start_client(config)`
      config = {
        cmd = { "zk", "lsp" },
        name = "zk",
        capabilities = capabilities,
        autostart = true,

        -- Override and enable virtual text; disable sign on sign columns
        handlers = {
          ["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, {
              virtual_text = {
                spacing = 2,
                prefix = ""
              },
              signs = false
            }
          ),
        }
      },

      -- automatically attach buffers in a zk notebook that match the given filetypes
      auto_attach = {
        enabled = true,
        filetypes = { "markdown" },
      },
    },
  })
end

return M
