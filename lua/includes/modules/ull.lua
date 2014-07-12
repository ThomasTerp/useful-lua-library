---------------------------------------------------------------------------------------------------------
--Useful Lua Library (ULL)                                                                             --
--                                                                                                     --
--Made by Thomas (http://steamcommunity.com/profiles/76561197999017482/)                               --
--You can use this script in any addons without giving me credits, but don't say you made it.          --
--                                                                                                     --
--Use require("ull") in top of the file you want to use this library in, works best if file is shared. --
---------------------------------------------------------------------------------------------------------



if SERVER then
    --AddCSLuaFiles--
    
    --This file
    AddCSLuaFile()
end



--Varibles--

ULL = ULL or {}
ULL.hookFunctionsOriginal = ULL.hookFunctionsOriginal or {}
ULL.hookFunctions         = ULL.hookFunctions         or {}



--Enums--
--[[
Examples:
local vec = ULL.VECTOR.UP*5000          --Same as Vector(0, 0, 5000)
local timeLeft = ULL.TIME.MINUTE        --60 seconds
local timeLeft = ULL.TIME.MINUTE*30     --1800 seconds
gui.OpenURL(ULL.WEBSITE.STEAM)          --Will open steampowered.com in steam overlay

]]



--Info
ULL.INFO = {}
ULL.INFO.NAME           = "Useful Lua Library"
ULL.INFO.GITHUB         = "https://github.com/Thomas672/useful_lua_library/"
ULL.INFO.VERSION        = "1.11"
ULL.INFO.AUTHOR_NAME    = "Thomas"
ULL.INFO.AUTHOR_STEAMID = "STEAM_0:0:1937587"
ULL.INFO.AUTHOR_PROFILE = "http://steamcommunity.com/profiles/76561197999017482/"
ULL.INFO.AUTHOR_GITHUB  = "https://github.com/Thomas672/"

--Instances
ULL.INSTANCE = {}
ULL.INSTANCE.SHARED = 1
ULL.INSTANCE.SERVER = 2
ULL.INSTANCE.CLIENT = 3

--Hook
ULL.HOOK = {}
ULL.HOOK.NORMAL        = 1
ULL.HOOK.RUN_IF_TRUE   = 2
ULL.HOOK.IGNORE_RETURN = 3

--Colors
ULL.COLOR = {}
ULL.COLOR.BLACK  = Color(0,   0,   0  )
ULL.COLOR.WHITE  = Color(255, 255, 255)
ULL.COLOR.RED    = Color(255, 0,   0  )
ULL.COLOR.GREEN  = Color(0,   255, 0  )
ULL.COLOR.BLUE   = Color(0,   0,   255)
ULL.COLOR.YELLOW = Color(255, 0,   255)
ULL.COLOR.ORANGE = Color(255, 150, 0  )
ULL.COLOR.PURPLE = Color(255, 0,   255)

--Vectors
ULL.VECTOR = {}
ULL.VECTOR.RIGHT    = Vector(1,  0,  0 )
ULL.VECTOR.FORWARD  = Vector(0,  1,  0 )
ULL.VECTOR.UP       = Vector(0,  0,  1 )
ULL.VECTOR.LEFT     = Vector(-1, 0,  0 )
ULL.VECTOR.BACKWARD = Vector(0,  -1, 0 )
ULL.VECTOR.DOWN     = Vector(0,  0,  -1)

--Time
ULL.TIME = {}
ULL.TIME.MILLISECOND = 0.001
ULL.TIME.CENTISECOND = 0.01
ULL.TIME.DECISECOND  = 0.1
ULL.TIME.SECOND      = 1
ULL.TIME.DEKASECOND  = 10
ULL.TIME.MINUTE      = 60
ULL.TIME.HECTOSECOND = 100
ULL.TIME.KILOSECOND  = 1000
ULL.TIME.HOUR        = 3600
ULL.TIME.DAY         = 86400
ULL.TIME.WEEK        = 604800
ULL.TIME.MEGASECOND  = 1000000
ULL.TIME.MONTH       = 2.63e+6
ULL.TIME.SEASON      = 7.889e+6
ULL.TIME.YEAR        = 3.156e+7
ULL.TIME.LUSTRUM     = 1.578e+8
ULL.TIME.DECADE      = 3.156e+8
ULL.TIME.INDICATION  = 4.734e+8
ULL.TIME.JUBILEE     = 1.578e+9
ULL.TIME.CENTURY     = 3.156e+9
ULL.TIME.MILLENNIUM  = 3.156e+10
ULL.TIME.TERASECOND  = 4.3233e+11
ULL.TIME.MEGAANNUM   = 3.155693e+13

--Websites
ULL.WEBSITE = {}
ULL.WEBSITE.STEAM           = "http://store.steampowered.com/"
ULL.WEBSITE.DAYBREAKGAMING  = "http://daybreakgaming.com/"
ULL.WEBSITE.GOOGLE          = "http://www.google.com/"
ULL.WEBSITE.FACEPUNCH       = "http://facepunch.com/"
ULL.WEBSITE.FACEBOOK        = "http://facebook.com/"
ULL.WEBSITE.TWITTER         = "http://twitter.com/"
ULL.WEBSITE.YOUTUBE         = "http://youtube.com/"
ULL.WEBSITE.GITHUB          = "http://github.com/"



--Functions--

--Easier way to include files
--[[
This will take care of AddCSLuaFiling and including a file so you wont have to use more than 1 function to include a file

Use these for the instance argument:
ULL.INSTANCE.SHARED
ULL.INSTANCE.SERVER
ULL.INSTANCE.CLIENT

Example:
ULL.Include("path/to/file.lua", ULL.INSTANCE.SHARED)
]]
function ULL.Include(path, instance)
    if SERVER then
        if instance == ULL.INSTANCE.SHARED or instance == ULL.INSTANCE.CLIENT then --If the file should be added to client
            AddCSLuaFile(path)
        end
        
        if instance == ULL.INSTANCE.SHARED or instance == ULL.INSTANCE.SERVER then --If the file should be ran on server
            include(path)
        end
    end
    
    if CLIENT and (instance == ULL.INSTANCE.SHARED or instance == ULL.INSTANCE.CLIENT) then --If the file should be ran on client
        include(path)
    end
end

--Get player by steamID
function ULL.GetPlayerBySteamID(steamID)
    for k, v in pairs(player.GetHumans()) do
        if v:SteamID() == steamID then
            return v
        end
    end
    
    return NULL
end

--Get player by name
function ULL.GetPlayerByName(name)
    local foundPlayers = {}
    
    for k, v in pairs(player.GetAll()) do
        if string.find(string.lower(v:Name()), string.lower(name)) then
            table.insert(foundPlayers, v)
        end
    end
    
    return foundPlayers
end

--Creates a random color and returns it
function ULL.RandomColor()
    return Color(math.random(0, 255), math.random(0, 255), math.random(0, 255))
end

--Creates a random color with alpha and returns it
function ULL.RandomColorAlpha()
    return Color(math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255))
