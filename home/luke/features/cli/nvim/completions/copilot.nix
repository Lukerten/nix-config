{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = copilot-vim;
      type = "lua";
      config =
        # lua
        ''
          require("copilot").setup()

          -- Setup Copilot to use <C-a> to accept Completions, remove TAB mapping
          vim.g.copilot_no_tab_map = true
          vim.api.nvim_set_keymap("i", "<C-a>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
        '';
    }
    {
      plugin = CopilotChat-nvim;
      type = "lua";
      config =
        # lua
        ''
          require("CopilotChat").setup({
            window = {
              layout = "vertical",
              title = "Copilot Chat",
            },
          })

          function _G.copilot_chat()
            require("CopilotChat").ask(vim.fn.input("Chat: "), { selection = require("CopilotChat.select").buffer })
          end

          function _G.copilot_chat_action()
            local actions = require("CopilotChat.actions")
            require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
          end

          vim.keymap.set({ 'n', 'v' }, '<leader>Cc', '<cmd>CopilotChatToggle<cr>',default_opts("CopilotChat - Toggle"))
          vim.keymap.set({ 'n', 'v' }, '<leader>Ce', '<cmd>CopilotChatExplain<cr>',default_opts("CopilotChat - Explain"))
          vim.keymap.set({ 'n', 'v' }, '<leader>Ct', '<cmd>CopilotChatTests<cr>',default_opts("CopilotChat - Tests"))
          vim.keymap.set({ 'n', 'v' }, '<leader>Cf', '<cmd>CopilotChatFixDiagnostic<cr>',default_opts("CopilotChat - Fix Diagnostic"))
          vim.keymap.set({ 'n', 'v' }, '<leader>Cr', '<cmd>CopilotChatReset<cr>',default_opts("CopilotChat - Reset"))
          vim.keymap.set({ 'n', 'v' }, '<leader>Ca', '<cmd>lua copilot_chat_action()<cr>',default_opts("CopilotChat - Actions"))
          vim.keymap.set({ 'n', 'v' }, '<leader>a' , '<cmd>lua copilot_chat()<cr>', default_opts("Ask Coppilot"))

          -- Autocommand to map 'q' to close buffer when filetype is copilot-chat
          vim.cmd([[
            augroup CopilotChat
              autocmd!
              autocmd FileType copilot-chat nnoremap <buffer> q :q<CR>
              autocmd FileType copilot-chat inoremap <buffer> q <ESC>:q<CR>
            augroup END
          ]])

          -- Autocommand to submit a new chat message when pressing Enter while in
          -- copilot chat buffer
          vim.cmd([[
            augroup CopilotChat
              autocmd!
              autocmd FileType copilot-chat nnoremap <buffer> <CR> :lua copilot_chat()<CR>
              autocmd FileType copilot-chat inoremap <buffer> <CR> <ESC>:lua copilot_chat()<CR>
            augroup END
          ]])
        '';
    }
  ];

  # Copilot requires an executeable version of node to be installed
  home.packages = [pkgs.nodejs-slim];
}
