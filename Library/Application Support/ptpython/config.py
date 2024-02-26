from prompt_toolkit.output import ColorDepth
from ptpython.layout import CompletionVisualisation


def configure(repl):
    repl.show_signature = False
    repl.show_docstring = True
    repl.show_meta_enter_message = False
    repl.completion_visualisation = CompletionVisualisation.MULTI_COLUMN
    repl.show_line_numbers = False
    repl.show_status_bar = True
    repl.show_sidebar_help = True
    repl.swap_light_and_dark = False
    repl.highlight_matching_parenthesis = True
    repl.wrap_lines = True
    repl.enable_mouse_support = False
    # XXX complete_while_typing is conflicting with enable_history_search
    repl.complete_while_typing = True
    repl.enable_fuzzy_completion = False
    repl.enable_dictionary_completion = False
    repl.vi_mode = False
    repl.paste_mode = False
    repl.prompt_style = 'classic'
    repl.insert_blank_line_after_output = False
    # XXX enable_history_search is conflicting with complete_while_typing
    repl.enable_history_search = False
    repl.enable_auto_suggest = True
    repl.enable_open_in_editor = False
    repl.enable_system_bindings = False
    repl.confirm_exit = False
    repl.enable_input_validation = True
    repl.color_depth = ColorDepth.DEPTH_24_BIT
    repl.enable_syntax_highlighting = True
    repl.vi_start_in_navigation_mode = False
    repl.vi_keep_last_used_mode = False
    repl.use_code_colorscheme('vim')
