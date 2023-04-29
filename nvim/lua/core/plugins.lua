local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-tree/nvim-web-devicons'
  use 'nvim-lualine/lualine.nvim'
      use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use {'nyoom-engineering/oxocarbon.nvim'}
    use "EdenEast/nightfox.nvim" -- Packer
    use 'jiangmiao/auto-pairs'
    use 'windwp/nvim-ts-autotag'
    use 'terrortylor/nvim-comment'
    use 'tpope/vim-surround'
    use {
  'nvim-telescope/telescope.nvim', tag = '0.1.1',
-- or                            , branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
}

use {
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig"

}
use "hrsh7th/nvim-cmp"
use "hrsh7th/cmp-nvim-lsp"
use "L3MON4D3/LuaSnip"
use 'saadparwaiz1/cmp_luasnip'
use 'rafamadriz/friendly-snippets'
use 'akinsho/toggleterm.nvim'
use {
  'kdheepak/tabline.nvim',
  requires = { { 'hoob3rt/lualine.nvim', opt=true }, {'kyazdani42/nvim-web-devicons', opt = true} }
}
use({
    "glepnir/lspsaga.nvim",
    opt = true,
    branch = "main",
    event = "LspAttach",
    config = function()
        require("lspsaga").setup({})
    end,
    requires = {
        {"nvim-tree/nvim-web-devicons"},
        --Please make sure you install markdown and markdown_inline parser
        {"nvim-treesitter/nvim-treesitter"}
    }
})
use 'onsails/lspkind.nvim'
use {
  'lewis6991/gitsigns.nvim',
  -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
}
use('jose-elias-alvarez/null-ls.nvim')
use('MunifTanjim/prettier.nvim')
use "folke/neodev.nvim"

  -- My plugins here
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
