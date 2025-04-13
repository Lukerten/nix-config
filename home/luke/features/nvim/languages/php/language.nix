{
  programs.nixvim.plugins = {
    luasnip.fromSnipmate = [
      {
        paths = ../../snippets/store/snippets/php.snippets;
        include = ["php"];
      }
    ];
  };
}
