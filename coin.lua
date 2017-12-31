
--[[

    awesome-coins module by alxk (@sheeplepie)

    displays latest cryptocurrency prices

    *heavily* inspired by lain widgets

--]]

local helpers  = require("awesome-coins.helpers")
local json     = require("awesome-coins.json")
local wibox    = require("wibox")
local tonumber = tonumber

-- coins.coin

local function factory(args)
    local coin                  = { widget = wibox.widget.textbox() }
    local args                  = args or {}
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
    local api_call              = "curl -s https://api.coinmarketcap.com/v1/ticker/%s/"

    coin.widget:set_markup(na_markup)

    function coin.update()
        local cmd = string.format(api_call, crypto)
        helpers.async(cmd, function(f)
            value = tonumber(json.decode(f)[1]["price_usd"])
            change = json.decode(f)[1][string.format("percent_change_%s", percentage_delta)]

            if tonumber(value) ~= nil and tonumber(change) ~= nil then
                if value > 1000 then
                    value = string.format("%.2fK", value/1000)
                else
                    value = string.format("%.2f", value)
                end

                widget = coin.widget
                settings()
            else
                coin.widget:set_markup(na_markup)
            end
        end)
    end

    coin.timer = helpers.newtimer("coin", timeout, coin.update, false, true)

    return coin
end

return factory
