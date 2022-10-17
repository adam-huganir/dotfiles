local wezterm = require 'wezterm';

return {
	    --  color_scheme = "Monokai Remastered",
        font = wezterm.font_with_fallback({"Iosevka Term Curly", "FiraCode Nerd Font", "FiraCode NF"}),
        line_height = 1.0,
        window_background_opacity = 0.9,
        text_background_opacity = 1.0,
        hide_tab_bar_if_only_one_tab = true,
	use_fancy_tab_bar = false,
        scrollback_lines = 3500,
	warn_about_missing_glyphs = false,
        leader = { key="w", mods="CTRL|ALT", timeout_milliseconds=3000 },
        keys = {
		{ key = "q", mods="LEADER", action=wezterm.action{CloseCurrentPane={confirm=true}}},
                { key = "%", mods="LEADER|SHIFT", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
                { key = "\"", mods="LEADER|SHIFT", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
                { key = "LeftArrow", mods="LEADER",     action=wezterm.action{ActivatePaneDirection="Left"}},
                { key = "LeftArrow", mods="LEADER|CTRL",     action=wezterm.action{AdjustPaneSize={"Left", 1}}},
                { key = "RightArrow", mods="LEADER", action=wezterm.action{ActivatePaneDirection="Right"}},
                { key = "RightArrow", mods="LEADER|CTRL", action=wezterm.action{AdjustPaneSize={"Right", 1}}},
                { key = "UpArrow", mods="LEADER", action=wezterm.action{ActivatePaneDirection="Up"}},
                { key = "UpArrow", mods="LEADER|CTRL", action=wezterm.action{AdjustPaneSize={"Up", 1}}},
                { key = "DownArrow", mods="LEADER", action=wezterm.action{ActivatePaneDirection="Down"}},
                { key = "DownArrow", mods="LEADER|CTRL", action=wezterm.action{AdjustPaneSize={"Down", 1}}},
		{ key = "r", mods="CTRL|SHIFT", action="ReloadConfiguration"},
        },


        visual_bell = {
            fade_in_function = "EaseIn",
            fade_in_duration_ms = 150,
            fade_out_function = "EaseOut",
            fade_out_duration_ms = 150,
            target = "BackgroundColor",
        },
        colors = {
                visual_bell = "#742739",
		compose_cursor = "orange",
        },
	exit_behavior = "Close",
}

