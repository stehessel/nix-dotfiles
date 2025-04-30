{
  config,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      # ansible
      # ansible-lint
      ansible-language-server
    ];
  };
  home = {
    sessionVariables = {
      ANSIBLE_CONFIG = "${config.xdg.configHome}/ansible/ansible.cfg";
    };
  };
  xdg.configFile."ansible/ansible.cfg".source = ./config/ansible.cfg;
}
