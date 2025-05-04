{ config, pkgs, ... }: let
  cfg = config.gpd.common.libfprint-focaltech;
in with lib; {
  config = mkIf cfg.enabled {
    services.fprintd = {
        enable = true;
        package = let
          libfprint = pkgs.libfprint.overrideAttrs (oldAttrs: {
            src = pkgs.fetchurl {
              url = "https://github.com/ftfpteams/focaltech-linux-fingerprint-driver/raw/refs/heads/main/Fedora_Redhat/libfprint-2-2_1.94.4+tod1_redhat_all_x64_20250219.install";
              sha256 = "0y7kb2mr7zd2irfgsmfgdpb0c7v33cb4hf3hfj7mndalma3xdhzn";
            };
          });
        in pkgs.fprintd.override {
          inherit libfprint;
        };
      };
    };
}
