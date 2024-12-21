{
  pkgs,
  config,
  ...
}: {
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      jnoortheen.nix-ide
      kamadorueda.alejandra
      arrterian.nix-env-selector
      zaaack.markdown-editor
      catppuccin.catppuccin-vsc-icons
      catppuccin.catppuccin-vsc
      yzhang.dictionary-completion
      yoavbls.pretty-ts-errors
      xaver.clang-format
      xdebug.php-debug
      waderyan.gitblame
      gitlab.gitlab-workflow
      github.copilot-chat
      github.copilot
      vscodevim.vim
      svelte.svelte-vscode
      skyapps.fish-vscode
      rust-lang.rust-analyzer
      equinusocio.vsc-material-theme-icons
      ms-azuretools.vscode-docker
      ms-vscode-remote.remote-containers
      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-ssh-edit
      ms-vscode-remote.remote-containers
      gruntfuggly.todo-tree
      editorconfig.editorconfig
      christian-kohler.npm-intellisense
      leonardssh.vscord
    ];
    userSettings = let
      fontMonospace = config.fontProfiles.monospace.name;
      fontRegular = config.fontProfiles.regular.name;
    in {
      "editor.minimap.renderCharacters" = false;
      "window.menuBarVisibility" = "hidden";
      "extensions.autoCheckUpdates" = false;
      "editor.fontFamily" = "'${fontMonospace}', 'monospace', monospace";
      "editor.codeLensFontFamily" = "'${fontMonospace}', 'monospace', monospace";
      "editor.inlineSuggest.fontFamily" = "'${fontMonospace}', 'monospace', monospace";
      "debug.console.fontFamily" = "'${fontMonospace}', 'monospace', monospace";
      "terminal.integrated.fontFamily" = "'${fontMonospace}', 'monospace', monospace";
      "markdown.preview.fontFamily" = "'${fontRegular}";
      "chat.editor.fontFamily" = "'${fontRegular}";
      "notebook.output.fontFamily" = "'${fontRegular}";
      "debug.terminal.clearBeforeReusing" = true;
      "terminal.integrated.enableImages" = true;
      "terminal.integrated.suggest.enabled" = true;
      "terminal.integrated.ignoreProcessNames" = [
        "starship"
        "oh-my-posh"
        "bash"
        "zsh"
        "fish"
        "nu"
      ];
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.iconTheme" = "catppuccin-mocha";
      "workbench.statusBar.visible" = false;
      "workbench.colorCustomizations" = let
        inherit (config.colorscheme) colors;
      in {
        "[Catppuccin Mocha]" = {
          "selection.background" = "${colors.surface}";
          "textCodeBlock.background" = "${colors.surface}";
          "textBlockQuote.background" = "${colors.surface}";
          "toolbar.hoverBackground" = "${colors.surface}";
          "toolbar.activeBackground" = "${colors.surface}";
          "editorActionList.background" = "${colors.surface}";
          "button.background" = "${colors.surface_variant}";
          "button.hoverBackground" = "${colors.surface_variant}";
          "button.secondaryBackground" = "${colors.tertiary}";
          "button.secondaryHoverBackground" = "${colors.on_surface}";
          "checkbox.background" = "${colors.surface}";
          "checkbox.selectBorder" = "${colors.primary}";
          "radio.activeBackground" = "${colors.primary}";
          "radio.inactiveBackground" = "${colors.surface}";
          "dropdown.background" = "${colors.surface}";
          "dropdown.listBackground" = "${colors.surface}";
          "dropdown.border" = "${colors.primary}";
          "dropdown.foreground" = "${colors.tertiary}";
          "input.background" = "${colors.surface}";
          "inputOption.activeBackground" = "${colors.surface}";
          "inputOption.hoverBackground" = "${colors.primary}";
          "scrollbarSlider.activeBackground" = "${colors.surface_variant}";
          "scrollbarSlider.background" = "${colors.tertiary}";
          "scrollbarSlider.hoverBackground" = "${colors.primary}";
          "badge.background" = "${colors.primary}";
          "badge.foreground" = "${colors.primary}";
          "progressBar.background" = "${colors.primary}";
          "list.activeSelectionBackground" = "${colors.surface}";
          "list.dropBackground" = "${colors.surface}";
          "list.focusBackground" = "${colors.surface}";
          "list.hoverBackground" = "${colors.surface}";
          "list.inactiveSelectionBackground" = "${colors.surface}";
          "list.inactiveFocusBackground" = "${colors.surface}";
          "list.dropBetweenBackground" = "${colors.primary}";
          "activityBar.background" = "${colors.surface}";
          "activityBarBadge.background" = "${colors.surface}";
          "activityBarBadge.foreground" = "${colors.primary}";
          "activityBar.foreground" = "${colors.primary}";
          "activityBar.inactiveForeground" = "${colors.on_surface}";
          "sideBar.background" = "${colors.surface}";
          "sideBarSectionHeader.background" = "${colors.surface}";
          "sideBarSectionHeader.foreground" = "${colors.primary}";
          "sideBarTitle.background" = "${colors.surface}";
          "sideBarTitle.foreground" = "${colors.primary}";
          "minimap.background" = "${colors.surface}";
          "minimap.findMatchHighlight" = "${colors.blue}";
          "minimap.selectionHighlight" = "${colors.cyan}";
          "minimap.errorHighlight" = "${colors.red}";
          "minimap.warningHighlight" = "${colors.yellow}";
          "editorGroup.dropBackground" = "${colors.primary}";
          "editorGroupHeader.tabsBackground" = "${colors.surface}";
          "editorGroupHeader.tabsBorder" = "${colors.primary}";
          "editorGroup.emptyBackground" = "${colors.surface}";
          "tab.activeBackground" = "${colors.surface}";
          "tab.unfocusedActiveBackground" = "${colors.surface}";
          "tab.activeForeground" = "${colors.primary}";
          "tab.activeBorder" = "${colors.primary}";
          "tab.activeBorderTop" = "${colors.primary}";
          "tab.selectedBorderTop" = "${colors.primary}";
          "tab.inactiveBackground" = "${colors.surface}";
          "tab.border" = "${colors.surface}";
          "tab.hoverForeground" = "${colors.primary}";
          "tab.hoverBackground" = "${colors.surface}";
          "tab.unfocusedInactiveBackground" = "${colors.surface}";
          "sideBySideEditor.verticalBorder" = "${colors.primary}";
          "sideBySideEditor.horizontalBorder" = "${colors.primary}";
          "editor.background" = "${colors.surface}";
          "editor.foreground" = "${colors.on_surface}";
          "editorLineNumber.foreground" = "${colors.on_surface}";
          "editorLineNumber.activeForeground" = "${colors.primary}";
          "editorLineNumber.dimmedForeground" = "${colors.tertiary}";
          "editorCursor.background" = "${colors.surface}";
          "editorCursor.foreground" = "${colors.on_surface}";
          "editorMultiCursor.primary.background" = "${colors.primary}";
          "editorMultiCursor.primary.foreground" = "${colors.surface}";
          "editorMultiCursor.secondary.background" = "${colors.tertiary}";
          "editorMultiCursor.secondary.foreground" = "${colors.surface}";
          "editorInlayHint.background" = "${colors.surface}";
          "editorInlayHint.foreground" = "${colors.primary}";
          "editorGutter.background" = "${colors.surface}";
          "editor.linkedEditingBackground" = "${colors.surface}";
          "editorOverviewRuler.background" = "${colors.surface}";
          "inlineChat.background" = "${colors.surface}";
          "inlineChat.foreground" = "${colors.primary}";
          "inlineChat.border" = "${colors.surface}";
          "inlineChatInput.background" = "${colors.surface}";
          "inlineChatInput.border" = "${colors.surface}";
          "statusBar.background" = "${colors.surface}";
          "statusBar.foreground" = "${colors.primary}";
          "statusBar.noFolderBackground" = "${colors.surface}";
          "statusBar.noFolderForeground" = "${colors.primary}";
          "statusBar.debuggingBackground" = "${colors.surface}";
          "statusBar.debuggingForeground" = "${colors.red}";
          "statusBarItem.activeBackground" = "${colors.surface}";
          "statusBarItem.hoverBackground" = "${colors.surface}";
          "statusBarItem.prominentForeground" = "${colors.surface}";
          "statusBarItem.prominentBackground" = "${colors.primary}";
          "statusBarItem.offlineBackground" = "${colors.surface}";
          "editorIndentGuide.background1" = "${colors.surface}";
          "editorIndentGuide.activeBackground1" = "${colors.primary}";
          "editorIndentGuide.background2" = "${colors.surface}";
          "editorIndentGuide.activeBackground2" = "${colors.primary}";
          "editorIndentGuide.background3" = "${colors.surface}";
          "editorIndentGuide.activeBackground3" = "${colors.primary}";
          "editorIndentGuide.background4" = "${colors.surface}";
          "editorIndentGuide.activeBackground4" = "${colors.primary}";
          "editorIndentGuide.background5" = "${colors.surface}";
          "editorIndentGuide.activeBackground5" = "${colors.primary}";
          "editorIndentGuide.background6" = "${colors.surface}";
          "editorIndentGuide.activeBackground6" = "${colors.primary}";
          "panel.background" = "${colors.surface}";
          "panel.border" = "${colors.surface}";
          "panelTitle.activeBorder" = "${colors.primary}";
          "panelSectionHeader.foreground" = "${colors.surface}";
          "panelSectionHeader.background" = "${colors.primary}";
          "titleBar.activeBackground" = "${colors.surface}";
          "titleBar.activeForeground" = "${colors.primary}";
          "titleBar.inactiveBackground" = "${colors.surface}";
          "titleBar.inactiveForeground" = "${colors.primary}";
          "menu.background" = "${colors.surface}";
          "menu.foreground" = "${colors.primary}";
          "menu.selectionBackground" = "${colors.surface}";
          "menu.selectionForeground" = "${colors.primary}";
          "menu.border" = "${colors.surface}";
          "banner.background" = "${colors.surface}";
          "banner.foreground" = "${colors.on_surface}";
          "banner.iconForeground" = "${colors.primary}";
          "breadcrumb.foreground" = "${colors.primary}";
          "breadcrumb.background" = "${colors.surface}";
          "breadcrumb.focusForeground" = "${colors.primary}";
        };
      };
    };
  };
}
