return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/vim-vsnip",
		"hrsh7th/cmp-vsnip",
	},
	config = function()
		local cmp = require("cmp")
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")

		cmp.event:on(
			"confirm_done",
			cmp_autopairs.on_confirm_done()
		)

		cmp.setup({
			-- Required snippet engine for cmp
			snippet = {
				expand = function(args)
					vim.fn["vsnip#anonymous"](args.body)
				end,
			},

            -- Add bordered windows
            window = {
                completion = cmp.config.window.bordered({
                    scrollbar = false,
                }),

                documentation = cmp.config.window.bordered({
                    scrollbar = false
                })
            },
			
			-- Sources for completion list
			-- Add buffer to suggest current file known-names in the list
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'vsnip' },
			}),

			-- Set mapping keys 
			mapping = {
				["<TAB>"] = cmp.mapping.select_next_item(),
				["<S-TAB>"] = cmp.mapping.select_prev_item(),
				["<CR>"] = cmp.mapping.confirm({ select = false }),
                ["<C-Space>"] = cmp.mapping.complete(),
			},

            -- Disable first item selection
            preselect = cmp.PreselectMode.None,

            formatting = {
                format = function(entry, vim_item)
                    vim_item.menu = ""
                    vim_item.kind = ""
                    return vim_item
                end
            },
		})
	end
}
