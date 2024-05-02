set autoread
let v:fcs_choice = 'reload'
autocmd BufEnter,WinEnter * checktime
autocmd CursorHold,CursorHoldI * checktime
