{ ... }:
{
  services.flatpak.packages = [
    "com.bitwarden.desktop"
    "com.calibre_ebook.calibre"
    "com.heroicgameslauncher.hgl"
    "com.spotify.Client"
    "md.obsidian.Obsidian"
    "org.cryptomator.Cryptomator"
    "org.prismlauncher.PrismLauncher"
    "org.qbittorrent.qBittorrent"
  ];

  services.flatpak.remotes = [
    {
      name = "flathub";
      location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    }
  ];
}
