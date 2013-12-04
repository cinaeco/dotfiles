" Folding - Modeline and Notes {{{
" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker:
"
"   cinaeco/dotfiles Folding Settings
"
"   These are settings to make folding easier to use and look at:
"    - Indented Folds to match their first line.
"    - Statbox to right displays line count and fold level.
"    - Coloured distinctly red!
"        (sounds harsh, but actually works well with solarized-dark!)
"    - Fillchar is forced to '.' rather than '-'.
"        (easier on eyes)
"    - SpaceBar toggles folds, if any.
"        (much more convenient than the 'z' commands)
"    - SPF13-VIM provides quick foldlevel setting map: <Leader>f[0-9]
"        (useful with statbox lvl)
"
"   Note that custom foldtext will only work for vim 7.3+. For earlier
"   versions of vim, only the colouring and spacebar mapping will take effect.
"
"   TODO:
"    - Fold description is just the first line found. Haven't really
"    understood the regex, but could perhaps make it better.
"    - Fold description current truncation rule is 1/3 of the window width.
"    Perhaps this could be some less arbitrary rule?
"
" }}}

if has('folding')

  " Default Settings {{{
  set foldmethod=indent
  set foldlevel=10
  " }}}

  " Keyboard Shortcuts {{{
  " Space as a Folding toggle in normal mode.
  nnoremap <silent> <space>     @=(foldlevel('.')?'za':"\<space>")<CR>

  " Code folding options (spf13-vim)
  nmap <leader>f0 :set foldlevel=0<CR>
  nmap <leader>f1 :set foldlevel=1<CR>
  nmap <leader>f2 :set foldlevel=2<CR>
  nmap <leader>f3 :set foldlevel=3<CR>
  nmap <leader>f4 :set foldlevel=4<CR>
  nmap <leader>f5 :set foldlevel=5<CR>
  nmap <leader>f6 :set foldlevel=6<CR>
  nmap <leader>f7 :set foldlevel=7<CR>
  nmap <leader>f8 :set foldlevel=8<CR>
  nmap <leader>f9 :set foldlevel=9<CR>
  " }}}

  " Fold Highlighting {{{
  highlight Folded term=none cterm=none ctermfg=darkgrey ctermbg=none guifg=darkgrey guibg=none
  " }}}

  " Fold Text {{{
  set foldtext=CustomFoldText()

  function! CustomFoldText(...)

    " At least vim 7.3 {{{
    "  - Requirement for strdisplaywidth().
    "  - strdisplaywidth() seems to work. If multi-byte characters start to give
    "  trouble, consider checking the more primitive solution in strlen() help.
    if v:version < 703
      return foldtext()
    endif
    " }}}

    " Common variables for all foldmethods {{{
    let lineCount = v:foldend - v:foldstart + 1
    let displayWidth = winwidth(0) - &foldcolumn
    if (&number || &relativenumber)
      let displayWidth -= &numberwidth
    endif
    let foldChar = '┄'
    " }}}

    " Set fold fillchar {{{
    "  - This complicated line is to ensure we replace the fold fillchar only.
    let &l:fillchars = substitute(&l:fillchars,',\?fold:.','','gi')
    exec 'setlocal fillchars+=fold:' . foldChar
    " }}}

    " Handle diff foldmethod {{{
    "  - Display a centre-aligned statbox with the number of lines.
    if &foldmethod == 'diff'

      " Prepare the statbox {{{
      let statBox = printf('[ %s matching lines ]', lineCount)
      " }}}

      " Prepare filler lines {{{
      let filler = repeat(foldChar, (displayWidth - strchars(statBox)) / 2)
      " }}}

      " Output the combined fold text {{{
      return filler.statBox
      " }}}

    endif
    " }}}

    " Handle all other foldmethods {{{

      " Prepare fold indent and indicator {{{
      "  - If indent allows, build the indicator into it.
      let foldIndicator = '▸ '
      let indLen = strdisplaywidth(foldIndicator)
      if indent(v:foldstart) >= indLen
        let indent = repeat(' ', indent(v:foldstart) - indLen) . foldIndicator
      else
        let indent = repeat(' ', indent(v:foldstart))
      endif
      " }}}

      " Prepare the statbox {{{
      "  - Fixed statbox width at 18 characters.
      "  - Count width by display cells instead of bytes if at least vim 7.4
      if v:version >= 704
        let countType = 'S'
      else
        let countType = 's'
      endif
      let statBox = '[ ' . printf('%14'.countType, lineCount.' lns, lv '.v:foldlevel) . ' ]'
      " }}}

      " Prepare fold description {{{
      "  - Remove fold markers and comment markers.
      "  - Truncate to 1/3 of the current window width.

        " Use function argument as line text if provided {{{
        let line = a:0 > 0 ? a:1 : getline(v:foldstart)
        " }}}

        " Remove fold markers {{{
        let foldmarkers = split(&foldmarker, ',')
        let line = substitute(line, '\V' . foldmarkers[0] . '\%(\d\+\)\?\s\*', '', '')
        " }}}

        " Remove surrounding whitespace {{{
        let line = substitute(line, '^\s*\(.\{-}\)\s*$', '\1', '')
        " }}}

        " Add an extra space at the end {{{
        let foldDesc = line.' '
        " }}}

      " }}}

      " Prepare filler lines {{{
      "  - midFiller is the fill between the description and statbox.
      "  - midFiller compensates for column widths generated by foldcolumn, number
      "  and relativenumber.
      let endFiller = repeat(foldChar, 1)
      let midFillerLength = displayWidth - strdisplaywidth(indent.foldDesc.statBox.endFiller)
      let midFiller = repeat(foldChar, midFillerLength)
      " }}}

      " Output the combined fold text {{{
      return indent.foldDesc.midFiller.statBox.endFiller
      " }}}

    " }}}

  endfunction
  " }}}

  " Lokaltog's Fold Text for learning more stuff about fold description preparation {{{
  function! FoldText(...)
    " This function uses code from doy's vim-foldtext: https://github.com/doy/vim-foldtext
    " Prepare fold variables {{{
    " Use function argument as line text if provided
    let l:line = a:0 > 0 ? a:1 : getline(v:foldstart)

    let l:line_count = v:foldend - v:foldstart + 1
    let l:indent = repeat(' ', indent(v:foldstart))

    let l:w_win = winwidth(0)
    let l:w_num = getwinvar(0, '&number') * getwinvar(0, '&numberwidth')
    let l:w_fold = getwinvar(0, '&foldcolumn')
    " }}}
    " Handle diff foldmethod {{{
    if &fdm == 'diff'
      let l:text = printf('┤ %s matching lines ├', l:line_count)

      " Center-align the foldtext
      return repeat('┄', (l:w_win - strchars(l:text) - l:w_num - l:w_fold) / 2) . l:text
    endif
    " }}}
    " Handle other foldmethods {{{
    let l:text = l:line
    " Remove foldmarkers {{{
    let l:foldmarkers = split(&foldmarker, ',')
    let l:text = substitute(l:text, '\V' . l:foldmarkers[0] . '\%(\d\+\)\?\s\*', '', '')
    " }}}
    " Remove comments {{{
    let l:comment = split(&commentstring, '%s')

    if l:comment[0] != ''
      let l:comment_begin = l:comment[0]
      let l:comment_end = ''

      if len(l:comment) > 1
        let l:comment_end = l:comment[1]
      endif

      let l:pattern = '\V' . l:comment_begin . '\s\*' . l:comment_end . '\s\*\$'

      if l:text =~ l:pattern
        let l:text = substitute(l:text, l:pattern, ' ', '')
      else
        let l:text = substitute(l:text, '.*\V' . l:comment_begin, ' ', '')

        if l:comment_end != ''
          let l:text = substitute(l:text, '\V' . l:comment_end, ' ', '')
        endif
      endif
    endif
    " }}}
    " Remove preceding non-word characters {{{
    let l:text = substitute(l:text, '^\W*', '', '')
    " }}}
    " Remove surrounding whitespace {{{
    let l:text = substitute(l:text, '^\s*\(.\{-}\)\s*$', '\1', '')
    " }}}
    " Make unmatched block delimiters prettier {{{
    let l:text = substitute(l:text, '([^)]*$',   '⟯ ⋯ ⟮', '')
    let l:text = substitute(l:text, '{[^}]*$',   '⟯ ⋯ ⟮', '')
    let l:text = substitute(l:text, '\[[^\]]*$', '⟯ ⋯ ⟮', '')
    " }}}
    " Add arrows when indent level > 2 spaces {{{
    if indent(v:foldstart) > 2
      let l:cline = substitute(l:line, '^\s*\(.\{-}\)\s*$', '\1', '')
      let l:clen = strlen(matchstr(l:cline, '^\W*'))

      let l:indent = repeat(' ', indent(v:foldstart) - 2)
      let l:text = '▸ ' . l:text
    endif
    " }}}
    " Prepare fold text {{{
    let l:fnum = printf('┤ %s ⭡ ', printf('%4s', l:line_count))
    let l:ftext = printf('%s%s ', l:indent, l:text)
    " }}}
    return l:ftext . repeat('┄', l:w_win - strchars(l:fnum) - strchars(l:ftext) - l:w_num - l:w_fold) . l:fnum
    " }}}
  endfunction
  " }}}

endif
