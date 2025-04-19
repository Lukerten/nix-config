{
  programs.nixvim.plugins.coverage.enable = true;

  programs.nixvim.keymaps = [
    {
      key = "<leader>Cc";
      action = "<cmd>Coverage<CR>";
      mode = "n";
      options = {
        desc = "Coverage";
        silent = true;
        noremap = true;
      };
    }
    {
      key = "<leader>Cl";
      action = "<cmd>CoverageLoad<CR>";
      mode = "n";
      options = {
        desc = "Coverage Load";
        silent = true;
        noremap = true;
      };
    }
    {
      key = "<leader>Cs";
      action = "<cmd>CoverageSummary<CR>";
      mode = "n";
      options = {
        desc = "Coverage Summary";
        silent = true;
        noremap = true;
      };
    }
    {
      key = "<leader>Ch";
      action = "<cmd>CoverageHide<CR>";
      mode = "n";
      options = {
        desc = "Coverage Hide";
        silent = true;
        noremap = true;
      };
    }
    {
      key = "<leader>Ct";
      action = "<cmd>CoverageToggle<CR>";
      mode = "n";
      options = {
        desc = "Coverage Toggle";
        silent = true;
        noremap = true;
      };
    }
    {
      key = "<leader>CC";
      action = "<cmd>CoverageClear<CR>";
      mode = "n";
      options = {
        desc = "Coverage Clear";
        silent = true;
        noremap = true;
      };
    }
    {
      key = "<leader>CS";
      action = "<cmd>CoverageShow<CR>";
      mode = "n";
      options = {
        desc = "Coverage Show";
        silent = true;
        noremap = true;
      };
    }
    {
      key = "<leader>Clc";
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
