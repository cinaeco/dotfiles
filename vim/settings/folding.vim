" Folding - Modeline and Notes {{{
" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker spell:
"
"   cinaeco/dotfiles Folding Settings
"
"   These are settings to make folding easier to use and look at:
"    - Indented Folds to match their first line.
"    - Stat box to right displays line count and fold level.
"    - Coloured distinctly red!
"        (sounds harsh, but actually works well with solarized-dark!)
"    - Fillchar is forced to '.' rather than '-'.
"        (easier on eyes)
"    - SpaceBar toggles folds, if any.
"        (much more convenient than the 'z' commands)
"    - SPF13-VIM provides quick foldlevel setting map: <Leader>f[0-9]
"        (useful with stat box lvl)
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
  " Red fold text! (Pretty good with solarized-dark)
  highlight Folded term=none cterm=none ctermfg=darkred ctermbg=none guifg=darkred guibg=none
  " }}}

  " Fold Text {{{
  set foldtext=CustomFoldText()

  function! CustomFoldText()

    " At least vim 7.3. {{{
    "  - Requirement for strdisplaywidth.
    if v:version < 703
      return foldtext()
    endif
    " }}}

    " Force dot fillchar. {{{
    "  - The complicated line is to ensure we replace the fold fillchar only.
    let &l:fillchars = substitute(&l:fillchars,',\?fold:.','','gi')
    setlocal fillchars+=fold:.
    " }}}

    " Prepare script variables. {{{
    let foldChar = matchstr(&fillchars, 'fold:\zs.')
    let currWinWidth = winwidth(0)
    " }}}

    " Prepare fold indent. {{{
    "  - Indent taken from first line in fold.
    let indentLevel = indent(v:foldstart)
    let indent = repeat(' ', indentLevel)
    " }}}

    " Prepare fold description. {{{
    "  - Truncated to 1/3 of the current window width.
    let allFoldMarkers = split(&foldmarker, ',')
    let frontFoldMarker = allFoldMarkers[0]
    let lineRaw = substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*'.frontFoldMarker.'\d*\s*', '', 'g')
    let line = '+ '.lineRaw.' '
    let foldDesc = strpart(line, 0, currWinWidth / 3)
    " }}}

    " Prepare the stat box. {{{
    "  - Fixed stat box width at 18 characters.
    "  - Count width by display cells instead of bytes if at least vim 7.4
    let lineCount = v:foldend - v:foldstart + 1
    if v:version >= 704
      let formatForm = 'S'
    else
      let formatForm = 's'
    endif
    let statBox = '| ' . printf('%18'.formatForm, lineCount.' lines, lvl '.v:foldlevel) . ' |'
    " }}}

    " Prepare filler lines. {{{
    "  - endFiller is the fill after the stat box. Fixed at 5 characters.
    "  - midFiller is the fill between the description and stat box.
    "  - midFiller compensates for column widths generated by foldcolumn, number
    "  and relativenumber.
    "  - strdisplaywidth() seems to work. If multi-byte characters start to give
    "  trouble, consider checking the more primitive solution in strlen() help.
    let endFiller = repeat(foldChar, 5)
    let midFillerLength = winwidth(0) - strdisplaywidth(indent.foldDesc.statBox.endFiller) - &foldcolumn
    if (&number || &relativenumber)
      let midFillerLength -= &numberwidth
    endif
    let midFiller = repeat(foldChar, midFillerLength)
    " }}}

    " Output the combined fold text. {{{
    return indent.foldDesc.midFiller.statBox.endFiller
    " }}}

  endfunction
  " }}}

endif
