" 2018/12/23
" 参考にしたページ：
"
" 【詳解】モテたいVimmer必見　快適にコーディングするためのvimrc解説
" https://qiita.com/ahiruman5/items/4f3c845500c172a02935
"
" Vimをもっと上手に! 新たな旋風、Neovimで自堕落なVim力に喝を入れる。
" https://liginc.co.jp/409849


"------------------ その他 -------------------
set noswapfile


" ------------------ 文字コード --------------
set encoding=utf-8 " ファイル読み込み時の文字コード
scriptencoding utf-8 " Vim script 内でマルチバイト文字を使う場合の設定
set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
set ambiwidth=double " □や○文字が崩れる問題を解決



" ---------------- タブ・インデント ----------
" set expandtab " タブ入力を複数の空白入力に置き換える
set tabstop=4 " 画面上でタブ文字が占める幅
set softtabstop=4 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent " 改行時に前の行のインデントを継続する
set smartindent " 改行時に前の行の構文をチェックし次の行のインデントを増減する
set shiftwidth=4 " smartindentで増減する幅



" ---------------- 文字列検索 ------------
set incsearch " インクリメンタルサーチ. １文字入力毎に検索を行う
set ignorecase " 検索パターンに大文字小文字を区別しない
set smartcase " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set hlsearch " 検索結果をハイライト
set inccommand=split " 置換をインタラクティブに行うことができる．すごい便利．

" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>



" --------------- カーソル ---------------
set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set number " 行番号を表示
set cursorline " カーソルラインをハイライト

" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

" バックスペースキーの有効化
set backspace=indent,eol,start



" ---------------- カッコ・タグジャンプ -------------
set showmatch " 括弧の対応関係を一瞬表示する
source $VIMRUNTIME/macros/matchit.vim " Vimの「%」を拡張する(%で対応するカッコにジャンプできる．)



" -------------- コマンド補完 --------------
set wildmenu " コマンドモードの補完
set history=5000 " 保存するコマンド履歴の数



" -------------- マウスの有効化 ---------------
" 以下はvim用の設定(not neovim)
"    "  以下の設定によりマウスでカーソル移動やスクロール移動ができるようになる．
"    if has('mouse')
"        set mouse=a
"        if has('mouse_sgr')
"            set ttymouse=sgr
"        elseif v:version > 703 || v:version is 703 && has('patch632')
"            set ttymouse=sgr
"        else
"            set ttymouse=xterm2
"        endif
"    endif

" 以下はneovim用の設定
set mouse=a       " どのモードでもマウスを使えるようにする
set nomousefocus  " マウスの移動でフォーカスを自動的に切替えない (mousefocus:切替る)
set mousehide     " 入力時にマウスポインタを隠す (nomousehide:隠さない)
set guioptions+=a " ビジュアル選択(D&D他)を自動的にクリップボードへ (:help guioptions_a)



" ------------ ペースト設定 ------------
"  クリップボードからペーストすると自動インデントが効いてネストが深いほどずれる．
"  以下の設定によりこの問題を解消できる．
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif




" ------------ エスケープキーを jj に設定する -----------
inoremap <silent> jj <ESC>
inoremap <silent> っｊ <ESC>



" ------------------ dein setting ---------------- "
if &compatible
 set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.local/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.local/dein')
 call dein#begin('~/.local/dein')

 call dein#add('~/.local/dein')
 call dein#add('Shougo/deoplete.nvim')
 call dein#add('zchee/deoplete-clang')
 if !has('nvim')
   call dein#add('roxma/nvim-yarp')
   call dein#add('roxma/vim-hug-neovim-rpc')
 endif


 " ============== plugins =============
 call dein#add('Shougo/unite.vim') " ファイル操作とか
 call dein#add('Shougo/neosnippet.vim') " スニペット
 call dein#add('Shougo/neosnippet-snippets') " スニペット
 " call dein#add('itchyny/lightline.vim') " ステータスラインの表示内容強化
 call dein#add('vim-airline/vim-airline') " ステータスラインがかっこよくなる
 call dein#add('vim-airline/vim-airline-themes')
 call dein#add('nathanaelkane/vim-indent-guides') " インデントを色分け
 call dein#add('Townk/vim-autoclose') " カッコを自動で閉じる
 call dein#add('honza/vim-snippets') " スニペット
 call dein#add('ujihisa/neco-look') " 英単語の補完
 call dein#add('Yggdroot/indentLine') " インデントの可視化

 " 行末尾の全角と半角の空白文字を赤くハイライト
 " :FixWhitespace でハイライトされている空白文字を一気に削除．
 call dein#add('bronson/vim-trailing-whitespace')

 call dein#add('tomasr/molokai') " カラースキーム molokai
 call dein#add('w0ng/vim-hybrid') " カラースキーム hybrid
 " 新しいプラグインを入れたら vim で :call dein#install() とする．
 " ====================================


 call dein#end()
 call dein#save_state()
endif
" ----------------- dein setting -------------------- "


" color scheme の設定． よくわからんが，dein の後に書くべきらしい．
set background=dark
colorscheme hybrid
syntax on



" dein の設定に含まれていたが，独立しているっぽいのでここに書いている．
filetype plugin indent on
syntax enable



" indentLine の設定
let g:indentLine_faster = 1 " indentLine の動作を軽くさせるもの(?)．　下のnmap は完全に謎．不要かも
nmap <silent><Leader>i :<C-u>IndentLinesToggle<CR>
set list lcs=tab:\|\  "tabの代わりに|とリーダーの空白を置くという意味．
let g:indentLine_char = '|' " インデントラインとしてどの文字を置くか


" Use deoplete.
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-6.0/lib/clang/6.0.0/lib/linux/libclang_rt.ubsan_standalone-x86_64.so'
let g:deoplete#sources#clang#clang_header = '/usr/include/clang'


" lighline用の設定
"    " ステータスラインの設定． 'itchyny/lightline.vim' に付随したもの．
"    set laststatus=2 " ステータスラインを常に表示
"    set showmode " 現在のモードを表示
"    set showcmd " 打ったコマンドをステータスラインの下に表示
"    set ruler " ステータスラインの右側にカーソルの現在位置を表示する
"    let g:lightline = {
"          \ 'colorscheme': 'jellybeans'
"          \ }



" ==============================
"     vim-airline の設定
" ==============================
set t_Co=256 " 色を正しく表示
set showtabline=2 " 常にタブラインを表示
let g:airline_powerline_fonts = 1 " パワーライン
let g:airline_theme = 'zenburn' " カラーテーマ
let g:airline#extensions#tabline#enabled = 1 " タブバー
" 選択行列の表示をカスタム(デフォルトだと長くて横幅を圧迫するので最小限に)
" let g:airline_section_z = airline#section#create(['windowswap', '%3p%% ', 'linenr', ':%3v'])
" let g:airline#extensions#virtualenv#enabled = 1 " virtulenvを認識しているか確認用に、現在activateされているvirtualenvを表示(vim-virtualenvの拡張)

" gitのHEADから変更した行の+-を非表示(vim-gitgutterの拡張)
" let g:airline#extensions#hunks#enabled = 0

" Lintツールによるエラー、警告を表示(ALEの拡張)
" let g:airline#extensions#ale#enabled = 1
" let g:airline#extensions#ale#error_symbol = 'E:'
" let g:airline#extensions#ale#warning_symbol = 'W:'



" let vim use clipboard
" vim用:
"   set clipboard&
"   set clipboard=unnamedplus,autoselect "unnamedplusはvimに貼り付ける時，autoselectはvimから貼り付ける時に必要なオプション．
set clipboard+=unnamedplus