end

--The ultimate question of life the universe and everything
function ULL.TheUltimateQuestionOfLifeTheUniverseAndEverything()
    return 42
end

--Gets a varible by name and returns it
--[[
Examples:
local var = ULL.GetVaribleByName("hook")
local var = ULL.GetVaribleByName("hook.Add")

]]
function ULL.GetTableVarible(name)
    local var = _G
    
    for k, v in ipairs(string.Explode(".", name)) do
        if type(var) == "table" then
           var = var[v]
        end
    end
    
    return var
end

--Set a varible in a table using a string
--[[
Normally you would just do
hook.Add = function() end
but in some cases that may not be possible (like my ULL.HookFunction)

Examples:
ULL.SetTableVarible("hook.Add", function()
    print("hook.Add can no longer be used >:)")
end)

]]
function ULL.SetTableVarible(tableVar, newVar)
    local parts = string.Explode(".", tableVar)
    local var = _G
    
    for k, v in ipairs(parts) do
        if k == #parts then
            var[v] = newVar
        elseif type(var) == "table" then
            var = var[v]
        end
    end
end


--Use a function as a hook
--[[
Example:
ULL.HookFunction(print, "print_prefix", function(...)
    return "print:", ...
end)

if you do print("Hello world!") it will print this to console:
print:  Hello world!

]]
function ULL.HookFunctionAdd(funcName, uniqueName, beforeFunc, afterFunc)
    --Store function with uniqueName
    ULL.hookFunctions[funcName] = ULL.hookFunctions[funcName] or {}
    ULL.hookFunctions[funcName][uniqueName] = {
        beforeFunc = beforeFunc,
        afterFunc  = afterFunc
    }
    
    --Create hook function if it's not already made
    if not ULL.hookFunctionsOriginal[funcName] then
        local original = ULL.GetTableVarible(funcName)
        ULL.hookFunctionsOriginal[funcName] = original
        
        ULL.SetTableVarible(funcName, function(...)
            local args = {...}
            
            for k, v in pairs(ULL.hookFunctions[funcName]) do
                args = {v.beforeFunc(original, unpack(args))}
            end
            
            local values = {original(unpack(args))}
            
            for k, v in pairs(ULL.hookFunctions[funcName]) do
                if v.afterFunc then
                    v.afterFunc(original, unpack(args))
                end
            end
            
            return values
        end)
    end
end

--Remove a hook function
function ULL.HookFunctionRemove(funcName, uniqueName)
    if ULL.hookFunctions[funcName] then
        ULL.hookFunctions[funcName][uniqueName] = nil
    end
end



if SERVER then
    --Network strings--
    
    util.AddNetworkString("ULL_CLIENT_ChatAddText")
    
    
    
    --Functions--
    
    --chat.AddText() for server
    --[[
    Examples:
    ULL.ChatAddText("Send", Entity(1), Color(255, 0, 0), "Hello world!")                --Send to player 1
    ULL.ChatAddText("Send", {Entity(1), Entity(2)}, Color(255, 0, 0), "Hello world!")   --Send to more players
    ULL.ChatAddText("Broadcast", nil, Color(255, 0, 0), "Hello world!")                 --Send to everyone
    
    ]]
    function ULL.ChatAddText(sendType, players, ...)
        net.Start("ULL_CLIENT_ChatAddText")
            net.WriteTable({...})
        net[sendType](players)
    end
end



if CLIENT then
    --Networking--
    
    --Print text from ULL.ChatAddText
    net.Receive("ULL_CLIENT_ChatAddText", function(length)
        chat.AddText(unpack(net.ReadTable()))
    end)
end



--Hook call--

hook.Call("ULL.Load")
