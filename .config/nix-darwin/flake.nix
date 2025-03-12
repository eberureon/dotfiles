{
  description = "My nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ 
          pkgs.vim
        ];
      nix.settings.experimental-features = "nix-command flakes";
      system.configurationRevision = self.rev or self.dirtyRev or null;
      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;
      nixpkgs.hostPlatform = "aarch64-darwin";
      # default shell on catalina
      programs.zsh.enable = true;  
      security.pam.services.sudo_local.touchIdAuth = true;

      system.defaults = {
        finder.AppleShowAllExtensions = true;
        finder.FXPreferredViewStyle = "clmv";
        screencapture.location = "~/Pictures/screenshots";
        screensaver.askForPasswordDelay = 10;
        dock.tilesize = 36;
        # dock.persistent-apps = [
        #   { app = "/System/Applications/Calendar.app"; }
        #   { app = "/Applications/Thunderbird.app"; } 
        #   { app = "/Applications/Zen Browser.app"; } 
        #   { app = "/Applications/Google Chrome.app/"; } 
        #   { app = "/System/Applications/Notes.app"; } 
        #   { app = "/Applications/Obsidian.app"; } 
        #   { app = "/Applications/Zed.app"; } 
        #   { app = "/Applications/Bitwarden.app"; } 
        #   { app = "/Applications/Zotero.app"; } 
        #   { app = "/Applications/VirtualBox.app"; } 
        #   { app = "/Applications/WezTerm.app"; }
        #   { app = "/System/Applications/System Settings.app"; }
        # ];
      };

      # Homebrew needs to be installed on its own!
      homebrew.enable = true;
      homebrew.casks = [
        "wireshark"
        "aerospace"
        "font-hack-nerd-font"
      ];
      homebrew.brews = [
        "fzf"
        "eza"
        "zoxide"
        "skhd"
        "htop"
        "neovim"
        "fastfetch"
        "jq"
        "ripgrep"
        "nvm"
      ];
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Leons-MacBook-Pro
    darwinConfigurations."Leons-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
