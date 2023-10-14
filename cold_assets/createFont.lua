
local CACHE_FONTS = {}

function createFont(section, fontType, fontSize)
    local nameInTable = fontType..fontSize
    if section and fontType and fontSize then
        if not CACHE_FONTS[section] then CACHE_FONTS[section] = {} end
        if not CACHE_FONTS[section][nameInTable] then 
            CACHE_FONTS[section][nameInTable] = {} 
            CACHE_FONTS[section][nameInTable] = dxCreateFont(":cold_assets/fonts/"..section.."/"..fontType..".ttf", fontSize, false, "default")
        end
    end
    return CACHE_FONTS[section][nameInTable]
end