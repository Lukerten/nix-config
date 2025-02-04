{
  programs.neovim.extraConfig =
    # vim
    ''
      "4 char-wide overrides
      augroup four_space_tab
        autocmd!
        autocmd FileType markdown,text,mediawiki,plaintext,conf,ini,log setlocal tabstop=4 softtabstop=4 shiftwidth=4
      augroup END

      "Set tera to use htmldjango syntax
      augroup tera_htmldjango
        autocmd!
        autocmd BufRead,BufNewFile *.tera setfiletype htmldjango
      augroup END

      "Fix nvim size according to terminal
      "(https://github.com/neovim/neovim/issues/11330)
      augroup fix_size
        autocmd VimEnter * silent exec "!kill -s SIGWINCH" getpid()
      augroup END
    '';
}
