:set nocompatible
:set showmatch
:set ignorecase
:set mouse=v
:set hlsearch
:set incsearch
:set tabstop=4
:set softtabstop=4
:set shiftwidth=4
:set autoindent
:set number
:set mouse=a
:set clipboard=unnamedplus
:set cursorline
:set ttyfast
:set splitright

syntax on
filetype plugin indent on
filetype indent on

call plug#begin()
 Plug 'https://github.com/dracula/vim'
 Plug 'https://github.com/ryanoasis/vim-devicons'
 Plug 'https://github.com/SirVer/ultisnips'
 Plug 'https://github.com/honza/vim-snippets'
 Plug 'https://github.com/scrooloose/nerdtree'
 Plug 'https://github.com/preservim/nerdcommenter'
 Plug 'https://github.com/mhinz/vim-startify'
 Plug 'https://github.com/neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

colorscheme dracula

" Exit terminal
tnoremap <Esc> <C-\><C-n>

nnoremap <F2> :call ChooseTerm("term-slider", 1) <CR>
nnoremap <C-q> :exe "qa" <CR>

function! ChooseTerm(termname, slider)
	let pane = bufwinnr(a:termname)
	let buf = bufexists(a:termname)

	if pane > 0
		if a:slider > 0
			:exe pane . "wincmd c"
		else
			:exe "e #"
		endif
	elseif buf > 0
		if a:slider
			:exe "topleft split"
		endif
		:exe "buffer " . a:termname
	else

		if a:slider
			:exe "topleft split"
		endif
		:terminal
		:exe "f" a:termname
		:startinsert
	endif
endfunction
