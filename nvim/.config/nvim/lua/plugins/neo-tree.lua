-- File tree on the working directory
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    -- Find open
    {
      "<leader>E",
      function ()
        require("neo-tree.command").execute({ toggle = true, position = 'right' })
      end,
      desc = "File [E]xplorer"
    },
  },
  config = {
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
      }
    },
    event_handlers = {
      -- Close on select
      {
        event = "file_opened",
        handler = function()
          require("neo-tree.command").execute({ action = "close" })
        end
      },
    }
  }
}
