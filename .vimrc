" .vimrc
" Author: Alvin Francis Dumalus <alvin.francis.dumalus@gmail.com>
" Last modified: 2013-06-23 23:34:08
" Description: Definitely still a work in progress. A lot of what's on here
" comes from (or takes ideas from) others. I'll try to comment as much as I
" can.
"
" ----------------------------------------------------------------------------


" OS-Dependent settings {{{1--------------------------------------------------
" Additional machine specific settings should be set in plugins scripts

if has('win32')
    " Force the use of forward slashes
    set shellslash

    " Change vimfiles directory
    let $VIMFILES="vimfiles"

    " Modify vundle paths
    set runtimepath+=$HOME/vimfiles/bundle/vundle/
    call vundle#rc("$HOME/vimfiles/bundle")

    " Set font to Consolas due to lack of fonts in Windows
    set guifont=Consolas:h09

else
    let escaped_home=escape(escape($HOME,'/'),' ')
    execute 'let $DESKTOP="' .escaped_home. '/Desktop"'

    " Use default wiki when on personal machines
    let g:vimwiki_list = [ {}, { 'path': '~/work/' } ]

    " Change vimfiles directory
    let $VIMFILES=".vim"

    set runtimepath+=~/.vim/bundle/vundle/
    call vundle#rc()

    " Set font to Monaco (preferred font)
    set guifont=Monaco:h11

    if exists('+transparency')
        command! Tran0 execute 'set transparency=0'
        command! Tran1 execute 'set transparency=25'
        command! Tran2 execute 'set transparency=50'
    endif

endif


" }}} ========================================================================
" Vundle {{{1-----------------------------------------------------------------

" Use Vundle to manage plugins

Bundle 'dbext.vim'
Bundle 'Conque-Shell'
Bundle 'taglist.vim'
Bundle 'Tagbar'
Bundle 'The-NERD-tree'
Bundle 'Align'
Bundle 'scratch.vim'
Bundle 'ack.vim'
Bundle 'gmarik/vundle'
Bundle 'mattn/calendar-vim'
Bundle 'kien/ctrlp.vim'
Bundle 'vimwiki/vimwiki'
Bundle 'tpope/vim-surround'
Bundle 'Lokaltog/vim-easymotion'
if has('python')
    Bundle 'VOoM'
    Bundle 'klen/python-mode'
    Bundle 'sjl/gundo.vim'
    Bundle 'SirVer/ultisnips'
endif
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-powerline'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-repeat'
Bundle 'terryma/vim-multiple-cursors'

" }}} ========================================================================
" Basic stuff {{{1------------------------------------------------------------

" The most fundamental config. This will ensure that vim does not have to
" worry about keeping compatibility with vi.
set nocompatible

filetype indent plugin on
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
syntax on
set hidden
set wildmenu
set showcmd
set nohlsearch
set incsearch
set ignorecase
set smartcase
set backspace=indent,eol,start
set autoindent
set ruler
set linebreak
let &showbreak = '+++ '
" set linespace=-1

" By default, do not wrap text. It makes display ugly more often than not. If
" necessary, word wrap will be set manually
set nowrap

set laststatus=2
set confirm
set visualbell
set t_vb=
set mouse=a
set cmdheight=2
set number
set notimeout ttimeout ttimeoutlen=200

" Tab preferences
" Expand tab to spaces, set shiftwidth (indent length) to 4, set
" tabstop (length of a tab) to 4, try not to rely on softabstop (used to mix
" spaces and tabs to adhere to the tabstop rule while making it feel as if
" the tabstop is different from what it really is)
set expandtab
set shiftwidth=4
set tabstop=4

" This determines the minimum number of lines that should be displayed at the
" bottom/top when scrolling down/up. It is the number of lines the cursor is
" offset from the end of the window.
set scrolloff=10

" Only unfold the highest level fold (helps in Vimwiki)
set foldlevelstart=2

" This will create a vertical column highlight at column 80. Useful to check
" if a line is becoming to overly long.
" set colorcolumn=80

" Don't auto-indent comments.
set fo-=c

colorscheme wombat


" }}} ========================================================================
" Gui Options {{{1------------------------------------------------------------

" Remove unnecessary GUI
set guioptions-=T " Toolbar
set guioptions-=m " Menu bar
set guioptions-=l " Left Scroll bar
set guioptions-=r " Right Scroll bar
set guioptions-=L " Left Scroll bar in splits
set guioptions-=R " Right Scroll bar in splits
set guioptions-=e " GUI Tab Pages Line

