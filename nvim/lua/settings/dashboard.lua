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

local function find_dashboard_content_bounds()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == 'dashboard' then
      local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
      local top_row
      local bottom_row
      for i, line in ipairs(lines) do
        if line:match('%S') then
          local row = i - 1
          if not top_row then
            top_row = row
          end
          bottom_row = row
        end
      end
      if top_row then
        return top_row, bottom_row
      end
    end
  end
end

local function center_dashboard_preview()
  local content_top_row, content_bottom_row = find_dashboard_content_bounds()
  local gap_lines = 3
  local col_offset = 2

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == 'dashboardpreview' then
      local cfg = vim.api.nvim_win_get_config(win)
      local width = as_number(cfg.width)
      local height = as_number(cfg.height)
      local col = math.max(0, math.ceil((vim.o.columns - width) / 2) + col_offset)
      local centered = math.max(0, math.floor((vim.o.lines - height) / 2) - 1)
      local upper_band = math.max(2, math.floor(vim.o.lines * 0.45))
      local row = math.max(2, math.min(centered, upper_band))

      if content_top_row then
        local max_row_before_content = content_top_row - height - gap_lines
        if max_row_before_content >= 2 then
          row = math.min(row, max_row_before_content)
        elseif content_bottom_row then
          local max_row_on_screen = math.max(0, vim.o.lines - height - 2)
          local row_below_content = content_bottom_row + 1
          row = math.max(0, math.min(row_below_content, max_row_on_screen))
        end
      end

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
    vim.defer_fn(center_dashboard_preview, 80)
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
    mru = {
      cwd_only = true,
    },
  },
  hide = {
    statusline = true,
    tabline = true,
    winbar = true,
  },
  preview = {
    command = [[sh -c 'if command -v tte >/dev/null 2>&1; then cat "$0" | tte beams --beam-row-symbols ☆ ･ ･ --beam-column-symbols ☆ ･ ･; else cat "$0"; fi; while :; do sleep 3600; done']],
    file_path = vim.fn.expand('~/dotfiles/logo.txt'),
    file_width = 56,
    file_height = 8,
  },
})
