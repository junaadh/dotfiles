return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = {
    "BufReadPost",
    "BufNewFile"
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function ()
    local configs = require("nvim-treesitter.configs")

	  configs.setup({
		  ensure_installed = {
			  "bash",
		    "c",
			  "cpp",
			  "rust",
			  "lua",
			  "vim",
			  "javascript",
			  "html"
		  },
      modules = {},
      ignore_install = {},
		  sync_install = false,
      auto_install = false,
      highlight = {
			  enable = true,
			  additional_vim_regex_highlighting = true
		  },
      indent = { enable = true },
    })
    end
 }
