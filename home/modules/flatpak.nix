_: {
  services.flatpak.packages = [
    "com.bitwarden.desktop"
    "com.calibre_ebook.calibre"
    "com.heroicgameslauncher.hgl"
    {
      appId = "io.github.Amethyst.ModManager";
      origin = "modmanager-origin";
    }
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
    {
      name = "modmanager-origin";
      location = "https://chrisdkn.github.io/Amethyst-Mod-Manager/amethyst.flatpakrepo";
    }
  ];
}
