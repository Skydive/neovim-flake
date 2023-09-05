{
  normal = {
    # Telescope
    "<leader>ff" = { action = "<cmd>Telescope find_files<cr>"; };
    "<leader>fo" = { action = "<cmd>Telescope old_files<cr>"; };
    "<leader>fg" = { action = "<cmd>Telescope live_grep<cr>"; };
    "<leader>fb" = { action = "<cmd>Telescope buffers<cr>"; };
    "<leader>fh" = { action = "<cmd>Telescope help_tags<cr>"; };
    "<leader>fp" = { action = "<cmd>Telescope projects<cr>"; };

    # CHADTree
    "<leader>e" = { action = "<cmd>CHADopen --always-focus<cr>"; };

    # Buffers
    "<leader>x" = { action = "<cmd>bdelete<cr>"; };
    "<leader>[" = { action = "<cmd>BufferLineMovePrev<cr>"; };
    "<leader>]" = { action = "<cmd>BufferLineMoveNext<cr>"; };
    "<leader>1" = { action = "<cmd>BufferLineGoToBuffer 1<cr>"; };
    "<leader>2" = { action = "<cmd>BufferLineGoToBuffer 2<cr>"; };
    "<leader>3" = { action = "<cmd>BufferLineGoToBuffer 3<cr>"; };
    "<leader>4" = { action = "<cmd>BufferLineGoToBuffer 4<cr>"; };
    "<leader>5" = { action = "<cmd>BufferLineGoToBuffer 5<cr>"; };
    "<leader>6" = { action = "<cmd>BufferLineGoToBuffer 6<cr>"; };
    "<leader>7" = { action = "<cmd>BufferLineGoToBuffer 7<cr>"; };
    "<leader>8" = { action = "<cmd>BufferLineGoToBuffer 8<cr>"; };
    "<leader>9" = { action = "<cmd>BufferLineGoToBuffer 9<cr>"; };
    "<leader>$" = { action = "<cmd>BufferLineGoToBuffer -1<cr>"; };

    "<leader>b" = { action = "<cmd>enew<cr>"; };

    "<leader>/" = { action = "<cmd>CommentToggle<cr>"; };

    "gD" = { action = "<cmd>lua vim.lsp.buf.declaration()<cr>"; }; 
    "gd" = { action = "<cmd>lua vim.lsp.buf.definition()<cr>"; }; 
    "K" = { action = "<cmd>lua vim.lsp.buf.hover()<cr>"; }; 
    "gi" = { action = "<cmd>lua vim.lsp.buf.implementation()<cr>"; }; 
    "gr" = { action = "<cmd>lua vim.lsp.buf.references()<cr>"; }; 
    "<leader>ls" = { action = "<cmd>lua vim.lsp.buf.signature_help()<cr>"; }; 

    "<leader>D" = { action = "<cmd>lua vim.lsp.buf.type_definition()<cr>"; }; 
    "<leader>ca" = { action = "<cmd>lua vim.lsp.buf.code_action()<cr>"; }; 

    "<leader>f" = { action = "<cmd>lua vim.diagnostic.open_float { border = \"rounded\" }<cr>"; }; 
  };

  visual = {
    "<leader>/" = { action = "<cmd>'<,'>CommentToggle<cr>"; };
  };
}
