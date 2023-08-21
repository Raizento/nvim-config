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

vim.cmd([[
    augroup auto_unfold_folds
        autocmd!
        autocmd BufWinEnter,BufReadPost,FileReadPost * normal zR
    augroup end
]])
