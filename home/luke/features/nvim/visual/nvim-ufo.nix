{
  programs.nixvim = {
    # Set fold settings
    # These options were recommended by nvim-ufo
    # See: https://github.com/kevinhwang91/nvim-ufo#minimal-configuration
    opts = {
      foldlevel = 99;
      foldlevelstart = 99;
      foldenable = true;
      foldmethod = "indent";
    };
    extraConfigLua =
      # lua
      ''
        vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
        vim.o.foldcolumn = 'auto:9'
      '';

    plugins.nvim-ufo = {
      enable = true;
      settings = {
        provider_selector =
          # Lua
          ''
            function(bufnr, filetype, buftype)
              local ftMap = {
                vim = "indent",
                python = {"indent"},
                git = ""
              }

             return ftMap[filetype]
            end
          '';
        fold_virt_text_handler =
          # Lua
          ''
            function(virtText, lnum, endLnum, width, truncate)
              local newVirtText = {}
              local suffix = (' ... %d lines hidden '):format(endLnum - lnum)
              local sufWidth = vim.fn.strdisplaywidth(suffix)
              local targetWidth = width - sufWidth
              local curWidth = 0
              for _, chunk in ipairs(virtText) do
                local chunkText = chunk[1]
                local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                if targetWidth > curWidth + chunkWidth then
                  table.insert(newVirtText, chunk)
                else
                  chunkText = truncate(chunkText, targetWidth - curWidth)
                  local hlGroup = chunk[2]
                  table.insert(newVirtText, {chunkText, hlGroup})
                  chunkWidth = vim.fn.strdisplaywidth(chunkText)
                  -- str width returned from truncate() may less than 2nd argument, need padding
                  if curWidth + chunkWidth < targetWidth then
                    suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                  end
                  break
                end
                curWidth = curWidth + chunkWidth
              end
              table.insert(newVirtText, {suffix, 'MoreMsg'})
              return newVirtText
            end
          '';
      };
    };
  };
}
