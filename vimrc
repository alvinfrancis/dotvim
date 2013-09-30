" .vimrc
" Author: Alvin Francis Dumalus <alvin.francis.dumalus@gmail.com>
" Last modified: 2013-07-15 00:26:26
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
    set guifont=Menlo:h11

    if exists('+transparency')
        command! Tran0 execute 'set transparency=0'
        command! Tran1 execute 'set transparency=25'
        command! Tran2 execute 'set transparency=50'
    endif

endif


" }}} ========================================================================
" Vundle {{{1-----------------------------------------------------------------

" Use Vundle to manage plugins

Bundle 'Align'
Bundle 'Conque-Shell'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Lokaltog/vim-powerline'
Bundle 'Shougo/neocomplcache.vim'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimproc.vim'
Bundle 'Shougo/vimshell.vim'
Bundle 'The-NERD-tree'
Bundle 'ack.vim'
Bundle 'coderifous/textobj-word-column.vim'
Bundle 'dbext.vim'
Bundle 'gitv'
Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'mattn/calendar-vim'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'scratch.vim'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'vimwiki/vimwiki'

if has('python')
    Bundle 'VOoM'
    Bundle 'klen/python-mode'
    Bundle 'sjl/gundo.vim'
    Bundle 'SirVer/ultisnips'
endif
if executable('ctags')
    Bundle 'taglist.vim'
    Bundle 'Tagbar'
endif
if executable('curl')
    Bundle 'mattn/webapi-vim'
    Bundle 'mattn/gist-vim'
endif


" }}} ========================================================================
" Basic stuff {{{1------------------------------------------------------------

" The most fundamental config. This will ensure that vim does not have to
" worry about keeping compatibility with vi.
set nocompatible

filetype indent plugin on
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
" set term=xterm-256color-italic
syntax on
" Text over the 500 col will not be syntax highlighted
set synmaxcol=500
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
let &showbreak = '  '
" set linespace=-1
set cursorline
" Do not jump to start of line when switching buffers
set nostartofline

" By default, do not wrap text. It makes the display ugly more often than not.
" If necessary, word wrap will be set manually
set nowrap

set laststatus=2
set confirm
set visualbell
set t_vb=
set mouse=a
set cmdheight=2
set number
set notimeout ttimeout ttimeoutlen=200

" Number of terminal colors
set t_Co=256

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
set scrolloff=999

" Only unfold the highest level fold (helps in Vimwiki)
set foldlevelstart=2

" This will create a vertical column highlight at column 80. Useful to check
" if a line is becoming to overly long.
" set colorcolumn=80

" Don't auto-indent comments.
set fo-=c

" Autoreload external changes made to files
set autoread

" color scheme
set background=dark
let g:solarized_termcolors = 16
colorscheme solarized


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

" Emacs style insert mode mappings
inoremap <C-a> <C-o>I
inoremap <C-e> <C-o>A
inoremap <C-f> <C-o>l
inoremap <C-b> <C-o>h
inoremap <C-k> <C-o>D
" inoremap f <C-o>w

" Split lines at cursor (TODO: Look into an easier mapping for this)
nnoremap <C-S-CR> i<CR><Esc>

" Create new line below or above
nnoremap ,<CR> o<Esc>
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

" Highlight selected text under cursor using highlighting groups {{{
" nnoremap <silent> <leader>hh :execute 'match InterestingWord1 /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>hx :<C-u>call MatchDeleteInterestingWords()<cr>
vnoremap <silent> <leader>h1 :<C-u>call HiInterestingWord(1)<cr>
vnoremap <silent> <leader>h2 :<C-u>call HiInterestingWord(2)<cr>
vnoremap <silent> <leader>h3 :<C-u>call HiInterestingWord(3)<cr>
vnoremap <silent> <leader>h4 :<C-u>call HiInterestingWord(4)<cr>
vnoremap <silent> <leader>h5 :<C-u>call HiInterestingWord(5)<cr>
vnoremap <silent> <leader>h6 :<C-u>call HiInterestingWord(6)<cr>

function! ResetInterestingColors() " {{{
    hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
    hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
    hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
    hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
    hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
    hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195
endfunction
" }}}
function! HiInterestingWord(n) " {{{
    " Calculate an arbitrary match ID.  Hopefully nothing else is using it.
    let matchid = 86750 + a:n
    " Clear existing matches, but don't worry if they don't exist.
    silent! call matchdelete(matchid)
    " Use VSetSearch code
    let temp = @@
    norm! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')

    call matchadd("InterestingWord" . a:n, @/, 1, matchid)
    let @@ = temp
endfunction " }}}
function! MatchDeleteInterestingWords() " {{{
    for offset in [1,2,3,4,5,6]
        let matchid = 86750 + offset
        silent! call matchdelete(matchid)
    endfor
endfunction " }}}

call ResetInterestingColors()
augroup InterestingWord
    autocmd ColorScheme * call ResetInterestingColors()
augroup END
" }}}

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
command! Changes execute 'CtrlPChange'
command! Buffers execute 'CtrlPBuffer'


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

" If buffer modified, update any 'Last modified:' in the first 10 lines.
" 'Last modified:' can have up to 10 characters before (they are retained).
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

" Toggle solarized background
function! ToggleSolarized()
    if !exists("g:solarized_style") || (g:solarized_style=="light")
        let g:solarized_style="dark"
        colorscheme solarized
    else
        let g:solarized_style="light"
        colorscheme solarized
    endif
