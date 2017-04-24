" vim:fdm=marker et fdl=2 ft=vim sts=2 sw=2 ts=2

" Plugins {{{
if !filereadable(expand('~/.config/nvim/autoload/plug.vim'))
  echo 'Must install vim-plug, run ~/dotfiles/scripts/nvim-setup.sh'
  echo 'Run nvim -u NONE to open without ' . expand("<sfile>")
  exit
endif

call plug#begin()

" Colors {{{
" A bunch of Base16 colorschemes
Plug 'chriskempson/base16-vim'
" Temporary while developing colorscheme
" Plug 'fortes/vim-escuro'
" Plug '~/x/vim-escuro'
" Shades indent levels
Plug 'nathanaelkane/vim-indent-guides'
" }}}

" System {{{
" Clipboard provider that uses tmux
Plug 'cazador481/fakeclip.neovim'
" }}}

" Editing {{{
" Accent autocompletion via <C-X><C-U> or gx in normal mode
Plug 'airblade/vim-accent'
" <leader>nr open visual selection in sep window
Plug 'chrisbra/NrrwRgn'
" Auto-close parens / quotes, requires no config
Plug 'cohama/lexima.vim'
" Personal snippets
Plug 'fortes/vim-personal-snippets'
" Make it easier to find the cursor after searching
Plug 'inside/vim-search-pulse'
" Motion via two-character combinations
" s{char}{char} to move forward to instance of {char}{char}
" ; for next match
" <c-o> or `` to go back to starting point
" s<CR> to repeat last search
" S to search backwards
" For text objects, use z (s taken by surround.vim)
" {action}z{char}{char}
Plug 'justinmk/vim-sneak'
" Async completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'steelsojka/deoplete-flow'
Plug 'carlitux/deoplete-ternjs'
" Snippet support, see configuration below
Plug 'SirVer/ultisnips'
" Comment / uncomment things quickly
" {Visual}gc comment / uncomment selection
" - gc{motion} comment / uncomment lines for motion
Plug 'tpope/vim-commentary'
" Make plugin actions for a few plugins repeatable
Plug 'tpope/vim-repeat'
" Readline-style keybindings everywhere (e.g. <C-a> for beginning of line)
Plug 'tpope/vim-rsi'
" Needed for orgmode
" Makes <C-a> and <C-x> able to increment/decrement dates
Plug 'tpope/vim-speeddating'
" Edit surrounding quotes / parents / etc
" - {Visual}S<arg> surrounds selection
" - cs/ds<arg1><arg2> change / delete
" - ys<obj><arg> surrounds text object
" - yss<arg> for entire line
Plug 'tpope/vim-surround'
" Extra motion commands, including:
" - [f, ]f next/prev file in directory
" - [l, ]l next/prev file in location list
" - [n, ]n next/prev SCM conflict
" - [q, ]q next/prev file in quickfix list
" Toggles a few options:
" - coh hlsearch
" - con number
" - cos spell
" - cow wrap
" Additonal paste options
" - >p paste and indent
" - <p paste and deindent
Plug 'tpope/vim-unimpaired'
" Replace object with register contents
" gr{motion} Replace w/ unnamed register
" "xgr{motion} Replace w/ register x
Plug 'vim-scripts/ReplaceWithRegister'
" Complete words from tmux with <C-x><C-u>
Plug 'wellle/tmux-complete.vim'
" }}}

" File/Buffer Handling {{{
" Use FZF for fuzzy finding if available (see config below)
if executable('fzf')
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
end
" Adds helpers for UNIX shell commands
" :Remove Delete buffer and file at same time
" :Unlink Delete file, keep buffer
" :Move Rename buffer and file
Plug 'tpope/vim-eunuch'
" Make netrw better
" - '-' in any buffer to go up to directory listing
" - cg/cl to cd into the 
" - ! to use the file in a command
Plug 'tpope/vim-vinegar'
" Show register contents when using " or @ in normal mode
" Also shows when hitting <c-r> in insert mode
Plug 'junegunn/vim-peekaboo'
" }}}

