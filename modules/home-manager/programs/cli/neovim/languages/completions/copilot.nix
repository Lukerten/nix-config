{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = copilot-vim;
      type = "lua";
      config = # lua
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
      config = # lua
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

          vim.keymap.set({ 'n', 'v' }, '<space>Cc', '<cmd>CopilotChatToggle<cr>',         { desc = "CopilotChat - Toggle chat window" })
          vim.keymap.set({ 'n', 'v' }, '<space>Ce', '<cmd>CopilotChatExplain<cr>',        { desc = "CopilotChat - Explain code" })
          vim.keymap.set({ 'n', 'v' }, '<space>Ct', '<cmd>CopilotChatTests<cr>',          { desc = "CopilotChat - Generate tests" })
          vim.keymap.set({ 'n', 'v' }, '<space>Cf', '<cmd>CopilotChatFixDiagnostic<cr>',  { desc = "CopilotChat - Fix diagnostic" })
          vim.keymap.set({ 'n', 'v' }, '<space>Cr', '<cmd>CopilotChatReset<cr>',          { desc = "CopilotChat - Reset chat history and clear buffer" })
          vim.keymap.set({ 'n', 'v' }, '<space>Ca', '<cmd>lua copilot_chat_action()<cr>', { desc = "CopilotChat - Action" })
          vim.keymap.set({ 'n', 'v' }, '<space>a' , '<cmd>lua copilot_chat()<cr>',        { desc = "Ask using CopilotChat" })

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
    home.packages = [ pkgs.nodejs-slim ];
}
