#!/usr/bin/env fish

set -x NIX_LINK "$HOME/.nix-profile"
set -x NIX_USER_PROFILE_DIR "/nix/var/nix/profiles/per-user/$USER"
set -x NIX_PROFILES "$HOME/.nix-profile"
set -x -p MANPATH "$NIX_LINK/share/man"
set -x NIX_PATH "$HOME/.nix-defexpr/channels"

# Set $NIX_SSL_CERT_FILE so that Nixpkgs applications like curl work.
if test -e ""/etc/ssl/certs/ca-certificates.crt"" # NixOS, Ubuntu, Debian, Gentoo, Arch
	set -x NIX_SSL_CERT_FILE ""/etc/ssl/certs/ca-certificates.crt""
else if test -e ""/etc/ssl/ca-bundle.pem"" # openSUSE Tumbleweed
	set -x NIX_SSL_CERT_FILE ""/etc/ssl/ca-bundle.pem""
else if test -e ""/etc/ssl/certs/ca-bundle.crt"" # Old NixOS
	set -x NIX_SSL_CERT_FILE ""/etc/ssl/certs/ca-bundle.crt""
else if test -e ""/etc/pki/tls/certs/ca-bundle.crt"" # Fedora, CentOS
	set -x NIX_SSL_CERT_FILE ""/etc/pki/tls/certs/ca-bundle.crt""
else if test -e ""$NIX_LINK/etc/ssl/certs/ca-bundle.crt"" # fall back to cacert in Nix profile
	set -x NIX_SSL_CERT_FILE ""$NIX_LINK/etc/ssl/certs/ca-bundle.crt""
else if test -e ""$NIX_LINK/etc/ca-bundle.crt"" # old cacert in Nix profile
	set -x NIX_SSL_CERT_FILE ""$NIX_LINK/etc/ca-bundle.crt""
end
