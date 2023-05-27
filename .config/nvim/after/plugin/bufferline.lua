local bufferline = require('bufferline')

bufferline.setup({
  options = {
    buffer_close_icon = '',
    close_icon = '',
    diagnostics = 'nvim_lsp',
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "center" ,
        separator = false,
      }
    },


    -- start of diagnostics icons function --
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
    -- end of diagnostics icons function --
    show_tab_indicators = true,
  }
})
