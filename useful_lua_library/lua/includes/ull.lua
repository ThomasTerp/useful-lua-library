--[[Useful Lua Library (ULL)
Made by Thomas (http://steamcommunity.com/profiles/76561197999017482/)
You can use this script in any addons without giving me credits, but don't say you made it.
]]



----Varibles----
ULL = ULL or {}


----Enums----

--Info--
ULL.INFO = {
	name 	   = "Useful Lua Library",
	hypocorism = "ULL",
	version    = 1.0,
	
	author = {
		name 	= "Thomas",
		country = "Denmark",
		profile = "http://steamcommunity.com/profiles/76561197999017482/",
		steamID = "STEAM_0:0:19375877",
	},
}

--Instances--
ULL.INSTANCE = {}
ULL.INSTANCE.SHARED = 1
ULL.INSTANCE.SERVER = 2
ULL.INSTANCE.CLIENT = 3

--Colors--
ULL.COLOR = {}
ULL.COLOR.BLACK  = Color(0,   0,   0)
ULL.COLOR.WHITE  = Color(255, 255, 255)
ULL.COLOR.RED    = Color(255, 0,   0)
ULL.COLOR.GREEN  = Color(0,   255, 0)
ULL.COLOR.BLUE   = Color(0,   0,   255)
ULL.COLOR.YELLOW = Color(255, 0,   255)
ULL.COLOR.ORANGE = Color(255, 150, 0)
ULL.COLOR.PURPLE = Color(255, 0,   255)

--Vectors--
ULL.VECTOR = {}
ULL.VECTOR.RIGHT 	= Vector(1,  0,  0)
ULL.VECTOR.FORWARD 	= Vector(0,  1,  0)
ULL.VECTOR.UP 		= Vector(0,  0,  1)
ULL.VECTOR.LEFT 	= Vector(-1, 0,  0)
ULL.VECTOR.BACKWARD = Vector(0,  -1, 0)
ULL.VECTOR.DOWN 	= Vector(0,  0,  -1)

--Time--
ULL.TIME = {}
ULL.TIME.MILLISECOND = 0.001
ULL.TIME.CENTISECOND = 0.01
ULL.TIME.DECISECOND	 = 0.1
ULL.TIME.SECOND		 = 1
ULL.TIME.DEKASECOND	 = 10
ULL.TIME.MINUTE		 = 60
ULL.TIME.HECTOSECOND = 100
ULL.TIME.KILOSECOND	 = 1000
ULL.TIME.HOUR		 = 3600
ULL.TIME.DAY		 = 86400
ULL.TIME.WEEK		 = 604800
ULL.TIME.MEGASECOND	 = 1000000
ULL.TIME.MONTH		 = 2.63e+6
ULL.TIME.SEASON		 = 7.889e+6
ULL.TIME.YEAR		 = 3.156e+7
ULL.TIME.LUSTRUM	 = 1.578e+8
ULL.TIME.DECADE		 = 3.156e+8
ULL.TIME.INDICATION	 = 4.734e+8
ULL.TIME.JUBILEE	 = 1.578e+9
ULL.TIME.CENTURY	 = 3.156e+9
ULL.TIME.MILLENNIUM	 = 3.156e+10
ULL.TIME.TERASECOND	 = 4.3233e+11
ULL.TIME.MEGAANNUM	 = 3.155693e+13

--Websites--
ULL.WEBSITE = {}
ULL.WEBSITE.STEAM			= "http://store.steampowered.com/"
ULL.WEBSITE.FACEPUNCH		= "http://facepunch.com/"
ULL.WEBSITE.GOOGLE			= "http://www.google.com/"
ULL.WEBSITE.DAYBREAKGAMING	= "http://daybreakgaming.com/"
ULL.WEBSITE.FACEBOOK		= "http://facebook.com/"
ULL.WEBSITE.TWITTER			= "http://twitter.com/"
ULL.WEBSITE.YOUTUBE			= "http://youtube.com/"


----Functions----

--Misc--

--[[Easier way to include files
This will take care of AddCSLuaFiling and including a file so you wont have to use more than 1 function to include a file

use these for the instance argument:
ULL.INSTANCE.SHARED
ULL.INSTANCE.SERVER
ULL.INSTANCE.CLIENT
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

--Find player by steamID
function ULL.GetPlayerBySteamID(steamID)
	for k, v in pairs(player.GetHumans()) do
		if v:SteamID() == steamID then
			return v
		end
	end
	
	return NULL
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
		port 	 = 0,
		
		OnConnected = function(mySQL)
			
		end,
	}
	
	WARNING: This function is unfinished
	]]
	function ULL.MySQL(...)
		require("mysqloo")
		
		local mySQL = {}
		local arg = ...
		
		mySQL.quene			  = {}
		mySQL.firstConnection = true
		mySQL.OnConnected 	  = arg.OnConnected
		mySQL.connectionInfo  = {
			hostname = arg.hostname,
			username = arg.username,
			password = arg.password,
			database = arg.database,
			port	 = arg.port,
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
	/*
	
	Examples:
	ULL.ChatAddText("Send", Entity(1), Color(255, 0, 0), "Hello world!") 				--Send to player 1
	ULL.ChatAddText("Send", {Entity(1), Entity(2)}, Color(255, 0, 0), "Hello world!") 	--Send to more players
	ULL.ChatAddText("Broadcast", nil, Color(255, 0, 0), "Hello world!") 				--Send to everyone
	
	*/
	function ULL.ChatAddText(sendType, players, ...)
		net.Start("ULL_CLIENT_ChatAddText")
			net.WriteTable(...)
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