
--[[

    awesome-coins module by alxk (@sheeplepie)

    displays latest cryptocurrency prices

    *heavily* inspired by lain widgets

--]]

local helpers  = require("awesome-coins.helpers")
local json     = require("awesome-coins.json")
local wibox    = require("wibox")
local tonumber = tonumber

local function round_decimal(n)
    return string.format("%.2f", n)
end

-- coins.coin

local function factory(args)
    local coin                  = { widget = wibox.widget.textbox() }
    local args                  = args or {}
    local prefix                = args.prefix or '$'
    local suffix                = args.suffix or ' '
    local crypto                = args.crypto or 'bitcoin'
    local timeout               = args.timeout or 60
    local na_markup             = args.na_markup or " N/A "
    local settings              = args.settings or function() end
    local api_call              = "curl -s https://api.coinmarketcap.com/v1/ticker/%s/"

    coin.widget:set_markup(na_markup)

    function coin.update()
        local cmd = string.format(api_call, crypto)
        helpers.async(cmd, function(f)
            data = tonumber(json.decode(f)[1]["price_usd"])

            if tonumber(data) ~= nil then
                if data > 1000 then
                    value = string.format("%.2fK", data/1000)
                else
                    value = string.format("%.2f", data)
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