" Maximize gvim window.
if has("gui_running")
    set lines=999 columns=999
endif


" }}} ========================================================================
" Leader {{{1-----------------------------------------------------------------

" Let comma be the leader key. Note, this will overwrite its default
" functionality as the counterpart of ';' which is used in the f/t movement.
let mapleader=","


" }}} ========================================================================
" Editing {{{1----------------------------------------------------------------

" Make Y behave (it acts like 'yy' by default)
noremap Y y$

" jj to Escape Insert mode
inoremap jj <Esc>

" Split lines at cursor (TODO: Look into an easier mapping for this)
nnoremap <C-S-CR> i<CR><Esc>

" Create new line below or above
nnoremap <C-CR> o<Esc>
nnoremap <S-CR> O<Esc>

" Paste from clipboard
nnoremap <leader>pp "+gP

" Yank selected text into clipboard
vnoremap <leader>y "+y

" Insert timestamp
" nnoremap <leader>it a<C-r>=strftime('%Y-%m-%d %T')<CR><Esc>
" vnoremap <leader>it c<C-r>=strftime('%Y-%m-%d %T')<CR><Esc>

" Quick edit vimrc
nnoremap <leader>evs :sp $MYVIMRC<CR>
nnoremap <leader>evv :vs $MYVIMRC<CR>
nnoremap <leader>eve :e $MYVIMRC<CR>
nnoremap <leader>evn :sp $MYVIMRC<CR>
nnoremap <leader>evt :tabedit $MYVIMRC<CR>

" Scratch Buffer Creator
nnoremap <leader>es :set buftype=nofile<CR>:set bufhidden=hide<CR>:setlocal noswapfile<CR>:set nobuflisted<CR>:echo "Buffer Scratched!"<CR>
" nnoremap <leader>ss :new<CR><C-W><S-j><C-W>5_:set buftype=nofile<CR>:set bufhidden=hide<CR>:setlocal noswapfile<CR>:set nobuflisted<CR>:echo "Mini Scratch Buffer"<CR>

" Ex mode is used very rarely enough so as not to warrant its own key
nnoremap Q K


" }}} ========================================================================
" Movement {{{1---------------------------------------------------------------

" Movement by display lines instead of actual lines (useful when wrap is
" on)
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" HJKL movement in Insert Mode (Just add Ctrl)
" inoremap <C-j> <Down>
" inoremap <C-k> <Up>
" inoremap <C-h> <Left>
" inoremap <C-l> <Right>

" Scroll Up and Down in Normal/Visual Mode
nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>
vnoremap <C-j> <C-d>
vnoremap <C-k> <C-u>

" Use space to jump 5 lines at a time in Normal/Visual Mode
nnoremap <Space> 5j
nnoremap <S-Space> 5k
vnoremap <Space> 5j
vnoremap <S-Space> 5k


" }}} ========================================================================
" Search {{{1-----------------------------------------------------------------

" Position cursor in middle when jumping to next search
nnoremap n nzzzv
nnoremap N Nzzzv

" Highlight word under cursor using highlighting groups (seems like overkill
" for now). Needs to create the highlight groups first.
" nnoremap <silent> <leader>hh :execute 'match InterestingWord1 /\<<c-r><c-w>\>/'<cr>
" nnoremap <silent> <leader>h1 :execute 'match InterestingWord1 /\<<c-r><c-w>\>/'<cr>
" nnoremap <silent> <leader>h2 :execute '2match InterestingWord2 /\<<c-r><c-w>\>/'<cr>
" nnoremap <silent> <leader>h3 :execute '3match InterestingWord3 /\<<c-r><c-w>\>/'<cr>

" Visual Mode */# from Scrooloose
" Pressing */# in Visual mode will search for the visually selected text
function! s:VSetSearch() " {{{
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction " }}}
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR><c-o>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR><c-o>

" Highlight the entire line containing the pattern
nnoremap <leader>hl /.*.*<Left><Left>

" Don't move on '*'. By default, '*' moves to the next instance of the word
" under the cursor.
nnoremap * *<c-o>

" Toggle highlighting. Note: This does not clear the search register. Also,
" search highlighting will remain toggled off or on until it is toggled again.
nnoremap <C-S-Space> :set hlsearch!<CR>


" }}} ========================================================================
" Windows, Tabs, and Buffers {{{1---------------------------------------------

