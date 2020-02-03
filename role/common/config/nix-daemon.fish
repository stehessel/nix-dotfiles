#!/usr/bin/env fish

set -x NIX_USER_PROFILE_DIR "/nix/var/nix/profiles/per-user/$USER"
set -x NIX_PROFILES "/nix/var/nix/profiles/default $HOME/.nix-profile"

# Set $NIX_SSL_CERT_FILE so that Nixpkgs applications like curl work.
if not set -q NIX_SSL_CERT_FILE[1] # Allow users to override the NIX_SSL_CERT_FILE
	if test -e '/etc/ssl/certs/ca-certificates.crt' # NixOS, Ubuntu, Debian, Gentoo, Arch
		set -x NIX_SSL_CERT_FILE '/etc/ssl/certs/ca-certificates.crt'
	else if test -e '/etc/ssl/ca-bundle.pem' # openSUSE Tumbleweed
		set -x NIX_SSL_CERT_FILE '/etc/ssl/ca-bundle.pem'
	else if test -e '/etc/ssl/certs/ca-bundle.crt' # Old NixOS
		set -x NIX_SSL_CERT_FILE '/etc/ssl/certs/ca-bundle.crt'
	else if test -e '/etc/pki/tls/certs/ca-bundle.crt' # Fedora, CentOS
		set -x NIX_SSL_CERT_FILE '/etc/pki/tls/certs/ca-bundle.crt'
	else
		# Fall back to what is in the nix profiles, favouring whatever is defined last.
		for i in $NIX_PROFILES
			if test -e "$i/etc/ssl/certs/ca-bundle.crt"
				set -x NIX_SSL_CERT_FILE "$i/etc/ssl/certs/ca-bundle.crt"
			end
		end
	end
end

set -x NIX_PATH "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixpkgs:/nix/var/nix/profiles/per-user/root/channels"
set -x PATH "$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH"
