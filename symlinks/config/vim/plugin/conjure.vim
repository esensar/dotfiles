if exists("g:loaded_conjure") || &cp | finish | endif

let g:loaded_conjure = 1

" In Chicken 5.4+ you may need to remove the `-quiet` arg for it to work with Conjure.
let g:conjure#client#scheme#stdio#command = "csi -:c"
let g:conjure#client#scheme#stdio#prompt_pattern = "\n-#;%d-> "
let g:conjure#client#scheme#stdio#value_prefix_pattern = v:false
