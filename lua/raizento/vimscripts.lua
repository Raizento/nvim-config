-- Save view of current file (only if file actually has a name, check prevents errors) 
vim.cmd([[
    function MakeViewOnlyIfFileNameIsNotEmpty()
        let file_name = expand('%:t:r')
        if len(file_name) !~ 0
            mkview
        endif
    endfunction

    " Autocommand to remember folds
    augroup remember_folds
        autocmd!
        autocmd BufWinLeave * call MakeViewOnlyIfFileNameIsNotEmpty()
        autocmd BufWinEnter * silent! loadview
    augroup END
]])

-- Autocommand to sync packer when plugins have been added/removed
vim.cmd([[augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]])

vim.cmd([[augroup auto_unfold_folds
  autocmd!
  autocmd BufWinEnter,BufReadPost,FileReadPost * normal zR
augroup end
]])
