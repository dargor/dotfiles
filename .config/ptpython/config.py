# Copy this file to ~/.config/ptpython/config.py

from __future__ import unicode_literals
from ptpython.layout import CompletionVisualisation


def configure(repl):
    repl.show_signature = True
    repl.show_docstring = True
    repl.show_meta_enter_message = False
    repl.completion_visualisation = CompletionVisualisation.MULTI_COLUMN
    repl.show_line_numbers = True
    repl.show_status_bar = True
    repl.show_sidebar_help = True
    repl.highlight_matching_parenthesis = True
    repl.wrap_lines = True
    repl.enable_mouse_support = False
    repl.complete_while_typing = True
    repl.vi_mode = False
    repl.paste_mode = False
    repl.prompt_style = 'classic'
    repl.insert_blank_line_after_output = False
    repl.enable_history_search = False
    repl.enable_auto_suggest = True
    repl.enable_open_in_editor = False
    repl.enable_system_bindings = False
    repl.confirm_exit = False
    repl.enable_input_validation = True
    repl.true_color = False
    repl.enable_syntax_highlighting = True
    repl.use_code_colorscheme('vim')
    repl.use_ui_colorscheme('blue')
