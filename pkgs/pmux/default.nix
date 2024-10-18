{
  lib,
  writeShellApplication,
  zoxide,
  tmux
}:
(writeShellApplication {
  name = "pmux";
  runtimeInputs = [];
  text = ''
    PRJ="''$(zoxide query -i)"
    echo "Launching tmux for ''$PRJ"
    set -x
    cd "''$PRJ" && \
      exec tmux -S "''$PRJ".tmux attach
  '';
}) // {
  meta = with lib; {
    licenses = licenses.mit;
    platforms = platforms.all;
  };
}
