--
-- Vim ocnfig full lua
--

-- Packer bootstrap auto
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end


vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost */nvim/lua/geckosplinter/packer.lua source <afile> | PackerCompile
  augroup
]]

return require('packer').startup({
    function(use)
      use 'wbthomason/packer.nvim'

      require 'geckosplinter'

      if packer_bootstrap then
        require('packer').sync()
      end
    end
})


