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
    rev = "84fdeffd12f2ee307994d1eb6feb48173b6e0502";
    hash = "sha256-pseSJJb5nBBGPzpxA1GzjGLB9OrT+u0At1saJ4NqZ1E=";
  };

  simpleEnglishSrc = pkgs.fetchFromGitHub {
    owner = "AminBlg";
    repo = "SimpleEnglish";
    rev = "59bfc702197a5aadc9cd1e37d17f290d8d50dcd3";
    hash = "sha256-QmlV9OZ4CNxI+pV7jDcn4n3Zet1+9W7h5oTNCUQ/vrY=";
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
      name = "code-review";
      source = "${wayfinderSrc}/skills/engineering/code-review";
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
      name = "resolving-merge-conflicts";
      source = "${wayfinderSrc}/skills/engineering/resolving-merge-conflicts";
    }
    {
      name = "triage";
      source = "${wayfinderSrc}/skills/engineering/triage";
    }
    {
      name = "wizard";
      source = "${wayfinderSrc}/skills/engineering/wizard";
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
