--[[Useful Lua Library (ULL)
Made by Thomas (http://steamcommunity.com/profiles/76561197999017482/)
You can use this script in any addons without giving me credits, but don't say you made it.

Use require("ull") in top of the file you want to use this library in, works best if file is shared.
]]

----AddCSLuaFiles----
if SERVER then
    --This file
    AddCSLuaFile()
end


----Varibles----
ULL = ULL or {}
ULL.hookFunctionsOriginal = ULL.hookFunctionsOriginal or {}
ULL.hookFunctions         = ULL.hookFunctions         or {}

----Enums----
--[[
Examples:
local vec = ULL.VECTOR.UP*5000          --Same as Vector(0, 0, 5000)
local timeLeft = ULL.TIME.MINUTE        --60 seconds
local timeLeft = ULL.TIME.MINUTE*30     --1800 seconds
gui.OpenURL(ULL.WEBSITE.STEAM)          --Will open steampowered.com in steam overlay

]]

--Info--
ULL.INFO = {}
ULL.INFO.NAME           = "Useful Lua Library"
ULL.INFO.GITHUB         = "https://github.com/Thomas672/useful_lua_library/"
ULL.INFO.VERSION        = "1.11"
ULL.INFO.AUTHOR_NAME    = "Thomas"
ULL.INFO.AUTHOR_STEAMID = "STEAM_0:0:1937587"
ULL.INFO.AUTHOR_PROFILE = "http://steamcommunity.com/profiles/76561197999017482/"
ULL.INFO.AUTHOR_GITHUB  = "https://github.com/Thomas672/"

--Instances--
ULL.INSTANCE = {}
ULL.INSTANCE.SHARED = 1
ULL.INSTANCE.SERVER = 2
ULL.INSTANCE.CLIENT = 3

--Hook--
ULL.HOOK = {}
ULL.HOOK.NORMAL        = 1
ULL.HOOK.RUN_IF_TRUE   = 2
ULL.HOOK.IGNORE_RETURN = 3

--Colors--
ULL.COLOR = {}
ULL.COLOR.BLACK  = Color(0,   0,   0  )
ULL.COLOR.WHITE  = Color(255, 255, 255)
ULL.COLOR.RED    = Color(255, 0,   0  )
ULL.COLOR.GREEN  = Color(0,   255, 0  )
ULL.COLOR.BLUE   = Color(0,   0,   255)
ULL.COLOR.YELLOW = Color(255, 0,   255)
ULL.COLOR.ORANGE = Color(255, 150, 0  )
ULL.COLOR.PURPLE = Color(255, 0,   255)

--Vectors--
ULL.VECTOR = {}
ULL.VECTOR.RIGHT    = Vector(1,  0,  0 )
ULL.VECTOR.FORWARD  = Vector(0,  1,  0 )
ULL.VECTOR.UP       = Vector(0,  0,  1 )
ULL.VECTOR.LEFT     = Vector(-1, 0,  0 )
ULL.VECTOR.BACKWARD = Vector(0,  -1, 0 )
ULL.VECTOR.DOWN     = Vector(0,  0,  -1)

--Time--
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

--Websites--
ULL.WEBSITE = {}
ULL.WEBSITE.STEAM           = "http://store.steampowered.com/"
ULL.WEBSITE.DAYBREAKGAMING  = "http://daybreakgaming.com/"
ULL.WEBSITE.GOOGLE          = "http://www.google.com/"
ULL.WEBSITE.FACEPUNCH       = "http://facepunch.com/"
ULL.WEBSITE.FACEBOOK        = "http://facebook.com/"
ULL.WEBSITE.TWITTER         = "http://twitter.com/"
ULL.WEBSITE.YOUTUBE         = "http://youtube.com/"
ULL.WEBSITE.GITHUB          = "http://github.com/"


----Functions----

--Misc--

--[[Easier way to include files
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

--[[Gets a varible by name and returns it

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

--[[Set a varible in a table using a string

normally you would just do
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


--[[Use a function as a hook

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



--Hook--
--[[ULL.hooksRunIfTrue    = {}
ULL.hooksIgnoreReturn = {}

ULL.HookFunction("hook.Call", "ULL.HookAdd", function(original, ...)
    local args = {...}
    local hookName = args[1]
    local gm = args[2]
    table.remove(args, 1)
    table.remove(args, 1)
    
    if ULL.hooksRunIfTrue[name] then
        for k, v in pairs(ULL.hooksRunIfTrue[name]) do
            if args[1] then
                v(unpack(args))
            end
        end
    end
    
    return original(...)
end)

function ULL.HookAdd(hookName, name, mode, func)
    if mode == ULL.HOOK.NORMAL then
        
        --Works exactly like hook.Add
        hook.Add(hookName, name, func)
        
    elseif mode == ULL.HOOK.RUN_IF_TRUE then
        
        --Store function in ULL.hooksRunIfTrue
        ULL.hooksRunIfTrue[hookName] = ULL.hooksRunIfTrue[hookName] or {}
        ULL.hooksRunIfTrue[hookName][name] = func
        
    elseif mode == ULL.HOOK.IGNORE_RETURN then
        
        --Store function in ULL.hooksIgnoreReturn
        ULL.hooksIgnoreReturn[hookName] = ULL.hooksIgnoreReturn[hookName] or {}
        ULL.hooksIgnoreReturn[hookName][name] = func
        
    end
end

function ULL.HookAdd(hookName, name, mode)
    if mode == ULL.HOOK.NORMAL then
        
        --Works exactly like hook.Remove
        hook.Remove(hookName, name)
        
    elseif mode == ULL.HOOK.RUN_IF_TRUE then
        
        --Remove function in ULL.hooksRunIfTrue
        if ULL.hooksRunIfTrue[hookName] then
            ULL.hooksRunIfTrue[hookName][name] = nil
        end
        
    elseif mode == ULL.HOOK.IGNORE_RETURN then
        
        --Remove function in ULL.hooksIgnoreReturn
        if ULL.hooksIgnoreReturn[hookName] then
            ULL.hooksIgnoreReturn[hookName][name] = nil
        end
        
    end
end
]]


if SERVER then
    
    ----Network strings----
    util.AddNetworkString("ULL_CLIENT_ChatAddText")
    
    
    ----Functions----
    
    --[[Returns a object to use for MySQL
    
    template:
    local mySQL = ULL.MySQL{
        hostname = "",
        username = "",
        password = "",
        database = "",
        port     = 0,
        
        OnConnected = function(mySQL)
            
        end,
    }
    
    WARNING: This function is unfinished
    ]]
    function ULL.MySQL(...)
        require("mysqloo")
        
        local mySQL = {}
        local arg = ...
        
        mySQL.quene           = {}
        mySQL.firstConnection = true
        mySQL.OnConnected     = arg.OnConnected
        mySQL.connectionInfo  = {
            hostname = arg.hostname,
            username = arg.username,
            password = arg.password,
            database = arg.database,
            port     = arg.port,
        }
        
        --Connect
        mySQL.connection = mysqloo.connect(
            mySQL.connectionInfo.hostname,
            mySQL.connectionInfo.username,
            mySQL.connectionInfo.password,
            mySQL.connectionInfo.database,
            mySQL.connectionInfo.port
        )
        
        function mySQL.connection:onConnected()
            ServerLog("Connection to database \""..mySQL.connectionInfo.database.."\" succeed!")
            
            if mySQL.firstConnection then
                mySQL.firstConnection = false
                
                --Run OnConnected hook
                if mySQL.OnConnected then
                    mySQL.OnConnected(mySQL)
                end
            end
            
            --Run queries in queue
            for k, v in pairs(mySQL.queue) do
                mySQL.Query(self, v.sql, v.callback)
            end
            
            --Clear quene
            mySQL.queue = {}
        end
         
        function mySQL.connection:onConnectionFailed(err)
            ServerLog("Connection to database \""..mySQL.connectionInfo.database.."\" failed!\n    [ERROR] "..err)
        end
        
        function mySQL.Query(sql, callback)
            local query = mySQL.connection:query(sql)
            
            --If query failed
            if !query then
                --Add query to quene
                table.insert(mySQL.queue, {
                    sql = sql,
                    callback = callback
                })
                
                --Connect again
                mySQL.connection:connect()
                
                return
            end
            
            if callback then
                --onSuccess hook
                function query:onSuccess(data)
                    callback(data)
                end
            end
            
            function query:onError(err)
                if mySQL.connection:status() == mysqloo.DATABASE_NOT_CONNECTED then
                    --Add query to quene
                    table.insert(mySQL.queue, {
                        sql = sql,
                        callback = callback
                    })
                    
                    --Connect again
                    mySQL.connection:connect()
                    
                    return
                end
                
                ServerLog("Query on database \""..mySQL.connectionInfo.database.."\" failed!\n    [ERROR] "..err.."\n    [SQL] "..sql)
            end

            query:start()
        end
        
        mySQL.connection:connect()
        
        return mySQL
    end
    
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
    ----Networking----
    net.Receive("ULL_CLIENT_ChatAddText", function(length)
        chat.AddText(unpack(net.ReadTable()))
    end)
end


----Hook call----
hook.Call("ULL.Load")