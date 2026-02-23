require('comment-translate').setup({
  target_language = 'ja',
  translate_service = 'google', -- 'google' or 'llm'
  hover = {
    enabled = true,
    delay = 500,
    auto = false,
  },
  immersive = {
    enabled = false,
  },
  cache = {
    enabled = true,
    max_entries = 1000,
  },
  max_length = 5000,
  targets = {
    comment = true,
    string = true,
  },
  -- llm = {
  --   provider = 'ollama', -- 'openai' | 'anthropic' | 'gemini' | 'ollama'
  --   api_key = nil,
  --   model = 'translategemma:4b',
  --   timeout = 20,
  -- },
  keymaps = {
    hover = '<leader>th',
    hover_manual = '<leader>tc',
    replace = '<leader>tr',
    toggle = '<leader>tt',
  },
})
