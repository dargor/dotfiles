let s:vim_ai_endpoint_url = "http://localhost:11434/v1/chat/completions"

let s:vim_ai_model = "qwen2.5-coder:14b-instruct-q8_0"
let s:vim_ai_temperature = 0.2
let s:vim_ai_top_p = 0.8

let s:vim_ai_chat_prompt =<< trim END
>>> system

You are a helpful code assistant.

Assume that all unknown symbols are properly initialized elsewhere.

Add a syntax type after ``` to enable proper syntax highlighting.
END

let s:vim_ai_edit_prompt =<< trim END
>>> system

You will act as a code generator.

You must satisfactorily meet the request with as few changes as possible.

Write your answer directly as plain text, without fences or headings to delimit it.

Do not write any introduction, conclusion, or explanation.

Make sure to keep the initial indentation level.
END

let s:vim_ai_chat_config = #{
\  engine: "chat",
\  options: #{
\    model: s:vim_ai_model,
\    initial_prompt: s:vim_ai_chat_prompt,
\    temperature: s:vim_ai_temperature,
\    top_p: s:vim_ai_top_p,
\    endpoint_url: s:vim_ai_endpoint_url,
\    enable_auth: 0,
\    max_tokens: 0,
\    request_timeout: 60,
\  },
\  ui: #{
\    code_syntax_enabled: 1,
\  },
\}

let s:vim_ai_edit_config = #{
\  engine: "chat",
\  options: #{
\    model: s:vim_ai_model,
\    initial_prompt: s:vim_ai_edit_prompt,
\    temperature: s:vim_ai_temperature,
\    top_p: s:vim_ai_top_p,
\    endpoint_url: s:vim_ai_endpoint_url,
\    enable_auth: 0,
\    max_tokens: 0,
\    request_timeout: 60,
\  },
\  ui: #{
\    paste_mode: 1,
\  },
\}

let g:vim_ai_chat = s:vim_ai_chat_config
let g:vim_ai_complete = s:vim_ai_edit_config
let g:vim_ai_edit = s:vim_ai_edit_config

let g:vim_ai_roles_config_file = expand('~/.vim-ai.ini')
