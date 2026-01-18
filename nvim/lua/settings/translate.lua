require('comment-translate').setup({
  target_language = 'ja',       -- Target language (default: auto-detected from system locale, fallback 'en')
  translate_service = 'google', -- Currently only 'google' is supported
  hover = {
    enabled = true,             -- Enable hover translation
    delay = 500,                -- Additional delay (ms) after CursorHold before showing hover
    auto = false,               -- If false, disable auto-hover and use explicit keymap
  },
  immersive = {
    enabled = false, -- Enable immersive translation on startup
  },
  cache = {
    enabled = true,     -- Enable translation cache
    max_entries = 1000, -- Maximum cache entries
  },
  max_length = 5000,    -- Maximum translation text length
  targets = {
    comment = true,     -- Include comments as translation targets
    string = true,      -- Include strings as translation targets
  },
  keymaps = {
    hover = '<leader>th',        -- Hover translation
    hover_manual = '<leader>tc', -- Manual hover trigger (when auto is disabled)
    replace = '<leader>tr',      -- Replace selected text with translation
    toggle = '<leader>tt',       -- Toggle immersive translation ON/OFF (global)
  },
})
