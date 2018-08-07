call plug#begin('~/.vim/plugged')

""" vim状态栏
Plug 'itchyny/lightline.vim'

""" 左侧文件浏览
Plug 'scrooloose/nerdtree'
"文件浏览框tab页支持
Plug 'jistr/vim-nerdtree-tabs'

""" 文件搜索
" 需要先安装依赖 brew install fzf
" 搜索代码的话还要安装 brew install the_silver_searcher, 安装后可以在vim里执行 :Ag 命令搜索文件里内容
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

""" 代码补全、语法检查
"括号自动补全
"Plug 'Raimondi/delimitMate'
Plug 'jiangmiao/auto-pairs'
"代码自动补全
"Plug 'maralla/completor.vim'
Plug 'Valloric/YouCompleteMe'
"代码语法检查
Plug 'w0rp/ale'
"显示末尾空格
Plug 'bronson/vim-trailing-whitespace'
"代码折叠
Plug 'tmhedberg/SimpylFold'

""" 不同语言支持
"js
Plug 'pangloss/vim-javascript'
"vue支持
Plug 'posva/vim-vue'
"jinja支持
Plug 'lepture/vim-jinja'
"sass支持
Plug 'cakebaker/scss-syntax.vim'
"sass显示colors
Plug 'gorodinskiy/vim-coloresque'
"html 标签匹配高亮
Plug 'Valloric/MatchTagAlways'
" 提高HTML和CSS的工作流
Plug 'mattn/emmet-vim'
" 提供快速编写xml/html的能力，如标签自动闭合等
Plug 'othree/xml.vim'
" 多光标编辑功能
Plug 'terryma/vim-multiple-cursors'
" 快速开关注释
Plug 'scrooloose/nerdcommenter'
" 显示git diff 和 stages/undoes 片段
Plug 'airblade/vim-gitgutter'
" 解决中文输入法下面无法使用命令
Plug 'ybian/smartim'

call plug#end()

""" vim 全局设置
syntax on                                  " 开启语法高亮
""" colorscheme Tomorrow-Night                 " 主题设置
" colorscheme space-vim-dark
colorschem panda
" colorschem vwilight
set confirm                                " 退出未保存文件的时候提示
set backspace=indent,eol,start             " 解决delete键无作用
set t_Co=256                               " 支持256色
set nowrap                                 " 不自动折行
set number                                 " 显示行号
set incsearch                              " 搜索时: 输入的时候就可以即时查看结果
set ignorecase                             " 搜索时: 忽略大小写
set smartcase                              " 搜索时: 如果有一个大写字母，则切换到大小写敏感查找
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp
let g:copycat#auto_sync = 1                " vim和系统共用剪切板
let mapleader = "\<Space>"                 " 设置leader 键为空格
let g:mapleader = "\<Space>"

" 解决vim卡
set re=1
set ttyfast
set lazyredraw

" 解决中文乱码
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
" 设置 utf-8 编码
set encoding=utf-8

" 按文件类型设置缩进
set expandtab       " 把tab键转为空格
set autoindent      " 自动缩进
set smartindent     " 智能缩进:每一行都和前一行有相同的缩进量
set smarttab        " 根据文件中其他地方的缩进空格个数来确定一个 tab 是多少个空格
set tabstop=4       " tab width
set softtabstop=4   " backspace
set shiftwidth=4    " indent width
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType javascript,vue setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType html,htmldjango,xhtml,haml setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType sass,scss,css,less setlocal tabstop=2 shiftwidth=2 softtabstop=2

" 解决 vim-vue 插件有时候高亮失效的问题
autocmd FileType vue syntax sync fromstart
" 解决 vim-vue 导致 vim 变卡
let g:vue_disable_pre_processors=1

" 代码折叠
set foldmethod=indent
set foldlevel=99

" 自动加载变化
set autoread
" 光标放一段时间，检查文件是否发生变化
autocmd CursorHold * checktime
" 刚进入 tab 时 检查文件是否发生变化
autocmd TabEnter * checktime

" 打开文件的时候，自动定位到上次查看的位置
autocmd BufReadPost *
      \ if ! exists("g:leave_my_cursor_position_alone") |
      \     if line("'\"") > 0 && line ("'\"") <= line("$") |
      \         exe "normal g'\"" |
      \     endif |
      \ endif


""" 左侧菜单nerdtree与顶部标签页
" 显示隐藏文件
let NERDTreeShowHidden=1
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1
let g:nerdtree_tabs_open_on_console_startup=1                        " 默认打开tree
let g:NERDTreeWinSize = 30                                           " 菜单栏宽度
nmap <F12> :NERDTreeToggle<cr>                                       " F12 切换显示或不显示
" 某些文件不显示在tree里
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$', 'node_modules', 'dist', '.DS_Store']
nnoremap <C-l> gt                                                    " ctr + l 向左切换标签页面
nnoremap <C-h> gT                                                    " ctr + h 向右切换标签页面


