" -----------------------------------------------------------------------------
"     - Scratch buffer -
"     Creates a basic scratch buffer
"     Adopted from https://github.com/hagsteel/vimconf/blob/master/vimrc
" -----------------------------------------------------------------------------

functio CreateScratchBuffer(vertical)
    if a:vertical == 1 
        :vnew
    else
        :new
    endif
    :setlocal buftype=nofile
    :setlocal bufhidden=hide
    :setlocal noswapfile
    :set ft=scratch
endfunction
:command! Scratch call CreateScratchBuffer(1)
:command! Scratchh call CreateScratchBuffer(0)
