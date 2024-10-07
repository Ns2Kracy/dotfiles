{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "Ns2Kracy";
    userEmail = "ns2kracy@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      core.editor = "vim";
      commit.gpgsign = true;
      tag.gpgsign = true;
    };
  };
}
