return {
	'nvim-telescope/telescope.nvim',
	dependencies = { 'nvim-lua/plenary.nvim' },

  config = {
    file_ignore_patterns = { "%.git/." },
    defaults = {
      file_ignore_patterns = {
        "node_modules",
        "package-lock.json"
      },
      sorting_strategy = "ascending",
      layout_config = {
        prompt_position = "top",
        preview_cutoff = 85
      }
    }
  }
}
