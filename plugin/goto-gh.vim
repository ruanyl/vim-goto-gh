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

let g:goto_gh_map =
      \ get(g:, "goto_gh_map", "<leader>o")

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

func! s:Goto_gh(...)
  let file_name = expand('%:t')
  " copy the words inside double quote
  let old_y = @@
  normal! mqyi"`q
  let str = @@
  let @@ = old_y

  if file_name ==? "package.json" && executable("npm")
    echo "opening..."
    call system("npm home " . str)
    echo "done!"
  elseif file_name ==? "bower.json" && executable("bower")
    call system("bower home " . str)
  endif

endfun

func! s:Goto_gh_v()
    let v_text = s:Vselection()
    let url = 'https://github.com/' . v_text
    call system("open " . url)
endfunction

func! s:Vselection()
  try
    let a_save = @@
    normal! gv"ay
    return @@
  finally
    let @@ = a_save
  endtry
endfunction

vnoremap <silent> <Plug>(goto-gh-v) :<C-U>call <SID>Goto_gh_v()<CR>
nnoremap <silent> <Plug>(goto-gh) :call <SID>Goto_gh()<CR>

if !hasmapto('<Plug>(goto-gh-v)')
    exe "vmap" g:goto_gh_map "<Plug>(goto-gh-v)"
end

if !hasmapto('<Plug>(goto-gh)')
    exe "nmap" g:goto_gh_map "<Plug>(goto-gh)"
end