endfunction

" format SQL using sqlformat.org
function! SQLFormat() " {{{
'<,'>python << EOF
import vim
import urllib2, urllib, json
sql = ' '.join(vim.current.range)
params = {'sql': sql,
          'n_indents': 4,
          'keyword_case': 'upper',
          'reindent': 1}
response = urllib2.urlopen('http://sqlformat.org/api/v1/format',
                           data=urllib.urlencode(params))
data = json.loads(response.read())
lines = str.splitlines(str(data['result']))
vim.current.range.append([line for line in lines if line != ''])
vim.command('\'<,\'>d')
EOF
endfunction " }}}

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
" vimwiki {{{2------------------------
augroup ft_wiki
    autocmd!
    autocmd FileType vimwiki setlocal textwidth=80
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

" Very Vanilla Powerline
function! MyStatusline(current) " {{{
    " let sline = {}
    " let sline['n'] = '%(%(%#StatusLine1# %{&paste ? "PASTE" : ""} %)%#StatusLine2#%)%(%(%#StatusLine3# %{GetMode()} %)%#StatusLine4#%)%(%(%#StatusLine5# %{GetBranch("BR:")} %)%#StatusLine5#│%)%( %(%#StatusLine6#%{&readonly ? "RO" : ""} %)%(%#StatusLine7#%{GetFilepath()}%)%(%#StatusLine8#%t %)%(%#StatusLine6#%M %)%(%#StatusLine6#%H%W %)%#StatusLine9#%)%<%#StatusLine10#%=%(%#StatusLine11#%(%#StatusLine12# %{&fileformat} %)%)%(%#StatusLine12#│%(%#StatusLine12# %{(&fenc == "" ? &enc : &fenc)} %)%)%(%#StatusLine12#│%(%#StatusLine12# %{strlen(&ft) ? &ft : "no ft"} %)%)%(%#StatusLine9#%(%#StatusLine5# %3p%% %)%)%(%#StatusLine7#%(%#StatusLine13# LN %3l%)%(%#StatusLine14#:%-2v%) %)'
    " let sline['i'] = '%(%(%#StatusLine1# %{&paste ? "PASTE" : ""} %)%#StatusLine15#%)%(%(%#StatusLine16# %{GetMode()} %)%#StatusLine17#%)%(%(%#StatusLine18# %{GetBranch("BR:")} %)%#StatusLine18#│%)%( %(%#StatusLine19#%{&readonly ? "RO" : ""} %)%(%#StatusLine18#%{GetFilepath()}%)%(%#StatusLine20#%t %)%(%#StatusLine19#%M %)%(%#StatusLine19#%H%W %)%#StatusLine21#%)%<%#StatusLine22#%=%(%#StatusLine23#%(%#StatusLine24# %{&fileformat} %)%)%(%#StatusLine24#│%(%#StatusLine24# %{(&fenc == "" ? &enc : &fenc)} %)%)%(%#StatusLine24#│%(%#StatusLine24# %{strlen(&ft) ? &ft : "no ft"} %)%)%(%#StatusLine21#%(%#StatusLine18# %3p%% %)%)%(%#StatusLine18#%(%#StatusLine25# LN %3l%)%(%#StatusLine26#:%-2v%) %)'
    " let sline['N'] = '%(%(%#StatusLine27# %{GetBranch("BR:")} %)%#StatusLine28#%)%( %(%#StatusLine29#%{&readonly ? "RO" : ""} %)%(%#StatusLine30#%{GetFilepath()}%)%(%#StatusLine31#%t %)%(%#StatusLine29#%M %)%(%#StatusLine29#%H%W %)%#StatusLine32#%)%<%#StatusLine33#%=%(%#StatusLine28#%(%#StatusLine27# %3p%% %)%)%(%#StatusLine34#│%(%#StatusLine34# LN %3l%)%(%#StatusLine35#:%-2v%) %)'
    " let sline['v'] = '%(%(%#StatusLine1# %{&paste ? "PASTE" : ""} %)%#StatusLine36#%)%(%(%#StatusLine37# %{GetMode()} %)%#StatusLine38#%)%(%(%#StatusLine5# %{GetBranch("BR:")} %)%#StatusLine5#│%)%( %(%#StatusLine6#%{&readonly ? "RO" : ""} %)%(%#StatusLine7#%{GetFilepath()}%)%(%#StatusLine8#%t %)%(%#StatusLine6#%M %)%(%#StatusLine6#%H%W %)%#StatusLine9#%)%<%#StatusLine10#%=%(%#StatusLine11#%(%#StatusLine12# %{&fileformat} %)%)%(%#StatusLine12#│%(%#StatusLine12# %{(&fenc == "" ? &enc : &fenc)} %)%)%(%#StatusLine12#│%(%#StatusLine12# %{strlen(&ft) ? &ft : "no ft"} %)%)%(%#StatusLine9#%(%#StatusLine5# %3p%% %)%)%(%#StatusLine7#%(%#StatusLine13# LN %3l%)%(%#StatusLine14#:%-2v%) %)' 
    " let sline['s'] = '%(%(%#StatusLine1# %{&paste ? "PASTE" : ""} %)%#StatusLine39#%)%(%(%#StatusLine40# %{GetMode()} %)%#StatusLine41#%)%(%(%#StatusLine5# %{GetBranch("BR:")} %)%#StatusLine5#│%)%( %(%#StatusLine6#%{&readonly ? "RO" : ""} %)%(%#StatusLine7#%{GetFilepath()}%)%(%#StatusLine8#%t %)%(%#StatusLine6#%M %)%(%#StatusLine6#%H%W %)%#StatusLine9#%)%<%#StatusLine10#%=%(%#StatusLine11#%(%#StatusLine12# %{&fileformat} %)%)%(%#StatusLine12#│%(%#StatusLine12# %{(&fenc == "" ? &enc : &fenc)} %)%)%(%#StatusLine12#│%(%#StatusLine12# %{strlen(&ft) ? &ft : "no ft"} %)%)%(%#StatusLine9#%(%#StatusLine5# %3p%% %)%)%(%#StatusLine7#%(%#StatusLine13# LN %3l%)%(%#StatusLine14#:%-2v%) %)'
    " let sline['r'] = '%(%(%#StatusLine1# %{&paste ? "PASTE" : ""} %)%#StatusLine1#│%)%(%(%#StatusLine1# %{GetMode()} %)%#StatusLine42#%)%(%(%#StatusLine5# %{GetBranch("BR:")} %)%#StatusLine5#│%)%( %(%#StatusLine6#%{&readonly ? "RO" : ""} %)%(%#StatusLine7#%{GetFilepath()}%)%(%#StatusLine8#%t %)%(%#StatusLine6#%M %)%(%#StatusLine6#%H%W %)%#StatusLine9#%)%<%#StatusLine10#%=%(%#StatusLine11#%(%#StatusLine12# %{&fileformat} %)%)%(%#StatusLine12#│%(%#StatusLine12# %{(&fenc == "" ? &enc : &fenc)} %)%)%(%#StatusLine12#│%(%#StatusLine12# %{strlen(&ft) ? &ft : "no ft"} %)%)%(%#StatusLine9#%(%#StatusLine5# %3p%% %)%)%(%#StatusLine7#%(%#StatusLine13# LN %3l%)%(%#StatusLine14#:%-2v%) %)'
 
    let mode = mode()
    if ! a:current
        let mode = 'N' " Normal (non-current)
    elseif mode =~# '\v(v|V| )'
        let mode = 'v' " Visual mode
    elseif mode =~# '\v(s|S| )'
        let mode = 's' " Select mode
    elseif mode =~# '\vi'
        let mode = 'i' " Insert mode
    elseif mode =~# '\v(R|Rv)'
        let mode = 'r' " Replace mode
    else
        " Fallback to normal mode
        let mode = 'n' " Normal (current)
    endif
 
    " return sline[mode]
    return g:MyStatusLine[mode]
