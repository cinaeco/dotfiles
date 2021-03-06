" Template for shell scripts.
" Removes comments, places cursor at end of file.
autocmd BufNewFile *.sh silent 0r ~/dotfiles/vim/templates/bashscript | silent 2,$ g/^#/d | normal G
" Make shell scripts executable on save.
autocmd BufWritePost *.sh if getline(1) =~ "^#!/" | execute 'silent !chmod +x <afile>' | endif

" Template for makefiles.
autocmd BufNewFile [Mm]akefile silent 0r ~/dotfiles/vim/templates/makefile | silent 4,$ g/^#/d | normal G

" Template for pandoc files.
autocmd BufNewFile *.pandoc silent 0r ~/dotfiles/vim/templates/pandoc | silent 0,$ g/^"/d | normal 2G$

" Template for pandoc silde files.
autocmd BufNewFile *.pandoc_slides silent 0r ~/dotfiles/vim/templates/pandoc_slides | silent 0,$ g/^"/d | normal 2G$
