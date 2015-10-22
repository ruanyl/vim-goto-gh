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

if globpath(&rtp, 'autoload/webapi/http.vim') ==# ''
  echohl ErrorMsg | echomsg 'Gotogh: require ''webapi'', install https://github.com/mattn/webapi-vim' | echohl None
  finish
else
  call webapi#json#true()
endif

func! s:Gotogh(...)
  let npm = 'npm'
  " copy the words inside double quote
  normal! mqyi"`q
  let str = @@

  if executable(npm)
    let json = system(npm . " home " . str)
  else
    " Executable bin doesn't exist
    call ErrorMsg('The '.engine.' is not executable!')
    return 1
  endif

endfun

command! Gotogh call s:Gotogh()