endfunction " }}}
function! GetMode() " {{{
    let mode = mode()

    if mode ==# 'v'
        let mode = "VISUAL"
    elseif mode ==# 'V'
        let mode = "V.LINE"
    elseif mode ==# ''
        let mode = "V.BLOCK"
    elseif mode ==# 's'
        let mode = "SELECT"
    elseif mode ==# 'S'
        let mode = "S.LINE"
    elseif mode ==# ''
        let mode = "S.BLOCK"
    elseif mode =~# '\vi'
        let mode = "INSERT"
    elseif mode =~# '\v(R|Rv)'
        let mode = "REPLACE"
    else
        " Fallback to normal mode
        let mode = "NORMAL"
    endif

    return mode
endfunction " }}}
function! GetFilepath() " {{{
    " Recalculate the filepath when cwd changes.
    let cwd = getcwd()
    if exists("b:Powerline_cwd") && cwd != b:Powerline_cwd
        unlet! b:Powerline_filepath
    endif
    let b:Powerline_cwd = cwd

    if exists('b:Powerline_filepath')
        return b:Powerline_filepath
    endif

    let dirsep = has('win32') && ! &shellslash ? '\' : '/'
    let filepath = expand('%:p')

    if empty(filepath)
        return ''
    endif

    let ret = ''

    " Display a relative path, similar to the %f statusline item
    let ret = fnamemodify(filepath, ':~:.:h') . dirsep

    if ret == ('.' . dirsep)
        let ret = ''
    endif

    let b:Powerline_filepath = ret
    return ret
endfunction " }}}
function! GetBranch(symbol) " {{{
    if exists('fugitive#statusline')
        let ret = fugitive#statusline()
    else
        let ret = ''
    endif
    let ret = substitute(ret, '\c\v\[?GIT\(([a-z0-9\-_\./:]+)\)\]?', a:symbol .' \1', 'g')

    return ret
endfunction " }}}

