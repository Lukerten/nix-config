{
  programs.nixvim.plugins.coverage.enable = true;

  programs.nixvim.keymaps = [
    {
      key = "<leader>cc";
      action = "<cmd>Coverage<CR>";
      mode = "n";
      options = {
        desc = "Coverage";
        silent = true;
        noremap = true;
      };
    }
    {
      key = "<leader>cl";
      action = "<cmd>CoverageLoad<CR>";
      mode = "n";
      options = {
        desc = "Coverage Load";
        silent = true;
        noremap = true;
      };
    }
    {
      key = "<leader>cs";
      action = "<cmd>CoverageSummary<CR>";
      mode = "n";
      options = {
        desc = "Coverage Summary";
        silent = true;
        noremap = true;
      };
    }
    {
      key = "<leader>ch";
      action = "<cmd>CoverageHide<CR>";
      mode = "n";
      options = {
        desc = "Coverage Hide";
        silent = true;
        noremap = true;
      };
    }
    {
      key = "<leader>ct";
      action = "<cmd>CoverageToggle<CR>";
      mode = "n";
      options = {
        desc = "Coverage Toggle";
        silent = true;
        noremap = true;
      };
    }
    {
      key = "<leader>cC";
      action = "<cmd>CoverageClear<CR>";
      mode = "n";
      options = {
        desc = "Coverage Clear";
        silent = true;
        noremap = true;
      };
    }
    {
      key = "<leader>cS";
      action = "<cmd>CoverageShow<CR>";
      mode = "n";
      options = {
        desc = "Coverage Show";
        silent = true;
        noremap = true;
      };
    }
    {
      key = "<leader>clc";
      action = "<cmd>CoverageLoadLcov<CR>";
      mode = "n";
      options = {
        desc = "Coverage Load Lcov";
        silent = true;
        noremap = true;
      };
    }
  ];
}