" General coding {{{
" async code formatting
" :Neoformat <opt_formatter> for entire file
" :Neoformat! <filetype> for visual selection
Plug 'sbdchd/neoformat', { 'on': ['Neoformat'] }
" async :make via NeoVim job control, replaces syntastic for showing errors
" Provides :Neomake and :Neomake!
" Only load on first use of :Neomake command
" Plug 'benekastah/neomake', { 'on': ['Neomake'] }
" async linting
Plug 'w0rp/ale'
" Use SignColumn to mark lines in Quickfix/Location list
Plug 'dhruvasagar/vim-markify'
" Test.vim: Run tests based on cursor position / file
Plug 'janko-m/vim-test', { 'for': ['javascript'] }
" }}}

" Git {{{
" Run Git commands from within Vim
" :Gstatus show `git status` in preview window
" - <C-N>/<C-P> next/prev file
" - - add/reset file under cursor
" - ca :Gcommit --amend
" - cc :Gcommit
" - D :Gdiff
" - p :Git add --patch (reset on staged files)
" - q close status
" - r reload status
" :Gcommit for committing
" :Gblame run blame on current file
" - <cr> open commit
" - o/O open commit in split/tab
" - - reblame commit
Plug 'tpope/vim-fugitive'
" Adds gutter signs and highlights based on git diff
" [c ]c to jump to prev/next change hunks
" <leader>hs to stage hunks within cursor
" <leader>hr to revert hunks within cursor
" <leader>hv to preview the hunk
Plug 'airblade/vim-gitgutter'
" }}}

" CSS/LESS {{{
" Better CSS syntax
Plug 'JulesWang/css.vim', { 'for': ['css', 'less'] }
" LESS Support
Plug 'groenewege/vim-less', { 'for': ['less'] }
" }}}

" Javascript {{{
" JS highlighting and indent support. Sometimes buggy, but has support for
" jsdocs and flow
Plug 'pangloss/vim-javascript', { 'for': ['javascript']}
if executable('flow')
  Plug 'flowtype/vim-flow', { 'for': ['javascript'] }
endif
" Tern auto-completion engine for JS (requires node/npm)
if executable('yarn')
  Plug 'marijnh/tern_for_vim', { 'do': 'yarn install', 'for': ['javascript'] }
endif
" }}}

call plug#end()
" }}}

" Load Vanilla (no-plugin) config
if filereadable(expand("~/.vimrc"))
  source ~/.vimrc
endif

" Re-generate spelling files if modified
for d in glob(fnamemodify($MYVIMRC, ':h').'/spell/*.add', 1, 1)
  if getftime(d) > getftime(d.'.spl')
    exec 'mkspell! ' . fnameescape(d)
  endif
endfor

" Neovim-only config {{{
" Useful reference for Neovim-only features (:help vim-differences)

" Terminal {{{
" Lots of scrollback in terminal
let g:terminal_scrollback_buffer_size = 50000

" Quickly open a shell below current window
nnoremap <leader>sh :below 10sp term://$SHELL<cr>

" Send selection to term below
vnoremap <leader>sp :<C-u>norm! gv"sy<cr><c-w>j<c-\><c-n>pa<cr><c-\><c-n><c-w>k

" Terminal key bindings for window switching
" Map jj and jk to <ESC> to leave insert mode quickly
" Also allow <leader><C-c> and <leader><esc>
tnoremap jj <C-\><C-n>
tnoremap jk <C-\><C-n>
tnoremap <leader><C-c> <C-\><C-n>
tnoremap <leader><esc> <C-\><C-n>

" Automatically go into insert mode when entering terminal window
augroup terminal_insert
  autocmd!
  autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif
augroup END
" }}}
" }}}

if &t_Co >= 256
  " Upgrade colors if we have more colors, stays with default if not available
  let base16colorspace=256
  silent! colorscheme base16-railscasts
endif

" TODO: Move into .vimrc
augroup on_vim_enter
  autocmd!
  autocmd VimEnter * call OnVimEnter()
augroup END