function! ResetStatusLineColors() " {{{
    hi StatusLine1 cterm=bold ctermfg=231 ctermbg=160 gui=bold guifg=#ffffff guibg=#d70000
    hi StatusLine10 ctermfg=231 ctermbg=236 guifg=#ffffff guibg=#303030
    hi StatusLine11 ctermfg=236 ctermbg=236 guifg=#303030 guibg=#303030
    hi StatusLine12 ctermfg=247 ctermbg=236 guifg=#9e9e9e guibg=#303030
    hi StatusLine13 cterm=bold ctermfg=236 ctermbg=252 gui=bold guifg=#303030 guibg=#d0d0d0
    hi StatusLine14 ctermfg=244 ctermbg=252 guifg=#808080 guibg=#d0d0d0
    hi StatusLine15 ctermfg=160 ctermbg=231 guifg=#d70000 guibg=#ffffff
    hi StatusLine16 cterm=bold ctermfg=23 ctermbg=231 gui=bold guifg=#005f5f guibg=#ffffff
    hi StatusLine17 ctermfg=231 ctermbg=31 guifg=#ffffff guibg=#0087af
    hi StatusLine18 ctermfg=117 ctermbg=31 guifg=#87d7ff guibg=#0087af
    hi StatusLine19 cterm=bold ctermfg=196 ctermbg=31 gui=bold guifg=#ff0000 guibg=#0087af
    hi StatusLine2 ctermfg=160 ctermbg=148 guifg=#d70000 guibg=#afd700
    hi StatusLine20 cterm=bold ctermfg=231 ctermbg=31 gui=bold guifg=#ffffff guibg=#0087af
    hi StatusLine21 ctermfg=31 ctermbg=24 guifg=#0087af guibg=#005f87
    hi StatusLine22 ctermfg=231 ctermbg=24 guifg=#ffffff guibg=#005f87
    hi StatusLine23 ctermfg=24 ctermbg=24 guifg=#005f87 guibg=#005f87
    hi StatusLine24 ctermfg=117 ctermbg=24 guifg=#87d7ff guibg=#005f87
    hi StatusLine25 cterm=bold ctermfg=23 ctermbg=117 gui=bold guifg=#005f5f guibg=#87d7ff
    hi StatusLine26 ctermfg=23 ctermbg=117 guifg=#005f5f guibg=#87d7ff
    hi StatusLine27 ctermfg=240 ctermbg=235 guifg=#585858 guibg=#262626
    hi StatusLine28 ctermfg=235 ctermbg=233 guifg=#262626 guibg=#121212
    hi StatusLine29 ctermfg=88 ctermbg=233 guifg=#870000 guibg=#121212
    hi StatusLine3 cterm=bold ctermfg=22 ctermbg=148 gui=bold guifg=#005f00 guibg=#afd700
    hi StatusLine30 ctermfg=241 ctermbg=233 guifg=#626262 guibg=#121212
    hi StatusLine31 cterm=bold ctermfg=245 ctermbg=233 gui=bold guifg=#8a8a8a guibg=#121212
    hi StatusLine32 ctermfg=233 ctermbg=233 guifg=#121212 guibg=#121212
    hi StatusLine33 ctermfg=231 ctermbg=233 guifg=#ffffff guibg=#121212
    hi StatusLine34 cterm=bold ctermfg=245 ctermbg=235 gui=bold guifg=#8a8a8a guibg=#262626
    hi StatusLine35 ctermfg=241 ctermbg=235 guifg=#626262 guibg=#262626
    hi StatusLine36 ctermfg=160 ctermbg=208 guifg=#d70000 guibg=#ff8700
    hi StatusLine37 cterm=bold ctermfg=88 ctermbg=208 gui=bold guifg=#870000 guibg=#ff8700
    hi StatusLine38 ctermfg=208 ctermbg=240 guifg=#ff8700 guibg=#585858
    hi StatusLine39 ctermfg=160 ctermbg=241 guifg=#d70000 guibg=#626262
    hi StatusLine4 ctermfg=148 ctermbg=240 guifg=#afd700 guibg=#585858
    hi StatusLine40 cterm=bold ctermfg=231 ctermbg=241 gui=bold guifg=#ffffff guibg=#626262
    hi StatusLine41 ctermfg=241 ctermbg=240 guifg=#626262 guibg=#585858
    hi StatusLine42 ctermfg=160 ctermbg=240 guifg=#d70000 guibg=#585858
    hi StatusLine5 ctermfg=250 ctermbg=240 guifg=#bcbcbc guibg=#585858
    hi StatusLine6 cterm=bold ctermfg=196 ctermbg=240 gui=bold guifg=#ff0000 guibg=#585858
    hi StatusLine7 ctermfg=252 ctermbg=240 guifg=#d0d0d0 guibg=#585858
    hi StatusLine8 cterm=bold ctermfg=231 ctermbg=240 gui=bold guifg=#ffffff guibg=#585858
    hi StatusLine9 ctermfg=240 ctermbg=236 guifg=#585858 guibg=#303030
endfunction "}}}
function! ItemGroup(...) " {{{
    let groupedstring = '%('
    let groupedstring .= join(a:000,'')
    let groupedstring .= '%)'
    return groupedstring