""" 底部状态栏 lightline
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'tab_component_function': {
    \   'filename': 'MyTabFilename',
    \ },
    \ 'component': {
    \   'filename': '%f',
    \   'close': '',
    \ },
\}
function! MyTabFilename(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let bufnum = buflist[winnr - 1]
  let bufname = expand('#'.bufnum.':t')
  let buffullname = expand('#'.bufnum.':p')
  let buffullnames = []
  let bufnames = []
  for i in range(1, tabpagenr('$'))
    if i != a:n
      let num = tabpagebuflist(i)[tabpagewinnr(i) - 1]
      call add(buffullnames, expand('#' . num . ':p'))
      call add(bufnames, expand('#' . num . ':t'))
    endif
  endfor
  let i = index(bufnames, bufname)
  if strlen(bufname) && i >= 0 && buffullnames[i] != buffullname
    return substitute(buffullname, '.*/\([^/]\+/\)', '\1', '')
  else
    return strlen(bufname) ? bufname : '[No Name]'
  endif
endfunction


""" Python 格式化
" pep8 格式化
map <f2> :!autopep8 --max-line-length 444 --in-place --aggressive --aggressive % <cr><cr>:edit<cr>
" yapf 格式化代码
autocmd FileType python nnoremap <leader>= :0,$!yapf<CR>
" 插入生成代码的相关信息
map <f1> i#!/usr/bin/env python<cr># coding: utf-8<cr><cr>if __name__ == '__main__':<cr>pass<Esc>
inoremap <f5> create by zhangwh at <c-r>=strftime("%y/%m/%d %H:%M")<cr>
inoremap <f6> modify by zhangwh at <c-r>=strftime("%y/%m/%d %H:%M")<cr>


"""  代码格式检查插件 ale
let g:ale_lint_on_text_changed = 'never'               " 文件编辑过程中不检查
let g:ale_lint_on_enter = 0                            " 打开文件的时候不检查
let g:ale_open_list = 0                                " 将所有检查到的错误显示在列表里
let g:ale_sign_error = '•'                             " 修改错误提示图标
let g:ale_sign_warning = '•'                           " 修改警告提示图标
highlight clear ALEErrorSign
highlight clear ALEWarningSign
"let g:ale_python_flake8_args="--ignore=E114,E116,E131 --max-line-length=120"
let g:ale_python_flake8_args="--max-line-length=100"
let g:ale_fixers = {
\    'javascript': ['eslint'],
\    'sh' : ['shellcheck'],
\    'vim' : ['vint'],
\    'html' : ['tidy'],
\    'css': ['stylelint'],
\    'python' : ['flake8', 'yapf'],
\}
" Do not lint or fix html files.
let g:ale_pattern_options = {
\    '\.html$': {'ale_linters': [], 'ale_fixers': []},
\}
" If you configure g:ale_pattern_options outside of vimrc, you need this.
let g:ale_pattern_options_enabled = 1


""" 搜索
" 搜索文件，用ctr+p，需要先安装依赖 brew install fzf
nnoremap <C-p> :Files<CR>
" 搜索文件里面的内容，用ctr+a, 需要先安装 brew install the_silver_searcher
nnoremap <C-f> :Ag<CR>


" completor {{{
    " 代码自动补全插件completor, 使用tab选中
    " inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    " inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    " inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
    " inoremap <c-d> :call completor#do('definition')<CR>
" }}}


" YouCompleteMe {{{
    """ 插件安装命令: ./install.py --clang-completer --system-libclang --js-completer
    let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
    " 在注释输入也能补全
    let g:ycm_complete_in_comments = 1
    " 在字符串输入也能补全
    let g:ycm_complete_in_strings = 1
    " 开启语法关键字补全
    let g:ycm_seed_identifiers_with_syntax=1
    " 回车作为选中
    let g:ycm_key_list_stop_completion = ['<CR>']
    " 关闭参数提示的小窗口
    set completeopt-=preview
    let g:ycm_add_preview_to_completeopt = 0
    " 跳转到定义处, 分屏打开
    let g:ycm_goto_buffer_command = 'horizontal-split'
    " 空格加d跳转到定义处
    nnoremap <leader>d :YcmCompleter GoToDefinitionElseDeclaration<CR>
    nnoremap <leader>j :YcmCompleter GoToDeclaration<CR>
" }}}

" 光标行列高亮
set cursorcolumn
set cursorline

" 在注释符默认添加空格
let g:NERDSpaceDelims = 1
" 使用紧凑语法美化多行注释
let g:NERDCompactSexyComs = 1
" 将行注释符左对齐而不是下面的代码缩进
let g:NERDDefaultAlign = 'left'
" 设置语言默认使用备用定界符
let g:NERDAltDelims_java = 1
" 添加自定义格式或覆盖默认值。
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" 允许注释和转换空行（注释区域时有用）
let g:NERDCommentEmptyLines = 1
" 启用时修整尾随空格注释
let g:NERDTrimTrailingWhitespace = 1
