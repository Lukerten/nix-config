{
  programs.neovim.extraConfig = # vim
    ''
      "AutoClose Terminal
      augroup AutoCloseTerminal
        autocmd!
        autocmd BufLeave * if &buftype ==# 'terminal' | execute 'bdelete!' | endif
      augroup END
    '';
}
