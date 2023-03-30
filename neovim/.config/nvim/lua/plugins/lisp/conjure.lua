return {
	"Olical/conjure",
	config = function()
		-- Disable some of the default mappings.
		vim.g["conjure#mapping#doc_word"] = "v:false"
		vim.g["conjure#mapping#eval_buf"] = "p"
		vim.g["conjure#filetypes"] = "['clojure', 'fennel', 'janet', 'hy', 'julia', 'racket', 'scheme', 'lisp']"

		-- Diable diagnostics in conjure log
		local diable_lsp_in_conjure_log = vim.api.nvim_create_augroup("DisableLspInConjureLog", { clear = true })

		vim.api.nvim_create_autocmd("BufNewFile", {
			pattern = { "conjure-log-*" },
			callback = function()
				vim.diagnostic.disable(0)
			end,
			group = diable_lsp_in_conjure_log,
		})
	end,
}
