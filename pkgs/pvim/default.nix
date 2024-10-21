{
  lib,
  writeShellApplication,
  zoxide,
  neovim,
}:
(writeShellApplication {
  name = "pvim";
  runtimeInputs = [];
  text = ''
    PRJ="''$(zoxide query -i)"
    echo "Launching Neovim for ''$PRJ"
    set -x
    cd "''$PRJ" && \
      exec nvim
  '';
})
// {
  meta = with lib; {
    licenses = licenses.mit;
    platforms = platforms.all;
  };
}
