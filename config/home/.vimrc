set expandtab
set shiftwidth=4
set softtabstop=4
set textwidth=80
set formatoptions=nq
set nojoinspaces
set showcmd
set autoindent
set ignorecase
set smartcase
syntax on
xnoremap <silent> <C-c> y:call system("wl-copy", @")<CR><C-l>
set rtp^="/home/jason/.opam/default/share/ocp-indent/vim"
