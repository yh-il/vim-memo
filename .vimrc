" ========================================
" dein.vimの設定
" :call dein#install()でインストール
" ========================================
if &compatible
  set nocompatible
endif

set runtimepath+=~/.vim/deinvim/dein.vim

call dein#begin(expand('~/.vim/dein'))
call dein#add('Shougo/vimproc.vim', {'build': 'make'})

" call dein#add('Shougo/neocomplete.vim')
" call dein#add('Shougo/neomru.vim')
" call dein#add('Shougo/neosnippet')
call dein#add('mattn/emmet-vim')
call dein#add('terryma/vim-multiple-cursors')
" call dein#add('Shougo/unite.vim')

" :NERDTree を打つとTree表示が起動します
" t -> 新しいタブで開く
" i -> 水平分割して開く
" s -> 垂直分割して開く
call dein#add('scrooloose/nerdtree')

" 選択範囲を ctrl + - (ハイフン2回押し)でコメントアウト
call dein#add('tomtom/tcomment_vim')

" vue.jsのカラーシンタックス
call dein#add('posva/vim-vue')

" あいまい検索でファイルを開く
" Ctrl+t -> 新しいタブ
" Ctrl+s -> 水平分割
" Ctrl+v -> 垂直分割
call dein#add('ctrlpvim/ctrlp.vim')

call dein#add('Lokaltog/vim-powerline') " ステータスラインをかっこよく

" call map(dein#check_clean(), "delete(v:val, 'rf')") " 未使用プラグイン削除(:call dein#recache_runtimepath() ←vim再起動後にこれを実行)

call dein#end()


" ========================================
" vimの設定
" ========================================

syntax on
" colorscheme molokai " ~.vim/colors配下にmolokai.vimを置く必要あり
colorscheme onedark " ~.vim/colorsと~.vim/autoload配下にonedark.vimを置く必要あり（公式のリポジトリ参照）
set autoindent
set smartindent
set expandtab
set tabstop=4
set shiftwidth=4
set cursorline
set number
set backspace=indent,eol,start
set history=1000
set ignorecase
set noswapfile " swpファイルを作成しない
set title " windowのタイトル表示
set hlsearch " 検索結果をハイライト
" set clipboard=unnamed " クリップボードにyankを同期
set showmatch " 括弧の対応関係を一瞬表示する
set wildmenu " コマンドモードの補完
set history=5000 " 保存するコマンド履歴の数


" autocmd QuickFixCmdPost *grep* cwindow " quickfix-windowを|cwしなくても開けるようになる
autocmd QuickfixCmdPost make,grep,grepadd,vimgrep tab cwindow " quickfix-windowをtabnewで開く

" 行末の空白を保存時に自動削除
" autocmd BufWritePre * :%s/\s\+$//ge



" ===============
" ステータスラインの設定（vim-powerline入れたのでコメントアウト）
" ===============
" 色
" highlight StatusLine term=NONE cterm=NONE ctermfg=black ctermbg=236
" ファイル名表示
" set statusline=%F
" 変更チェック表示
" set statusline+=%m
" 読み込み専用かどうか表示
" set statusline+=%r
" ヘルプページなら[HELP]と表示
" set statusline+=%h
" プレビューウインドウなら[Prevew]と表示
" set statusline+=%w
" これ以降は右寄せ表示
" set statusline+=%=
" file encoding
" set statusline+=[ENC=%{&fileencoding}]
" 現在行数/全行数
" set statusline+=[LOW=%l/%L]
" ステータスラインを常に表示(0:表示しない、1:2つ以上ウィンドウがある時だけ表示)
set laststatus=2


" ==============
" vim-powerlineの設定
" ===============
" 三角のやつ
let g:Powerline_symbols = 'fancy'


" ========================================
" ctrlp.vimの設定(内部grepの対象外にしたい)
" ========================================
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.jpg,*.png,*.gif,*.svg,*/node_modules/*
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_match_window = 'bottom,min:1,max:40,results:40'
let g:ctrlp_show_hidden = 1 " .(ドット)から始まるファイルも検索対象にする
let g:ctrlp_types = ['fil'] "ファイル検索のみ使用


" ========================================
" key bind
" ========================================

" ctrl + e でemmet-vim起動
imap <C-e> <C-y>,
vmap <C-e> <C-y>,

" jj でesc
inoremap jj <Esc>

" 閉じ括弧の自動挿入（十字キーの挙動がおかしくなるからコメントアウト）
" inoremap { {}<LEFT>
" inoremap ( ()<LEFT>

" phpタグ挿入
inoremap php<TAB> <?php   ?><LEFT><LEFT><LEFT><LEFT>

" 縦割りでnewファイルリスト表示
nnoremap :vnew<CR> :vnew<CR>:e .<CR>

" ディレクトリ内検索
inoremap <C-f> <Esc>:vim //j ./**\<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
nnoremap <C-f> <Esc>:vim //j ./**\<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>

" ファイル内置換
nnoremap <C-h> <Esc>:%s///gc

" ファイル内置換(選択範囲を絞って)
vnoremap <C-h> :s///gc<LEFT><LEFT><LEFT><LEFT>

" ctags設定(<C-]>でジャンプ、<C-o>で戻れる)
" nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
" tagsジャンプの時に複数ある時は一覧表示
nnoremap <C-]> g<C-]>

" ctrl + h , l でタブ切り替え
nnoremap <C-h> gT
nnoremap <C-l> gt

" 幅を狭める
nnoremap <C-j> <C-w><

" ページ分割系
nnoremap <C-s>s :<C-u>sp<CR>
nnoremap <C-s>v :<C-u>vs<CR>
nnoremap <C-s>t :<C-u>tabnew<CR>:e .<CR>
" ctrl + tでタブを開いてツリー表示
" nnoremap <C-t> :tabnew<CR>:e .<CR>
" ctrl + k でツリーの表示、非表示
nnoremap <C-k> :NERDTreeFind<CR>

" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk
