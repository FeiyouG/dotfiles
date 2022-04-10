---- MARK: Declaration of variabels
local luasnip = require("luasnip")
local types = require("luasnip.util.types")

local command_center = require("command_center")
local noremap = { noremap = true }

command_center.add({
  {
    description = "luasnip choice node: next choice",
    command = "<Plug>luasnip-next-choice",
    keybindings = {
      {"i", "<C-d>", noremap},
      {"s", "<C-d>", noremap}
    }
  }
})


---- MARK: General Configuration ----
luasnip.config.set_config {
  -- This one is cool cause if you have dynamic snippets, it updates as you type!
  -- updateevents = "TextChanged,TextChangedI",
  updateevents = "TextChanged",

  -- Autosnippets:
  enable_autosnippets = true,

  -- Crazy highlights!!
  -- #vid3
  -- ext_opts = nil,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "<-", "Error" } },
      },
    },
  },
}

require("luasnip.loaders.from_vscode").load()
require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/lua/snippets" } })

-- ---- MARK: Load filetype specific snippets on demand ----
-- function _G.snippets_clear()
-- 	for m, _ in pairs(luasnip.snippets or {}) do
-- 		package.loaded["snippets."..m] = nil
-- 	end
-- 	luasnip.snippets = setmetatable({}, {
-- 		__index = function(t, k)
-- 			local ok, m = pcall(require, "snippets." .. k)
-- 			if not ok and not string.match(m, "^module.*not found:") then
-- 				error(m)
-- 			end
-- 			t[k] = ok and m or {}
--
-- 			-- optionally load snippets from vscode- or snipmate-library:
			-- require("luasnip.loaders.from_vscode").load({include = {k}})
-- 			-- require("luasnip.loaders.from_snipmate").load({include={k}})
-- 			return t[k]
-- 		end
-- 	})
-- end
--
-- _G.snippets_clear()
--
-- vim.cmd [[
--   augroup snippets_clear
--     au!
--     au BufWritePost $HOME/.config/nvim/lua/snippets/*.lua lua _G.snippets_clear()
--   augroup END
-- ]]
--
-- function _G.edit_ft()
-- 	-- returns table like {"lua", "all"}
-- 	local fts = require("luasnip.util.util").get_snippet_filetypes()
-- 	vim.ui.select(fts, {
-- 		prompt = "Select which filetype to edit:"
-- 	}, function(item, idx)
-- 		-- selection aborted -> idx == nil
-- 		if idx then
-- 			vim.cmd("edit ~/.config/nvim/lua/snippets/"..item..".lua")
-- 		end
-- 	end)
-- end
--
-- vim.cmd [[command! LuaSnipEdit :lua _G.edit_ft()]]


---- MARK: Popup for choiceNode
-- local current_nsid = vim.api.nvim_create_namespace("LuaSnipChoiceListSelections")
-- local current_win = nil
--
-- local function window_for_choiceNode(choiceNode)
--     local buf = vim.api.nvim_create_buf(false, true)
--     local buf_text = {}
--     local row_selection = 0
--     local row_offset = 0
--     local text
--     for _, node in ipairs(choiceNode.choices) do
--         text = node:get_docstring()
--         -- find one that is currently showing
--         if node == choiceNode.active_choice then
--             -- current line is starter from buffer list which is length usually
--             row_selection = #buf_text
--             -- finding how many lines total within a choice selection
--             row_offset = #text
--         end
--         vim.list_extend(buf_text, text)
--     end
--
--     vim.api.nvim_buf_set_text(buf, 0,0,0,0, buf_text)
--     local w, h = vim.lsp.util._make_floating_popup_size(buf_text)
--
--     -- adding highlight so we can see which one is been selected.
--     local extmark = vim.api.nvim_buf_set_extmark(buf,current_nsid,row_selection ,0,
--         {hl_group = 'incsearch',end_line = row_selection + row_offset})
--
--     -- shows window at a beginning of choiceNode.
--     local win = vim.api.nvim_open_win(buf, false, {
--         relative = "win", width = w, height = h, bufpos = choiceNode.mark:pos_begin_end(), style = "minimal", border = 'rounded'})
--
--     -- return with 3 main important so we can use them again
--     return {win_id = win,extmark = extmark,buf = buf}
-- end
--
-- function choice_popup(choiceNode)
-- 	-- build stack for nested choiceNodes.
-- 	if current_win then
-- 		vim.api.nvim_win_close(current_win.win_id, true)
--                 vim.api.nvim_buf_del_extmark(current_win.buf,current_nsid,current_win.extmark)
-- 	end
--         local create_win = window_for_choiceNode(choiceNode)
-- 	current_win = {
-- 		win_id = create_win.win_id,
-- 		prev = current_win,
-- 		node = choiceNode,
--                 extmark = create_win.extmark,
--                 buf = create_win.buf
-- 	}
-- end
--
-- function update_choice_popup(choiceNode)
--     vim.api.nvim_win_close(current_win.win_id, true)
--     vim.api.nvim_buf_del_extmark(current_win.buf,current_nsid,current_win.extmark)
--     local create_win = window_for_choiceNode(choiceNode)
--     current_win.win_id = create_win.win_id
--     current_win.extmark = create_win.extmark
--     current_win.buf = create_win.buf
-- end
--
-- function choice_popup_close()
-- 	vim.api.nvim_win_close(current_win.win_id, true)
--         vim.api.nvim_buf_del_extmark(current_win.buf,current_nsid,current_win.extmark)
--         -- now we are checking if we still have previous choice we were in after exit nested choice
-- 	current_win = current_win.prev
-- 	if current_win then
-- 		-- reopen window further down in the stack.
--                 local create_win = window_for_choiceNode(current_win.node)
--                 current_win.win_id = create_win.win_id
--                 current_win.extmark = create_win.extmark
--                 current_win.buf = create_win.buf
-- 	end
-- end
--
-- vim.cmd([[
--   augroup choice_popup
--     au!
--     au User LuasnipChoiceNodeEnter lua choice_popup(require("luasnip").session.event_node)
--     au User LuasnipChoiceNodeLeave lua choice_popup_close()
--     au User LuasnipChangeChoice lua update_choice_popup(require("luasnip").session.event_node)
--   augroup END
-- ]])
