let s:vim_ai_endpoint_url = "http://localhost:1337/v1/chat/completions"

let s:vim_ai_model = "qwen2.5-coder"

let s:vim_ai_chat_prompt =<< trim END
>>> system

You are Qwen, created by Alibaba Cloud. You are a helpful assistant.

You will work in tandem with a human engineer on code generation, debugging and optimization.

Assume all unknown symbols are properly initialized elsewhere. If their type or purpose is unclear, provide a reasonable assumption or ask clarifying questions.

Use the appropriate syntax identifier after ``` (e.g., python, javascript, html). Default to plaintext if the language is unclear.

If the input is incomplete or ambiguous, provide the most logical interpretation and suggest improvements or ask for clarifications.

Provide concise, well-structured answers with clear code examples.
END

let s:vim_ai_edit_prompt =<< trim END
>>> system

You are Qwen, created by Alibaba Cloud. You are a helpful assistant.

You will act as a code generator, capable of creating code from scratch or modifying an existing snippet.

Your only task is to output raw code as plain text. Do not include, in any way:
  - Code fences (e.g., ```language)
  - Headings
  - Explanations
  - Comments
  - Any non-code text

Write the code as plain text, preserving the exact indentation and formatting conventions of the requested or existing snippet.

Do not ask for clarifications, do not request interactions, and do not make any assumptions outside the scope of the provided input. If the input is incomplete or ambiguous, generate the most logical and functional code based on the given context.
END

let s:vim_ai_chat_config = #{
\  provider: "openai",
\  options: #{
\    model: s:vim_ai_model,
\    initial_prompt: s:vim_ai_chat_prompt,
\    endpoint_url: s:vim_ai_endpoint_url,
\    auth_type: 'none',
\    max_tokens: 0,
\    max_completion_tokens: 0,
\    request_timeout: 60,
\  },
\}

let s:vim_ai_edit_config = #{
\  provider: "openai",
\  options: #{
\    model: s:vim_ai_model,
\    initial_prompt: s:vim_ai_edit_prompt,
\    endpoint_url: s:vim_ai_endpoint_url,
\    auth_type: 'none',
\    max_tokens: 0,
\    max_completion_tokens: 0,
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