" Switch windows using Shift+HJKL
nnoremap <S-j> <C-w>j
nnoremap <S-k> <C-w>k
nnoremap <S-h> <C-w>h
nnoremap <S-l> <C-w>l

" Tab switching. Use leader for future proofing
nnoremap <leader>ll gt
nnoremap <leader>hh gT
nnoremap <leader>nn :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>

" Switch tabs using Ctrl+HL
nnoremap <C-h> gT
nnoremap <C-l> gt

" Buffer stuff (TODO: Look into using buffer switching more)
" nnoremap <F1> :bN<CR>
" nnoremap <F2> :bn<CR>
nnoremap <F9> :call CloseHiddenBuffers()<CR>
nnoremap <leader>gb :ls<CR>:b
nnoremap <Left> :bN<CR>
nnoremap <Right> :bn<CR>

" }}} ========================================================================
" Undo, Swap, History, and Backup {{{1----------------------------------------

" Turn on persistent undo
set undofile
set undodir=$HOME/$VIMFILES/undo

" Swap files directory
set directory=$HOME/$VIMFILES/tmp

" Command line history limit
set history=1000


" if exists("+undofile")
"     if !has('win32')
"         if isdirectory($HOME . '/.vim/undo') == 0
"             :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
"         else
"             :silent !find $HOME'/.vim/undo/' -type f -mtime +7 -delete > /dev/null 2>&1
"         endif
"     endif
"     set undodir=./.vim-undo//
"     set undodir+=~/.vim/undo//
"     set undofile
" endif


" }}} ========================================================================
" Commands {{{1---------------------------------------------------------------

command! Cls execute 'let @/=""'
command! SaveWork execute 'mksession! $HOME\Work.vim'
command! SaveSession execute 'mksession! $HOME\Session.vim'


" }}} ========================================================================
" Functions {{{1--------------------------------------------------------------

" Highlight a column in csv text
" :Csv 12   " highlight twelfth column
" :Csv 0    " switch off highlight
function! CSVH(colnr) " {{{
    if a:colnr > 1
        let n = a:colnr - 1
        execute 'match Keyword /^\([^,]*,\)\{'.n.'}\zs[^,]*/'
        execute 'normal! 0'.n.'f,'
    elseif a:colnr == 1
        match Keyword /^[^,]*/
        normal! 0
    else
        match
    endif
endfunction " }}}
command! -nargs=1 Csv :call CSVH(<args>)

" Check if buffer is empty
function! BufferIsEmpty() " {{{
    if line2byte(line('$')) <= 2
        return 1
    else
        return 0
    endif
endfunction " }}}
" Close all hidden buffers
function! CloseHiddenBuffers() " {{{
    let lastBuffer = bufnr('$')
    let currentBuffer = 1
    while currentBuffer <= lastBuffer
        if bufexists(currentBuffer) && buflisted(currentBuffer) && bufwinnr(currentBuffer) < 0
            execute 'bdelete' currentBuffer
        endif
        let currentBuffer = currentBuffer + 1
    endwhile
endfunction " }}}
" Wipeout all non-visible buffers
function! Wipeout() " {{{
    " list of *all* buffer numbers
    let l:buffers = range(1, bufnr('$'))

    " what tab page are we in?
    let l:currentTab = tabpagenr()
    try
        " go through all tab pages
        let l:tab = 0
        while l:tab < tabpagenr('$')
            let l:tab += 1

            " go through all windows
            let l:win = 0
            while l:win < winnr('$')
                let l:win += 1
                " whatever buffer is in this window in this tab, remove it from
                " l:buffers list
                let l:thisbuf = winbufnr(l:win)
                call remove(l:buffers, index(l:buffers, l:thisbuf))
            endwhile
        endwhile

        " if there are any buffers left, delete them
        if len(l:buffers)
            execute 'bwipeout' join(l:buffers)
        endif
    finally
        " go back to our original tab page
        execute 'tabnext' l:currentTab
    endtry
endfunction " }}}
" Close all [No Name] buffers
function! CloseNoNameBuffers() " {{{
    let lastBuffer = bufnr('$')
    let currentBuffer = 1
    while currentBuffer <= lastBuffer
        if bufexists(currentBuffer) && bufname(currentBuffer) == ''
            execute 'bdelete!' currentBuffer
        endif
        let currentBuffer = currentBuffer + 1
    endwhile
endfunction " }}}

