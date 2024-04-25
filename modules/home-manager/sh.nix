{ config, ... }:

{
  programs = {
    zsh = {
      oh-my-zsh = {
        enable = true;
        custom = "/home/philo/.config/zsh-custom";
        plugins = [
          #   "forgit"
          #   "appup"
          #   "kctl"
          #   "zsh-dotnet-completion"
          #   "docker"
          #   "npm"
          #   "vi-mode"
          #   "nix-shell"
          #   "F-Sy-H"
          "fzf-tab"
        ];
      };
      enable = true;
      dotDir = ".config/zsh";

      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      history = {
        save = 10000;
        size = 10000;
        path = "$HOME/.cache/zsh_history";
      };

      initExtra = ''
        pokeget random --hide-name -s
        bindkey '^[[1;5C' forward-word # Ctrl+RightArrow
        bindkey '^[[1;5D' backward-word # Ctrl+LeftArrow

        zstyle ':completion:*' completer _complete _match _approximate
        zstyle ':completion:*:match:*' original only
        zstyle ':completion:*:approximate:*' max-errors 1 numeric
        zstyle ':completion:*' menu select
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"

        # HACK! Simple shell function to patch ruff bins downloaded by tox from PyPI to use
        # the ruff included in NixOS - needs to be run each time the tox enviroment is
        # recreated
        patch_tox_ruff() {
          for x in $(find .tox -name ruff -type f -print); do
            rm $x;
            ln -sf $(which ruff) $x;
          done
        }

        setopt AUTO_CD
        eval "$(zoxide init zsh)"
        export EDITOR=nvim
      '';

      shellAliases = {
        ls =
          "eza -l --git --group-directories-first  --color=always --icons=always";
        ll =
          "eza -la --group-directories-first --git --color=always --icons=always";
        tree = "eza --tree  --icons=always --git --color=always";

        pni = "pnpm install";
        pnd = "pnpm dev";
        pnx = "pnpm dlx";
        pn = "pnpm";
        nx = "pnpm dlx nx";

        dev = "nix develop -c zsh";
        swi = "sudo nixos-rebuild switch --flake .#default";
        upd = "sudo nix flake update";
        sus = "sys; upd; swi";
        del =
          "sudo nix-env --delete-generations old --profile /nix/var/nix/profiles/system";

        tt = "taskwarrior-tui";

        logi = "sudo systemctl restart logiops";

        ip = "ip --color";
        ipb = "ip --color --brief";

        lazy =
          "lazygit --use-config-file='/home/philopater/.config/lazygit/config.yml'";

        hollywood = "docker run --rm -it bcbcarl/hollywood";

        gac = "git add -A  && git commit -a";
        gad = "git add .";
        gp = "git push";
        gst = "git status -sb";

        tf = "terraform";
        tfi = "terraform init";
        tfp = "terraform plan";
        tfa = "terraform apply -auto-approve";
        tfd = "terraform destroy -auto-approve";
        tfo = "terraform output -json";

        wgu = "sudo wg-quick up";
        wgd = "sudo wg-quick down";

        ts = "tailscale";
        tssh = "tailscale ssh";
        tst = "tailscale status";
        tsu = "tailscale up --ssh --operator=$USER";
        tsd = "tailscale down";

        js = "juju status";
        jsw = "juju status --watch 1s --color";
        jsrw = "juju status --watch 1s --color --relations";
        jdl = "juju debug-log";

        rlu = "sudo nix flake update $HOME/nixos-config";
        rlb = "rln;rlh";

        open = "xdg-open";
        k = "kubectl";

        sys = "z sys";

        conf = "z .config";

        opget = ''
          op item get "$(op item list --format=json | jq -r '.[].title' | fzf)"'';

        speedtest =
          "curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -";

        cleanup-nix = "sudo nix-collect-garbage -d";
      };
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;

    changeDirWidgetOptions = [ "--preview 'tree -C {} | head -200'" ];

    defaultCommand = "rg --files";

    defaultOptions = [ "--height 90%" "--border" ];

    fileWidgetCommand = "rg --files";
    fileWidgetOptions = [
      "--preview 'bat -n --color=always {}'"
      "--bind 'ctrl-/:change-preview-window(down|hidden|)'"
    ];

    tmux.enableShellIntegration = true;
    colors = {
      "bg+" = "#313244"; # Surface0
      "fg+" = "#cdd6f4"; # Text
      "hl+" = "#f38ba8"; # Red
      bg = "#313244"; # Surface0
      fg = "#cdd6f4"; # Text
      header = "#f38ba8"; # Red
      hl = "#f38ba8"; # Red
      info = "#cba6f7"; # Mauve
      marker = "#cdd6f4"; # Text
      pointer = "#cdd6f4"; # Text
      prompt = "#cba6f7"; # Mauve
      spinner = "#cdd6f4"; # Text
    };
  };
}
