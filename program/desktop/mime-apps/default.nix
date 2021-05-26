{ config, lib, pkgs, ... }:
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
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "x-scheme-handler/ftp" = [ "firefox.desktop" ];
      "x-scheme-handler/chrome" = [ "firefox.desktop" ];
      "x-scheme-handler/mailto" = [ "mail.desktop" ];
      "application/x-extension-htm" = [ "firefox.desktop" ];
      "application/x-extension-html" = [ "firefox.desktop" ];
      "application/x-extension-shtml" = [ "firefox.desktop" ];
      "application/xhtml+xml" = [ "firefox.desktop" ];
      "application/x-extension-xhtml" = [ "firefox.desktop" ];
      "application/x-extension-xht" = [ "firefox.desktop" ];
      "text/plain" = [ "text.desktop" ];
      "text/x-shellscript" = [ "text.desktop" ];
      "text/html" = [ "firefox.desktop" ];
      "application/pdf" = [ "pdf.desktop" ];
      "image/png" = [ "img.desktop" ];
      "image/jpeg" = [ "img.desktop" ];
      "image/gif" = [ "img.desktop" ];
      "application/rss+xml" = [ "rss.desktop" ];
    };
  };
}
