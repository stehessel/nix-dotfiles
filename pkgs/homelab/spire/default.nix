{
  config,
  pkgs,
  ...
}: let
  certDir = "${config.xdg.configHome}/spire/certs";
in {
  home.packages = [pkgs.spire];

  xdg.configFile."spire/agent.conf".text = ''
    agent {
      data_dir = "/tmp/spire-agent-data"
      log_level = "INFO"
      server_address = "192.168.1.106"
      server_port = "8081"
      socket_path = "/tmp/spire-agent/public/api.sock"
      trust_domain = "homelab.local"
      insecure_bootstrap = true
    }

    plugins {
      NodeAttestor "x509pop" {
        plugin_data {
          private_key_path = "${certDir}/agent.key"
          certificate_path = "${certDir}/agent.crt"
        }
      }

      KeyManager "disk" {
        plugin_data {
          directory = "/tmp/spire-agent-data"
        }
      }

      WorkloadAttestor "unix" {
        plugin_data {}
      }
    }
  '';
}
