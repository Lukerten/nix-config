$env.config = {
  edit_mode: vi,
  show_banner: false,
  use_kitty_protocol: true,
  shell_integration: {
    osc2: false,
    osc7: true,
    osc8: true,
    osc133: true,
    osc633: true,
    reset_application_mode: true,
  },
  completions: {
    algorithm: "fuzzy",
  },
  history: {
    sync_on_enter: true,
  },
}

$env.PROMPT_INDICATOR = {|| "> " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| "> " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "| " }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }
$env.KITTY_SHELL_INTEGRATION = "enabled"

