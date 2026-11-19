{
  config,
  lib,
  pkgs,
  ...
}:
let
  wayfinderSrc = pkgs.fetchFromGitHub {
    owner = "mattpocock";
    repo = "skills";
    rev = "4ae2317ddb22b046e26455e4f9c9b3aaaf62212d";
    hash = "sha256-3vhd77xfZjKUYJsIwPFevIZPUAzUgZXr0RYj5NQrBwk=";
  };

  simpleEnglishSrc = pkgs.fetchFromGitHub {
    owner = "AminBlg";
    repo = "SimpleEnglish";
    rev = "a6fcb4fde098b33617cc1578d151ebf58774b883";
    hash = "sha256-p1ffLp/3Yg1yBfCikBwua3ieVBCNyZfTZH6GBAxNREA=";
  };

  skills = [
    {
      name = "simple-english";
      source = "${simpleEnglishSrc}/skills/simple-english";
    }
    {
      name = "wayfinder";
      source = "${wayfinderSrc}/skills/engineering/wayfinder";
    }
    {
      name = "grilling";
      source = "${wayfinderSrc}/skills/productivity/grilling";
    }
    {
      name = "ask-matt";
      source = "${wayfinderSrc}/skills/engineering/ask-matt";
    }
    {
      name = "domain-modeling";
      source = "${wayfinderSrc}/skills/engineering/domain-modeling";
    }
    {
      name = "research";
      source = "${wayfinderSrc}/skills/engineering/research";
    }
    {
      name = "prototype";
      source = "${wayfinderSrc}/skills/engineering/prototype";
    }
    {
      name = "handoff";
      source = "${wayfinderSrc}/skills/productivity/handoff";
    }
    {
      name = "improve-codebase-architecture";
      source = "${wayfinderSrc}/skills/engineering/improve-codebase-architecture";
    }
    {
      name = "setup-matt-pocock-skills";
      source = "${wayfinderSrc}/skills/engineering/setup-matt-pocock-skills";
    }
    {
      name = "grill-me";
      source = "${wayfinderSrc}/skills/productivity/grill-me";
    }
    {
      name = "grill-with-docs";
      source = "${wayfinderSrc}/skills/engineering/grill-with-docs";
    }
    {
      name = "wait-what";
      source = "${wayfinderSrc}/skills/productivity/wait-what";
    }
    {
      name = "teach";
      source = "${wayfinderSrc}/skills/productivity/teach";
    }
    {
      name = "tdd";
      source = "${wayfinderSrc}/skills/engineering/tdd";
    }
    # Planning → implementation seam: collapse a map/spec into buildable work
    {
      name = "to-spec";
      source = "${wayfinderSrc}/skills/engineering/to-spec";
    }
    {
      name = "to-tickets";
      source = "${wayfinderSrc}/skills/engineering/to-tickets";
    }
    {
      name = "implement";
      source = "${wayfinderSrc}/skills/engineering/implement";
    }
    {
      name = "implement-spec";
      source = "${wayfinderSrc}/skills/engineering/implement-spec";
    }
    {
      name = "code-review";
      source = "${wayfinderSrc}/skills/engineering/code-review";
    }
    {
      name = "pr";
      source = "${wayfinderSrc}/skills/engineering/pr";
    }
    {
      name = "retro";
      source = "${wayfinderSrc}/skills/engineering/retro";
    }
    {
      name = "codebase-design";
      source = "${wayfinderSrc}/skills/engineering/codebase-design";
    }
    {
      name = "diagnosing-bugs";
      source = "${wayfinderSrc}/skills/engineering/diagnosing-bugs";
    }
    {
      name = "triage";
      source = "${wayfinderSrc}/skills/engineering/triage";
    }
    {
      name = "wizard";
      source = "${wayfinderSrc}/skills/engineering/wizard";
    }
    # Standalone: hand-off questions to someone else when the blocker
    # is outside your head or codebase (referenced by ask-matt).
    {
      name = "to-questionnaire";
      source = "${wayfinderSrc}/skills/productivity/to-questionnaire";
    }
    # Reference for writing documents agents consume (skills, AGENTS.md).
    {
      name = "writing-for-agents";
      source = "${wayfinderSrc}/skills/productivity/writing-for-agents";
    }
  ];
in
{
  home.packages = [
    pkgs.herdr
    pkgs.opencode
    pkgs.opencode-desktop
  ];

  home.file = lib.listToAttrs (
    map (s: {
      name = ".agents/skills/${s.name}";
      value = {
        inherit (s) source;
        recursive = true;
      };
    }) skills
  );

  xdg.configFile."opencode/opencode.json".text = builtins.toJSON {
    "$schema" = "https://opencode.ai/config.json";
    lsp = {
      nix = {
        command = [ "nil" ];
        extensions = [ ".nix" ];
      };
    };
  };
}
