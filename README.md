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

## Installation & Usage

Clone this into your `awesome` configuration directory:

`git clone git@github.com:whatever ~/.config/awesome`

Setup is similar to `lain`, so edit your `rc.lua` or `theme.lua` to look 
something like this:

```lua
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
-- Cardano
local cardanoicon = wibox.widget.imagebox(theme.widget_cardano)
theme.cardano = coins.coin({
    crypto = "cardano",
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
            bitcoin,
            cardanoicon,
            cardano
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
-- target digital currency, refere to https://coinmarketcap.com/api/
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
