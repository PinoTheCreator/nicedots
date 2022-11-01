-- Automatically install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever I save this file
vim.cmd[[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]]

-- protected call, avoids errors if packer isn't installed
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

packer.init {
	display = {
    	open_fn  = require('packer.util').float, -- An optional function to open a window for packer's display
    	}
}

require('packer').startup(function()
	use 'wbthomason/packer.nvim'

  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP

  use { 'ms-jpq/coq_nvim', run = 'python3 -m coq deps' }
  use 'ms-jpq/coq.artifacts'
  use 'ms-jpq/coq.thirdparty'

  use 'folke/tokyonight.nvim'
  use 'ellisonleao/gruvbox.nvim'
  use 'Mofiqul/vscode.nvim'

	use 'jiangmiao/auto-pairs'
  use 'vimwiki/vimwiki'
  use 'tpope/vim-surround'
  use 'farmergreg/vim-lastplace'
  
  -- use 'ap/vim-css-color'
  use 'chrisbra/Colorizer'

  use 'glepnir/dashboard-nvim'
  use 'kyazdani42/nvim-web-devicons'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
end)
