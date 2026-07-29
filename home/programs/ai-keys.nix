{ config, ... }:
{
  sops.secrets = {
    charm_hyper_api_key.sopsFile = ../../secrets/peach.yaml;
    mistral_api_key.sopsFile = ../../secrets/peach.yaml;
    nebius_api_key.sopsFile = ../../secrets/peach.yaml;
  };

  sops.templates."ai-keys-env" = {
    path = "${config.home.homeDirectory}/.config/fish/conf.d/ai-keys.fish";
    mode = "0600";
    content = ''
      set -gx CHARM_HYPER_API_KEY ${config.sops.placeholder.charm_hyper_api_key}
      set -gx MISTRAL_API_KEY ${config.sops.placeholder.mistral_api_key}
      set -gx NEBIUS_API_KEY ${config.sops.placeholder.nebius_api_key}
    '';
  };
}
