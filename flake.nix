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
          # options = {
          #   listChars = {
          #     enable = true;
          #     eol = "↴";
          #     trail = "-";
          #   };
          # };
          colorschemes.catppuccin.enable = true;
          globals.mapleader = ",";
          maps = {
            normal."<leader>ff" = { action = "<cmd>Telescope find_files<cr>"; };
            normal."<leader>fg" = { action = "<cmd>Telescope live_grep<cr>"; };
            normal."<leader>fb" = { action = "<cmd>Telescope buffers<cr>"; };
            normal."<leader>fh" = { action = "<cmd>Telescope help_tags<cr>"; };

            normal."<leader>e" = { action = "<cmd>CHADopen<cr>"; };

            normal."<leader>x" = { action = "<cmd>bdelete<cr>"; };
            normal."<leader>h" = { action = "<cmd>BufferLineMovePrev<cr>"; };
            normal."<leader>l" = { action = "<cmd>BufferLineMoveNext<cr>"; };
            normal."<leader>1" = { action = "<cmd>BufferLineGoToBuffer 1<cr>"; };
            normal."<leader>2" = { action = "<cmd>BufferLineGoToBuffer 2<cr>"; };
            normal."<leader>3" = { action = "<cmd>BufferLineGoToBuffer 3<cr>"; };
            normal."<leader>4" = { action = "<cmd>BufferLineGoToBuffer 4<cr>"; };
            normal."<leader>5" = { action = "<cmd>BufferLineGoToBuffer 5<cr>"; };
            normal."<leader>6" = { action = "<cmd>BufferLineGoToBuffer 6<cr>"; };
            normal."<leader>7" = { action = "<cmd>BufferLineGoToBuffer 7<cr>"; };
            normal."<leader>8" = { action = "<cmd>BufferLineGoToBuffer 8<cr>"; };
            normal."<leader>9" = { action = "<cmd>BufferLineGoToBuffer 9<cr>"; };
            normal."<leader>$" = { action = "<cmd>BufferLineGoToBuffer -1<cr>"; };
          };
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
      
            cursorline.enable = true;

            neogit.enable = true;
            gitsigns.enable = true;

            notify.enable = true;
            lualine.enable = true;
            
            telescope.enable = true;
            chadtree.enable = true;

            tmux-navigator.enable = true;
            nvim-autopairs.enable = true;
            comment-nvim.enable = true;
            
            noice.enable = true;

            treesitter.enable = true;
            intellitab.enable = true;

            bufferline.enable = true;

            project-nvim.enable = true;

            rust-tools.enable = true;	
          };
          extraPlugins = with pkgs.vimPlugins; [
            nvim-ts-autotag
            vim-sleuth
          ];
          extraConfigLua = ''
            require('nvim-ts-autotag').setup()
          '';
          extraConfigVim = ''
            set number 
            set mouse 
          '';
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
