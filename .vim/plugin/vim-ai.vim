" Ensure python3 is available
if !has('python3')
  echoerr "Python 3 support is required for vim-ai plugin"
  finish
endif

command! -range -nargs=? -complete=customlist,vim_ai#RoleCompletion AI <line1>,<line2>call vim_ai#AIRun(<range>, {}, <q-args>)
command! -range -nargs=? -complete=customlist,vim_ai#RoleCompletion AIEdit <line1>,<line2>call vim_ai#AIEditRun(<range>, {}, <q-args>)
command! -range -nargs=? -complete=customlist,vim_ai#RoleCompletion AIChat <line1>,<line2>call vim_ai#AIChatRun(<range>, {}, <q-args>)
command! -nargs=? AINewChat call vim_ai#AINewChatRun(<f-args>)
command! AIRedo call vim_ai#AIRedoRun()