" Called after plugins have loaded {{{
function! g:OnVimEnter()
  augroup neoformat_autosave
    autocmd!
    if exists(':Neoformat')
      " Run automatically before saving for supported filetypes
      " TODO: Enable
      " autocmd BufWritePre *.js Neoformat
    endif
  augroup END

  " augroup neomake_automake
  "   autocmd!
  "   if exists(':Neomake')
  "     " Check for lint errors on open & write for supported filetypes
  "     autocmd BufRead,BufWritePost *.js,*.less,*.sh silent! Neomake
  "   endif
  " augroup END
endfunction
" }}}
"
" Plugin Configuration {{{

" Deoplete {{{
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#flow#flow_bin = 'flow'
" let g:deoplete#omni#functions = {}
" let g:deoplete#omni#functions.javascript = [ 'tern#Complete', 'flowcomplete#Complete' ]
let g:deoplete#sources = {}
let g:deoplete#sources['javascript'] = ['flow', 'ternjs']
" }}}

" Markify {{{
" Use nicer symbols
let g:markify_error_text = '✗'
let g:markify_warning_text = '⚠'
let g:markify_info_text = '↳'

" Clear out markify symbols with <c-l>
nnoremap <silent> <C-L> :MarkifyClear<cr>:nohlsearch<cr><C-L>
" }}}

" Test.vim {{{
" Run test commands in NeoVim terminal
let test#strategy = 'neovim'

let test#javascript#mocha#options = {
  \ 'nearest': '--reporter list',
  \ 'file': '--reporter list',
  \ 'suite': '--reporter dot',
  \ }

" Only works in JS for now
augroup test_shortcuts
  autocmd!

  " <leader>tt to test based on cursor, <leader>twt to watch
  autocmd FileType javascript nnoremap <buffer> <silent> <leader>tt :TestNearest<cr>
  autocmd FileType javascript nnoremap <buffer> <silent> <leader>twt :TestNearest -w<cr><c-\><c-n><c-w><c-k>
  " <leader>tf to test current file, <leader> twf to watch
  autocmd FileType javascript nnoremap <buffer> <silent> <leader>tf :TestFile<cr>
  autocmd FileType javascript nnoremap <buffer> <silent> <leader>twf :TestFile -w<cr><c-\><c-n><c-w><c-k>
augroup END
" }}}

" Neoformat {{{
" Use formatprg when available
let g:neoformat_try_formatprg = 1
" }}}

" NeoMake {{{
if executable('eslint') || executable('eslint_d')
  " Use eslint/eslint_d if it's available
  if executable('flow')
    " And flow
    let g:neomake_javascript_enabled_makers = ['makeprg', 'flow']
  else
    let g:neomake_javascript_enabled_makers = ['makeprg']
  endif
endif

if executable('lessc')
  let g:neomake_less_enabled_makers = ['makeprg']
endif

if executable('shellcheck')
  let g:neomake_sh_enabled_makers = ['makeprg']
endif

" Open list automatically when there are errors
let g:neomake_open_list = 2
" }}}

" Fuzzy Finding (FZF) {{{
if executable('fzf')
  " <C-p> or <C-t> to search files
  " Open in split via control-x / control-v
  " Select/Deselect all via alt-a / alt-d
  nnoremap <silent> <C-t> :FZF -m<cr>
  nnoremap <silent> <C-p> :FZF -m<cr>

  " <M-p> for open buffers
  nnoremap <silent> <M-p> :Buffers<cr>

  " <M-S-p> for MRU & v:oldfiles
  nnoremap <silent> <M-S-p> :History<cr>

  " Fuzzy line completion via <c-x><c-m> instead of <c-x><c-l>
  imap <c-x><c-m> <plug>(fzf-complete-line)

  " Use fuzzy completion relative filepaths across directory with <c-x><c-j>
  imap <expr> <c-x><c-j> fzf#vim#complete#path('git ls-files $(git rev-parse --show-toplevel)')

  " Better command history with <leader>:
  nnoremap <leader>: :History:<CR>

  " Better search history with <leader>/
  nnoremap <leader>/ :History/<CR>

  " Fuzzy search help <leader>?
  nnoremap <leader>? :Helptags<CR>

  " Search from git root via :Rag (Root Ag)
  autocmd VimEnter * command! -nargs=* Rag
    \ call fzf#vim#ag(<q-args>, extend(FindGitRootCD(), g:fzf#vim#default_layout))

  " Use fuzzy searching for K & Q, select items to go into quickfix
  nnoremap K :Rag <C-R><C-W><cr>
  vnoremap K :<C-u>norm! gv"sy<cr>:silent! Rag <C-R>s<cr>
  nnoremap Q :Rag<SPACE>