" If buffer modified, update any 'Last modified: ' in the first 20 lines.
" 'Last modified: ' can have up to 10 characters before (they are retained).
" Restores cursor and window position using save_cursor variable.
function! LastModified() " {{{
  if &modified
    let save_cursor = getpos(".")
    let n = min([10, line("$")])
    keepjumps exe '1,' . n . 's#^\(.\{,10}Last modified: \).*#\1' .
          \ strftime('%Y-%m-%d %H:%M:%S') . '#e'
    call histdel('search', -1)
    call setpos('.', save_cursor)
  endif
endfun " }}}


" }}} ========================================================================
" Text Objects {{{1-----------------------------------------------------------

" TODO: Assess danger of recursive omap (Rewrite?)
" Fold Object {{{2---------------------
" This object refers to the contents of a fold. 'if' refers only to the
" inside; it does not include the fold boundaries (as defined by '[z' and
" ']z'). 'af' refers to the whole fold including the boundaries.
onoremap af :<C-U>silent! normal! [zV]z
vnoremap af :<C-U>silent! normal! [zV]z
" omap af :normal Vaf<CR><C-O><C-O>
onoremap if :<C-U>silent! normal! [zjV]zk
vnoremap if :<C-U>silent! normal! [zjV]zk
" omap if :normal Vif<CR><C-O><C-O>

" }}} ---------------------------------
" Number Object {{{2---------------------
" TODO: Work-In-Progress
" vnoremap in :<C-U>silent! normal! ?[^0-9\.]wV/[^0-9\.]b
" omap af :normal Vaf<CR><C-O><C-O>
" vnoremap if :<C-U>silent! normal! [zjV]zk
" omap if :normal Vif<CR><C-O><C-O>

