require("nvim-tree").setup({
  filters = {
    custom = {},
    dotfiles = true,
  },

  open_on_tab = true,
  disable_netrw = false,
  hijack_netrw = false,

  actions = {
    open_file = {
      quit_on_open = true,
    },
  },

  update_focused_file = {
    enable = true,
  },

  view = {
    width = 40,
    side = "left",
  },

  renderer = {
    highlight_git = true,
    add_trailing = true,
    group_empty = true,
    root_folder_modifier = ":~",
    indent_markers = {
      enable = true,
    },

  icons = {
    show = {
      file = true,
      folder = true,
      git = true,
    },

    glyphs = {
      default = '',
      symlink = '',
      git = {
        unstaged = "✗",
        staged = "✓",
        unmerged = "",
        renamed = "➜",
        untracked = "★"
      },
      folder = {
        default = "",
        open = "",
        empty = "",
        empty_open = "",
        symlink = "",
        symlink_open = "",
      },
    },
  },
}})

local function open_nvim_tree(data)

  -- buffer is a [No Name]
  local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not no_name and not directory then
    return
  end

  -- change to the directory
  if directory then
    vim.cmd.cd(data.file)
  end

  -- open the tree
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
