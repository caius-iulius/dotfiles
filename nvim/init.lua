-- TODO VARI:
-- TODO: per la barra di stato considera: https://github.com/vim-airline/vim-airline
-- TODO: per latex considera: https://github.com/lervag/vimtex
--
-- TODO: buffer/tabs?
-- https://howchoo.com/vim/3-ways-to-use-tabs-in-vim
-- https://github.com/ap/vim-buftabline https://vim.fandom.com/wiki/Using_tab_pages
-- https://vim.fandom.com/wiki/Buffers
--
-- TODO FILE FOLDS...
-- RILEGGI BENE https://www.freecodecamp.org/news/vimrc-configuration-guide-customize-your-vim-editor/
-- TODO: GUARDA TUTTO IL REPOSITORY DI tpope, IN PARTICOLARE https://github.com/tpope/vim-sensible
-- TODO: matchit.vim

-- Impostazioni generali

-- Estetica
--- Neovide
vim.opt.guifont = "Gemini Minimal:h11"
-- Standard
vim.opt.number = true
vim.opt.scrolloff = 12
vim.opt.ruler = true
vim.opt.listchars = {trail='·'}
vim.opt.list = true
vim.opt.termguicolors = true
vim.cmd([[
"if &t_Co == 8 && $TERM !~# '^Eterm'
"  set t_Co=16
"endif
colorscheme base16-brewermod
" hi Normal guibg=NONE ctermbg=NONE
" hi LineNr guibg=NONE ctermbg=NONE
hi WinSeparator guibg=None ctermbg=None
]])
vim.opt.guicursor = {n="block", v="block", c="block", i="block"}

-- Comportamento tab
vim.opt.tabstop = 4
vim.opt.sts = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.backspace = {"indent", "eol", "start"}

-- Interazione col sistema operativo
-- NOTE: Serve il programma "xclip" per far comunicare nvim e la clipboard di sistema
vim.opt.clipboard:append("unnamedplus")
vim.opt.autoread = true

-- TODO Impostazioni da testare
--vim.opt.termguicolors = true
vim.cmd("set nocompatible")
vim.opt.nrformats:remove("octal")
--TODO CAMBIA HIGHLIGHT RICERCA INCREMENTALE
vim.opt.incsearch = true
vim.opt.showmatch = true
-- vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showcmd = true
vim.opt.hlsearch = false
vim.opt.history = 1000
-- vim.opt.tabpagemax = 50
-- vim.opt.laststatus = true
-- Roba che ha a che fare con wildmenu (auto completion
vim.opt.wildmenu = true
vim.opt.wildmode = {list="longest"}
vim.opt.wildignore= {"*.docx", "*.jpg", "*.png", "*.gif", "*.pdf", "*.pyc", "*.exe", "*.flv", "*.img", "*.xlsx"}

-- Macro
local function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

vim.g.mapleader = "," -- Attenzione: leader key

-- Tilde
map('n', "<leader>t", "i~<Esc>l")
-- OG Lenny
map('n', "<leader>ll", "i( ͡° ͜ʖ ͡°)<Esc>l")
-- Lenny confuso
map('n', "<leader>lc", " i( ͠° ͟ʖ ͡°)<Esc>l")
--  Lenny scrolla
map('n', "<leader>ls", "i¯\\_( ͡° ͜ʖ ͡°)_/¯<Esc>l")
-- Lenny attenzione
map('n', "<leader>la"," i»-(¯`·.·´¯)-><-(¯`·.·´¯)-«<Esc>12hi")
-- ᕕ( ᐛ )ᕗ
-- (ᗒᗣᗕ)
-- ಥ_ಥ
--(｢๑•₃•)｢ ʷʱʸ?
--»-(¯`·.·´¯)->Inserisci testo<-(¯`·.·´¯)-«
--... e tante altre: https://www.lennyfaceguru.com/sunglasses.html

vim.cmd([[
if empty(mapcheck('<C-U>', 'i'))
  inoremap <C-U> <C-G>u<C-U>
endif
]])

-- Per allenarmi a usare le hjkl invece delle frecce
map('n', "<up>", [[<Cmd>echoerr "le frecce pungono, usa 'k'"<CR>]])
map('n', "<down>", [[<Cmd>echoerr "le frecce pungono, usa 'j'"<CR>]])
map('n', "<left>", [[<Cmd>echoerr "le frecce pungono, usa 'h'"<CR>]])
map('n', "<right>", [[<Cmd>echoerr "le frecce pungono, usa 'l'"<CR>]])
map('i', "<up>", "<NOP>")
map('i', "<down>", "<NOP>")
map('i', "<left>", "<NOP>")
map('i', "<right>", "<NOP>")

-- Finestre
map('n', "<leader>wa", "<C-w>v:edit<space>")
map('n', "<leader>wd", "<C-w>v<C-w>l:edit<space>")
map('n', "<leader>ww", "<C-w>s:edit<space>")

map('n', "<leader>wh", "<C-w>h")
map('n', "<leader>wj", "<C-w>j")
map('n', "<leader>wk", "<C-w>k")
map('n', "<leader>wl", "<C-w>l")

-- Debug
vim.diagnostic.config {
    virtual_text = false
}
map('n', "<leader>e", "<Cmd>lua vim.diagnostic.open_float()<CR>")

-- Terminal mode
map('n', "<leader>s", "<C-w>v<C-w>w<Cmd>terminal<CR>i")
map('t', "<Esc>", "<C-\\><C-N>")

-- Plugin con packer
require('plugins')

require('nvim-tree').setup {
    open_on_setup=true
}
map('n', "<leader>nt", "<Cmd>NvimTreeFindFile<CR>")

require("nvim-lsp-installer").setup {
    --automatic_installation = true,
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
}

local lspconfig = require'lspconfig'

lspconfig.clangd.setup {}
lspconfig.sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      --[[workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },]]--
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
lspconfig.elmls.setup {}
lspconfig.hls.setup {}
--lspconfig.rust_analyzer.setup {}
--require('rust-tools').setup {}

vim.diagnostic.config({virtual_text = true})
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

vim.cmd([[
" Impostazioni generali

" Estetica
" A quanto pare inutili
" filetype on
" filetype plugin on
" filetype indent on
" syntax on
" TODO Colore stile da modificare
" set cursorline
" set cursorcolumn

" Plugin installati
" call plug#begin('~/.config/nvim/plugged')
" call plug#end()
" Plug 'dense-analysis/ale'
" Plug 'tc50cal/vim-terminal'
" Plug 'rust-lang/rust.vim'
" Plug 'preservim/nerdtree'
" Plug 'caius-iulius/haskell-vim'

"Impostazioni di linting
let g:ale_linters = {
\   'c':['ccls', 'clangd', 'clang', 'cppcheck', 'cquery', 'flawfinder', 'gcc'],
\   'haskell':['ghc'],
\}
"Attenzione: escluso clangtidy a causa delle chiamate memcpy, memset...
autocmd BufEnter *.h :setlocal filetype=c
]])
