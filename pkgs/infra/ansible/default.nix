{
  config,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      ansible
      ansible-lint
      # ansible-language-server
    ];
  };
  home = {
    sessionVariables = {
      ANSIBLE_HOME = "${config.xdg.configHome}/ansible";
    };
  };
  xdg.configFile."ansible/ansible.cfg".source = ./config/ansible.cfg;
}
