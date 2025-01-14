def create_title [] {
  let prefix = if SSH_TTY in $env {$"[(hostname | str replace -r "\\..*" "")] "}
  let path = pwd | str replace $env.HOME "~"
  ([$prefix, $path] | str join)
}

$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = ""
$env.PROMPT_MULTILINE_INDICATOR = ""
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
  hooks: {
    pre_prompt: [{
      print -n $"(ansi title)(create_title)(ansi st)"
    }]
  }
}
$env.KITTY_SHELL_INTEGRATION = "enabled"
