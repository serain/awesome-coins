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

Clone this into your `awesome` configuration directory, probably like this:

`git clone git@github.com:whatever ~/.config/awesome`

Setup is similar to `lain`, so edit your `rc.lua` or `theme.lua` to look
something like this:

```lua
local coins = require("awesome-coins")

-- {{ Coin widgets
-- Ripple
local rippleicon = wibox.widget.imagebox(theme.widget_ripple)
theme.ripple = coins.coin({
    crypto = "ripple",
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, value))
    end
})
-- Bitcoin
local bitcoinicon = wibox.widget.imagebox(theme.widget_bitcoin)
theme.bitcoin = coins.coin({
    crypto = "bitcoin",
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, value))
    end
})
-- Cardano
local cardanoicon = wibox.widget.imagebox(theme.widget_cardano)
theme.cardano = coins.coin({
    crypto = "cardano",
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, value))
    end
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