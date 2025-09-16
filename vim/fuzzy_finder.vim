let s:file_cache = []
let s:cache_cwd = ""
let s:max_choices = 15

function! s:EnsureCache() abort
    if empty(s:file_cache) || s:cache_cwd !=# getcwd()
        let s:cache_cwd = getcwd()

        let l:all = globpath(s:cache_cwd, '**/*', 0, 1)
        let l:files = []
        for f in l:all
            if filereadable(f)
                call add(l:files, f)
            endif
        endfor

        let s:file_cache = l:files
    endif
endfunction

function! s:IsWordBoundary(t, idx) abort
    if a:idx <= 0 
        return 1
    endif
    let l:ch = a:t[a:idx - 1]

    if l:ch =~# '[/._\- ]'
        return 1
    endif

    return 0
endfunction

function! s:FuzzyScore(text, pattern) abort
    if a:pattern ==# ''
        return -1
    endif

    let l:orig = a:text
    let l:text = tolower(a:text)
    let l:pat = tolower(a:pattern)

    let l:ti = 0
    let l:idxs = []
    for ch in split(l:pat, '\zs')
        let l:pos = stridx(l:text, ch, l:ti)
        if l:pos < 0
            return -1
        endif
        call add(l:idxs, l:pos)
        let l:ti = l:pos + 1
    endfor

    let l:score = len(l:idxs) * 10

    " Contiguity bonus
    for i in range(1, len(l:idxs)-1)
        if l:idxs[i] ==# l:idxs[i-1] + 1
            let l:score += 5
        endif
    endfor

    " Word/segment boundary bonus
    for i in range(0, len(l:idxs) - 1)
        if s:IsWordBoundary(l:text, l:idxs[i])
            let l:score += 4
        endif
    endfor

    " Filename bias
    let l:base = fnamemodify(l:orig, ':t')
    let l:base_start = strlen(l:text) - strlen(l:base)
    for idx in l:idxs
        if idx >= l:base_start
            let l:score += 2
        endif
    endfor

    " Gap penalty
    let l:span = l:idxs[-1] - l:idxs[0] + 1
    let l:gaps = l:span - len(l:idxs)
    let l:score -= l:gaps

    " Depth penalty
    let l:depth = len(split(l:text, '/')) - 1
    let l:score -= l:depth

    return l:score
endfunction

function! s:FuzzyFilterSort(files, pattern) abort
    let l:scored = []
    for f in a:files
        let l:s = s:FuzzyScore(f, a:pattern)
        if l:s >= 0
            call add(l:scored, [l:s, strlen(f), f])
        endif
    endfor

    call sort(l:scored, {a,b -> (a[0] ==# b[0] ? (a[1] ==# b[1] ? 0 : (a[1] < b[1] ? -1 : 1)) : (a[0] > b[0] ? -1 : 1))})
    return map(l:scored, '[v:val[0], v:val[2]]')
endfunction

function! s:SelectFromList(matches) abort
    let l:n = min([len(a:matches), s:max_choices])
    let l:menu = ['Select a file ('.len(a:matches).' matches, showing '.l:n.'). 0 = cancel']
    
    for i in range(0, l:n-1)
        let l:menu += [printf('%2d. %s', i+1, fnamemodify(a:matches[i][1], ':.'))]
    endfor
    
    let l:choice = inputlist(l:menu)
    if l:choice >= 1 && l:choice <= l:n
        return a:matches[l:choice-1][1]
    endif
    return ''
endfunction

function! FuzzyFinder()
    let l:pat = input('Fuzzy pattern: ')
    if l:pat ==# ''
        echo 'FuzzyFind: no pattern'
        return
    endif

    call s:EnsureCache()
    let l:matches = s:FuzzyFilterSort(s:file_cache, l:pat)
    if empty(l:matches)
        echo 'FuzzyFind: no matches'
        return
    endif

    let l:chosen = s:SelectFromList(l:matches)

    if l:chosen ==# ''
        return
    else
        execute 'edit' fnameescape(l:chosen)
    endif
endfunction

command! -nargs=0 FuzzyFind call FuzzyFinder()

nnoremap <silent> <leader>f :FuzzyFind<CR>