endfunction " }}}
function! SetStatusColorDict() " {{{
    let g:StatusColors = {}
    let g:StatusColors['i'] = {
                \ 'PasteSeg'         : '%#StatusLine1#',
                \ 'PasteSep'         : '%#StatusLine15#',
                \ 'ModeSeg'          : '%#StatusLine16#',
                \ 'ModeSep'          : '%#StatusLine17#',
                \ 'BranchSeg'        : '%#StatusLine18#',
                \ 'BranchSep'        : '%#StatusLine18#',
                \ 'ROSeg'            : '%#StatusLine19#',
                \ 'PathSeg'          : '%#StatusLine18#',
                \ 'NameSeg'          : '%#StatusLine20#',
                \ 'ModFlagSeg'       : '%#StatusLine19#',
                \ 'HelpPrevFlagsSeg' : '%#StatusLine19#',
                \ 'FileInfoSep'      : '%#StatusLine21#',
                \ 'MidSeg'           : '%#StatusLine22#',
                \ 'FormatInfoSep'    : '%#StatusLine23#',
                \ 'FormatSeg'        : '%#StatusLine24#',
                \ 'EncSep'           : '%#StatusLine24#',
                \ 'EncSeg'           : '%#StatusLine24#',
                \ 'FileTypeSep'      : '%#StatusLine24#',
                \ 'FileTypeSeg'      : '%#StatusLine24#',
                \ 'PercSep'          : '%#StatusLine21#',
                \ 'PercSeg'          : '%#StatusLine18#',
                \ 'LineColSep'       : '%#StatusLine18#',
                \ 'LineSeg'          : '%#StatusLine25#',
                \ 'ColSeg'           : '%#StatusLine26#' }
    let g:StatusColors['n'] = {
                \ 'PasteSeg'         : '%#StatusLine1#',
                \ 'PasteSep'         : '%#StatusLine2#',
                \ 'ModeSeg'          : '%#StatusLine3#',
                \ 'ModeSep'          : '%#StatusLine4#',
                \ 'BranchSeg'        : '%#StatusLine5#',
                \ 'BranchSep'        : '%#StatusLine5#',
                \ 'ROSeg'            : '%#StatusLine6#',
                \ 'PathSeg'          : '%#StatusLine7#',
                \ 'NameSeg'          : '%#StatusLine8#',
                \ 'ModFlagSeg'       : '%#StatusLine6#',
                \ 'HelpPrevFlagsSeg' : '%#StatusLine6#',
                \ 'FileInfoSep'      : '%#StatusLine9#',
                \ 'MidSeg'           : '%#StatusLine10#',
                \ 'FormatInfoSep'    : '%#StatusLine11#',
                \ 'FormatSeg'        : '%#StatusLine12#',
                \ 'EncSep'           : '%#StatusLine12#',
                \ 'EncSeg'           : '%#StatusLine12#',
                \ 'FileTypeSep'      : '%#StatusLine12#',
                \ 'FileTypeSeg'      : '%#StatusLine12#',
                \ 'PercSep'          : '%#StatusLine9#',
                \ 'PercSeg'          : '%#StatusLine5#',
                \ 'LineColSep'       : '%#StatusLine7#',
                \ 'LineSeg'          : '%#StatusLine13#',
                \ 'ColSeg'           : '%#StatusLine14#' }
    let g:StatusColors['v'] = {
                \ 'PasteSeg'         : '%#StatusLine1#',
                \ 'PasteSep'         : '%#StatusLine36#',
                \ 'ModeSeg'          : '%#StatusLine37#',
                \ 'ModeSep'          : '%#StatusLine38#',
                \ 'BranchSeg'        : '%#StatusLine5#',
                \ 'BranchSep'        : '%#StatusLine5#',
                \ 'ROSeg'            : '%#StatusLine6#',
                \ 'PathSeg'          : '%#StatusLine7#',
                \ 'NameSeg'          : '%#StatusLine8#',
                \ 'ModFlagSeg'       : '%#StatusLine6#',
                \ 'HelpPrevFlagsSeg' : '%#StatusLine6#',
                \ 'FileInfoSep'      : '%#StatusLine9#',
                \ 'MidSeg'           : '%#StatusLine10#',
                \ 'FormatInfoSep'    : '%#StatusLine11#',
                \ 'FormatSeg'        : '%#StatusLine12#',
                \ 'EncSep'           : '%#StatusLine12#',
                \ 'EncSeg'           : '%#StatusLine12#',
                \ 'FileTypeSep'      : '%#StatusLine12#',
                \ 'FileTypeSeg'      : '%#StatusLine12#',
                \ 'PercSep'          : '%#StatusLine9#',
                \ 'PercSeg'          : '%#StatusLine5#',
                \ 'LineColSep'       : '%#StatusLine7#',
                \ 'LineSeg'          : '%#StatusLine13#',
                \ 'ColSeg'           : '%#StatusLine14#' }
    let g:StatusColors['s'] = {
                \ 'PasteSeg'         : '%#StatusLine1#',
                \ 'PasteSep'         : '%#StatusLine39#',
                \ 'ModeSeg'          : '%#StatusLine40#',
                \ 'ModeSep'          : '%#StatusLine41#',
                \ 'BranchSeg'        : '%#StatusLine5#',
                \ 'BranchSep'        : '%#StatusLine5#',
                \ 'ROSeg'            : '%#StatusLine6#',
                \ 'PathSeg'          : '%#StatusLine7#',
                \ 'NameSeg'          : '%#StatusLine8#',
                \ 'ModFlagSeg'       : '%#StatusLine6#',
                \ 'HelpPrevFlagsSeg' : '%#StatusLine6#',
                \ 'FileInfoSep'      : '%#StatusLine9#',
                \ 'MidSeg'           : '%#StatusLine10#',
                \ 'FormatInfoSep'    : '%#StatusLine11#',
                \ 'FormatSeg'        : '%#StatusLine12#',
                \ 'EncSep'           : '%#StatusLine12#',
                \ 'EncSeg'           : '%#StatusLine12#',
                \ 'FileTypeSep'      : '%#StatusLine12#',
                \ 'FileTypeSeg'      : '%#StatusLine12#',
                \ 'PercSep'          : '%#StatusLine9#',
                \ 'PercSeg'          : '%#StatusLine5#',
                \ 'LineColSep'       : '%#StatusLine7#',
                \ 'LineSeg'          : '%#StatusLine13#',
                \ 'ColSeg'           : '%#StatusLine14#' }
    let g:StatusColors['r'] = {
                \ 'PasteSeg'         : '%#StatusLine1#',
                \ 'PasteSep'         : '%#StatusLine1#',
                \ 'ModeSeg'          : '%#StatusLine1#',
                \ 'ModeSep'          : '%#StatusLine42#',
                \ 'BranchSeg'        : '%#StatusLine5#',
                \ 'BranchSep'        : '%#StatusLine5#',
                \ 'ROSeg'            : '%#StatusLine6#',
                \ 'PathSeg'          : '%#StatusLine7#',
                \ 'NameSeg'          : '%#StatusLine8#',
                \ 'ModFlagSeg'       : '%#StatusLine6#',
                \ 'HelpPrevFlagsSeg' : '%#StatusLine6#',
                \ 'FileInfoSep'      : '%#StatusLine9#',
                \ 'MidSeg'           : '%#StatusLine10#',
                \ 'FormatInfoSep'    : '%#StatusLine11#',
                \ 'FormatSeg'        : '%#StatusLine12#',
                \ 'EncSep'           : '%#StatusLine12#',
                \ 'EncSeg'           : '%#StatusLine12#',
                \ 'FileTypeSep'      : '%#StatusLine12#',
                \ 'FileTypeSeg'      : '%#StatusLine12#',
                \ 'PercSep'          : '%#StatusLine9#',
                \ 'PercSeg'          : '%#StatusLine5#',
                \ 'LineColSep'       : '%#StatusLine7#',
                \ 'LineSeg'          : '%#StatusLine13#',
                \ 'ColSeg'           : '%#StatusLine14#' }
    let g:StatusColors['N'] = {
                \ 'BranchSeg'        : '%#StatusLine27#',
                \ 'BranchSep'        : '%#StatusLine28#',
                \ 'ROSeg'            : '%#StatusLine29#',
                \ 'PathSeg'          : '%#StatusLine30#',
                \ 'NameSeg'          : '%#StatusLine31#',
                \ 'ModFlagSeg'       : '%#StatusLine29#',
                \ 'HelpPrevFlagsSeg' : '%#StatusLine29#',
                \ 'FileInfoSep'      : '%#StatusLine32#',
                \ 'MidSeg'           : '%#StatusLine33#',
                \ 'PercSep'          : '%#StatusLine28#',
                \ 'PercSeg'          : '%#StatusLine27#',
                \ 'LineColSep'       : '%#StatusLine34#',
                \ 'LineSeg'          : '%#StatusLine34#',
                \ 'ColSeg'           : '%#StatusLine35#' }
