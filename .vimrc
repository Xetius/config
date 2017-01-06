" Basic Setup {{{
    set nocompatible

    syntax enable
    set background=dark
    colorscheme solarized

    filetype on
    filetype off
" }}}

" Load bundles {{{
    if filereadable(expand("~/.vimrc.plugins"))
        source ~/.vimrc.plugins
    endif
" }}}

" Basic Config {{{
    set autoindent
    set autoread
    set clipboard=unnamed
    set list
    set listchars=tab:▸\ ,trail:▫
    set expandtab
    set number
    set ruler
    set shiftwidth=4
    set showcmd
    set softtabstop=4
    set tabstop=4
    set pastetoggle=<F12>
    set hlsearch
    set incsearch
    set nojoinspaces
    set shiftround
    set mouse=a
    highlight NonText guifg=#4a4a59
    highlight SpecialKey guifg=#4a4a59
" }}}

" Autocommand Config {{{
    " only do this part when compiled with support for autocommands
    if has("autocmd")
        " Enable file type detection
        filetype on

        " Syntax of these languages is fussy over tabs Vs spaces
        autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
        autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

        " Customisations based on house-style (arbitrary)
        autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
        autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
        autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab

        " Treat .rss files as XML
        autocmd BufNewFile,BufRead *.rss setfiletype xml
    endif

" }}}

" Key mappings {{{
    let mapleader = ','

    " Navigation {{{
        " Split Navigation
        nnoremap <C-J> <C-W><C-J>
        nnoremap <C-K> <C-W><C-K>
        nnoremap <C-L> <C-W><C-L>
        nnoremap <C-H> <C-W><C-H>

        noremap j gj
        noremap k gk

        map <S-H> gT
        map <S-L> gt

        vnoremap < <gv
        vnoremap > >gv
    " }}}

    " UI Control {{{
        nnoremap <silent> <leader>l :set list!<CR>
    " }}}

    " Code Folding {{{
        inoremap <F9> <C-O>za
        nnoremap <F9> za
        onoremap <F9> <C-C>za
        vnoremap <F9> zf

        nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
        vnoremap <Space> zf

        nnoremap <silent> <leader>f0 :set foldlevel=0 <CR>
        nnoremap <silent> <leader>f1 :set foldlevel=1 <CR>
        nnoremap <silent> <leader>f2 :set foldlevel=2 <CR>
        nnoremap <silent> <leader>f3 :set foldlevel=3 <CR>
        nnoremap <silent> <leader>f4 :set foldlevel=4 <CR>
        nnoremap <silent> <leader>f5 :set foldlevel=5 <CR>
        nnoremap <silent> <leader>f6 :set foldlevel=6 <CR>
        nnoremap <silent> <leader>f7 :set foldlevel=7 <CR>
        nnoremap <silent> <leader>f8 :set foldlevel=8 <CR>
        nnoremap <silent> <leader>f9 :set foldlevel=9 <CR>
    " }}}
" }}}

" Plugin Configuration {{{

    " vim-airline {{{
        set laststatus=2
        let g:airline_powerline_fonts = 1
    " }}}

    " syntastic {{{
        set statusline+=%#warningmsg#
        set statusline+=%{SyntasticStatuslineFlag()}
        set statusline+=%*

        let g:syntastic_always_populate_loc_list = 1
        let g:syntastic_auto_loc_list = 1
        let g:syntastic_check_on_open = 1
        let g:syntastic_check_on_wq = 0
        let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
        let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
    " }}}
    
    " nerdtree {{{
        nnoremap <silent> <leader>n :NERDTreeToggle<CR>
        let g:NERDTreeIndicatorMapCustom = {
            \ "Modified"  : "✹",
            \ "Staged"    : "✚",
            \ "Untracked" : "✭",
            \ "Renamed"   : "➜",
            \ "Unmerged"  : "═",
            \ "Deleted"   : "✖",
            \ "Dirty"     : "✗",
            \ "Clean"     : "✔︎",
            \ "Unknown"   : "?"
            \ }
    " }}}

    " vim-table-mode {{{
        nnoremap <leader>tm :TableModeToggle <CR>
    " }}}

    " neocomplete {{{
        let g:neocomplete#enable_at_startup = 1
    " }}}

    " vim-go {{{
        let g:go_highlight_functions = 1
        let g:go_highlight_methods = 1
        let g:go_highlight_fields = 1
        let g:go_highlight_types = 1
        let g:go_highlight_operators = 1
        let g:go_highlight_build_constraints = 1
        let g:go_fmt_command = "goimports"

        au FileType go nmap <leader>r <Plug>(go-run)
        au FileType go nmap <leader>b <Plug>(go-build)
        au FileType go nmap <leader>t <Plug>(go-test)
        au FileType go nmap <leader>c <Plug>(go-coverage)
        au FileType go nmap <leader>gi <Plug>(go-install)

        au FileType go nmap <Leader>ds <Plug>(go-def-split)
        au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
        au FileType go nmap <Leader>dt <Plug>(go-def-tab)

        au FileType go nmap <Leader>gd <Plug>(go-doc)
        au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

        au FileType go nmap <Leader>s <Plug>(go-implements)
        au FileType go nmap <Leader>i <Plug>(go-info)
        au FileType go nmap <Leader>e <Plug>(go-rename)
    " }}}

    " Functions {{{
        " Set tabstop, softtabstop and shiftwidth to the same value
        command! -nargs=* Stab call Stab()
        function! Stab()
        let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
        if l:tabstop > 0
            let &l:sts = l:tabstop
            let &l:ts = l:tabstop
            let &l:sw = l:tabstop
        endif
        call SummarizeTabs()
        endfunction

        function! SummarizeTabs()
        try
            echohl ModeMsg
            echon 'tabstop='.&l:ts
            echon ' shiftwidth='.&l:sw
            echon ' softtabstop='.&l:sts
            if &l:et
            echon ' expandtab'
            else
            echon ' noexpandtab'
            endif
        finally
            echohl None
        endtry
        endfunction
    " }}}
" }}}

" Modeline {{{
" vim: et ts=4 sts=4 sw=4 fdm=marker fmr={{{,}}} fdl=9 fen
" }}}