end
" }}}

" UltiSnips {{{
" Use tab to expand snippet and move to next target. Shift tab goes back.
let g:UltiSnipsExpandTrigger="<tab>"
" <C-k> fuzzy-finds available snippets for the file with FZF
" let g:UltiSnipsListSnippets="<C-k>"
inoremap <C-k> <C-o>:Snippets<cr>
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
" }}}

" vim-javascript {{{
" jsdoc syntax
let g:javascript_plugin_jsdoc = 1

" flow syntax
let g:javascript_plugin_flow = 1
" }}}

" Flow {{{
" Don't typecheck automatically (Neomake does this)
let g:flow#enable = 0

augroup flow_shortcuts
  autocmd!

  " Switch omnifunc to flow via <leader>fc
  autocmd FileType javascript nnoremap <buffer> <leader>fc :setlocal omnifunc=flowcomplete#Complete<cr>
augroup END
" }}}

" Tern {{{
" Hide argument hints
let g:tern_show_argument_hints = 0
" Automatically set omnifunc (switch to flow via <leader>fc)
let g:tern_set_omni_function = 1
" Don't automatically map keys
let g:tern_map_keys = 0
" Don't auto-shutdown after 5 minutes
let g:tern#arguments = ['--persistent']
" Suppress location list after variable rename
let g:tern_show_loc_after_rename = 0

augroup tern_shortcuts
  autocmd!

  " <leader>tr to rename variable under cursor via Tern
  autocmd FileType javascript nnoremap <buffer> <leader>tr :TernRename<cr>
  " <leader>td to go to definition
  autocmd FileType javascript nnoremap <buffer> <leader>td :TernDef<cr>
  " <leader>tc to swtich omnifunc to tern
  autocmd FileType javascript nnoremap <buffer> <leader>tc :setlocal omnifunc=tern#Complete<cr>
augroup END
" }}}

" GitGutter {{{
" Unimpaired-style toggling for the line highlights
" cogg Gutter / cogl line highlight
nnoremap <silent> cogg :GitGutterToggle<cr>
nnoremap <silent> cogl :GitGutterLineHighlightsToggle<cr>

" Ignore whitespace
let g:gitgutter_diff_args='-w'

" Use raw grep
let g:gitgutter_escape_grep=1

" Don't highlight lines by default (use cogl to toggle)
let g:gitgutter_highlight_lines=0

" Be aggressive about looking for diffs
let g:gitgutter_realtime=1
let g:gitgutter_eager=1

" Tweak signs
let g:gitgutter_sign_modified='±'
let g:gitgutter_sign_modified_removed='≠'
" }}}

" Indent Guides {{{
" Default guides to on everywhere
let g:indent_guides_enable_on_vim_startup=1

" Don't turn on mapping for toggling guides
let g:indent_guides_default_mapping=0

" Don't use their colors, depending on the colorscheme to define
let g:indent_guides_auto_colors=0

" Wait until we've nested a little before showing
let g:indent_guides_start_level=3

" Skinny guides
let g:indent_guides_guide_size=1
" }}}

" Javascript libraries syntax {{{
let g:used_javascript_libs='react'
" }}}

" vim-jsx config {{{
" Don't require .jsx extension
let g:jsx_ext_required=0
" }}}

" }}}

" Local Settings {{{
if filereadable(expand("~/.nvimrc.local"))
  source ~/.nvimrc.local
endif
" }}}