endfunction " }}}
function! SetMyStatusLine() " {{{
    let g:MyStatusLine = {}
    let g:MyStatusLine['n'] = CreateBasicStatusLine('n')
    let g:MyStatusLine['i'] = CreateBasicStatusLine('i')
    let g:MyStatusLine['N'] = CreateBasicStatusLine('N')
    let g:MyStatusLine['v'] = CreateBasicStatusLine('v')
    let g:MyStatusLine['s'] = CreateBasicStatusLine('s')
    let g:MyStatusLine['r'] = CreateBasicStatusLine('r')
endfunction " }}}
function! CreateBasicStatusLine(mode) " {{{
    let sline = ''
    if a:mode !=# 'N'
    " StatusLine for when window is current {{{
        let sline .= ItemGroup(
                        \ ItemGroup(
                            \ g:StatusColors[a:mode]['PasteSeg'],
                            \ ' %{&paste ? "PASTE" : ""} '),
                        \ g:StatusColors[a:mode]['PasteSep'])
        let sline .= ItemGroup(
                        \ ItemGroup(
                            \ g:StatusColors[a:mode]['ModeSeg'],
                            \ ' %{GetMode()} '),
                        \ g:StatusColors[a:mode]['ModeSep'])
        let sline .= ItemGroup(
                        \ ItemGroup(
                            \ g:StatusColors[a:mode]['BranchSeg'],
                            \ ' %{GetBranch("BR:")} '),
                        \ g:StatusColors[a:mode]['BranchSep'],
                        \ '|')
        let sline .= ItemGroup(
                        \ ' ',
                        \ ItemGroup(
                            \ g:StatusColors[a:mode]['ROSeg'],
                            \ '%{&readonly ? "RO" : ""} '),
                        \ ItemGroup(
                            \ g:StatusColors[a:mode]['PathSeg'],
                            \ '%{GetFilepath()}'),
                        \ ItemGroup(
                            \ g:StatusColors[a:mode]['NameSeg'],
                            \ '%t '),
                        \ ItemGroup(
                            \ g:StatusColors[a:mode]['ModFlagSeg'],
                            \ '%M '),
                        \ ItemGroup(
                            \ g:StatusColors[a:mode]['HelpPrevFlagsSeg'],
                            \ '%H',
                            \ '%W '),
                        \ g:StatusColors[a:mode]['FileInfoSep'])
        let sline .= '%<'
        let sline .= g:StatusColors[a:mode]['MidSeg']
        let sline .= '%='
        let sline .= ItemGroup(
                        \ g:StatusColors[a:mode]['FormatInfoSep'],
                        \ ItemGroup(
                            \ g:StatusColors[a:mode]['FormatSeg'],
                            \ ' %{&fileformat} '))
        let sline .= ItemGroup(
                        \ g:StatusColors[a:mode]['EncSep'],
                        \ '|',
                        \ ItemGroup(
                            \ g:StatusColors[a:mode]['EncSeg'],
                            \ ' %{(&fenc == "" ? &enc : &fenc)} '))
        let sline .= ItemGroup(
                        \ g:StatusColors[a:mode]['FileTypeSep'],
                        \ '|',
                        \ ItemGroup(
                            \ g:StatusColors[a:mode]['FileTypeSeg'],
                            \ ' %{strlen(&ft) ? &ft : "no ft"} '))
        let sline .= ItemGroup(
                        \ g:StatusColors[a:mode]['PercSep'],
                        \ ItemGroup(
                            \ g:StatusColors[a:mode]['PercSeg'],
                            \ ' %3p%%'))
        let sline .= ItemGroup(
                        \ ' ',
                        \ g:StatusColors[a:mode]['LineColSep'],
                        \ ItemGroup(
                            \ g:StatusColors[a:mode]['LineSeg'],
                            \ ' LN %3l'),
                        \ ItemGroup(
                            \ g:StatusColors[a:mode]['ColSeg'],
                            \ ':%-2v'),
                        \ ' ')
    " }}}
    else
    " StatusLine for when window is not current {{{
        let sline .= ItemGroup(
                        \ ItemGroup(
                            \ g:StatusColors[a:mode]['BranchSeg'],
                            \ ' %{GetBranch("BR:")} '),
                        \ g:StatusColors[a:mode]['BranchSep'])
        let sline .= ItemGroup(
                        \ ' ',
                        \ ItemGroup(
                            \ g:StatusColors[a:mode]['ROSeg'],
                            \ '%{&readonly ? "RO" : ""} '),
                        \ ItemGroup(
                            \ g:StatusColors[a:mode]['PathSeg'],
                            \ '%{GetFilepath()}'),
                        \ ItemGroup(
                            \ g:StatusColors[a:mode]['NameSeg'],
                            \ '%t '),
                        \ ItemGroup(
                            \ g:StatusColors[a:mode]['ModFlagSeg'],
                            \ '%M '),
                        \ ItemGroup(
                            \ g:StatusColors[a:mode]['HelpPrevFlagsSeg'],
                            \ '%H',
                            \ '%W '),
                        \ g:StatusColors[a:mode]['FileInfoSep'])
        let sline .= '%<'
        let sline .= g:StatusColors[a:mode]['MidSeg']
        let sline .= '%='
        let sline .= ItemGroup(
                        \ g:StatusColors[a:mode]['PercSep'],
                        \ ItemGroup(
                            \ g:StatusColors[a:mode]['PercSeg'],
                            \ ' %3p%%'))
        let sline .= ItemGroup(
                        \ ' ',
                        \ g:StatusColors[a:mode]['LineColSep'],
                        \ ItemGroup(
                            \ g:StatusColors[a:mode]['LineSeg'],
                            \ ' LN %3l'),
                        \ ItemGroup(
                            \ g:StatusColors[a:mode]['ColSeg'],
                            \ ':%-2v'),
                        \ ' ')
    " }}}
    endif
    return sline
