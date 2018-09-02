function! te#leaderf#dir#source(args) abort
    if te#env#IsWindows()
        let l:text = te#compatiable#systemlist('dir /B /D')
        if type(l:text) == g:t_number
            return
        endif
        let l:text_dir=filter(deepcopy(l:text),'isdirectory(v:val)')
        call filter(l:text,'isdirectory(v:val) == 0')
        call map(l:text_dir, 'v:val."\\"')
        call extend(l:text, l:text_dir)
        call add(l:text, '..\')
    else
        let l:text = te#compatiable#systemlist('ls -a -F')
        if type(l:text) == g:t_number
            return
        endif
    endif
    return l:text
endfunction


function! te#leaderf#dir#accept(line, args) abort
    let l:file_or_dir=matchstr(a:line,".*[^@]")
    if isdirectory(l:file_or_dir)
        execute 'cd 'l:file_or_dir
        :Leaderf dir
    else
        execute 'e '.l:file_or_dir
    endif
endfunction



function! te#leaderf#dir#Get_digest(line, mode)
	" full path, i.e, the whole line
	if a:mode == 0
		return [a:line, 0]
		" name only, i.e, the part of file name
	elseif a:mode == 1
		return [split(a:line)[0], 0]
		" directory, i.e, the part of greped line
	else
		let items = split(a:line, '\t')
		return [items[2], len(a:line) - len(items[2])]
	endif
endfunction

function! Do_nothing(orig_buf_nr, orig_cursor, args)
endfunction