" }}} ---------------------------------
" Next and Last Object {{{2-------------------
" (Taken from Steve Losh)
" Motion for "next/last object". For example, "din(" would go to the next "()"
" pair and delete its contents.

onoremap an :<c-u>silent call <SID>NextTextObject('a', 'f')<cr>
xnoremap an :<c-u>silent call <SID>NextTextObject('a', 'f')<cr>
onoremap in :<c-u>silent call <SID>NextTextObject('i', 'f')<cr>
xnoremap in :<c-u>silent call <SID>NextTextObject('i', 'f')<cr>

onoremap al :<c-u>silent call <SID>NextTextObject('a', 'F')<cr>
xnoremap al :<c-u>silent call <SID>NextTextObject('a', 'F')<cr>
onoremap il :<c-u>silent call <SID>NextTextObject('i', 'F')<cr>
xnoremap il :<c-u>silent call <SID>NextTextObject('i', 'F')<cr>

function! s:NextTextObject(motion, dir)
  let c = nr2char(getchar())

  if c ==# "b"
      let c = "("
  elseif c ==# "B"
      let c = "{"
  elseif c ==# "d"
      let c = "["
  endif

  exe "normal! ".a:dir.c."v".a:motion.c
endfunction

" }}} ---------------------------------


" }}} ========================================================================
" Java specific stuff  {{{1---------------------------------------------------

" TODO: Reorganize this.

let java_highlight_all=1
let java_highlight_debug=1
let java_ignore_javadoc=1
let java_highlight_functions=1
" let java_mark_braces_in_parens_as_errors=1
abbr sysout. System.out.


" }}} ========================================================================
" Autocmd Groups specifics {{{1-----------------------------------------------

" vim {{{2-----------------------------
augroup ft_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker foldmarker={{{,}}}
augroup END

" }}} ---------------------------------
" javascript {{{2----------------------
augroup ft_js
    autocmd!
    autocmd FileType javascript setlocal foldmethod=marker foldmarker={,}
augroup END

" }}} ---------------------------------
" vimrc {{{2---------------------------
augroup ft_vimrc
    autocmd!
    " This updates the timestamp before each write
    autocmd BufWritePre *vimrc call LastModified()
augroup END

" }}} ---------------------------------
" fugitive {{{2------------------------
augroup ft_git
    autocmd!
    autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END
" }}} ---------------------------------
" snippets {{{2------------------------
augroup ft_snippets
    autocmd!
    autocmd BufReadPost *.snippets set bufhidden=delete
augroup END
" }}} ---------------------------------
" vbs {{{2------------------------
augroup ft_vb
    autocmd!
    autocmd FileType vb setlocal syntax=vbnet foldmethod=syntax
augroup END
" }}} ---------------------------------


" }}} ========================================================================
" TODO stuff {{{1-------------------------------------------------------------

" TODO: TABLIFY WORK IN PROGRESS
" normal :s/^\| \|$/|/g`[VypV:s/[^|]/-/gak0:let @/=""
" Set spell
" TODO: Move spell to another group
if version >= 700
    set spl=en spell
    set nospell
endif

" Vimwiki has a nice foldtext method. Keeping this for future reference. Using
" same vimwiki function here:
function! MyFoldText() "{{{
  let line = substitute(getline(v:foldstart), '\t',
        \ repeat(' ', &tabstop), 'g')
  return line.' ['.(v:foldend - v:foldstart).']'
endfunction "}}}
" TODO: reorganize this to somewhere
set tags+=./tags;/
set foldtext=MyFoldText()
" set foldtext=getline(v:foldstart)


" }}} ========================================================================
" Status Line {{{1------------------------------------------------------------

set statusline=%<%f
set statusline+=\ %h%m%r
if exists('*fugitive#statusline()')
    set statusline+=\ %{fugitive#statusline()}
endif
set statusline+=%= "separation point
set statusline+=%(%c%V%)\ :\ %l/%L

augroup statusline
    autocmd!
    autocmd InsertEnter  * call InsertStatuslineColor(v:insertmode)
    autocmd InsertChange * call InsertStatuslineColor(v:insertmode)
    autocmd InsertLeave  * highlight statusline guibg=green
augroup END

function! InsertStatuslineColor(mode)
    if a:mode == 'i'
        hi statusline guibg=yellow
        hi statusline guifg=black
    elseif a:mode == 'r'
        hi statusline guibg=blue
        hi statusline guifg=white
    else
        hi statusline guibg=green
        hi statusline guifg=black
    endif
endfunction


" }}} ========================================================================
" Plugin Configurations {{{1--------------------------------------------------

" NERDTree {{{2------------------------
let NERDTreeHijackNetrw=0
nnoremap <leader><Tab> :NERDTreeToggle<CR>

" }}} ---------------------------------
" Scratch Plugin {{{2------------------
" A simple plugin that creates a single shared Scratch buffer

function! ScratchToggle()
  if exists("w:is_scratch_window")
    unlet w:is_scratch_window
    exec "q"
  else
    exec "normal! :Sscratch\<cr>\<C-W>J:resize 13\<cr>"
    let w:is_scratch_window = 1
  endif
endfunction
command! ScratchToggle call ScratchToggle()
nnoremap <silent> <F3> :ScratchToggle<cr>

" }}} ---------------------------------
" Vimwiki options {{{2-----------------

" Set work as default wiki
let g:vimwiki_ext2syntax = {}

" let g:vimwiki_list = [ {'path': '~/work/', 'syntax': 'markdown', 'ext': '.md'}]
" Set default wiki as default wiki
let g:vimwiki_folding='syntax'
let g:vimwiki_fold_lists=1
" Vimwiki Insert Mode table mappings conflict with UltiSnips
let g:vimwiki_table_mappings=0

" }}} ---------------------------------
" CtrlP {{{2---------------------------

" Set working directory options
let g:ctrlp_working_path_mode = '0'
" Do not clear cache on exit
let g:ctrlp_clear_cache_on_exit = 0
" Mapping for CtrlPMRU
nnoremap <leader><C-p> :CtrlPMRU<CR>
" Mapping for CtrlPBuff
nnoremap <leader><leader><C-p> :CtrlPBuffer<CR>


" }}} ---------------------------------
" Python-mode {{{2---------------------

" Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 1

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'Q'

" Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"

" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 1

" }}} ---------------------------------
" TagBar and Taglist {{{2--------------

" Toggle TagBar mapping
nnoremap <leader><C-]> :TagbarToggle<CR>

" Toggle Taglist mapping
nnoremap <leader><C-[> :TlistToggle<CR>

" }}} ---------------------------------
" UltiSnips {{{2-----------------------

let g:UltiSnipsSnippetDirectories=["ultisnips","snippets"]

" }}} ---------------------------------
" Gundo {{{2---------------------------

nnoremap <F5> :GundoToggle<CR>

" }}} ---------------------------------
" Multiple-Cursors {{{2----------------

let g:multi_cursor_quit_key='<C-j>'

" }}} ---------------------------------


" }}} ========================================================================

" vim: foldmethod=marker foldmarker={{{,}}} tw=79