endfunction " }}}
"
" Autocommands {{{
    function! s:Startup()
        call ResetStatusLineColors()
        call SetStatusColorDict()
        call SetMyStatusLine()
        augroup StatuslineMain
            autocmd!
            autocmd ColorScheme * call ResetStatusLineColors()
            autocmd BufEnter,WinEnter,FileType,BufUnload,CmdWinEnter *
                        \ call setwinvar(winnr(), '&statusline',
                        \                '%!MyStatusline(1)')
            autocmd BufLeave,WinLeave,CmdWinLeave * 
                        \ call setwinvar(winnr(), '&statusline',
                        \ '%!MyStatusline(0)')
        augroup END
 
        let curwindow = winnr()
        for window in range(1, winnr('$'))
            call setwinvar(winnr(), '&statusline',
                        \  '%!MyStatusline('. (window == curwindow) .')')
        endfor
    endfunction
 
    augroup StatuslineStartup
        autocmd!
        autocmd VimEnter * call s:Startup()
    augroup END
" }}}


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
" Unite {{{2---------------------------
" Use the fuzzy matcher for everything
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#custom#source('file,file/new,buffer,file_rec,command',
\ 'matchers', 'matcher_fuzzy')

" Use the rank sorter for everything
call unite#filters#sorter_default#use(['sorter_rank'])

" Set up some custom ignores
call unite#custom_source('file_rec,file_mru,file,buffer,grep',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ 'git5/.*/review/',
      \ 'google/obj/',
      \ ], '\|'))

" Map space to the prefix for Unite
nnoremap [unite] <nop>
nmap \ [unite]

nnoremap <silent> [unite]\ :<C-u>UniteResume<CR>

" General fuzzy search
nnoremap <silent> [unite]<space> :<C-u>Unite
      \ -buffer-name=all buffer file_mru bookmark<CR>

