# Tools for working with GDScript and Godot
{ pkgs, ... }:

{
  home.packages = [
    pkgs.gdtoolkit_4
    pkgs.godot_4
  ];
}
