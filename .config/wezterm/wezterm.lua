local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.audible_bell = 'Disabled'
config.check_for_updates = false
config.cursor_blink_rate = 0
config.hide_mouse_cursor_when_typing = false
config.hide_tab_bar_if_only_one_tab = true
config.hyperlink_rules = {}
config.initial_cols = 80
config.initial_rows = 24
config.native_macos_fullscreen_mode = true
config.scrollback_lines = 10000
config.selection_word_boundary = ',│`|;"\' ()[]{}<>\t'
config.skip_close_confirmation_for_processes_named = {}
config.ssh_domains = {}
config.swallow_mouse_click_on_pane_focus = true
config.swallow_mouse_click_on_window_focus = true

config.font = wezterm.font('Monaspace Krypton')
config.font_size = 11
config.freetype_load_flags = 'FORCE_AUTOHINT'
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

config.colors = {
    background = '#000000',
    foreground = '#A8A8A8',
    cursor_bg = '#A8A8A8',
    cursor_fg = '#000000',
    selection_bg = '#A8A8A8',
    selection_fg = '#000000',
    ansi = {
        '#000000',
        '#B21818',
        '#18B218',
        '#BE5F00',
        '#6D85BA',
        '#B218B2',
        '#18B2B2',
        '#B2B2B2',
    },
    brights = {
        '#686868',
        '#FF5454',
        '#54FF54',
        '#FFFF54',
        '#73A5FF',
        '#FF54FF',
        '#54FFFF',
        '#FFFFFF',
    },
    compose_cursor = 'orange',
    cursor_border = '#A8A8A8',
}

config.keys = {
    {
        key = 'n',
        mods = 'META|SHIFT',
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'v',
        mods = 'META|SHIFT',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
}

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

return config
