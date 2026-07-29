{ pkgs, ... }:
{
  home.packages = with pkgs; [
    crush
  ];

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

      nebius = {
        type = "openai-compat";
        base_url = "https://api.tokenfactory.nebius.com/v1";
        api_key = "$NEBIUS_API_KEY";
        models = [
          {
            id = "moonshotai/Kimi-K3";
            name = "Kimi K3";
          }
          {
            id = "moonshotai/Kimi-K2.7-Code";
            name = "Kimi K2.7 Code";
          }
        ];
      };
    };

    lsp = {
      nix.command = "nil";
    };
  };
}
