"% Preliminary validation of global variables
"  and version of the editor.

if v:version < 700
  finish
endif

" check whether this script is already loaded
if exists('g:loaded_gotogh')
  finish
endif

let g:loaded_gotogh = 1

" Function for debugging
" @param {Any} content Any type which will be converted
" to string and write to tmp file
func! s:console(content)
  let log_dir = fnameescape('/tmp/vimlog')
  call writefile([string(a:content)], log_dir)
  return 1
endfun

" Output warning message
" @param {Any} message The warning message
fun! WarningMsg(message)
  echohl WarningMsg
  echo string(a:message)
endfun

" Output error message
" @param {Any} message The error message
fun! ErrorMsg(message)
  echoerr string(a:message)
endfun

func! s:Gotogh(...)
  let file_name = expand('%:t')
  " copy the words inside double quote
  normal! mqyi"`q
  let str = @@

  if file_name ==? "package.json" && executable("npm")
    echom "opening..."
    call system("npm home " . str)
    echom "done!"
  elseif file_name ==? "bower.json" && executable("bower")
    echom "opening, wait..."
    call system("bower home " . str)
    echom "done!"
  endif

endfun

command! Gotogh call s:Gotogh()
