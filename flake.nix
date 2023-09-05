{
  description = "Current neovim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-utils.url = "github:numtide/flake-utils";
    plugin-cmp-nvim-lsp.url = "github:hrsh7th/cmp-nvim-lsp";
    plugin-cmp-nvim-lsp.flake = false;
  };

  outputs = { nixpkgs, nixvim, flake-utils, ... } @ inputs: 
    flake-utils.lib.eachDefaultSystem (system: let
      nixvimLib = nixvim.lib.${system};

      pkgs = import nixpkgs {inherit system;};
      nixvim' = nixvim.legacyPackages.${system};

      module = {
        config = {
          colorschemes.catppuccin.enable = true;
          globals.mapleader = ",";
          maps = import ./maps.nix;
          plugins = {
            # Greeter
            lsp = {
              enable = true;
              servers.eslint.enable = true;
              servers.tsserver.enable = true;
            };

            nvim-lightbulb.enable = true;
            nvim-cmp = {
              enable = true;
              mapping = {
      		"<CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
		"<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), { \"i\", \"s\" })";
		"<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), { \"i\", \"s\" })"; 
              };
              preselect = "Item";
              sources = [
                { name = "nvim_lsp"; }
                #{ name = "treesitter"; }
                { name = "path"; }
                { name = "tmux"; }
                { name = "buffer"; }
                { name = "calc"; }
                #{ name = "cmp_clippy"; }
                { name = "crates"; }
                { name = "nvim_lsp_document_symbol"; }
                { name = "nvim_lsp_signature_help"; }
              ];
            };
            cmp-nvim-lsp.enable = true;
            cmp-nvim-lsp-document-symbol.enable = true;
            cmp-nvim-lsp-signature-help.enable = true;

            cmp-buffer.enable = true;
            cmp-calc.enable = true;
            cmp-clippy.enable = true;
            cmp-path.enable = true;
            cmp-tmux.enable = true;
            cmp-treesitter.enable = true;
            cmp-cmdline.enable = true;
            cmp-greek.enable = true;
            cmp-emoji.enable = true;
            crates-nvim.enable = true;

            lspkind.enable = true;
            lspkind.cmp.enable = true;

            alpha.enable = true;
      

            neogit.enable = true;
            gitsigns.enable = true;

            telescope.enable = true;
            chadtree.enable = true;

            tmux-navigator.enable = true;
            comment-nvim.enable = true;
            
            noice.enable = true;
            notify.enable = true;
            lualine.enable = true;
            cursorline.enable = true;

            nvim-autopairs.enable = true;
            treesitter.enable = true;
            treesitter-context.enable = true;
            #rainbow-delimiters.enable = true;

            # Typescript...
            ts-autotag.enable = true;
            ts-context-commentstring.enable = true;
            #surround.enable = true;

            # Sleuth > This dumb shit
            #intellitab.enable = false;

            bufferline.enable = true;

            project-nvim.enable = true;

            rust-tools.enable = true;	

            # Broken...
            #tagbar.enable = true;

            # Show binds
            which-key.enable = true;
          };
          extraPlugins = with pkgs.vimPlugins; [
            vim-sleuth
          ];
          extraConfigLua = ''
          '';
          extraConfigLuaPost = builtins.readFile ./init.lua;
        };
      };

      nvim = nixvim'.makeNixvimWithModule {
        inherit pkgs;
        inherit module;
      };
    in {
      checks = {
        # Run `nix flake check .` to verify that your config is not broken
        default = nixvimLib.check.mkTestDerivationFromNvim {
          inherit nvim;
          name = "A nixvim configuration";
        };
      };

      packages = {
        # Lets you run `nix run .` to start nixvim
        default = nvim;
      };
    });
}