" Quick registers
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>

" Quick buffer and mru
nnoremap <silent> [unite]u :<C-u>Unite -buffer-name=buffers buffer file_mru<CR>

" Quick yank history
nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<CR>

" Quick outline
nnoremap <silent> [unite]o :<C-u>Unite -buffer-name=outline -vertical outline<CR>

" Quick sessions (projects)
nnoremap <silent> [unite]p :<C-u>Unite -buffer-name=sessions session<CR>

" Quick snippet
nnoremap <silent> [unite]s :<C-u>Unite -buffer-name=snippets snippet<CR>

" Quickly switch lcd
nnoremap <silent> [unite]d
      \ :<C-u>Unite -buffer-name=change-cwd -default-action=lcd directory_mru<CR>

" Quick file search
nnoremap <silent> [unite]f :<C-u>Unite -buffer-name=files file_rec<CR>

" Quick grep from cwd
nnoremap <silent> [unite]g :<C-u>UniteWithInput -buffer-name=grep grep:.<CR>

" Quick help
nnoremap <silent> [unite]h :<C-u>Unite -buffer-name=help help<CR>

" Quick line using the word under cursor
nnoremap <silent> [unite]l :<C-u>UniteWithCursorWord -buffer-name=search_file line<CR>

" Quick MRU search
nnoremap <silent> [unite]m :<C-u>Unite -buffer-name=mru file_mru<CR>

" Quick find
nnoremap <silent> [unite]n :<C-u>Unite -buffer-name=find find:.<CR>

" Quick commands
nnoremap <silent> [unite]c :<C-u>Unite -buffer-name=commands command<CR>

" Quick bookmarks
" nnoremap <silent> [unite]b :<C-u>Unite -buffer-name=bookmarks bookmark<CR>

" Quick buffers
nnoremap <silent> [unite]b :<C-u>Unite -buffer-name=buffers buffer<CR>

" Fuzzy search from current buffer
" nnoremap <silent> [unite]b :<C-u>UniteWithBufferDir
      " \ -buffer-name=files -prompt=%\  buffer file_mru bookmark file<CR>

" Quick commands
nnoremap <silent> [unite]; :<C-u>Unite -buffer-name=history history/command command<CR>

" Custom Unite settings
augroup unite
    autocmd!
    autocmd FileType unite call s:unite_settings()
augroup END

function! s:unite_settings() " {{{

    nmap <buffer> <ESC> <Plug>(unite_exit)
    imap <buffer> <ESC> <Plug>(unite_exit)
    " imap <buffer> <c-j> <Plug>(unite_select_next_line)
    imap <buffer> <c-j> <Plug>(unite_select_next_line)
    imap <buffer> <c-k> <Plug>(unite_select_previous_line)
    inoremap <silent><buffer><expr> <C-s> unite#do_action('split')
    nnoremap <silent><buffer><expr> <C-s> unite#do_action('split')
    inoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
    nnoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
    inoremap <silent><buffer><expr> <C-t> unite#do_action('tabopen')
    nnoremap <silent><buffer><expr> <C-t> unite#do_action('tabopen')
  
    let unite = unite#get_current_unite()
    if unite.buffer_name =~# '^search'
        nnoremap <silent><buffer><expr> r     unite#do_action('replace')
    else
        nnoremap <silent><buffer><expr> r     unite#do_action('rename')
    endif
  
    nnoremap <silent><buffer><expr> cd     unite#do_action('lcd')
  
    " Using Ctrl-\ to trigger outline, so close it using the same keystroke
    if unite.buffer_name =~# '^outline'
        imap <buffer> <C-\> <Plug>(unite_exit)
    endif
  
    " Using Ctrl-/ to trigger line, close it using same keystroke
    if unite.buffer_name =~# '^search_file'
        imap <buffer> <C-_> <Plug>(unite_exit)
    endif
endfunction " }}}

" Start in insert mode
let g:unite_enable_start_insert = 1

" Enable short source name in window
" let g:unite_enable_short_source_names = 1

" Enable history yank source
let g:unite_source_history_yank_enable = 1

" Open in bottom right
let g:unite_split_rule = "botright"

" Shorten the default update date of 500ms
let g:unite_update_time = 200

let g:unite_source_file_mru_limit = 1000
" let g:unite_cursor_line_highlight = 'TabLineSel'
" let g:unite_abbr_highlight = 'TabLine'

let g:unite_source_file_mru_filename_format = ':~:.'
let g:unite_source_file_mru_time_format = ''

" For ack.
if executable('ack-grep')
    let g:unite_source_grep_command = 'ack-grep'
    " Match whole word only. This might/might not be a good idea
    let g:unite_source_grep_default_opts = '--no-heading --no-color -a -w'
    let g:unite_source_grep_recursive_opt = ''
elseif executable('ack')
    let g:unite_source_grep_command = 'ack'
    let g:unite_source_grep_default_opts = '--no-heading --no-color -a'
    let g:unite_source_grep_recursive_opt = ''
endif

" }}} ---------------------------------
" VimShell {{{2------------------------

let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_prompt = $USER.'$ '

" }}} ---------------------------------
" neocomplcache {{{2------------------------

nnoremap <F6> :NeoComplCacheEnable<CR>

" }}} ---------------------------------


" }}} ========================================================================

" vim: foldmethod=marker foldmarker={{{,}}} tw=79
