{ config, lib, ... }: {
  programs = {
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = lib.mkDefault {
        format = lib.concatStrings [
          "$os"
          "$username"
          "$hostname"
          "$directory"
          "$git_branch"
          "$git_state"
          "$git_status"
          "$docker_context"
          "$nodejs"
          "$dotnet"
          "$nix_shell"
          "$fill"
          "$python"
          "$golang"
          "$status"
          "$line_break"
          "$character"
        ];

        fill.symbol = " ";
        hostname.ssh_symbol = "";
        python.format = "([ $virtualenv]($style)) ";
        rust.symbol = " ";
        status.disabled = false;
        username.format = "[$user]($style)@";

        character = {
          success_symbol = "[❯](purple)";
          error_symbol = "[❯](red)";
          vicmd_symbol = "[❯](green)";
        };

        directory = {
          read_only = " ";
          home_symbol = " ~";
          style = "blue";
          truncate_to_repo = false;
          truncation_length = 5;
          truncation_symbol = ".../";
        };

        docker_context = {
          disabled = false;
          format = " [🐋 $context](blue bold)";
          detect_files = [
            "docker-compose.web-app.yml"
            "Dockerfile_web-app"
            "docker-compose.yml"
            "docker-compose.yaml"
            "Dockerfile"
          ];
        };

        git_branch = {
          symbol = " ";
          format = "[ $branch]($style)";
          style = "green";
        };

        git_status = {
          format =
            "[[( $conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
          style = "cyan";
          conflicted = "​=$count ";
          untracked = "​?$count ";
          modified = "​!$count ";
          staged = "​+$count ";
          renamed = "»$count ​";
          deleted = "​✘$count ";
          stashed = "≡";
        };

        git_state = {
          format = "([$state( $progress_current/$progress_total)]($style)) ";
          style = "bright-black";
        };

        golang = {
          symbol = " ";
          format = "[$symbol$version](cyan bold) ";
        };

        kubernetes = {
          disabled = false;
          format = "[$symbol$context](cyan bold) ";
        };

        nix_shell = {
          disabled = false;
          symbol = " ";
          format = "[ $symbol($name)]($style)";
        };

        dotnet = {
          symbol = "";
          format = "[$symbol $version](bold green)";
          disabled = false;
        };

        nodejs = {
          disabled = false;
          symbol = "";
          format = "[$symbol $version](bold green)";
        };
      };
    };
  };

}
