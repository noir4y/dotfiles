local function as_number(v)
  if type(v) == 'number' then
    return v
  end
  if type(v) == 'table' and type(v[false]) == 'number' then
    return v[false]
  end
  return 0
end

local function set_pos(cfg, row, col)
  if type(cfg.row) == 'table' then
    cfg.row[false] = row
  else
    cfg.row = row
  end

  if type(cfg.col) == 'table' then
    cfg.col[false] = col
  else
    cfg.col = col
  end
end

local function center_dashboard_preview()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == 'dashboardpreview' then
      local cfg = vim.api.nvim_win_get_config(win)
      local width = as_number(cfg.width)
      local height = as_number(cfg.height)
      local col = math.max(0, math.floor((vim.o.columns - width) / 2))
      local row = math.max(0, math.floor((vim.o.lines - height) / 2) - 1)
      cfg.relative = 'editor'
      set_pos(cfg, row, col)
      pcall(vim.api.nvim_win_set_config, win, cfg)
    end
  end
end

local group = vim.api.nvim_create_augroup('DashboardPreviewCenter', { clear = true })
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'TermOpen', 'VimResized', 'WinResized' }, {
  group = group,
  callback = function()
    vim.schedule(center_dashboard_preview)
  end,
})

require('dashboard').setup({
  theme = 'hyper',
  disable_move = true,
  config = {
    week_header = {
      enable = false,
    },
    header = {},
    footer = {},
    vertical_center = true,
    shortcut = {},
    project = {
      action = function(path)
        local ok, fzf_lua = pcall(require, 'fzf-lua')
        if ok then
          fzf_lua.files({ cwd = path })
          return
        end

        local escaped = vim.fn.fnameescape(path)
        if vim.fn.exists(':Telescope') == 2 then
          vim.cmd('Telescope find_files cwd=' .. escaped)
          return
        end

        vim.cmd('edit ' .. escaped)
      end,
    },
  },
  hide = {
    statusline = true,
    tabline = true,
    winbar = true,
  },
  preview = {
    command = [[sh -c 'cat "$0" | tte beams --beam-row-symbols ☆ ･ ･ --beam-column-symbols ☆ ･ ･; while :; do sleep 3600; done']],
    file_path = vim.fn.expand('~/dotfiles/logo.txt'),
    file_width = 50,
    file_height = 20,
  },
})
