{ lib, pkgs, ... }:
{
  xdg.dataFile = {
    "applications" = {
      source = ./config;
      recursive = true;
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/http" = [ "brave.desktop" ];
      "x-scheme-handler/https" = [ "brave.desktop" ];
      "x-scheme-handler/ftp" = [ "brave.desktop" ];
      "x-scheme-handler/chrome" = [ "brave.desktop" ];
      "x-scheme-handler/mailto" = [ "mail.desktop" ];
      "application/x-extension-htm" = [ "brave.desktop" ];
      "application/x-extension-html" = [ "brave.desktop" ];
      "application/x-extension-shtml" = [ "brave.desktop" ];
      "application/xhtml+xml" = [ "brave.desktop" ];
      "application/x-extension-xhtml" = [ "brave.desktop" ];
      "application/x-extension-xht" = [ "brave.desktop" ];
      "text/plain" = [ "text.desktop" ];
      "text/x-shellscript" = [ "text.desktop" ];
      "text/html" = [ "brave.desktop" ];
      "application/pdf" = [ "pdf.desktop" ];
      "image/png" = [ "img.desktop" ];
      "image/jpeg" = [ "img.desktop" ];
      "image/gif" = [ "img.desktop" ];
      "application/rss+xml" = [ "rss.desktop" ];
    };
  };
}
