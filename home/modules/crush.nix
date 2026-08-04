{ config, pkgs, ... }:
{
  sops.secrets = {
    charm_hyper_api_key.sopsFile = ../../secrets/peach.yaml;
    mistral_api_key.sopsFile = ../../secrets/peach.yaml;
  };

  sops.templates."ai-keys-env" = {
    path = "${config.home.homeDirectory}/.config/fish/conf.d/ai-keys.fish";
    mode = "0600";
    content = ''
      set -gx CHARM_HYPER_API_KEY ${config.sops.placeholder.charm_hyper_api_key}
      set -gx MISTRAL_API_KEY ${config.sops.placeholder.mistral_api_key}
    '';
  };

  home.packages = [ pkgs.crush ];

  xdg.configFile."crush/crush.json".text = builtins.toJSON {
    "$schema" = "https://charm.land/crush.json";
    providers = {
      mistral = {
        type = "openai-compat";
        base_url = "https://api.mistral.ai/v1";
        api_key = "$MISTRAL_API_KEY";
        models = [
          {
            id = "mistral-large-latest";
            name = "Mistral Large";
          }
        ];
      };
    };

    lsp = {
      nix.command = "nil";
    };
  };
}
