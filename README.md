# awesome-coins

## Overview

`awesome-coins` provides a widget for displaying cryptocurrency values in 
awesomeWM. It's powered by
[coinmarketcap's API](https://coinmarketcap.com/api/).

You could make it look like this:

![awesome-coins sample](./screenshots/sample.png "awesome-coins sample")

## Acknowledgements

This plugin is mostly an adaptation Luca CPZ's
[`lain`](https://github.com/lcpz/lain) widgets, modified to display
cryptocurrency values.

## Prerequisites

You'll need [`lain`](https://github.com/lcpz/lain) in your `awesome`
configuration directory if you don't have it already:

`git clone https://github.com/lcpz/lain.git ~/.config/awesome`

## Installation & Usage

Clone `awesome-coins` into your `awesome` configuration directory:

`git clone https://github.com/sheeplepie/awesome-coins.git ~/.config/awesome`

Setup is similar to `lain` widgets, so edit your `rc.lua` or `theme.lua` to look 
something like this:

```lua
local markup = lain.util.markup
local coins = require("awesome-coins")

-- {{ Coins
-- Settings
local coin_settings = function()
    if tonumber(change) >= 0 then
        change = markup.fontfg(theme.font, "#87af5f", '+' .. change .. '%')
    else
        change = markup.fontfg(theme.font, "#e54c62", change .. '%')
    end
    widget:set_markup('$' .. markup.fontfg(theme.font, theme.fg_normal, value) ..
                      ' (' .. change .. ') ')
end
-- Ripple
local rippleicon = wibox.widget.imagebox(theme.widget_ripple)
theme.ripple = coins.coin({
    crypto = "ripple",
    settings = coin_settings
})
-- Bitcoin
local bitcoinicon = wibox.widget.imagebox(theme.widget_bitcoin)
theme.bitcoin = coins.coin({
    crypto = "bitcoin",
    settings = coin_settings
})
-- }}

-- {{ Wibar
function theme.at_screen_connect(s)
    -- Create the wibox
    s.mywibox = awful.wibar({ ... })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            rippleicon,
            ripple,
            bitcoinicon,
            bitcoin
        },
        ...
    }
end
-- }}
```

## Options

Check `coin.lua` for details. The following `args` can be passed to
`coins.coin()`, as a single table parameter:

```lua
-- target digital currency, refer to https://coinmarketcap.com/api/
local crypto                = args.crypto or 'bitcoin'
-- refresh timeout
local timeout               = args.timeout or 60
-- default text if API fails for whatever reason
local na_markup             = args.na_markup or " N/A "
-- percentage_delta can be: 1h || 24h || 7d
local percentage_delta      = args.percentage_delta or "24h"
-- see lain or examples in README
local settings              = args.settings or function() end
```
