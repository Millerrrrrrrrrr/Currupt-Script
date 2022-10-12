--[[
--WE HAVE TAKEN OVER░ \☻/\☻/--
--░░░░░░░░░░░░░░░░░░░▌░ ▌--
--░░░░░░░░░░░░░░░░░░ / \░ / \--
--░░░░░░░░░░░░░░░░░███████ ]▄▄▄▄▄▄▄▄▄-----------●--
--░░░░░░░░░░░░▂▄▅█████████▅▄▃▂
--░░░░░░░░░░░I███████████████████].--
]]
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if Meteor then
	menu.notify("The Script is already loaded!", "Initialization Cancelled", 12, 211)
	return
end

if not menu.is_trusted_mode_enabled(1 << 2) then
	menu.notify("This Script requires Natives Trusted Mode to be executed!", "Initialization Cancelled", 12, 211) 
	return
end

if not menu.is_trusted_mode_enabled(1 << 3) then
	menu.notify("This Script requires HTTP Trusted Mode to be executed!", "Initialization Cancelled", 12, 211) 
	return
end

local require_files = {"Meteor/Lib/Utils", "Meteor/Lib/Menyoo", "Meteor/Lib/Natives", "Meteor/Lib/Script_Func", "Meteor/Lib/Text_Func", "Meteor/Lib/Player_Func", "Meteor/Data/ModderFlags", "Meteor/Mapper/NetEventIDs", "Meteor/Mapper/NetEventNames", "Meteor/Mapper/NetEventNames", "Meteor/Mapper/ObjectModels", "Meteor/Mapper/PedModels", "Meteor/Mapper/VehicleModels", "Meteor/SafeMode", "Meteor/Data/DataMain", "Meteor/Data/Settings"}

local utilities = require("Meteor/Lib/Utils")
local xml_handler = require("Meteor/Lib/Menyoo")
local natives = require("Meteor/Lib/Natives")
local script_func = require("Meteor/Lib/Script_Func")
local text_func = require("Meteor/Lib/Text_Func")
local memory = require("Meteor/Lib/Memory")
local player_func = require("Meteor/Lib/Player_Func")
local custommodderflags = require("Meteor/Data/ModderFlags")
local NetEventID = require("Meteor/Mapper/NetEventIDs")
local NetEventName = require("Meteor/Mapper/NetEventNames")
local UserNetEventName = require("Meteor/Mapper/UserNetEventNames")
local ObjectModel = require("Meteor/Mapper/ObjectModels")
local PedModel = require("Meteor/Mapper/PedModels")
local VehicleModel = require("Meteor/Mapper/VehicleModels")
local LaunchInSafeMode = require("Meteor/SafeMode")
local DataMain = require("Meteor/Data/DataMain")
local settings = require("Meteor/Data/Settings")

for i = 1, #require_files do
	if not require(require_files[i]) then
		menu.notify("Missing Or Broken Library: " .. require_files[i], "Initialization Cancelled", 8, 211) 
		return
	end
end

Meteor = "Meteor v1.6.0"
MeteorVer = "1.6.0"

do
	if not utils.dir_exists(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\Logs") then
		utils.make_dir(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\Logs")
	end
	if not utils.dir_exists(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\Logs\\Chat") then
		utils.make_dir(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\Logs\\Chat")
	end
	if not utils.dir_exists(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\Logs\\NetEvents") then
		utils.make_dir(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\Logs\\NetEvents")
	end
	if not utils.dir_exists(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\Logs\\ScriptEvents") then
		utils.make_dir(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\Logs\\ScriptEvents")
	end
	if not utils.dir_exists(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\Menyoo Vehicles") then
		utils.make_dir(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\Menyoo Vehicles")
	end
	if not utils.dir_exists(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\GIF") then
		utils.make_dir(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\GIF")
	end
	if not utils.dir_exists(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\Settings Profiles") then
		utils.make_dir(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\Settings Profiles")
	end
	if not utils.dir_exists(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\Settings Profiles\\Load") then
		utils.make_dir(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\Settings Profiles\\Load")
	end
	if not utils.file_exists(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\Settings Profiles\\Default.ini") then
		text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", "") .. "\\Default.ini", "w"), "")
	end
	if not utils.dir_exists(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\Data") then
		utils.make_dir(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\Data")
	end
	if not utils.file_exists(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\Data\\NoFlyZones.txt") then
		text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Data\\", "") .. "\\NoFlyZones.txt", "w"), "")
	end
	if not utils.file_exists(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\Data\\CustomLocations.txt") then
		text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Data\\", "") .. "\\CustomLocations.txt", "w"), "")
	end
end

local all_settings = {
	"» Clumsy",
	"» Auto Resurrect",
	"» Demi Passive Mode",
	"» Dragon Breath",
	"» Fire Wings",
	"» Auto Recharge Bar",
	"» Sparks",
	"» Sparks Gun Effects",
	"» Flames",
	"» Flames Gun Effects",
	"» Rapid Fire",
	"» Flamethrower",
	"» Mine Impact Gun",
	"» Delete Gun",
	"» Nuke Gun",
	"» Airstrike Gun",
	"» Smoke Bomb Gun",
	"» Hands Up",
	"» Shoot Weapon Objects",
	"» Shoot Custom Objects",
	"» Shoot Fake Money Bags",
	"» Shoot Stones",
	"» Shoot Dogshit",
	"» Shoot Missiles",
	"» Rope Gun",
	"» 40.000 KW Basskanone",
	"» Call Kamikaze Attack",
	"» Prevent Helmet Removal",
	"» Lock Outfit By File",
	"» Notify Session Host Migrations",
	"» Notify Script Host Migrations",
	"» Notify Typing Players",
	"» Guided Missile Tracker",
	"» Kill Tracker",
	"» Vpn/Proxy Player Check",
	"» Remember Players",
	"» Anti Crash Cam",
	"» Log Session Chat",
	"» Log Session Change",
	"» Translate Chat Messages",
	"» Notify Sent Messages",
	"» Uwu-Ify Chat Messages",
	"» Session Chat Flooder",
	"» Chat Command veh <model> <max> <god>",
	"» Chat Command crash <name>",
	"» Chat Command kick <name>",
	"» Chat Command bounty <name> <amount>",
	"» Chat Command perico <name>",
	"» Chat Command otr <name>",
	"» Player Info Tab",
	"» Tab 1 X Position",
	"» Tab 2 X Position",
	"» Tab 1 Y Position",
	"» Tab 2 Y Position",
	"» Tab 1 Alpha",
	"» Tab 2 Alpha",
	"» Russian Roulette",
	"» Random Player",
	"» Auto Force Session Host",
	"» Auto Force Script Host",
	"» Block Join Requests",
	"» Hide Session",
	"» Disable Recording",
	"» Local Time",
	"» Freeze Time",
	"» Time Cycle",
	"» Override Weather",
	"» Change Weather",
	"» Override Cloud Hat",
	"» Change Cloud Hat",
	"» Auto Godmode Remover",
	"» Notify Orbital Cannon Room Events",
	"» Aim Response Crash",
	"» Aim Response Kick",
	"» Aim Response Freeze",
	"» Aim Response Send To Cayo",
	"» Aim Response Transaction Error",
	"» Aim Response Explode Named",
	"» Aim Response Explode Anonymous",
	"» Aim Response Taze",
	"» Remove Player Target Restrictions",
	"» Remove Cutscenes",
	"» Disable Weapons",
	"» For Players In Range",
	"» Anti Barcode Shitter",
	"» Anti Chat Spam",
	"» Anti Ur Mom",
	"» Anti Oppressor Mk2",
	"» Anti Pussy Cannon",
	"» Anti Explosive Sniper",
	"» Anti East Ukraine",
	"» Anti West Taiwan",
	"» Anti Level 8000",
	"» Anti Down Syndrome",
	"» Anti Submarine Missile",
	"» Auto Kick All Modders",
	"» Exclude Yourself From No Fly Zones",
	"» Exclude Friends From No Fly Zones",
	"» Bouncy Vehicles",
	"» Zero Gravity Vehicles",
	"» Reduce Vehicle Grip",
	"» Out Of Control",
	"» Frodo In Da Hood",
	"» Clumsy Peds",
	"» Petrol Leaking Vehicles",
	"» Ped Scream",
	"» Pedestrian Horn Boost",
	"» City Riot",
	"» Launch Random Vehicles",
	"» Rockstar Chat Global",
	"» Rockstar Chat Team",
	"» Spawn Custom Entity",
	"» Enable Spectator Chat",
	"» Instant Respawn",
	"» Display OS Time",
	"» Freecam Hide HUD",
	"» Draw Line",
	"» Freecam Speed",
	"» Quick Entity Actions",
	"» Entity Debug Info",
	"» No Entity Collision",
	"» Disable Vehicle Spawning",
	"» Disable Ped Spawning",
	"» Nearby Peds Godmode",
	"» Nearby Vehicles Godmode",
	"» Lock All Vehicle Doors",
	"» Train Key Control",
	"» RGB Neons",
	"» Vehicle Godmode",
	"» Heli Blades Speed",
	"» Remove Plane Turbulence",
	"» Infinite Rocket Boost",
	"» Set Rocket Boost Refill Time",
	"» Toggle Rocket Boost",
	"» Reduce Grip",
	"» Bouncy Vehicle",
	"» Extra Airplane Bombs",
	"» Spawn Inside Vehicle",
	"» Forward Vector Offset",
	"» Always Spawn Maxed",
	"» Spawn In Air",
	"» Small Boost",
	"» Vehicle Fly",
	"» Demolition Boost",
	"» Better Barrage",
	"» Static Horn Boost",
	"» Attach Front Ramp",
	"» Auto Modify Vehicle Speed",
	"» Bypass Parachute Restrictions",
	"» Activate Parachute",
	"» Low Pitch Warning",
	"» High Bank Angle Warning",
	"» Engine Warning",
	"» Fire Warning",
	"» Stall Warning",
	"» Terrain Warning",
	"» Collision Notify",
	"» Runway Tracker",
	"» Information Display",
	"» Air Traffic",
	"» Bail To Singleplayer",
	"» Invalid SCID Detection",
	"» Modded Health Detection",
	"» Godmode Detection",
	"» Invalid Name Detection",
	"» Invalid IP Detection",
	"» Bad Net Event Detection",
	"» Bad Script Event Detection",
	"» Stand User Detection",
	"» Max Speed Bypass Detection",
	"» Invalid Stats Detection",
	"» Bad Outfit Data Detection",
	"» Altered Script Host Migration Detection",
	"» Modded Spectate Detection",
	"» Modded OTR Detection",
	"» Bad Parachute Model Detection",
	"» Modded Explosion Detection",
	"» Uh Oh Spaghetti O's Detection",
	"» Modded Vehicle Modification Detection",
	"» Scripted Entity Spawn Detection",
	"» No Ragdoll Detection",
	"» Anti AFK Bypass Detection",
	"» Teleportation Detection",
	"» Super Run Detection",
	"» Lobby Spoof Detection",
	"» Exclude Friends From Detections",
	"» Exclude Whitelisted Players From Detections",
	"» Auto Waypoint Tp",
	"» Display Welcome Screen",
	"» Header Height Offset",
	"» Header Alpha",
	"» Header Playback Speed",
	"» Downgrade To Standard",
	"» Chat Command Prefix"
}

for i = 0, 75 do
	table.insert(all_settings, "» Auto Kick Modder " .. i)
end

for i = 0, 87 do
	table.insert(all_settings, "» Net Event Responses " .. i)
end

for i = 1, 50 do
	table.insert(all_settings, "» Header Gif Packs " .. i)
end

local meteor_session_timer = utils.time_ms()
local altered_sh_migration_detection_timer = utils.time_ms()
local altered_sh_migration_detection_timer_left_player = utils.time_ms()
local did_someone_type = false

local player_feat_ids = {}
local meteor_entities = {}
local ptfxs = {}
local threads = {}
local feature = {}
local localparents = {}
local playerparents = {}
local listeners = {}
local eventhooks = {}

local IsPlayerDead = {}
local IsPlayerAlive = {}
local HasBeenTyping = {}
local HasNotBeenTyping = {}
local FakeTypingBegin = {}
local FakeTypingStop = {}
local IsInOrbitalCannonRoom = {}
local IsNotInOrbitalCannonRoom = {}
local IsCallingAnOrbitalStrike = {}
local IsNotCallingAnOrbitalStrike = {}
local IsOTRFor = {}
local SentXMessagesInTheLast5Seconds = {}

local InvalidSCIDDetectionPlayer = {}
local ModdedHealthDetectionPlayer = {}
local GodmodeDetectionPlayer = {}
local InvalidNameDetectionPlayer = {}
local InvalidIPDetectionPlayer = {}
local StandUserDetectionPlayer = {}
local MaxSpeedBypassDetectionPlayer = {}
local InvalidStatsDetectionPlayer = {}
local SessionHostCrashDetectionPlayer = {}
local BadOutfitDataDetectionPlayer = {}
local FakeTypingIndicatorDetectionPlayer = {}
local ModdedSpectateDetectionPlayer = {}
local ModdedOTRDetectionPlayer = {}
local BadParachuteModelDetectionPlayer = {}
local InvalidMovementDetectionPlayer = {}
local InvalidEntitySpawnDetectionPlayer = {}
local NoRagdollDetectionPlayer = {}
local SuperRunDetectionPlayer = {}
local LobbySpoofDetectionPlayer = {}

local SessionBrokenAlteredSHQueue = false
local SessionBrokenBadScriptEvent = false
local SessionBrokenAlteredSHMigration = false
local SessionBrokenModifiedEntityState = false
local SessionBrokenOutOfRangeWorldRender = false
local InvalidPickupPlacement = false
local SessionBrokenGameServerModify = false
local SessionBrokenModifiedWeather = false

local ChatCommandPrefix = settings["» Chat Command Prefix"].Value or "!"

if eventhooks["» Main Script Event Hook"] == nil then
	eventhooks["» Main Script Event Hook"] = hook.register_script_event_hook(function(source, target, params, count)
		for i = 1, #params do
			params[i] = params[i] & 0xFFFFFFFF
		end
		if params[1] == 1695663635 or params[1] == 522189882 then
			SessionBrokenBadScriptEvent = true
		end
	end)
end

if eventhooks["» Main Net Event Hook"] == nil then
	eventhooks["» Main Net Event Hook"] = hook.register_net_event_hook(function(source, target, eventId)
		if eventId == NetEventID["SCRIPT_ENTITY_STATE_CHANGE_EVENT"] or eventId == NetEventID["PED_PLAY_PAIN_EVENT"] then
			SessionBrokenModifiedEntityState = true
		end
		if eventId == NetEventID["GAME_CLOCK_EVENT"] or eventId == NetEventID["GAME_WEATHER_EVENT"] then
			SessionBrokenModifiedWeather = true
		end
		if eventId == NetEventID["GIVE_PICKUP_REWARDS_EVENT"] or eventId == NetEventID["REPORT_CASH_SPAWN_EVENT"] then
			InvalidPickupPlacement = true
		end
		if eventId == NetEventID["NETWORK_CHECK_EXE_SIZE_EVENT"] or eventId == NetEventID["NETWORK_CHECK_CODE_CRCS_EVENT"] or eventId == NetEventID["NETWORK_CHECK_CATALOG_CRC"] then
			SessionBrokenGameServerModify = true
		end
	end)
end

if listeners["» Main Player Leave Event Listener"] == nil then
	listeners["» Main Player Leave Event Listener"] = event.add_event_listener("player_leave", function(left_player)
		altered_sh_migration_detection_timer_left_player = utils.time_ms() + 8000
		local my_pid = player.player_id()
		if left_player.player == my_pid then
			meteor_session_timer = utils.time_ms() + 15000
			did_someone_type = false
			SessionBrokenAlteredSHQueue = false
			SessionBrokenMissingScriptHost = false
			SessionBrokenBadScriptEvent = false
			SessionBrokenAlteredSHMigration = false
			SessionBrokenModifiedEntityState = false
			SessionBrokenOutOfRangeWorldRender = false
			InvalidPickupPlacement = false
			SessionBrokenGameServerModify = false
			SessionBrokenModifiedWeather = false
			if feature["» Holy $1B Pickup"] then
				menu.delete_feature(feature["» Holy $1B Pickup"].id)
			end
			if feature["» Create Money Pickup"] then
				menu.delete_feature(feature["» Create Money Pickup"].id)
			end
			if feature["» Money Pickup Loop"] then
				menu.delete_feature(feature["» Money Pickup Loop"].id)
			end
			if feature["» Real Money Gun"] then
				menu.delete_feature(feature["» Real Money Gun"].id)
			end
			for i = 0, 31 do
				if meteor_entities["Player Target Ped " .. i] ~= nil and meteor_entities["Player Target Vehicle " .. i] ~= nil then
					entity.delete_entity(meteor_entities["Player Target Ped " .. i])
					entity.delete_entity(meteor_entities["Player Target Vehicle " .. i])
					meteor_entities["Player Target Ped " .. i] = nil
					meteor_entities["Player Target Vehicle " .. i] = nil
				end
			end
			my_pid = player.player_id()
		end
		InvalidSCIDDetectionPlayer[left_player.player] = false
		ModdedHealthDetectionPlayer[left_player.player] = false
		GodmodeDetectionPlayer[left_player.player] = false
		InvalidNameDetectionPlayer[left_player.player] = false
		InvalidIPDetectionPlayer[left_player.player] = false
		StandUserDetectionPlayer[left_player.player] = false
		MaxSpeedBypassDetectionPlayer[left_player.player] = false
		InvalidStatsDetectionPlayer[left_player.player] = false
		SessionHostCrashDetectionPlayer[left_player.player] = false
		BadOutfitDataDetectionPlayer[left_player.player] = false
		FakeTypingIndicatorDetectionPlayer[left_player.player] = false
		ModdedSpectateDetectionPlayer[left_player.player] = false
		ModdedOTRDetectionPlayer[left_player.player] = false
		BadParachuteModelDetectionPlayer[left_player.player] = false
		InvalidMovementDetectionPlayer[left_player.player] = false
		InvalidEntitySpawnDetectionPlayer[left_player.player] = false
		NoRagdollDetectionPlayer[left_player.player] = false
		SuperRunDetectionPlayer[left_player.player] = false
		LobbySpoofDetectionPlayer[left_player.player] = false
		IsOTRFor[left_player.player] = 0
		if eventhooks["» Log Script Events " .. left_player.player] then
			hook.remove_script_event_hook(eventhooks["» Log Script Events " .. left_player.player])
			eventhooks["» Log Script Events " .. left_player.player] = nil
		end
		if eventhooks["» Log Net Events " .. left_player.player] then
			hook.remove_net_event_hook(eventhooks["» Log Net Events " .. left_player.player])
			eventhooks["» Log Net Events " .. left_player.player] = nil
		end
		if meteor_entities["Player Target Ped " .. left_player.player] ~= nil and meteor_entities["Player Target Vehicle " .. left_player.player] ~= nil then
			entity.delete_entity(meteor_entities["Player Target Ped " .. left_player.player])
			entity.delete_entity(meteor_entities["Player Target Vehicle " .. left_player.player])
			meteor_entities["Player Target Ped " .. left_player.player] = nil
			meteor_entities["Player Target Vehicle " .. left_player.player] = nil
		end
		if orbital_cannon_room_blocking_object then
			network.request_control_of_entity(orbital_cannon_room_blocking_object)
			entity.delete_entity(orbital_cannon_room_blocking_object)
			orbital_cannon_room_blocking_object = nil
		end
	end)
end

if listeners["» Main Player Join Event Listener"] == nil then
	listeners["» Main Player Join Event Listener"] = event.add_event_listener("player_join", function(joined_player)
		if joined_player.player == player.player_id() then
			meteor_session_timer = utils.time_ms() + 15000
			did_someone_type = false
			SessionBrokenAlteredSHQueue = false
			SessionBrokenMissingScriptHost = false
			SessionBrokenBadScriptEvent = false
			SessionBrokenAlteredSHMigration = false
			SessionBrokenModifiedEntityState = false
			SessionBrokenOutOfRangeWorldRender = false
			InvalidPickupPlacement = false
			SessionBrokenGameServerModify = false
			SessionBrokenModifiedWeather = false
			if feature["» Holy $1B Pickup"] then
				menu.delete_feature(feature["» Holy $1B Pickup"].id)
			end
			if feature["» Create Money Pickup"] then
				menu.delete_feature(feature["» Create Money Pickup"].id)
			end
			if feature["» Money Pickup Loop"] then
				menu.delete_feature(feature["» Money Pickup Loop"].id)
			end
			if feature["» Real Money Gun"] then
				menu.delete_feature(feature["» Real Money Gun"].id)
			end
		else
			meteor_session_timer = utils.time_ms() + 4000
		end
		if joined_player.player == player.player_id() then
			altered_sh_migration_detection_timer = utils.time_ms() + 8000
		end
		if player.is_player_valid(joined_player.player) then
			if not string.find(player.get_player_name(joined_player.player), "|") then
				if joined_player.player ~= player.player_id() then
					local params_string = ""
					local os_year = os.date("*t").year
					if os_year < 10 then
						os_year = "0" .. os_year .. ""
					end
					local os_month = os.date("*t").month
					if os_month < 10 then
						os_month = "0" .. os_month .. ""
					end
					local os_day = os.date("*t").day
					if os_day < 10 then
						os_day = "0" .. os_day .. ""
					end
					local os_hour = os.date("*t").hour
					if os_hour < 10 then
						os_hour = "0" .. os_hour .. ""
					end
					local os_min = os.date("*t").min
					if os_min < 10 then
						os_min = "0" .. os_min .. ""
					end
					local os_sec = os.date("*t").sec
					if os_sec < 10 then
						os_sec = "0" .. os_sec .. ""
					end
					local time_prefix = "" .. os_year .. "-" .. os_month .. "-" .. os_day .. " " .. os_hour .. ":" .. os_min .. ":" .. os_sec .. ""
					text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\Data\\", "") .. "\\LoggedPlayers.log", "w"), "")
					text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\Data\\", "") .. "\\LoggedPlayers.log", "a"), "" .. time_prefix .. "||" .. player.get_player_name(joined_player.player) .. "||" .. player.get_player_scid(joined_player.player) .. "||" .. player.get_player_ip(joined_player.player) .. "\n")
				end
			end
		end
		if player.is_player_valid(joined_player.player) then
			if joined_player.player ~= player.player_id() and not string.find(player.get_player_name(joined_player.player), "|") then
				text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\Data\\", "") .. "\\RememberedPlayers.log", "a"), "" .. player.get_player_name(joined_player.player) .. "|" .. player.get_player_scid(joined_player.player) .. "|" .. player.get_player_ip(joined_player.player) .. "|" .. network.network_hash_from_player(joined_player.player) .. "\n")
			end
		end
	end)
end

localparents["» Currupt Meteor"] = menu.add_feature("» Currupt Meteor", "parent", 0).id

localparents["» Lobby"] = menu.add_feature("» Lobby", "parent", localparents["» Currupt Meteor"])
localparents["» Chat Options"] = menu.add_feature("» Chat Options", "parent", localparents["» Currupt Meteor"])
localparents["» General"] = menu.add_feature("» General", "parent", localparents["» Currupt Meteor"])
localparents["» Vehicle Options"] = menu.add_feature("» Vehicle Options", "parent", localparents["» Currupt Meteor"])
localparents["» Modder Detections"] = menu.add_feature("» Modder Detections", "parent", localparents["» Currupt Meteor"])
localparents["» Math Crash Lobby"] = menu.add_feature("» Math Crash Lobby", "parent", localparents["» Currupt Meteor"])



playerparents["» Crashes And Kicks"] = menu.add_player_feature("» Currupt Crashes And Kicks", "parent", playerparents["» Crashes And Kicks"]).id
playerparents["» Currupt Meteor"] = menu.add_player_feature("» Currupt Meteor", "parent", 0).id


playerparents["» Script Events"] = menu.add_player_feature("» Script Events", "parent", playerparents["» Currupt Meteor"]).id
playerparents["» Trolling"] = menu.add_player_feature("» Trolling", "parent", playerparents["» Currupt Meteor"]).id
playerparents["» Friendly"] = menu.add_player_feature("» Friendly", "parent", playerparents["» Currupt Meteor"]).id
playerparents["» Modder Info"] = menu.add_player_feature("» Modder Info", "parent", playerparents["» Currupt Meteor"]).id
playerparents["» Vehicle Options"] = menu.add_player_feature("» Vehicle Options", "parent", playerparents["» Currupt Meteor"]).id




menu.add_player_feature("» Electrocute Player", "action", playerparents["» Trolling"], function(f, pid)
	gameplay.shoot_single_bullet_between_coords(player.get_player_coords(pid) + v3(0, 0, 2), player.get_player_coords(pid), 0, gameplay.get_hash_key("weapon_stungun"), player.get_player_ped(player.player_id()), true, false, 10000)
end)

menu.add_player_feature("» Specialist For Warehouse Logistics Logistician", "action", playerparents["» Trolling"], function(f, pid)
	for i = 1, 40 do
		utilities.request_model(757019157)
		local object_ = object.create_object(757019157, player.get_player_coords(pid) + v3(math.random(-3, 3), math.random(-3, 3), math.random(5, 10)), true, true)
		utilities.request_control_silent(object_)
		entity.apply_force_to_entity(object_, 3, 0, 0, -0.1, 0.0, 0.0, 0.0, true, true)
	end
	utilities.request_model(1491375716)
	local vehicle_ = vehicle.create_vehicle(1491375716, player.get_player_coords(pid) + v3(0, 0, 10), 0, true, false)
	utilities.request_control_silent(vehicle_)
	entity.apply_force_to_entity(vehicle_, 3, 0, 0, -0.1, 0.0, 0.0, 0.0, true, true)
end)

menu.add_player_feature("» Atomize", "action", playerparents["» Trolling"], function(f, pid)
	for i = 1, 30 do
		fire.add_explosion(player.get_player_coords(pid) + v3(math.random(-2, 2), math.random(-2, 2), math.random(-2, 2)), 70, true, false, 0.2, player.get_player_ped(pid))
		system.wait(math.random(0, 1))
	end
end)

menu.add_player_feature("» Earrape Player", "action", playerparents["» Trolling"], function(f, pid)
	for i = 0, 100 do
		audio.play_sound_from_coord(-1, "BED", player.get_player_coords(pid), "WASTEDSOUNDS", true, 20, false)
	end
end)

menu.add_player_feature("» Send To Gas Chamber", "action", playerparents["» Trolling"], function(f, pid)
    menu.create_thread(function()
        ped.clear_ped_tasks_immediately(player.get_player_ped(pid))
        local object_ = object.create_object(959275690, player.get_player_coords(pid) - v3(0, 0, 0.5), true, false)
        fire.add_explosion(player.get_player_coords(pid), 21, true, false, 0, pid)
        fire.add_explosion(player.get_player_coords(pid), 21, true, false, 0, pid)
        fire.add_explosion(player.get_player_coords(pid), 21, true, false, 0, pid)
		fire.add_explosion(player.get_player_coords(pid), 21, true, false, 0, pid)
        fire.add_explosion(player.get_player_coords(pid), 21, true, false, 0, pid)
        system.wait(14000)
        entity.delete_entity(object_)
    end, nil)
end)

menu.add_player_feature("» Kamikaze Attack", "action", playerparents["» Trolling"], function(f, pid)
	utilities.request_model(0xE75B4B1C)
	utilities.request_model(0xC5DD6967)
	threads["» Kamikaze Attack"] = menu.create_thread(function()
		local vehicle_ = vehicle.create_vehicle(0xC5DD6967, player.get_player_coords(pid) + v3(math.random(-50, 50), math.random(-50, 50), math.random(30, 50)), 0, true, false)
		local ped_ = ped.create_ped(1, 0xE75B4B1C, player.get_player_coords(pid) + v3(math.random(-50, 50), math.random(-50, 50), math.random(50, 100)), 0, true, false)
		system.wait(10)
		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
		ped.set_ped_into_vehicle(ped_, vehicle_, -1)
		vehicle.control_landing_gear(vehicle_, 3)
		entity.set_entity_rotation(vehicle_, utilities.pos_to_rot(vehicle_, player.get_player_coords(pid)))
		system.wait(10)
		vehicle.set_vehicle_forward_speed(vehicle_, 60.0)
		system.wait(5000)
		utilities.hard_remove_entity(vehicle_)
		streaming.set_model_as_no_longer_needed(0xC5DD6967)
		streaming.set_model_as_no_longer_needed(0xE75B4B1C)
	end, nil)
end)

menu.add_player_feature("» Make Area Foggy", "toggle", playerparents["» Trolling"], function(f, pid)
	if f.on then
		graphics.set_next_ptfx_asset("core")
		while not graphics.has_named_ptfx_asset_loaded("core") do
			graphics.request_named_ptfx_asset("core")
			system.wait(0)
		end
		if meteor_entities["» Make Area Foggy 1"] == nil then
			meteor_entities["» Make Area Foggy 1"] = utilities.spawn_object(1803116220, player.get_player_coords(player.player_id()) + v3(0, 0, -1))
			entity.set_entity_collision(meteor_entities["» Make Area Foggy 1"], false, false, false)
			entity.set_entity_visible(meteor_entities["» Make Area Foggy 1"], false)
			streaming.set_model_as_no_longer_needed(1803116220)
		end
		if ptfxs["» Make Area Foggy 1"] == nil then
			ptfxs["» Make Area Foggy 1"] = graphics.start_networked_ptfx_looped_on_entity("exp_grd_grenade_smoke", meteor_entities["» Make Area Foggy 1"], v3(), v3(), 10)
			graphics.set_ptfx_looped_scale(ptfxs["» Make Area Foggy 1"], 6)
			while f.on do
				system.yield(0)
				utilities.set_entity_coords(meteor_entities["» Make Area Foggy 1"], player.get_player_coords(pid) + v3(0, 0, -1))
			end
		end
		if meteor_entities["» Make Area Foggy 2"] == nil then
			meteor_entities["» Make Area Foggy 2"] = utilities.spawn_object(1803116220, player.get_player_coords(player.player_id()) + v3(0, 0, -1))
			entity.set_entity_collision(meteor_entities["» Make Area Foggy 2"], false, false, false)
			entity.set_entity_visible(meteor_entities["» Make Area Foggy 2"], false)
			streaming.set_model_as_no_longer_needed(1803116220)
		end
		if ptfxs["» Make Area Foggy 2"] == nil then
			ptfxs["» Make Area Foggy 2"] = graphics.start_networked_ptfx_looped_on_entity("exp_grd_grenade_smoke", meteor_entities["» Make Area Foggy 2"], v3(), v3(), 8)
			graphics.set_ptfx_looped_scale(ptfxs["» Make Area Foggy 2"], 6)
			while f.on do
				system.yield(0)
				utilities.set_entity_coords(meteor_entities["» Make Area Foggy 2"], player.get_player_coords(pid) + v3(0, 0, -1))
			end
		end
		if meteor_entities["» Make Area Foggy 3"] == nil then
			meteor_entities["» Make Area Foggy 3"] = utilities.spawn_object(1803116220, player.get_player_coords(player.player_id()) + v3(0, 0, -1))
			entity.set_entity_collision(meteor_entities["» Make Area Foggy 3"], false, false, false)
			entity.set_entity_visible(meteor_entities["» Make Area Foggy 3"], false)
			streaming.set_model_as_no_longer_needed(1803116220)
		end
		if ptfxs["» Make Area Foggy 3"] == nil then
			ptfxs["» Make Area Foggy 3"] = graphics.start_networked_ptfx_looped_on_entity("exp_grd_grenade_smoke", meteor_entities["» Make Area Foggy 3"], v3(), v3(), 6)
			graphics.set_ptfx_looped_scale(ptfxs["» Make Area Foggy 3"], 6)
			while f.on do
				system.yield(0)
				utilities.set_entity_coords(meteor_entities["» Make Area Foggy 3"], player.get_player_coords(pid) + v3(0, 0, -1))
			end
		end
		if meteor_entities["» Make Area Foggy 4"] == nil then
			meteor_entities["» Make Area Foggy 4"] = utilities.spawn_object(1803116220, player.get_player_coords(player.player_id()) + v3(0, 0, -1))
			entity.set_entity_collision(meteor_entities["» Make Area Foggy 4"], false, false, false)
			entity.set_entity_visible(meteor_entities["» Make Area Foggy 4"], false)
			streaming.set_model_as_no_longer_needed(1803116220)
		end
		if ptfxs["» Make Area Foggy 4"] == nil then
			ptfxs["» Make Area Foggy 4"] = graphics.start_networked_ptfx_looped_on_entity("exp_grd_grenade_smoke", meteor_entities["» Make Area Foggy 4"], v3(), v3(), 9)
			graphics.set_ptfx_looped_scale(ptfxs["» Make Area Foggy 4"], 6)
			while f.on do
				system.yield(0)
				utilities.set_entity_coords(meteor_entities["» Make Area Foggy 4"], player.get_player_coords(pid) + v3(0, 0, -1))
			end
		end
		if meteor_entities["» Make Area Foggy 5"] == nil then
			meteor_entities["» Make Area Foggy 5"] = utilities.spawn_object(1803116220, player.get_player_coords(player.player_id()) + v3(0, 0, -1))
			entity.set_entity_collision(meteor_entities["» Make Area Foggy 5"], false, false, false)
			entity.set_entity_visible(meteor_entities["» Make Area Foggy 5"], false)
			streaming.set_model_as_no_longer_needed(1803116220)
		end
		if ptfxs["» Make Area Foggy 5"] == nil then
			ptfxs["» Make Area Foggy 5"] = graphics.start_networked_ptfx_looped_on_entity("exp_grd_grenade_smoke", meteor_entities["» Make Area Foggy 5"], v3(), v3(), 7)
			graphics.set_ptfx_looped_scale(ptfxs["» Make Area Foggy 5"], 6)
			while f.on do
				system.yield(0)
				utilities.set_entity_coords(meteor_entities["» Make Area Foggy 5"], player.get_player_coords(pid) + v3(0, 0, -1))
			end
		end
		if meteor_entities["» Make Area Foggy 6"] == nil then
			meteor_entities["» Make Area Foggy 6"] = utilities.spawn_object(1803116220, player.get_player_coords(player.player_id()) + v3(0, 0, -1))
			entity.set_entity_collision(meteor_entities["» Make Area Foggy 6"], false, false, false)
			entity.set_entity_visible(meteor_entities["» Make Area Foggy 6"], false)
			streaming.set_model_as_no_longer_needed(1803116220)
		end
		if ptfxs["» Make Area Foggy 6"] == nil then
			ptfxs["» Make Area Foggy 6"] = graphics.start_networked_ptfx_looped_on_entity("exp_grd_grenade_smoke", meteor_entities["» Make Area Foggy 6"], v3(), v3(), 5)
			graphics.set_ptfx_looped_scale(ptfxs["» Make Area Foggy 6"], 6)
			while f.on do
				system.yield(0)
				utilities.set_entity_coords(meteor_entities["» Make Area Foggy 6"], player.get_player_coords(pid) + v3(0, 0, -1))
			end
		end
	end
	if not f.on then
		if ptfxs["» Make Area Foggy 1"] then
			utilities.clear_ptfx(meteor_entities["» Make Area Foggy 1"])
			meteor_entities["» Make Area Foggy 1"] = nil
			utilities.clear_ptfx(meteor_entities["» Make Area Foggy 2"])
			meteor_entities["» Make Area Foggy 2"] = nil
			utilities.clear_ptfx(meteor_entities["» Make Area Foggy 3"])
			meteor_entities["» Make Area Foggy 3"] = nil
			utilities.clear_ptfx(meteor_entities["» Make Area Foggy 4"])
			meteor_entities["» Make Area Foggy 4"] = nil
			utilities.clear_ptfx(meteor_entities["» Make Area Foggy 5"])
			meteor_entities["» Make Area Foggy 5"] = nil
			utilities.clear_ptfx(meteor_entities["» Make Area Foggy 6"])
			meteor_entities["» Make Area Foggy 6"] = nil
			ptfxs["» Make Area Foggy 1"] = nil
			ptfxs["» Make Area Foggy 2"] = nil
			ptfxs["» Make Area Foggy 3"] = nil
			ptfxs["» Make Area Foggy 4"] = nil
			ptfxs["» Make Area Foggy 5"] = nil
			ptfxs["» Make Area Foggy 6"] = nil
			graphics.remove_named_ptfx_asset("core")
		end
	end
end)

menu.add_player_feature("» Make Nearby Peds Hostile", "toggle", playerparents["» Trolling"], function(f, pid)
	while f.on do
		system.yield(500)
		local peds = utilities.get_table_of_entities(ped.get_all_peds(), 25, 100, true, true, player.get_player_coords(pid))
    	for i = 1, #peds do
			ped.set_ped_combat_ability(peds[i], 2)
			ped.set_ped_combat_attributes(peds[i], 5, true)
			ai.task_combat_ped(peds[i], player.get_player_ped(pid), 0, 16)
    	end
	end
end)

playerparents["» Sounds"] = menu.add_player_feature("» Sounds", "parent", playerparents["» Trolling"]).id

menu.add_player_feature("» Hack Success", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "Hack_Success", player.get_player_coords(pid), "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true, 2, false)
end)

menu.add_player_feature("» Hack Fail", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "Hack_Failed", player.get_player_coords(pid), "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true, 2, false)
end)

menu.add_player_feature("» Rip Car", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "FAMILY_1_CAR_BREAKDOWN", player.get_player_coords(pid), "FAMILY1_BOAT", true, 2, false)
end)

menu.add_player_feature("» Hammer Slam", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "Drill_Pin_Break", player.get_player_coords(pid), "DLC_HEIST_FLEECA_SOUNDSET", true, 2, false)
end)

menu.add_player_feature("» Baritone Saxophone", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "Horn", player.get_player_coords(pid), "DLC_Apt_Yacht_Ambient_Soundset", true, 2, false)
end)

menu.add_player_feature("» Rank Up", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "MP_RANK_UP", player.get_player_coords(pid), "HUD_FRONTEND_DEFAULT_SOUNDSET", true, 2, false)
end)

menu.add_player_feature("» Cash Pickup", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", player.get_player_coords(pid), "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true, 2, false)
end)

menu.add_player_feature("» Camera Shutter", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "SHUTTER_FLASH", player.get_player_coords(pid), "CAMERA_FLASH_SOUNDSET", true, 2, false)
end)

menu.add_player_feature("» Menu Accept", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "Menu_Accept", player.get_player_coords(pid), "Phone_SoundSet_Default", true, 2, false)
end)

menu.add_player_feature("» Alert Sound", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "Out_Of_Bounds_Timer", player.get_player_coords(pid), "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true, 2, false)
end)

menu.add_player_feature("» Race Checkpoint", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "CHECKPOINT_AHEAD", player.get_player_coords(pid), "HUD_MINI_GAME_SOUNDSET", true, 2, false)
end)

menu.add_player_feature("» Walkie-Talkie", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "Start_Squelch", player.get_player_coords(pid), "CB_RADIO_SFX", true, 2, false)
end)

menu.add_player_feature("» Pickup", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "Bus_Schedule_Pickup", player.get_player_coords(pid), "DLC_PRISON_BREAK_HEIST_SOUNDS", true, 2, false)
end)

menu.add_player_feature("» Fast Beeping", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "Beep_Red", player.get_player_coords(pid), "DLC_HEIST_HACKING_SNAKE_SOUNDS", true, 2, false)
end)

menu.add_player_feature("» Notification", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "CHALLENGE_UNLOCKED", player.get_player_coords(pid), "HUD_AWARDS", true, 2, false)
end)

menu.add_player_feature("» Focus In", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "FocusIn", player.get_player_coords(pid), "HintCamSounds", true, 2, false)
end)

menu.add_player_feature("» Stunt Jump", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "LOSER", player.get_player_coords(pid), "HUD_AWARDS", true, 2, false)
end)

menu.add_player_feature("» Air Defenses Off", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "Air_Defenses_Disabled", player.get_player_coords(pid), "DLC_sum20_Business_Battle_AC_Sounds", true, 2, false)
end)

menu.add_player_feature("» Air Defenses On", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "Air_Defences_Activated", player.get_player_coords(pid), "DLC_sum20_Business_Battle_AC_Sounds", true, 2, false)
end)

menu.add_player_feature("» Phone Select", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "YES", player.get_player_coords(pid), "HUD_FRONTEND_DEFAULT_SOUNDSET", true, 2, false)
end)

menu.add_player_feature("» Metal Detector Sounds", "action_value_str", playerparents["» Sounds"], function(f, pid)
    if f.value == 0 then
		audio.play_sound_from_coord(-1, "Metal_Detector_Small_Guns", player.get_player_coords(pid), "dlc_ch_heist_finale_security_alarms_sounds", true, 2, false)
    elseif f.value == 1 then
		audio.play_sound_from_coord(-1, "Metal_Detector_Big_Guns", player.get_player_coords(pid), "dlc_ch_heist_finale_security_alarms_sounds", true, 2, false)
    end
end):set_str_data({
	"Small Weps",
	"Big Weps"
})

menu.add_player_feature("» Fast Beep Loop", "toggle", playerparents["» Sounds"], function(f, pid)
	while f.on do
		audio.play_sound_from_coord(-1, "Beep_Red", player.get_player_coords(pid), "DLC_HEIST_HACKING_SNAKE_SOUNDS", true, 2, false)
		system.wait(0)
	end
end)

menu.add_player_feature("» Click Loop", "toggle", playerparents["» Sounds"], function(f, pid)
	while f.on do
		audio.play_sound_from_coord(-1, "Click_Special", player.get_player_coords(pid), "WEB_NAVIGATION_SOUNDS_PHONE", true, 2, false)
		system.wait(150)
	end
end)

menu.add_player_feature("» Bari Sax Loop", "toggle", playerparents["» Sounds"], function(f, pid)
	while f.on do
		audio.play_sound_from_coord(-1, "Horn", player.get_player_coords(pid), "DLC_Apt_Yacht_Ambient_Soundset", true, 2, false)
		system.wait(0)
	end
end)

playerparents["» Fake Pickup Drops"] = menu.add_player_feature("» Fake Pickup Drops", "parent", playerparents["» Trolling"]).id

menu.add_player_feature("» Fake Money Bag Drop", "toggle", playerparents["» Fake Pickup Drops"], function(f, pid)
	while f.on do
		system.yield(60)
		threads["» Fake Money Bag Drop"] = menu.create_thread(function()
			local object_ = object.create_object(2628187989, player.get_player_coords(pid) + v3(math.random(-2, 2) / 10, math.random(-2, 2) / 10, math.random(13, 14) / 10), true, true)
			entity.apply_force_to_entity(object_, 3, 0, 0, -0.5, 0.0, 0.0, 0.0, true, true)
			while f.on do
				system.yield(10)
				for pid = 0, 31 do
					if utilities.get_distance_between(player.get_player_ped(pid), object_) < 1.2 then
						audio.play_sound_from_coord(-1, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", entity.get_entity_coords(object_), "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true, 2, false)
						utilities.request_control_silent(object_)
						entity.delete_entity(object_)
					end
				end
			end
			system.wait(2000)
			entity.delete_entity(object_)
		end, nil)
	end
	if not f.on then
		if threads["» Fake Money Bag Drop"] then
			menu.delete_thread(threads["» Fake Money Bag Drop"])
		end
	end
end)

menu.add_player_feature("» Drop Fake Money Bag", "action", playerparents["» Fake Pickup Drops"], function(f, pid)
	threads["» Drop Fake Money Bag 1"] = menu.create_thread(function()
		local object_ = object.create_object(2628187989, player.get_player_coords(pid) + v3(0, 0, 1.5), true, true)
		entity.apply_force_to_entity(object_, 3, 0, 0, -0.5, 0.0, 0.0, 0.0, true, true)
		threads["» Drop Fake Money Bag 2"] = menu.create_thread(function()
			while Meteor do
				system.yield(10)
				for pid = 0, 31 do
					if utilities.get_distance_between(player.get_player_ped(pid), object_) < 1.2 then
						audio.play_sound_from_coord(-1, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", entity.get_entity_coords(object_), "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true, 2, false)
						utilities.request_control_silent(object_)
						entity.delete_entity(object_)
					end
				end
			end
		end, nil)
		system.wait(10000)
		entity.delete_entity(object_)
	end, nil)
	if not f.on then
		if threads["» Drop Fake Money Bag 2"] then
			menu.delete_thread(threads["» Drop Fake Money Bag 2"])
		end
		if threads["» Drop Fake Money Bag 1"] then
			menu.delete_thread(threads["» Drop Fake Money Bag 1"])
		end
	end
end)

menu.add_player_feature("» Fake RP Drop", "toggle", playerparents["» Fake Pickup Drops"], function(f, pid)
	while f.on do
		system.yield(60)
		threads["» Fake RP Drop"] = menu.create_thread(function()
			local random_hash = 1298470051
			local random_int = math.random(1, 8)
			if random_int == 1 then
				random_hash = 1298470051
			elseif random_int == 2 then
				random_hash = 1955543594
			elseif random_int == 3 then
				random_hash = 446117594
			elseif random_int == 4 then
				random_hash = 1025210927
			elseif random_int == 5 then
				random_hash = 437412629
			elseif random_int == 6 then
				random_hash = 3644302825
			elseif random_int == 7 then
				random_hash = 601745115
			elseif random_int == 8 then
				random_hash = 2568981558
			end
			local object_ = object.create_object(random_hash, player.get_player_coords(pid) + v3(math.random(-2, 2) / 10, math.random(-2, 2) / 10, math.random(13, 14) / 10), true, true)
			entity.apply_force_to_entity(object_, 3, 0, 0, -0.5, 0.0, 0.0, 0.0, true, true)
			while f.on do
				system.yield(10)
				for pid = 0, 31 do
					if utilities.get_distance_between(player.get_player_ped(pid), object_) < 1.2 then
						audio.play_sound_from_coord(-1, "Bus_Schedule_Pickup", entity.get_entity_coords(object_), "DLC_PRISON_BREAK_HEIST_SOUNDS", true, 2, false)
						utilities.request_control_silent(object_)
						entity.delete_entity(object_)
					end
				end
			end
			system.wait(2000)
			entity.delete_entity(object_)
		end, nil)
	end
	if not f.on then
		if threads["» Fake RP Drop"] then
			menu.delete_thread(threads["» Fake RP Drop"])
		end
	end
end)

menu.add_player_feature("» Drop Fake RP", "action", playerparents["» Fake Pickup Drops"], function(f, pid)
	threads["» Drop Fake RP 1"] = menu.create_thread(function()
		local random_hash
		local random_int = math.random(1, 8)
		if random_int == 1 then
			random_hash = 1298470051
		elseif random_int == 2 then
			random_hash = 1955543594
		elseif random_int == 3 then
			random_hash = 446117594
		elseif random_int == 4 then
			random_hash = 1025210927
		elseif random_int == 5 then
			random_hash = 437412629
		elseif random_int == 6 then
			random_hash = 3644302825
		elseif random_int == 7 then
			random_hash = 601745115
		elseif random_int == 8 then
			random_hash = 2568981558
		end
		local object_ = object.create_object(random_hash, player.get_player_coords(pid) + v3(0, 0, 1.5), true, true)
		entity.apply_force_to_entity(object_, 3, 0, 0, -0.5, 0.0, 0.0, 0.0, true, true)
		threads["» Drop Fake RP 2"] = menu.create_thread(function()
			while Meteor do
				system.yield(10)
				for pid = 0, 31 do
					if utilities.get_distance_between(player.get_player_ped(pid), object_) < 1.2 then
						audio.play_sound_from_coord(-1, "Bus_Schedule_Pickup", entity.get_entity_coords(object_), "DLC_PRISON_BREAK_HEIST_SOUNDS", true, 2, false)
						utilities.request_control_silent(object_)
						entity.delete_entity(object_)
					end
				end
			end
		end, nil)
		system.wait(10000)
		entity.delete_entity(object_)
	end, nil)
	if not f.on then
		if threads["» Drop Fake RP 2"] then
			menu.delete_thread(threads["» Drop Fake RP 2"])
		end
		if threads["» Drop Fake RP 1"] then
			menu.delete_thread(threads["» Drop Fake RP 1"])
		end
	end
end)

menu.add_player_feature("» Fake Health Drop", "toggle", playerparents["» Fake Pickup Drops"], function(f, pid)
	while f.on do
		system.yield(60)
		threads["» Fake Health Drop"] = menu.create_thread(function()
			local object_ = object.create_object(678958360, player.get_player_coords(pid) + v3(math.random(-2, 2) / 10, math.random(-2, 2) / 10, math.random(13, 14) / 10), true, true)
			entity.apply_force_to_entity(object_, 3, 0, 0, -0.5, 0.0, 0.0, 0.0, true, true)
			while f.on do
				system.yield(10)
				for pid = 0, 31 do
					if utilities.get_distance_between(player.get_player_ped(pid), object_) < 1.2 and player.get_player_health(pid) < player.get_player_max_health(pid) then
						audio.play_sound_from_coord(-1, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", entity.get_entity_coords(object_), "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true, 2, false)
						utilities.request_control_silent(object_)
						entity.delete_entity(object_)
					end
				end
			end
			system.wait(2000)
			entity.delete_entity(object_)
		end, nil)
	end
	if not f.on then
		if threads["» Fake Health Drop"] then
			menu.delete_thread(threads["» Fake Health Drop"])
		end
	end
end)

menu.add_player_feature("» Drop Fake Health", "action", playerparents["» Fake Pickup Drops"], function(f, pid)
	threads["» Drop Fake Health 1"] = menu.create_thread(function()
		local object_ = object.create_object(678958360, player.get_player_coords(pid) + v3(0, 0, 1.5), true, true)
		entity.apply_force_to_entity(object_, 3, 0, 0, -0.5, 0.0, 0.0, 0.0, true, true)
		threads["» Drop Fake Health 2"] = menu.create_thread(function()
			while Meteor do
				system.yield(10)
				for pid = 0, 31 do
					if utilities.get_distance_between(player.get_player_ped(pid), object_) < 1.2 and player.get_player_health(pid) < player.get_player_max_health(pid) then
						audio.play_sound_from_coord(-1, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", entity.get_entity_coords(object_), "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true, 2, false)
						utilities.request_control_silent(object_)
						entity.delete_entity(object_)
					end
				end
			end
		end, nil)
		system.wait(10000)
		entity.delete_entity(object_)
	end, nil)
	if not f.on then
		if threads["» Drop Fake Health 2"] then
			menu.delete_thread(threads["» Drop Fake Health 2"])
		end
		if threads["» Drop Fake Health 1"] then
			menu.delete_thread(threads["» Drop Fake Health 1"])
		end
	end
end)

menu.add_player_feature("» Fake Armor Drop", "toggle", playerparents["» Fake Pickup Drops"], function(f, pid)
	while f.on do
		system.yield(60)
		threads["» Fake Armor Drop"] = menu.create_thread(function()
			local object_ = object.create_object(701173564, player.get_player_coords(pid) + v3(math.random(-2, 2) / 10, math.random(-2, 2) / 10, math.random(13, 14) / 10), true, true)
			entity.apply_force_to_entity(object_, 3, 0, 0, -0.5, 0.0, 0.0, 0.0, true, true)
			while f.on do
				system.yield(10)
				for pid = 0, 31 do
					if utilities.get_distance_between(player.get_player_ped(pid), object_) < 1.2 and player.get_player_armour(pid) < 50 then
						audio.play_sound_from_coord(-1, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", entity.get_entity_coords(object_), "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true, 2, false)
						utilities.request_control_silent(object_)
						entity.delete_entity(object_)
					end
				end
			end
			system.wait(2000)
			entity.delete_entity(object_)
		end, nil)
	end
	if not f.on then
		if threads["» Fake Armor Drop"] then
			menu.delete_thread(threads["» Fake Armor Drop"])
		end
	end
end)

menu.add_player_feature("» Drop Fake Armor", "action", playerparents["» Fake Pickup Drops"], function(f, pid)
	threads["» Drop Fake Armor 1"] = menu.create_thread(function()
		local object_ = object.create_object(701173564, player.get_player_coords(pid) + v3(0, 0, 1.5), true, true)
		entity.apply_force_to_entity(object_, 3, 0, 0, -0.5, 0.0, 0.0, 0.0, true, true)
		threads["» Drop Fake Armor 2"] = menu.create_thread(function()
			while Meteor do
				system.yield(10)
				for pid = 0, 31 do
					if utilities.get_distance_between(player.get_player_ped(pid), object_) < 1.2 and player.get_player_armour(pid) < 50 then
						audio.play_sound_from_coord(-1, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", entity.get_entity_coords(object_), "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true, 2, false)
						utilities.request_control_silent(object_)
						entity.delete_entity(object_)
					end
				end
			end
		end, nil)
		system.wait(10000)
		entity.delete_entity(object_)
	end, nil)
	if not f.on then
		if threads["» Drop Fake Armor 2"] then
			menu.delete_thread(threads["» Drop Fake Armor 2"])
		end
		if threads["» Drop Fake Armor 1"] then
			menu.delete_thread(threads["» Drop Fake Armor 1"])
		end
	end
end)

menu.add_player_feature("» Fake P's & Q's Drop", "toggle", playerparents["» Fake Pickup Drops"], function(f, pid)
	while f.on do
		system.yield(60)
		threads["» Fake P's & Q's Drop"] = menu.create_thread(function()
			local object_ = object.create_object(1374501775, player.get_player_coords(pid) + v3(math.random(-2, 2) / 10, math.random(-2, 2) / 10, math.random(13, 14) / 10), true, true)
			entity.apply_force_to_entity(object_, 3, 0, 0, -0.5, 0.0, 0.0, 0.0, true, true)
			while f.on do
				system.yield(10)
				for pid = 0, 31 do
					if utilities.get_distance_between(player.get_player_ped(pid), object_) < 1.2 then
						audio.play_sound_from_coord(-1, "PICKUP_WEAPON_SMOKEGRENADE", entity.get_entity_coords(object_), "HUD_FRONTEND_WEAPONS_PICKUPS_SOUNDSET", true, 2, false)
						utilities.request_control_silent(object_)
						entity.delete_entity(object_)
					end
				end
			end
			system.wait(2000)
			entity.delete_entity(object_)
		end, nil)
	end
	if not f.on then
		if threads["» Fake P's & Q's Drop"] then
			menu.delete_thread(threads["» Fake P's & Q's Drop"])
		end
	end
end)

menu.add_player_feature("» Drop Fake P's & Q's", "action", playerparents["» Fake Pickup Drops"], function(f, pid)
	threads["» Drop Fake P's & Q's 1"] = menu.create_thread(function()
		local object_ = object.create_object(1374501775, player.get_player_coords(pid) + v3(0, 0, 1.5), true, true)
		entity.apply_force_to_entity(object_, 3, 0, 0, -0.5, 0.0, 0.0, 0.0, true, true)
		threads["» Drop Fake P's & Q's 2"] = menu.create_thread(function()
			while Meteor do
				system.yield(10)
				for pid = 0, 31 do
					if utilities.get_distance_between(player.get_player_ped(pid), object_) < 1.2 then
						audio.play_sound_from_coord(-1, "PICKUP_WEAPON_SMOKEGRENADE", entity.get_entity_coords(object_), "HUD_FRONTEND_WEAPONS_PICKUPS_SOUNDSET", true, 2, false)
						utilities.request_control_silent(object_)
						entity.delete_entity(object_)
					end
				end
			end
		end, nil)
		system.wait(10000)
		entity.delete_entity(object_)
	end, nil)
	if not f.on then
		if threads["» Drop Fake P's & Q's 2"] then
			menu.delete_thread(threads["» Drop Fake P's & Q's 2"])
		end
		if threads["» Drop Fake P's & Q's 1"] then
			menu.delete_thread(threads["» Drop Fake P's & Q's 1"])
		end
	end
end)


menu.add_player_feature("» Give All Weapons", "action", playerparents["» Friendly"], function(f, pid)
	for i = 1, #DataMain.all_weapon_hashes do
		weapon.give_delayed_weapon_to_ped(player.get_player_ped(pid), DataMain.all_weapon_hashes[i], 0, false)
		weapon.set_ped_ammo(player.get_player_ped(pid), DataMain.all_weapon_hashes[i], select(2, weapon.get_max_ammo(player.get_player_ped(pid), DataMain.all_weapon_hashes[i])))
	end
end)

menu.add_player_feature("» Give Collectibles", "action_value_str", playerparents["» Friendly"], function(f, pid)
    if f.value == 0 then
        for i = 0, 9 do
            script.trigger_script_event(995853474, pid, {1, 0, i, 1, 1, 1})
            script.trigger_script_event(995853474, pid, {1, 1, i, 1, 1, 1})
            script.trigger_script_event(995853474, pid, {1, 3, i, 1, 1, 1})
            script.trigger_script_event(995853474, pid, {1, 6, i, 1, 1, 1})
        end
        for i = 0, 19 do
            script.trigger_script_event(995853474, pid, {1, 4, i, 1, 1, 1})
        end
        script.trigger_script_event(995853474, pid, {1, 2, 0, 1, 1, 1})
        script.trigger_script_event(995853474, pid, {1, 2, 1, 1, 1, 1})
        script.trigger_script_event(995853474, pid, {1, 5, 0, 1, 1, 1})
    elseif f.value == 1 then
        for i = 0, 9 do
            script.trigger_script_event(995853474, pid, {1, 0, i, 1, 1, 1})
        end
    elseif f.value == 2 then
        for i = 0, 9 do
            script.trigger_script_event(995853474, pid, {1, 1, i, 1, 1, 1})
        end
    elseif f.value == 3 then
        script.trigger_script_event(995853474, pid, {1, 2, 0, 1, 1, 1})
        script.trigger_script_event(995853474, pid, {1, 2, 1, 1, 1, 1})
    elseif f.value == 4 then
        for i = 0, 9 do
            script.trigger_script_event(995853474, pid, {1, 3, i, 1, 1, 1})
        end
    elseif f.value == 5 then
        for i = 0, 19 do
            script.trigger_script_event(995853474, pid, {1, 4, i, 1, 1, 1})
        end
    elseif f.value == 6 then
        script.trigger_script_event(995853474, pid, {1, 5, 0, 1, 1, 1})
    elseif f.value == 7 then
        for i = 0, 9 do
            script.trigger_script_event(995853474, pid, {1, 6, i, 1, 1, 1})
        end
    end
end):set_str_data({"All", "Movie Props", "Hidden Caches", "Treasure Chests", "Radio Antennas", "Media USBs", "Shipwrecks", "Burried Stashes"})

menu.add_player_feature("» Send SMS", "action", playerparents["» Friendly"], function(f, pid)
	local input_stat, input_val = input.get("Enter SMS String", "", 999, 0)
    if input_stat == 1 then
        return HANDLER_CONTINUE
    end
    if input_stat == 2 then
        return HANDLER_POP
    end

	if player.is_player_valid(pid) then
		player.send_player_sms(pid, input_val)
	end
end)

menu.add_player_feature("» Money Yoinker", "toggle", playerparents["» Friendly"], function(f, pid)
	while f.on do
		system.yield(0)
		if not player_func.is_player_in_interior(player.player_id()) then
			local pickups = object.get_all_pickups()
			system.wait(10)
			for i = 1, #pickups do
				if entity.get_entity_model_hash(pickups[i]) == 3999186071 or entity.get_entity_model_hash(pickups[i]) == 289396019 or entity.get_entity_model_hash(pickups[i]) == 2628187989 then
					network.request_control_of_entity(pickups[i])
					entity.set_entity_coords_no_offset(pickups[i], player.get_player_coords(pid))
				end
			end
		end
	end
end)

menu.add_player_feature("» Bulletproof", "toggle", playerparents["» Friendly"], function(f, pid)
	if f.on then
		while f.on do
			system.yield(0)
			if meteor_entities["» Bulletproof " .. pid] == nil then
				utilities.request_model(148511758)
				meteor_entities["» Bulletproof " .. pid] = object.create_object(148511758, player.get_player_coords(pid), true, false)
				utilities.request_control_silent(meteor_entities["» Bulletproof " .. pid])
			end
			entity.set_entity_visible(meteor_entities["» Bulletproof " .. pid], false)
			entity.set_entity_god_mode(meteor_entities["» Bulletproof " .. pid], true)
			entity.set_entity_collision(meteor_entities["» Bulletproof " .. pid], false, false, false)
			entity.set_entity_coords_no_offset(meteor_entities["» Bulletproof " .. pid], player.get_player_coords(pid))
			if not player.is_player_valid(pid) then
				if meteor_entities["» Bulletproof " .. pid] and entity.is_an_entity(meteor_entities["» Bulletproof " .. pid]) then
					utilities.request_control_silent(meteor_entities["» Bulletproof " .. pid])
					utilities.hard_remove_entity(meteor_entities["» Bulletproof " .. pid])
					meteor_entities["» Bulletproof " .. pid] = nil
				end
			end
		end
	end
	if not f.on then
		if meteor_entities["» Bulletproof " .. pid] then
			utilities.request_control_silent(meteor_entities["» Bulletproof " .. pid])
			utilities.hard_remove_entity(meteor_entities["» Bulletproof " .. pid])
			meteor_entities["» Bulletproof " .. pid] = nil
		end
	end
end)

menu.add_player_feature("» Ceo Money Loop", "value_str", playerparents["» Friendly"], function(f, pid)
	if f.on then
		if f.value == 0 then
			script.trigger_script_event(0x70AB59D5, pid, {pid, 10000, -1292453789, 0, script_func.get_global_main(pid), script_func.get_global_9(), script_func.get_global_10()})
			system.wait(120100)
		elseif f.value == 1 then
			script.trigger_script_event(0x70AB59D5, pid, {pid, 10000, -1292453789, 1, script_func.get_global_main(pid), script_func.get_global_9(), script_func.get_global_10()})
			system.wait(60100)
		elseif f.value == 2 then
			script.trigger_script_event(0x70AB59D5, pid, {pid, 30000, 198210293, 1, script_func.get_global_main(pid), script_func.get_global_9(), script_func.get_global_10()})
			system.wait(120100)
		end
	end
	return HANDLER_CONTINUE
end):set_str_data({
	"10K (Every 2 Min)",
	"10K (Every 60 Sec)",
	"30K (Every 2 Min)"
})

menu.add_feature("» Join New Session", "action", localparents["» Lobby"].id, function(f)
	natives.NETWORK_SESSION_ENTER(999, 0, 0, 18, 0, natives.NETWORK_CAN_ENTER_MULTIPLAYER():__tointeger())
end)

feature["» Bail To Singleplayer"] = menu.add_feature("» Bail To Singleplayer", "action_value_str", localparents["» Lobby"].id, function(f)
	settings["» Bail To Singleplayer"].value = f.value
	if natives.NETWORK_CAN_BAIL():__tointeger() == 1 then
		if f.value == 0 then
			natives.NETWORK_BAIL(0, 0, 0)
		elseif f.value == 1 then
			natives.NETWORK_SESSION_END(false, true)
		elseif f.value == 2 then
			natives.NETWORK_SESSION_LEAVE_SINGLE_PLAYER()
		end
	end
end)
feature["» Bail To Singleplayer"]:set_str_data({"v1", "v2", "v3"})

feature["» Enable Spectator Chat"] = menu.add_feature("» Enable Spectator Chat", "toggle", localparents["» Lobby"].id, function(f)
	settings["» Enable Spectator Chat"].Enabled = f.on
	if f.on then
		while f.on do
			if network.is_session_started() then
				natives.NETWORK_SET_NO_SPECTATOR_CHAT(false)
				natives.NETWORK_OVERRIDE_CHAT_RESTRICTIONS(player.player_id(), true)
				natives.NETWORK_OVERRIDE_SEND_RESTRICTIONS(player.player_id(), true)
				natives.NETWORK_OVERRIDE_RECEIVE_RESTRICTIONS(player.player_id(), true)
				natives.MULTIPLAYER_CHAT_SET_DISABLED(false)
			end
			system.yield(8000)
		end
	end
	if not f.on then
		if network.is_session_started() then
			natives.NETWORK_SET_NO_SPECTATOR_CHAT(true)
			natives.NETWORK_OVERRIDE_CHAT_RESTRICTIONS(player.player_id(), false)
			natives.NETWORK_OVERRIDE_SEND_RESTRICTIONS(player.player_id(), false)
			natives.NETWORK_OVERRIDE_RECEIVE_RESTRICTIONS(player.player_id(), false)
		end
	end
	settings["» Enable Spectator Chat"].Enabled = f.on
end)

feature["» Disable Recording"] = menu.add_feature("» Disable Recording", "toggle", localparents["» Lobby"].id, function(f)
	settings["» Disable Recording"].Enabled = f.on
	while f.on do
		system.yield(0)
		natives.STOP_RECORDING_THIS_FRAME()
	end
	settings["» Disable Recording"].Enabled = f.on
end)

localparents["» Host Options"] = menu.add_feature("» Host Options", "parent", localparents["» Lobby"].id)

feature["» Block Join Requests"] = menu.add_feature("» Block Join Requests", "toggle", localparents["» Host Options"].id, function(f)
	settings["» Block Join Requests"].Enabled = f.on
	if f.on then
		while f.on do
			if network.is_session_started() and network.network_is_host() then
				natives.NETWORK_SESSION_BLOCK_JOIN_REQUESTS(true)
			end
			system.yield(6000)
		end
	end
	if not f.on then
		if network.is_session_started() and network.network_is_host() then
			natives.NETWORK_SESSION_BLOCK_JOIN_REQUESTS(false)
		end
	end
	settings["» Block Join Requests"].Enabled = f.on
end)

feature["» Hide Session"] = menu.add_feature("» Hide Session", "toggle", localparents["» Host Options"].id, function(f)
	settings["» Hide Session"].Enabled = f.on
	if f.on then
		while f.on do
			if network.is_session_started() and network.network_is_host() then
				if natives.NETWORK_SESSION_IS_VISIBLE():__tointeger() == 1 then
					natives.NETWORK_SESSION_MARK_VISIBLE(false)
				end
			end
			system.yield(6000)
		end
	end
	if not f.on then
		if network.is_session_started() and network.network_is_host() then
			if natives.NETWORK_SESSION_IS_VISIBLE():__tointeger() == 0 then
				natives.NETWORK_SESSION_MARK_VISIBLE(true)
			end
		end
	end
	settings["» Hide Session"].Enabled = f.on
end)

menu.add_feature("» Is Session Broken?", "action", localparents["» Lobby"].id, function(f, pid)
	if network.is_session_started() then
		local all_session_flags = ""
		local all_session_flags_count = 0
		local altered_sh_queue = false
		local missing_session_host = false
		local missing_script_host = false
		local bad_script_event = false
		local altered_sh_migration = false
		local modified_entity_state = false
		local out_of_range_world_render = false
		local invalid_pickup_placement = false
		local game_server_modify = false
		local modified_weather = false
		for pid = 0, 31 do
			if player.is_player_valid(pid) then
				if player.get_player_host_token(pid) == 0 then
					SessionBrokenAlteredSHQueue = true
				end
			end
		end
		if SessionBrokenAlteredSHQueue then
			if not altered_sh_queue then
				all_session_flags = all_session_flags .. "Host Token 0 lesss go"
			end
			altered_sh_queue = true
			all_session_flags_count = all_session_flags_count + 1
		end
		local has_session_host = false
		for pid = 0, 31 do
			if player.is_player_valid(pid) then
				if player.is_player_host(pid) then
					has_session_host = true
				end
			end
		end
		if not has_session_host then
			if not missing_session_host then
				all_session_flags = all_session_flags .. "Where is your session host bitch?"
			end
			missing_session_host = true
			all_session_flags_count = all_session_flags_count + 1
		end
		local has_script_host = false
		for pid = 0, 31 do
			if player.is_player_valid(pid) then
				if script.get_host_of_this_script() == pid then
					has_script_host = true
				end
			end
		end
		if not has_script_host then
			if not missing_script_host then
				all_session_flags = all_session_flags .. "Where is your script host bitch?"
			end
			missing_script_host = true
			all_session_flags_count = all_session_flags_count + 1
		end
		if SessionBrokenBadScriptEvent then
			if not bad_script_event then
				if all_session_flags_count > 0 then
					all_session_flags = all_session_flags .. ", " .. "Don't use SEs To break lobbies"
				else
					all_session_flags = all_session_flags .. "Don't use SEs to break lobbies"
				end
				bad_script_event = true
				all_session_flags_count = all_session_flags_count + 1
			end
		end
		if SessionBrokenAlteredSHMigration then
			if not altered_sh_migration then
				if all_session_flags_count > 0 then
					all_session_flags = all_session_flags .. ", " .. "Force Script Host goes Brrrrrr"
				else
					all_session_flags = all_session_flags .. "Force Script Host goes Brrrrrr"
				end
				altered_sh_migration = true
				all_session_flags_count = all_session_flags_count + 1
			end
		end
		for pid = 0, 31 do
			if player.is_player_valid(pid) then
				if entity.get_entity_model_hash(player.get_player_ped(pid)) ~= 2627665880 and entity.get_entity_model_hash(player.get_player_ped(pid)) ~= 1885233650 then
					SessionBrokenModifiedEntityState = true
				end
			end
		end
		if SessionBrokenModifiedEntityState then
			if not modified_entity_state then
				if all_session_flags_count > 0 then
					all_session_flags = all_session_flags .. ", " .. "Don't do weird interacts mf"
				else
					all_session_flags = all_session_flags .. "Don't do weird interacts mf"
				end
				modified_entity_state = true
				all_session_flags_count = all_session_flags_count + 1
			end
		end
		if SessionBrokenOutOfRangeWorldRender then
			if not out_of_range_world_render then
				if all_session_flags_count > 0 then
					all_session_flags = all_session_flags .. ", " .. "Someone swam too far away"
				else
					all_session_flags = all_session_flags .. "Someone swam too far away"
				end
				out_of_range_world_render = true
				all_session_flags_count = all_session_flags_count + 1
			end
		end
		if InvalidPickupPlacement then
			if not invalid_pickup_placement then
				if all_session_flags_count > 0 then
					all_session_flags = all_session_flags .. ", " .. "Yeah don't create scripted pickups"
				else
					all_session_flags = all_session_flags .. "Yeah don't create scripted pickups"
				end
				invalid_pickup_placement = true
				all_session_flags_count = all_session_flags_count + 1
			end
		end
		for pid = 0, 31 do
			if player.is_player_valid(pid) then
				if ui.is_mission_creator_blip(ui.get_blip_from_entity(player.get_player_ped(pid))) then
					SessionBrokenGameServerModify = true
				end
			end
		end
		if SessionBrokenGameServerModify then
			if not game_server_modify then
				if all_session_flags_count > 0 then
					all_session_flags = all_session_flags .. ", " .. "Messing with the game server is a bad idea"
				else
					all_session_flags = all_session_flags .. "Messing with the game server is a bad idea"
				end
				game_server_modify = true
				all_session_flags_count = all_session_flags_count + 1
			end
		end
		if SessionBrokenModifiedWeather then
			if not modified_weather then
				if all_session_flags_count > 0 then
					all_session_flags = all_session_flags .. ", " .. "Some fucker messed with the weather"
				else
					all_session_flags = all_session_flags .. "Some fucker messed with the weather"
				end
				modified_weather = true
				all_session_flags_count = all_session_flags_count + 1
			end
		end
		if all_session_flags_count == 0 then
			menu.notify("Session Broken: False\nFlags: None", Meteor, 12, 0x00ff00)
		else
			menu.notify("Session Broken: True\nFlags: " .. all_session_flags .. "", Meteor, 12, 211)
		end
	else
		menu.notify("Session Broken: False\nFlags: None", Meteor, 12, 0x00ff00)
	end
end)

localparents["» Force S/H"] = menu.add_feature("» Force S/H", "parent", localparents["» Lobby"].id)

menu.add_feature("» Auto Force Script Host", "toggle", localparents["» Force S/H"].id, function(f, pid)
	settings["» Auto Force Script Host"].Enabled = f.on
	if f.on then
		while f.on do
			if script.get_host_of_this_script() ~= player.player_id() then
				script_func.force_script_host()
			end
			system.yield(8000)
		end
	end
	settings["» Auto Force Script Host"].Enabled = f.on
end)

menu.add_feature("» Force Script Host", "action", localparents["» Force S/H"].id, function(f, pid)
	if script.get_host_of_this_script() ~= player.player_id() then
		script_func.force_script_host()
	end
end)


feature["» Auto Force Session Host"] = menu.add_feature("» Auto Force Session Host", "toggle", localparents["» Force S/H"].id, function(f, pid)
	settings["» Auto Force Session Host"].Enabled = f.on
	if f.on then
		while f.on do
			system.yield(5000)
			if network.is_session_started() then
				if not network.network_is_host() then
					if player_func.get_host_queue_count() > 0 then
						for pid = 0, 31 do
							if player.is_player_valid(pid) and player.get_player_host_priority(pid) < player.get_player_host_priority(player.player_id()) then
								if network.network_is_host() then
									network.network_session_kick_player(pid)
								elseif player.is_player_host(pid) and player.is_player_modder(pid, -1) then
									script_func.script_event_kick(pid)
								else
									network.force_remove_player(pid)
								end
							end
						end
						system.wait(10000)
					else
						if player.is_player_modder(player.get_host(), -1) then
							script_func.script_event_kick(player.get_host())
						else
							network.force_remove_player(player.get_host())
						end
						system.wait(10000)
					end
				end
			end
		end
	end
	settings["» Auto Force Session Host"].Enabled = f.on
end)

menu.add_feature("» Force Session Host", "action", localparents["» Force S/H"].id, function(f)
	if network.is_session_started() then
		if network.network_is_host() then
			menu.notify("You are already the session host!", Meteor, 3, 211)
		else
			if player_func.get_host_queue_count() > 0 then
				for pid = 0, 31 do
					if player.is_player_valid(pid) and player.get_player_host_priority(pid) < player.get_player_host_priority(player.player_id()) then
						if network.network_is_host() then
							network.network_session_kick_player(pid)
						elseif player.is_player_host(pid) and player.is_player_modder(pid, -1) then
							script_func.script_event_kick(pid)
						else
							network.force_remove_player(pid)
						end
					end
				end
				system.wait(2000)
				if network.network_is_host() then
					menu.notify("Successfully forced Session Host!", Meteor, 3, 0x00ff00)
				else
					menu.notify("Failed to force Session Host!", Meteor, 3, 211)
				end
			else
				if player.is_player_modder(player.get_host(), -1) then
					script_func.script_event_kick(player.get_host())
				else
					network.force_remove_player(player.get_host())
				end
				system.wait(2000)
				if network.network_is_host() then
					menu.notify("Successfully forced Session Host!", Meteor, 3, 0x00ff00)
				else
					menu.notify("Failed to force Session Host!", Meteor, 3, 211)
				end
			end
		end
	end
end)

localparents["» Session Info"] = menu.add_feature("» Session Info", "parent", localparents["» Lobby"].id, function()
	if feature["» Session Info Player Count"] then
		menu.delete_feature(feature["» Session Info Player Count"].id)
	end
	if feature["» Session Info Type"] then
		menu.delete_feature(feature["» Session Info Type"].id)
	end
	if feature["» Session Info Visible"] then
		menu.delete_feature(feature["» Session Info Visible"].id)
	end
	if feature["» Session Info Session Host"] then
		menu.delete_feature(feature["» Session Info Session Host"].id)
	end
	if feature["» Session Info Script Host"] then
		menu.delete_feature(feature["» Session Info Script Host"].id)
	end

	feature["» Session Info Player Count"] = menu.add_feature("» Player Count:", "action_value_str", localparents["» Session Info"].id, function(f)
	end)
	feature["» Session Info Player Count"]:set_str_data({tostring(player.player_count())})

	feature["» Session Info Type"] = menu.add_feature("» Session Type:", "action_value_str", localparents["» Session Info"].id, function(f)
	end)
	if natives.NETWORK_SESSION_IS_CLOSED_FRIENDS():__tointeger() == 1 then
		feature["» Session Info Type"]:set_str_data({"Closed Friends"})
	elseif natives.NETWORK_SESSION_IS_CLOSED_CREW():__tointeger() == 1 then
		feature["» Session Info Type"]:set_str_data({"Closed Crew"})
	elseif natives.NETWORK_SESSION_IS_SOLO():__tointeger() == 1 then
		feature["» Session Info Type"]:set_str_data({"Solo"})
	elseif natives.NETWORK_SESSION_IS_PRIVATE():__tointeger() == 1 then
		feature["» Session Info Type"]:set_str_data({"Private"})
	else
		feature["» Session Info Type"]:set_str_data({"Public"})
	end

	feature["» Session Info Visible"] = menu.add_feature("» Visible:", "action_value_str", localparents["» Session Info"].id, function(f)
	end)
	feature["» Session Info Visible"]:set_str_data({tostring(natives.NETWORK_SESSION_IS_VISIBLE():__tointeger() == 1)})

	feature["» Session Info Session Host"] = menu.add_feature("» Session Host:", "action_value_str", localparents["» Session Info"].id, function(f)
	end)
	feature["» Session Info Session Host"]:set_str_data({tostring(player.get_player_name(player.get_host()))})

	feature["» Session Info Script Host"] = menu.add_feature("» Script Host:", "action_value_str", localparents["» Session Info"].id, function(f)
	end)
	feature["» Session Info Script Host"]:set_str_data({tostring(player.get_player_name(script.get_host_of_this_script()))})
end)

localparents["» Last Joined Player"] = menu.add_feature("» Last Joined Player", "parent", localparents["» Lobby"].id, function()
	if feature["» Last Joined Player Time"] then
		menu.delete_feature(feature["» Last Joined Player Time"].id)
		feature["» Last Joined Player Time"] = nil
	end
	if feature["» Last Joined Player Name"] then
		menu.delete_feature(feature["» Last Joined Player Name"].id)
		feature["» Last Joined Player Name"] = nil
	end
	if feature["» Last Joined Player SCID"] then
		menu.delete_feature(feature["» Last Joined Player SCID"].id)
		feature["» Last Joined Player SCID"] = nil
	end
	if feature["» Last Joined Player IP"] then
		menu.delete_feature(feature["» Last Joined Player IP"].id)
		feature["» Last Joined Player IP"] = nil
	end
	if utils.file_exists(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\Meteor\\Data\\LoggedPlayers.log") then
		local file = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\Meteor\\Data\\LoggedPlayers.log", "r")
		local file_content_table = {}
		local file_content_count = 1
		for line in file:lines() do
			file_content_table[file_content_count] = "" .. line .. ""
			file_content_count = file_content_count + 1
		end
		if file_content_table[#file_content_table] ~= nil and string.find(file_content_table[#file_content_table], "|") then
			local info_parts = text_func.split_string(file_content_table[#file_content_table], "||")
			local log_time = info_parts[1]
			local player_name = info_parts[2]
			local player_scid = info_parts[3]
			local player_ip = info_parts[4]
			feature["» Last Joined Player Time"] = menu.add_feature("» Log Time:", "action_value_str", localparents["» Last Joined Player"].id, function(f)
				utils.to_clipboard(tostring(log_time))
				menu.notify("Copied Log Time - " .. tostring(log_time) .. "")
			end)
			feature["» Last Joined Player Time"]:set_str_data({"" .. log_time .. ""})
			feature["» Last Joined Player Name"] = menu.add_feature("» Copy Name:", "action_value_str", localparents["» Last Joined Player"].id, function(f)
				utils.to_clipboard(tostring(player_name))
				menu.notify("Copied Player Name To Clipboard - " .. tostring(player_name) .. "")
			end)
			feature["» Last Joined Player Name"]:set_str_data({"" .. tostring(player_name) .. ""})
			feature["» Last Joined Player SCID"] = menu.add_feature("» Copy SCID:", "action_value_str", localparents["» Last Joined Player"].id, function(f)
				utils.to_clipboard("" .. player_scid .. "")
				menu.notify("Copied Player SCID To Clipboard - " .. player_scid .. "")
			end)
			feature["» Last Joined Player SCID"]:set_str_data({"" .. player_scid .. ""})
			feature["» Last Joined Player IP"] = menu.add_feature("» Copy IP:", "action_value_str", localparents["» Last Joined Player"].id, function(f)
				utils.to_clipboard(utilities.dec_to_ipv4(tonumber(player_ip)))
				menu.notify("Copied Player IP To Clipboard - " .. utilities.dec_to_ipv4(tonumber(player_ip)) .. "")
			end)
			feature["» Last Joined Player IP"]:set_str_data({"" .. utilities.dec_to_ipv4(tonumber(player_ip)) .. ""})
		end
	end
end)

feature["» Invalid SCID Detection"] = menu.add_feature("» Invalid SCID", "value_str", localparents["» Modder Detections"].id, function(f, pid)
	settings["» Invalid SCID Detection"].Enabled = f.on
	settings["» Invalid SCID Detection"].Value = f.value
	if f.on then
		while f.on do
			system.yield(4000)
			if network.is_session_started() then
				for pid = 0, 31 do
					if player.get_player_scid(pid) < 10000 or player.get_player_scid(pid) > 250000000 then
						if (settings["» Exclude Friends From Detections"].Enabled and player.is_player_friend(pid)) or (settings["» Exclude Whitelisted Players From Detections"].Enabled and not player.can_player_be_modder(pid)) then
						else
							if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Invalid SCID"]) then
								if f.value == 0 then
									menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Invalid SCID", "Meteor Modder Detection", 12, 0x00A2FF)
									player.set_player_as_modder(pid, custommodderflags["Invalid SCID"])
								elseif f.value == 1 and not InvalidSCIDDetectionPlayer[pid] then
									menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Invalid SCID", "Meteor Modder Detection", 12, 0x00A2FF)
									InvalidSCIDDetectionPlayer[pid] = true
								elseif f.value == 2 then
									player.set_player_as_modder(pid, custommodderflags["Invalid SCID"])
								end
							end
						end
					end
				end
			end
		end
	end
	settings["» Invalid SCID Detection"].Enabled = f.on
	settings["» Invalid SCID Detection"].Value = f.value
end)
feature["» Invalid SCID Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Invalid SCID Detection"].value = 0

feature["» Modded Health Detection"] = menu.add_feature("» Modded Health", "value_str", localparents["» Modder Detections"].id, function(f, pid)
	settings["» Modded Health Detection"].Enabled = f.on
	settings["» Modded Health Detection"].Value = f.value
	if f.on then
		while f.on do
			system.yield(4000)
			if network.is_session_started() then
				for pid = 0, 31 do
					if not player.get_player_health(pid) == 2600 or not player.get_player_health(pid) == 2600 then
						if (player.get_player_health(pid) < 0 or player.get_player_health(pid) > 328 or player.get_player_max_health(pid) < 0 or player.get_player_max_health(pid) > 328 or player.get_player_max_health(pid) < player.get_player_health(pid) or player.get_player_health(pid) > player.get_player_max_health(pid)) or (player.get_player_health(pid) == 0 and player.get_player_max_health(pid) == 0 and entity.is_entity_dead(player.get_player_ped(pid))) then
							if (settings["» Exclude Friends From Detections"].Enabled and player.is_player_friend(pid)) or (settings["» Exclude Whitelisted Players From Detections"].Enabled and not player.can_player_be_modder(pid)) then
							else
								if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Modded Health"]) then
									if f.value == 0 then
										menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Modded Health", "Meteor Modder Detection", 12, 0x00A2FF)
										player.set_player_as_modder(pid, custommodderflags["Modded Health"])
									elseif f.value == 1 and not ModdedHealthDetectionPlayer[pid] then
										menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Modded Health", "Meteor Modder Detection", 12, 0x00A2FF)
										ModdedHealthDetectionPlayer[pid] = true
									elseif f.value == 2 then
										player.set_player_as_modder(pid, custommodderflags["Modded Health"])
									end
								end
							end
						end
					end
				end
			end
		end
	end
	settings["» Modded Health Detection"].Enabled = f.on
	settings["» Modded Health Detection"].Value = f.value
end)
feature["» Modded Health Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Modded Health Detection"].value = 0

feature["» Godmode Detection"] = menu.add_feature("» Godmode", "value_str", localparents["» Modder Detections"].id, function(f, pid)
	settings["» Godmode Detection"].Enabled = f.on
	settings["» Godmode Detection"].Value = f.value
	if f.on then
		while f.on do
			system.yield(500)
			if network.is_session_started() then
				for pid = 0, 31 do
					if player.is_player_valid(pid) then
						local guilty = false
						if (player.is_player_god(pid) and player_func.is_player_moving(pid) and entity.is_entity_visible(player.get_player_ped(pid)) and not player_func.is_player_in_interior(pid) and (ai.is_task_active(player.get_player_ped(pid), 4) or ai.is_task_active(player.get_player_ped(pid), 9) or ai.is_task_active(player.get_player_ped(pid), 128) or ai.is_task_active(player.get_player_ped(pid), 200) or ai.is_task_active(player.get_player_ped(pid), 272) or ai.is_task_active(player.get_player_ped(pid), 287) or ai.is_task_active(player.get_player_ped(pid), 289) or ai.is_task_active(player.get_player_ped(pid), 290) or ai.is_task_active(player.get_player_ped(pid), 291) or ai.is_task_active(player.get_player_ped(pid), 295) or ai.is_task_active(player.get_player_ped(pid), 298) or ai.is_task_active(player.get_player_ped(pid), 299) or ai.is_task_active(player.get_player_ped(pid), 302) or ai.is_task_active(player.get_player_ped(pid), 303) or ai.is_task_active(player.get_player_ped(pid), 304) or ai.is_task_active(player.get_player_ped(pid), 335) or ai.is_task_active(player.get_player_ped(pid), 422) or ai.is_task_active(player.get_player_ped(pid), 423))) then
							guilty = true
						end
						if player_func.is_player_moving(pid) and utilities.get_distance_between(player.get_player_coords(player.player_id()), player.get_player_coords(pid)) and player.is_player_in_any_vehicle(pid) and entity.is_entity_visible(player.get_player_ped(pid)) and not player_func.is_player_in_interior(pid) then
							local bulletProof_ = native.ByteBuffer8()
							local fireProof_ = native.ByteBuffer8()
							local explosionProof_ = native.ByteBuffer8()
							local collisionProof_ = native.ByteBuffer8()
							local meleeProof_ = native.ByteBuffer8()
							local steamProof_ = native.ByteBuffer8()
							local p7_ = native.ByteBuffer8()
							local drownProof_ = native.ByteBuffer8()
							local success = natives.GET_ENTITY_PROOFS(player.get_player_vehicle(pid), bulletProof_, fireProof_, explosionProof_, collisionProof_, meleeProof_, steamProof_, p7_, drownProof_):__tointeger()
							if success == 1 and bulletProof_:__tointeger() == 1 and fireProof_:__tointeger() == 1 and explosionProof_:__tointeger() == 1 and collisionProof_:__tointeger() == 1 and meleeProof_:__tointeger() == 1 and steamProof_:__tointeger() == 1 and p7_:__tointeger() == 1 and drownProof_:__tointeger() == 1 and not entity.get_entity_god_mode(player.get_player_vehicle(pid)) then
								guilty = true
							end
						end
						if guilty then
							if (settings["» Exclude Friends From Detections"].Enabled and player.is_player_friend(pid)) or (settings["» Exclude Whitelisted Players From Detections"].Enabled and not player.can_player_be_modder(pid)) then
							else
								if pid ~= player.player_id() and not player.is_player_modder(pid, custommodderflags["Godmode"]) then
									if f.value == 0 then
										menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Godmode", "Meteor Modder Detection", 12, 0x00A2FF)
										player.set_player_as_modder(pid, custommodderflags["Godmode"])
									elseif f.value == 1 and not GodmodeDetectionPlayer[pid] then
										menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Godmode", "Meteor Modder Detection", 12, 0x00A2FF)
										GodmodeDetectionPlayer[pid] = true
									elseif f.value == 2 then
										player.set_player_as_modder(pid, custommodderflags["Godmode"])
									end
								end
							end
						end
					end
				end
			end
		end
	end
	settings["» Godmode Detection"].Enabled = f.on
	settings["» Godmode Detection"].Value = f.value
end)
feature["» Godmode Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Godmode Detection"].value = 0

feature["» Invalid Name Detection"] = menu.add_feature("» Invalid Name", "value_str", localparents["» Modder Detections"].id, function(f, pid)
	settings["» Invalid Name Detection"].Enabled = f.on
	settings["» Invalid Name Detection"].Value = f.value
	if f.on then
		while f.on do
			system.yield(4000)
			if network.is_session_started() then
				for pid = 0, 31 do
					if player.is_player_valid(pid) then
						local Name1 = player_func.get_player_name(pid, 1)
						local Name2 = player_func.get_player_name(pid, 2)
						local Name3 = player_func.get_player_name(pid, 3)
						local Name4 = player_func.get_player_name(pid, 4)
						if string.len(player.get_player_name(pid)) < 6 or string.len(player.get_player_name(pid)) > 16 or not string.find(player.get_player_name(pid), "^[%.%-%w_]+$") or Name1 ~= Name2 or Name1 ~= Name3 or Name1 ~= Name4 or Name2 ~= Name3 or Name2 ~= Name4 or Name3 ~= Name4 then
							if (settings["» Exclude Friends From Detections"].Enabled and player.is_player_friend(pid)) or (settings["» Exclude Whitelisted Players From Detections"].Enabled and not player.can_player_be_modder(pid)) then
							else
								if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Invalid Name"]) then
									if f.value == 0 then
										menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Invalid Name", "Meteor Modder Detection", 12, 0x00A2FF)
										player.set_player_as_modder(pid, custommodderflags["Invalid Name"])
									elseif f.value == 1 and not InvalidNameDetectionPlayer[pid] then
										menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Invalid Name", "Meteor Modder Detection", 12, 0x00A2FF)
										InvalidNameDetectionPlayer[pid] = true
									elseif f.value == 2 then
										player.set_player_as_modder(pid, custommodderflags["Invalid Name"])
									end
								end
							end
						end
					end
				end
			end
		end
	end
	settings["» Invalid Name Detection"].Enabled = f.on
	settings["» Invalid Name Detection"].Value = f.value
end)
feature["» Invalid Name Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Invalid Name Detection"].value = 0

feature["» Invalid IP Detection"] = menu.add_feature("» Invalid IP", "value_str", localparents["» Modder Detections"].id, function(f, pid)
	settings["» Invalid IP Detection"].Enabled = f.on
	settings["» Invalid IP Detection"].Value = f.value
	if f.on then
		while f.on do
			if network.is_session_started() then
				for pid = 0, 31 do
					if player.is_player_valid(pid) then
						if pid ~= player.player_id() then
							if player.get_player_ip(pid) <= 0 or player.get_player_ip(pid) > 4294967295 or player.get_player_ip(pid) == 2130706433 then
								if (settings["» Exclude Friends From Detections"].Enabled and player.is_player_friend(pid)) or (settings["» Exclude Whitelisted Players From Detections"].Enabled and not player.can_player_be_modder(pid)) then
								else
									if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Invalid IP"]) then
										if f.value == 0 then
											menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Invalid IP", "Meteor Modder Detection", 12, 0x00A2FF)
											player.set_player_as_modder(pid, custommodderflags["Invalid IP"])
										elseif f.value == 1 and not InvalidIPDetectionPlayer[pid] then
											menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Invalid IP", "Meteor Modder Detection", 12, 0x00A2FF)
											InvalidIPDetectionPlayer[pid] = true
										elseif f.value == 2 then
											player.set_player_as_modder(pid, custommodderflags["Invalid IP"])
										end
									end
								end
							end
						end
					end
				end
			end
			system.yield(5000)
		end
	end
	settings["» Invalid IP Detection"].Enabled = f.on
	settings["» Invalid IP Detection"].Value = f.value
end)
feature["» Invalid IP Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Invalid IP Detection"].value = 0

feature["» Bad Net Event Detection"] = menu.add_feature("» Bad Net Event", "value_str", localparents["» Modder Detections"].id, function(f)
	settings["» Bad Net Event Detection"].Enabled = f.on
	settings["» Bad Net Event Detection"].Value = f.value
	if f.on then
		if eventhooks["» Bad Net Event Detection"] == nil then
			eventhooks["» Bad Net Event Detection"] = hook.register_net_event_hook(function(source, target, eventId)
				if eventId == NetEventID["GAME_CLOCK_EVENT"] or eventId == NetEventID["GAME_WEATHER_EVENT"] or eventId == NetEventID["GIVE_WEAPON_EVENT"] or eventId == NetEventID["REMOVE_WEAPON_EVENT"] or eventId == NetEventID["REMOVE_ALL_WEAPONS_EVENT"] or eventId == NetEventID["NETWORK_CLEAR_PED_TASKS_EVENT"] or eventId == NetEventID["NETWORK_START_PED_ARREST_EVENT"] or eventId == NetEventID["NETWORK_START_PED_UNCUFF_EVENT"] or eventId == NetEventID["SCRIPT_ENTITY_STATE_CHANGE_EVENT"] or eventId == NetEventID["GIVE_PICKUP_REWARDS_EVENT"] or eventId == NetEventID["NETWORK_CHECK_EXE_SIZE_EVENT"] or eventId == NetEventID["NETWORK_CHECK_CODE_CRCS_EVENT"] or eventId == NetEventID["PED_PLAY_PAIN_EVENT"] or eventId == NetEventID["REPORT_CASH_SPAWN_EVENT"] or eventId == NetEventID["NETWORK_CHECK_CATALOG_CRC"] then
					if (settings["» Exclude Friends From Detections"].Enabled and player.is_player_friend(source)) or (settings["» Exclude Whitelisted Players From Detections"].Enabled and not player.can_player_be_modder(source)) then
					else
						if source ~= player.player_id() and player.is_player_valid(source) and not player.is_player_modder(source, custommodderflags["Bad Net Event"]) then
							if f.value == 0 then
								menu.notify("Player: " .. player.get_player_name(source) .. "\nReason: Bad Net Event", "Meteor Modder Detection", 12, 0x00A2FF)
								player.set_player_as_modder(source, custommodderflags["Bad Net Event"])
							elseif f.value == 1 then
								menu.notify("Player: " .. player.get_player_name(source) .. "\nReason: Bad Net Event", "Meteor Modder Detection", 12, 0x00A2FF)
							elseif f.value == 2 then
								player.set_player_as_modder(source, custommodderflags["Bad Net Event"])
							end
						end
					end
				end
			end)
		end
	end
	if not f.on then
		if eventhooks["» Bad Net Event Detection"] then
			hook.remove_net_event_hook(eventhooks["» Bad Net Event Detection"])
			eventhooks["» Bad Net Event Detection"] = nil
		end
	end
	settings["» Bad Net Event Detection"].Enabled = f.on
	settings["» Bad Net Event Detection"].Value = f.value
end)
feature["» Bad Net Event Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Bad Net Event Detection"].value = 0

feature["» Bad Script Event Detection"] = menu.add_feature("» Bad Script Event", "value_str", localparents["» Modder Detections"].id, function(f)
	settings["» Bad Script Event Detection"].Enabled = f.on
	settings["» Bad Script Event Detection"].Value = f.value
	if f.on then
		if eventhooks["» Bad Script Event Detection"] == nil then
			eventhooks["» Bad Script Event Detection"] = hook.register_script_event_hook(function(source, target, params, count)
				for i = 1, #params do
					params[i] = params[i] & 0xFFFFFFFF
				end
				if ((params[2] ~= source) or (params[2] < 0) or (params[2] > 31) or (#params < 2) or (params[1] == 962740265) or (params[1] == -1386010354) or (params[1] == -399817245 and params[4] > 31) or (params[1] == -569621836 and params[4] >= 30583) or (params[1] == -1782442696 and prams[3] == 420 and params[4] == 69) or (params[1] == -621279188 and params[2] == 1) or (params[1] == 1463943751 and (params[5] == 3 or params[5] == 4) and (params[6] == 0 or params[6] == 1)) or (params[1] == 0xE56661F6) or (params[1] == 0x3FAC59CA) or (params[1] == 603406648 and params[3] == 217) or (params[1] == 962740265 and params[3] > 0 and params[3] < 13) or (params[1] == 1463943751) or (params[1] == 0x2FC154DC and params[3] == 869796886 and params[4] == 0)) and player.get_player_coords(source).z > 0 then
					if (settings["» Exclude Friends From Detections"].Enabled and player.is_player_friend(source)) or (settings["» Exclude Whitelisted Players From Detections"].Enabled and not player.can_player_be_modder(source)) then
					else
						if source ~= player.player_id() and player.is_player_valid(source) and not player.is_player_modder(source, custommodderflags["Bad Script Event"]) then
							if f.value == 0 then
								menu.notify("Player: " .. player.get_player_name(source) .. "\nReason: Bad Script Event", "Meteor Modder Detection", 12, 0x00A2FF)
								player.set_player_as_modder(source, custommodderflags["Bad Script Event"])
							elseif f.value == 1 then
								menu.notify("Player: " .. player.get_player_name(source) .. "\nReason: Bad Script Event", "Meteor Modder Detection", 12, 0x00A2FF)
							elseif f.value == 2 then
								player.set_player_as_modder(source, custommodderflags["Bad Script Event"])
							end
						end
					end
				end
			end)
		end
	end
	if not f.on then
		if eventhooks["» Bad Script Event Detection"] then
			hook.remove_script_event_hook(eventhooks["» Bad Script Event Detection"])
			eventhooks["» Bad Script Event Detection"] = nil
		end
	end
	settings["» Bad Script Event Detection"].Enabled = f.on
	settings["» Bad Script Event Detection"].Value = f.value
end)
feature["» Bad Script Event Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Bad Script Event Detection"].value = 0

feature["» Stand User Detection"] = menu.add_feature("» Stand User", "value_str", localparents["» Modder Detections"].id, function(f)
	settings["» Stand User Detection"].Enabled = f.on
	settings["» Stand User Detection"].Value = f.value
	if f.on then
		has_someone_been_marked_as_stand_user = false
		if eventhooks["» Stand User Detection"] == nil then
			eventhooks["» Stand User Detection"] = hook.register_script_event_hook(function(source, target, params, count)
				for i = 1, #params do
					params[i] = params[i] & 0xFFFFFFFF
				end
				if ((params[1] == -1386010354) or (params[1] == -399817245 and params[4] > 31) or (params[1] == -569621836 and params[4] >= 30583) or (params[1] == -1782442696 and params[3] == 420 and params[4] == 69) or (params[1] == 1228916411 and params[3] > 10000) or (params[1] == 537760938 and params[2] == 2680059592720 and params[3] == 2680059592880 and params[4] == 539) or (params[1] == -371781708 and params[5] >= -2147483647) or (params[1] == -317318371 and params[5] >= -2147483647) or (params[1] == 911179316 and params[6] >= -2147483647) or (params[1] == 846342319 and params[3] >= -2147483647 and params[4] == 1) or (params[1] == -1991317864 and params[3] == 3 and params[4] >= -2147483647) or (params[1] == -1767058336 and params[3] >= -2147483647) or (params[1] == 296518236 and params[6] == 1) or (params[1] == 924535804 and params[3] >= -2147483647 and params[4] == 0)) and player.get_player_coords(source).z > 0 then
					if (settings["» Exclude Friends From Detections"].Enabled and player.is_player_friend(source)) or (settings["» Exclude Whitelisted Players From Detections"].Enabled and not player.can_player_be_modder(source)) then
					else
						if source ~= player.player_id() and player.is_player_valid(source) and not player.is_player_modder(source, custommodderflags["Stand User"]) then
							if f.value == 0 then
								menu.notify("Player: " .. player.get_player_name(source) .. "\nReason: Stand User", "Meteor Modder Detection", 12, 0x00A2FF)
								player.set_player_as_modder(source, custommodderflags["Stand User"])
							elseif f.value == 1 then
								menu.notify("Player: " .. player.get_player_name(source) .. "\nReason: Stand User", "Meteor Modder Detection", 12, 0x00A2FF)
							elseif f.value == 2 then
								player.set_player_as_modder(source, custommodderflags["Stand User"])
							end
						end
					end
				end
			end)
		end
		while f.on do
			system.yield(500)
			if network.is_session_started() then
				if not player_func.is_player_in_interior(player.player_id()) then
					has_found_stand_user_suspect = false
					for pid = 0, 31 do
						if player.player_id() ~= pid and player.is_player_in_any_vehicle(pid) and entity.get_entity_model_hash(player.get_player_vehicle(pid)) == 941494461 and vehicle.get_vehicle_parachute_model(player.get_player_vehicle(pid)) == 1913502601 and entity.get_entity_god_mode(player.get_player_vehicle(pid)) then
							if (settings["» Exclude Friends From Detections"].Enabled and player.is_player_friend(pid)) or (settings["» Exclude Whitelisted Players From Detections"].Enabled and not player.can_player_be_modder(pid)) then
							else
								if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Stand User"]) then
									if f.value == 0 then
										menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Stand User", "Meteor Modder Detection", 12, 0x00A2FF)
										player.set_player_as_modder(pid, custommodderflags["Stand User"])
									elseif f.value == 1 and not StandUserDetectionPlayer[pid] then
										menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Stand User", "Meteor Modder Detection", 12, 0x00A2FF)
										StandUserDetectionPlayer[pid] = true
									elseif f.value == 2 then
										player.set_player_as_modder(pid, custommodderflags["Stand User"])
									end
								end
							end
						end
					end
					local vehicles = utilities.get_table_of_entities(vehicle.get_all_vehicles(), 1000, 1000, true, true, player.get_player_coords(player.player_id()))
					for i = 1, #vehicles do
						if entity.get_entity_model_hash(vehicles[i]) == 1349725314 and vehicle.get_num_vehicle_mods(vehicles[i], 48) ~= 0 and utilities.get_distance_between(vehicles[i], player.get_player_ped(player.player_id())) < 50 then
							stand_user_detection_suspect = memory.get_entity_owner(vehicles[i])
							if stand_user_detection_suspect ~= nil then
								if player.is_player_valid(stand_user_detection_suspect) then
									if (settings["» Exclude Friends From Detections"].Enabled and player.is_player_friend(stand_user_detection_suspect)) or (settings["» Exclude Whitelisted Players From Detections"].Enabled and not player.can_player_be_modder(stand_user_detection_suspect)) then
									else
										if stand_user_detection_suspect ~= player.player_id() and player.is_player_valid(stand_user_detection_suspect) and not player.is_player_modder(stand_user_detection_suspect, custommodderflags["Stand User"]) then
											if f.value == 0 then
												menu.notify("Player: " .. player.get_player_name(stand_user_detection_suspect) .. "\nReason: Stand User", "Meteor Modder Detection", 12, 0x00A2FF)
												player.set_player_as_modder(stand_user_detection_suspect, custommodderflags["Stand User"])
											elseif f.value == 1 and not StandUserDetectionPlayer[stand_user_detection_suspect] then
												menu.notify("Player: " .. player.get_player_name(stand_user_detection_suspect) .. "\nReason: Stand User", "Meteor Modder Detection", 12, 0x00A2FF)
												StandUserDetectionPlayer[stand_user_detection_suspect] = true
											elseif f.value == 2 then
												player.set_player_as_modder(stand_user_detection_suspect, custommodderflags["Stand User"])
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
	if not f.on then
		if eventhooks["» Stand User Detection"] then
			hook.remove_script_event_hook(eventhooks["» Stand User Detection"])
			eventhooks["» Stand User Detection"] = nil
		end
	end
	settings["» Stand User Detection"].Enabled = f.on
	settings["» Stand User Detection"].Value = f.value
end)
feature["» Stand User Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Stand User Detection"].value = 0

feature["» Max Speed Bypass Detection"] = menu.add_feature("» Max Speed Bypass", "value_str", localparents["» Modder Detections"].id, function(f, pid)
	settings["» Max Speed Bypass Detection"].Enabled = f.on
	settings["» Max Speed Bypass Detection"].Value = f.value
	if f.on then
		while f.on do
			system.yield(500)
			if network.is_session_started() then
				for pid = 0, 31 do
					if player.is_player_valid(pid) and player.is_player_in_any_vehicle(pid) then
						local guilty = false
						if streaming.is_model_a_plane(entity.get_entity_model_hash(player.get_player_vehicle(pid))) then
							if entity.get_entity_speed(player.get_player_vehicle(pid)) > 576 / 3.6 or vehicle.get_vehicle_estimated_max_speed(player.get_player_vehicle(pid)) > 576 then
								guilty = true
							end
						else
							if entity.get_entity_speed(player.get_player_vehicle(pid)) > 540 / 3.6 or vehicle.get_vehicle_estimated_max_speed(player.get_player_vehicle(pid)) > 540 then
								guilty = true
							end
						end
						if guilty then
							local entity_owner = memory.get_entity_owner(player.get_player_vehicle(pid))
							if entity_owner ~= nil and entity_owner ~= player.player_id() then
								if player.is_player_valid(entity_owner) then
									if (settings["» Exclude Friends From Detections"].Enabled and player.is_player_friend(entity_owner)) or (settings["» Exclude Whitelisted Players From Detections"].Enabled and not player.can_player_be_modder(entity_owner)) then
									else
										if entity_owner ~= player.player_id() and player.is_player_valid(entity_owner) and not player.is_player_modder(entity_owner, custommodderflags["Max Speed Bypass"]) then
											if f.value == 0 then
												menu.notify("Player: " .. player.get_player_name(entity_owner) .. "\nReason: Max Speed Bypass", "Meteor Modder Detection", 12, 0x00A2FF)
												player.set_player_as_modder(entity_owner, custommodderflags["Max Speed Bypass"])
											elseif f.value == 1 and not MaxSpeedBypassDetectionPlayer[entity_owner] then
												menu.notify("Player: " .. player.get_player_name(entity_owner) .. "\nReason: Max Speed Bypass", "Meteor Modder Detection", 12, 0x00A2FF)
												MaxSpeedBypassDetectionPlayer[entity_owner] = true
											elseif f.value == 2 then
												player.set_player_as_modder(entity_owner, custommodderflags["Max Speed Bypass"])
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
	settings["» Max Speed Bypass Detection"].Enabled = f.on
	settings["» Max Speed Bypass Detection"].Value = f.value
end)
feature["» Max Speed Bypass Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Max Speed Bypass Detection"].value = 0

feature["» Invalid Stats Detection"] = menu.add_feature("» Invalid Stats", "value_str", localparents["» Modder Detections"].id, function(f, pid)
	settings["» Invalid Stats Detection"].Enabled = f.on
	settings["» Invalid Stats Detection"].Value = f.value
	if f.on then
		while f.on do
			system.yield(10000)
			if network.is_session_started() then
				for pid = 0, 31 do
					if player.is_player_valid(pid) then
						if (script_func.get_player_kills(pid) > 2147483647 or script_func.get_player_kills(pid) < 0 or script_func.get_player_deaths(pid) > 2147483647 or script_func.get_player_deaths(pid) < 0 or script_func.get_player_kd(pid) > 2147483647 or script_func.get_player_kd(pid) < 0 or script_func.get_player_rank(pid) > 8000 or script_func.get_player_rank(pid) < 0) and not player.is_player_god(pid) then
							if pid ~= player.player_id() and player.is_player_valid(pid) and player_func.is_player_moving_slow(pid) and meteor_session_timer < utils.time_ms() and not player_func.is_player_in_interior(pid) then
								if (settings["» Exclude Friends From Detections"].Enabled and player.is_player_friend(pid)) or (settings["» Exclude Whitelisted Players From Detections"].Enabled and not player.can_player_be_modder(pid)) then
								else
									if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Invalid Stats"]) then
										if f.value == 0 then
											menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Invalid Stats", "Meteor Modder Detection", 12, 0x00A2FF)
											player.set_player_as_modder(pid, custommodderflags["Invalid Stats"])
										elseif f.value == 1 and not InvalidStatsDetectionPlayer[pid] then
											menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Invalid Stats", "Meteor Modder Detection", 12, 0x00A2FF)
											InvalidStatsDetectionPlayer[pid] = true
										elseif f.value == 2 then
											player.set_player_as_modder(pid, custommodderflags["Invalid Stats"])
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
	settings["» Invalid Stats Detection"].Enabled = f.on
	settings["» Invalid Stats Detection"].Value = f.value
end)
feature["» Invalid Stats Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Invalid Stats Detection"].value = 0

feature["» Bad Outfit Data Detection"] = menu.add_feature("» Bad Outfit Data", "value_str", localparents["» Modder Detections"].id, function(f, pid)
	settings["» Bad Outfit Data Detection"].Enabled = f.on
	settings["» Bad Outfit Data Detection"].Value = f.value
	if f.on then
		while f.on do
			system.yield(400)
			if network.is_session_started() then
				for pid = 0, 31 do
					if did_someone_type and player.is_player_valid(pid) and meteor_session_timer < utils.time_ms() and player_func.is_player_moving(pid) and not player_func.is_player_in_interior(pid) then
						if (player.is_player_female(pid) and (ped.get_ped_drawable_variation(player.get_player_ped(pid), 3) == 415 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 8) == 234 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 6) == 106 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 4) == 151)) or (not player.is_player_female(pid) and (ped.get_ped_drawable_variation(player.get_player_ped(pid), 3) == 393 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 8) == 189 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 6) == 102 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 4) == 144)) or (ped.get_ped_drawable_variation(player.get_player_ped(pid), 0) > 500 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 0) < 0 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 1) > 500 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 1) < 0 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 2) > 500 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 2) < 0 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 3) > 500 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 4) < 0 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 5) > 500 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 5) < 0 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 6) > 500 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 6) < 0 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 7) > 500 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 7) < 0 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 8) > 500 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 8) < 0 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 9) > 500 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 9) < 0 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 10) > 500 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 10) < 0 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 11) > 500 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 11) < 0) then
							if ped.get_ped_drawable_variation(player.get_player_ped(pid), 11) ~= 0 then
								if (settings["» Exclude Friends From Detections"].Enabled and player.is_player_friend(pid)) or (settings["» Exclude Whitelisted Players From Detections"].Enabled and not player.can_player_be_modder(pid)) then
								else
									if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Bad Outfit Data"]) then
										if f.value == 0 then
											menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Bad Outfit Data", "Meteor Modder Detection", 12, 0x00A2FF)
											player.set_player_as_modder(pid, custommodderflags["Bad Outfit Data"])
										elseif f.value == 1 and not BadOutfitDataDetectionPlayer[pid] then
											menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Bad Outfit Data", "Meteor Modder Detection", 12, 0x00A2FF)
											BadOutfitDataDetectionPlayer[pid] = true
										elseif f.value == 2 then
											player.set_player_as_modder(pid, custommodderflags["Bad Outfit Data"])
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
	settings["» Bad Outfit Data Detection"].Enabled = f.on
	settings["» Bad Outfit Data Detection"].Value = f.value
end)
feature["» Bad Outfit Data Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Bad Outfit Data Detection"].value = 0

feature["» Altered Script Host Migration Detection"] = menu.add_feature("» Altered Script Host Migration", "value_str", localparents["» Modder Detections"].id, function(f, pid)
	settings["» Altered Script Host Migration Detection"].Enabled = f.on
	settings["» Altered Script Host Migration Detection"].Value = f.value
	if f.on then
		while f.on do
			system.yield(0)
			local current_sh
			local sh_name
			if current_sh == nil then
				current_sh = script.get_host_of_this_script()
				sh_name = player.get_player_name(current_sh)
			end
			system.wait(2000)
			local new_sh = script.get_host_of_this_script()
			if current_sh ~= new_sh then
				if player.is_player_valid(new_sh) then
					if altered_sh_migration_detection_timer_left_player < utils.time_ms() and altered_sh_migration_detection_timer < utils.time_ms() then
						if (settings["» Exclude Friends From Detections"].Enabled and player.is_player_friend(new_sh)) or (settings["» Exclude Whitelisted Players From Detections"].Enabled and not player.can_player_be_modder(new_sh)) then
						else
							if new_sh ~= player.player_id() and player.is_player_valid(new_sh) and not player.is_player_modder(new_sh, custommodderflags["Altered SH Migration"]) then
								if f.value == 0 then
									menu.notify("Player: " .. tostring(player.get_player_name(new_sh)) .. "\nReason: Altered Script Host Migration", "Meteor Modder Detection", 12, 0x00A2FF)
									player.set_player_as_modder(new_sh, custommodderflags["Altered SH Migration"])
								elseif f.value == 1 then
									menu.notify("Player: " .. tostring(player.get_player_name(new_sh)) .. "\nReason: Altered Script Host Migration", "Meteor Modder Detection", 12, 0x00A2FF)
								elseif f.value == 2 then
									player.set_player_as_modder(new_sh, custommodderflags["Altered SH Migration"])
								end
							end
						end
					end
					sh_name = player.get_player_name(current_sh)
				end
			end
			system.wait(0)
		end
		system.wait(1000)
	end
	settings["» Altered Script Host Migration Detection"].Enabled = f.on
	settings["» Altered Script Host Migration Detection"].Value = f.value
end)
feature["» Altered Script Host Migration Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Altered Script Host Migration Detection"].value = 0

feature["» Modded Spectate Detection"] = menu.add_feature("» Modded Spectate", "value_str", localparents["» Modder Detections"].id, function(f, pid)
	settings["» Modded Spectate Detection"].Enabled = f.on
	settings["» Modded Spectate Detection"].Value = f.value
	if f.on then
		while f.on do
			system.yield(800)
			if network.is_session_started() then
				for pid = 0, 31 do
					if player.is_player_valid(pid) then
						if player.is_player_spectating(pid) and not player_func.is_player_in_interior(pid) and not entity.is_entity_dead(player.get_player_ped(pid)) then
							if (settings["» Exclude Friends From Detections"].Enabled and player.is_player_friend(pid)) or (settings["» Exclude Whitelisted Players From Detections"].Enabled and not player.can_player_be_modder(pid)) then
							else
								if pid ~= player.player_id() and not player.is_player_modder(pid, custommodderflags["Modded Spectate"]) then
									if f.value == 0 then
										menu.notify("Player: " .. tostring(player.get_player_name(pid)) .. "\nReason: Modded Spectate", "Meteor Modder Detection", 12, 0x00A2FF)
										player.set_player_as_modder(pid, custommodderflags["Modded Spectate"])
									elseif f.value == 1 then
										menu.notify("Player: " .. tostring(player.get_player_name(pid)) .. "\nReason: Modded Spectate", "Meteor Modder Detection", 12, 0x00A2FF)
										ModdedSpectateDetectionPlayer[pid] = true
									elseif f.value == 2 then
										player.set_player_as_modder(pid, custommodderflags["Modded Spectate"])
									end
								end
							end
						end
					end
				end
			end
		end
	end
	settings["» Modded Spectate Detection"].Enabled = f.on
	settings["» Modded Spectate Detection"].Value = f.value
end)
feature["» Modded Spectate Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Modded Spectate Detection"].value = 0

feature["» Modded OTR Detection"] = menu.add_feature("» Modded OTR", "value_str", localparents["» Modder Detections"].id, function(f, pid)
	settings["» Modded OTR Detection"].Enabled = f.on
	settings["» Modded OTR Detection"].Value = f.value
	if f.on then
		for i = 0, 31 do
			IsOTRFor[i] = 0
		end
		while f.on do
			system.yield(1000)
			if network.is_session_started() then
				for pid = 0, 31 do
					if player.is_player_valid(pid) then
						if script_func.is_player_otr(pid) and not player_func.is_player_in_interior(pid) then
							IsOTRFor[pid] = IsOTRFor[pid] + 1
						else
							IsOTRFor[pid] = 0
						end
						if IsOTRFor[pid] > 181 then
							if (settings["» Exclude Friends From Detections"].Enabled and player.is_player_friend(pid)) or (settings["» Exclude Whitelisted Players From Detections"].Enabled and not player.can_player_be_modder(pid)) then
							else
								if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Modded OTR"]) then
									if f.value == 0 then
										menu.notify("Player: " .. tostring(player.get_player_name(pid)) .. "\nReason: Modded OTR", "Meteor Modder Detection", 12, 0x00A2FF)
										player.set_player_as_modder(pid, custommodderflags["Modded OTR"])
									elseif f.value == 1 and not ModdedOTRDetectionPlayer[pid] then
										menu.notify("Player: " .. tostring(player.get_player_name(pid)) .. "\nReason: Modded OTR", "Meteor Modder Detection", 12, 0x00A2FF)
										ModdedOTRDetectionPlayer[pid] = true
									elseif f.value == 2 then
										player.set_player_as_modder(pid, custommodderflags["Modded OTR"])
									end
								end
							end
						end
					end
				end
			end
		end
	end
	if not f.on then
		for i = 0, 31 do
			IsOTRFor[i] = 0
		end
	end
	settings["» Modded OTR Detection"].Enabled = f.on
	settings["» Modded OTR Detection"].Value = f.value
end)
feature["» Modded OTR Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Modded OTR Detection"].value = 0

feature["» Bad Parachute Model Detection"] = menu.add_feature("» Bad Parachute Model", "value_str", localparents["» Modder Detections"].id, function(f, pid)
	settings["» Bad Parachute Model Detection"].Enabled = f.on
	settings["» Bad Parachute Model Detection"].Value = f.value
	if f.on then
		while f.on do
			system.yield(4000)
			for pid = 0, 31 do
				if player.is_player_valid(pid) then
					local guilty = false
					if player.is_player_in_any_vehicle(pid) then
						if vehicle.get_vehicle_parachute_model(player.get_player_vehicle(pid)) ~= 0 and vehicle.get_vehicle_parachute_model(player.get_player_vehicle(pid)) ~= 3430676794 and vehicle.get_vehicle_parachute_model(player.get_player_vehicle(pid)) ~= 1298918533 and vehicle.get_vehicle_parachute_model(player.get_player_vehicle(pid)) ~= 1931904776 and vehicle.get_vehicle_parachute_model(player.get_player_vehicle(pid)) ~= 3255984827 and vehicle.get_vehicle_parachute_model(player.get_player_vehicle(pid)) ~= 1336576410 and vehicle.get_vehicle_parachute_model(player.get_player_vehicle(pid)) ~= 3981285813 and vehicle.get_vehicle_parachute_model(player.get_player_vehicle(pid)) ~= 1740193300 and vehicle.get_vehicle_parachute_model(player.get_player_vehicle(pid)) ~= 218548447 and vehicle.get_vehicle_parachute_model(player.get_player_vehicle(pid)) ~= 2170442475 and vehicle.get_vehicle_parachute_model(player.get_player_vehicle(pid)) ~= 1654893215 and vehicle.get_vehicle_parachute_model(player.get_player_vehicle(pid)) ~= 2235049942 and vehicle.get_vehicle_parachute_model(player.get_player_vehicle(pid)) ~= 230075693 and vehicle.get_vehicle_parachute_model(player.get_player_vehicle(pid)) ~= 3316027 and vehicle.get_vehicle_parachute_model(player.get_player_vehicle(pid)) ~= 2514357004 then
							guilty = true
						end
					else
						if player.get_player_parachute_model(pid) ~= 0 and player.get_player_parachute_model(pid) ~= 3430676794 and player.get_player_parachute_model(pid) ~= 1298918533 and player.get_player_parachute_model(pid) ~= 1931904776 and player.get_player_parachute_model(pid) ~= 3255984827 and player.get_player_parachute_model(pid) ~= 1336576410 and player.get_player_parachute_model(pid) ~= 3981285813 and player.get_player_parachute_model(pid) ~= 1740193300 and player.get_player_parachute_model(pid) ~= 218548447 and player.get_player_parachute_model(pid) ~= 2170442475 and player.get_player_parachute_model(pid) ~= 1654893215 and player.get_player_parachute_model(pid) ~= 2235049942 and player.get_player_parachute_model(pid) ~= 230075693 and player.get_player_parachute_model(pid) ~= 3316027 and player.get_player_parachute_model(pid) ~= 2514357004 then
							guilty = true
						end
					end
					if guilty then
						local suspect = pid
						if player.is_player_in_any_vehicle(pid) then
							suspect = memory.get_entity_owner(player.get_player_vehicle(pid))
						end
						if suspect ~= nil and suspect ~= player.player_id() then
							if player.is_player_valid(suspect) then
								if (settings["» Exclude Friends From Detections"].Enabled and player.is_player_friend(suspect)) or (settings["» Exclude Whitelisted Players From Detections"].Enabled and not player.can_player_be_modder(suspect)) then
								else
									if suspect ~= player.player_id() and player.is_player_valid(suspect) and not player.is_player_modder(suspect, custommodderflags["Bad Parachute Model"]) then
										if f.value == 0 then
											menu.notify("Player: " .. tostring(player.get_player_name(suspect)) .. "\nReason: Bad Parachute Model", "Meteor Modder Detection", 12, 0x00A2FF)
											player.set_player_as_modder(suspect, custommodderflags["Bad Parachute Model"])
										elseif f.value == 1 and not BadParachuteModelDetectionPlayer[suspect] then
											menu.notify("Player: " .. tostring(player.get_player_name(suspect)) .. "\nReason: Bad Parachute Model", "Meteor Modder Detection", 12, 0x00A2FF)
											BadParachuteModelDetectionPlayer[suspect] = true
										elseif f.value == 2 then
											player.set_player_as_modder(suspect, custommodderflags["Bad Parachute Model"])
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
	settings["» Bad Parachute Model Detection"].Enabled = f.on
	settings["» Bad Parachute Model Detection"].Value = f.value
end)
feature["» Bad Parachute Model Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Bad Parachute Model Detection"].value = 0

feature["» Modded Explosion Detection"] = menu.add_feature("» Modded Explosion", "value_str", localparents["» Modder Detections"].id, function(f, pid)
	settings["» Modded Explosion Detection"].Enabled = f.on
	settings["» Modded Explosion Detection"].Value = f.value
	if f.on then
		if eventhooks["» Modded Explosion Detection"] == nil then
			eventhooks["» Modded Explosion Detection"] = hook.register_net_event_hook(function(source, target, eventId)
				if eventId == NetEventID["EXPLOSION_EVENT"] and utilities.get_distance_between(player.get_player_coords(player.player_id()), player.get_player_coords(source)) > 3000 and meteor_session_timer < utils.time_ms() and network.get_entity_player_is_spectating(player.player_id()) == nil and player.get_player_coords(player.player_id()).z > 0 and not freecam_player_cam and not guided_missile_object and not player_func.is_player_in_interior(source) and not player.is_player_spectating(player.player_id()) then
					if (settings["» Exclude Friends From Detections"].Enabled and player.is_player_friend(source)) or (settings["» Exclude Whitelisted Players From Detections"].Enabled and not player.can_player_be_modder(source)) then
					else
						if source ~= player.player_id() and player.is_player_valid(source) and not player.is_player_modder(source, custommodderflags["Modded Explosion"]) then
							if f.value == 0 then
								menu.notify("Player: " .. player.get_player_name(source) .. "\nReason: Modded Explosion", "Meteor Modder Detection", 12, 0x00A2FF)
								player.set_player_as_modder(source, custommodderflags["Modded Explosion"])
							elseif f.value == 1 then
								menu.notify("Player: " .. player.get_player_name(source) .. "\nReason: Modded Explosion", "Meteor Modder Detection", 12, 0x00A2FF)
							elseif f.value == 2 then
								player.set_player_as_modder(source, custommodderflags["Modded Explosion"])
							end
						end
					end
				end
			end)
		end
		local guilty = {}
		while f.on do
			system.yield(0)
			if network.is_session_started() then
				if natives.IS_EXPLOSION_IN_AREA(59, player.get_player_coords(player.player_id()).x - 1000, player.get_player_coords(player.player_id()).y - 1000, player.get_player_coords(player.player_id()).z - 1000, player.get_player_coords(player.player_id()).x + 1000, player.get_player_coords(player.player_id()).y + 1000, player.get_player_coords(player.player_id()).z + 1000):__tointeger() == 1 then
					local explo_owner = player.get_player_from_ped(natives.GET_OWNER_OF_EXPLOSION_IN_ANGLED_AREA(59, player.get_player_coords(player.player_id()).x - 1000, player.get_player_coords(player.player_id()).y - 1000, player.get_player_coords(player.player_id()).z - 1000, player.get_player_coords(player.player_id()).x + 1000, player.get_player_coords(player.player_id()).y + 1000, player.get_player_coords(player.player_id()).z + 1000, 1000.0):__tointeger())
					if player.is_player_valid(explo_owner) and player.get_player_coords(explo_owner).z > 0 then
						guilty[explo_owner] = true
					end
				end
				for i = 1, #DataMain.all_unnatural_interior_explosions do
					if natives.IS_EXPLOSION_IN_AREA(DataMain.all_unnatural_interior_explosions[i], player.get_player_coords(player.player_id()).x - 1000, player.get_player_coords(player.player_id()).y - 1000, player.get_player_coords(player.player_id()).z - 1000, player.get_player_coords(player.player_id()).x + 1000, player.get_player_coords(player.player_id()).y + 1000, player.get_player_coords(player.player_id()).z + 1000):__tointeger() == 1 then
						local explo_owner = player.get_player_from_ped(natives.GET_OWNER_OF_EXPLOSION_IN_ANGLED_AREA(DataMain.all_unnatural_interior_explosions[i], player.get_player_coords(player.player_id()).x - 1000, player.get_player_coords(player.player_id()).y - 1000, player.get_player_coords(player.player_id()).z - 1000, player.get_player_coords(player.player_id()).x + 1000, player.get_player_coords(player.player_id()).y + 1000, player.get_player_coords(player.player_id()).z + 1000, 1000.0):__tointeger())
						if player.is_player_valid(explo_owner) and player_func.get_accurate_non_interior_bool(explo_owner) then
							guilty[explo_owner] = true
						end
					end
				end
				if natives.IS_EXPLOSION_IN_AREA(35, player.get_player_coords(player.player_id()).x - 1000, player.get_player_coords(player.player_id()).y - 1000, player.get_player_coords(player.player_id()).z - 1000, player.get_player_coords(player.player_id()).x + 1000, player.get_player_coords(player.player_id()).y + 1000, player.get_player_coords(player.player_id()).z + 1000):__tointeger() == 1 then
					local explo_owner = player.get_player_from_ped(natives.GET_OWNER_OF_EXPLOSION_IN_ANGLED_AREA(35, player.get_player_coords(player.player_id()).x - 1000, player.get_player_coords(player.player_id()).y - 1000, player.get_player_coords(player.player_id()).z - 1000, player.get_player_coords(player.player_id()).x + 1000, player.get_player_coords(player.player_id()).y + 1000, player.get_player_coords(player.player_id()).z + 1000, 1000.0):__tointeger())
					if player.is_player_valid(explo_owner) then
						guilty[explo_owner] = true
					end
				end
				if natives.IS_EXPLOSION_IN_AREA(38, player.get_player_coords(player.player_id()).x - 1000, player.get_player_coords(player.player_id()).y - 1000, player.get_player_coords(player.player_id()).z - 1000, player.get_player_coords(player.player_id()).x + 1000, player.get_player_coords(player.player_id()).y + 1000, player.get_player_coords(player.player_id()).z + 1000):__tointeger() == 1 then
					local explo_owner = player.get_player_from_ped(natives.GET_OWNER_OF_EXPLOSION_IN_ANGLED_AREA(38, player.get_player_coords(player.player_id()).x - 1000, player.get_player_coords(player.player_id()).y - 1000, player.get_player_coords(player.player_id()).z - 1000, player.get_player_coords(player.player_id()).x + 1000, player.get_player_coords(player.player_id()).y + 1000, player.get_player_coords(player.player_id()).z + 1000, 1000.0):__tointeger())
					if player.is_player_valid(explo_owner) and not weapon.has_ped_got_weapon(player.get_player_ped(explo_owner), 0x7F7497E5) then
						guilty[explo_owner] = true
					end
				end
				if natives.IS_EXPLOSION_IN_AREA(39, player.get_player_coords(player.player_id()).x - 1000, player.get_player_coords(player.player_id()).y - 1000, player.get_player_coords(player.player_id()).z - 1000, player.get_player_coords(player.player_id()).x + 1000, player.get_player_coords(player.player_id()).y + 1000, player.get_player_coords(player.player_id()).z + 1000):__tointeger() == 1 then
					local explo_owner = player.get_player_from_ped(natives.GET_OWNER_OF_EXPLOSION_IN_ANGLED_AREA(39, player.get_player_coords(player.player_id()).x - 1000, player.get_player_coords(player.player_id()).y - 1000, player.get_player_coords(player.player_id()).z - 1000, player.get_player_coords(player.player_id()).x + 1000, player.get_player_coords(player.player_id()).y + 1000, player.get_player_coords(player.player_id()).z + 1000, 1000.0):__tointeger())
					if player.is_player_valid(explo_owner) then
						guilty[explo_owner] = true
					end
				end
				for pid = 0, 31 do
					if player.is_player_valid(pid) then
						if guilty[pid] then
							if network.get_entity_player_is_spectating(player.player_id()) == nil and player.get_player_coords(player.player_id()).z > 0 and not freecam_player_cam and not guided_missile_object and not player.is_player_spectating(player.player_id()) then
								if (settings["» Exclude Friends From Detections"].Enabled and player.is_player_friend(pid)) or (settings["» Exclude Whitelisted Players From Detections"].Enabled and not player.can_player_be_modder(pid)) then
								else
									if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Modded Explosion"]) then
										if f.value == 0 then
											menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Modded Explosion", "Meteor Modder Detection", 12, 0x00A2FF)
											player.set_player_as_modder(pid, custommodderflags["Modded Explosion"])
										elseif f.value == 1 then
											menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Modded Explosion", "Meteor Modder Detection", 12, 0x00A2FF)
										elseif f.value == 2 then
											player.set_player_as_modder(pid, custommodderflags["Modded Explosion"])
										end
									end
								end
							end
						end
						guilty[pid] = false
					else
						guilty[pid] = false
					end
				end
			end
		end
	end
	if not f.on then
		if eventhooks["» Modded Explosion Detection"] then
			hook.remove_script_event_hook(eventhooks["» Modded Explosion Detection"])
			eventhooks["» Modded Explosion Detection"] = nil
		end
	end
	settings["» Modded Explosion Detection"].Enabled = f.on
	settings["» Modded Explosion Detection"].Value = f.value
end)
feature["» Modded Explosion Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Modded Explosion Detection"].value = 0

feature["» Modded Vehicle Modification Detection"] = menu.add_feature("» Modded Vehicle Modification", "value_str", localparents["» Modder Detections"].id, function(f, pid)
	settings["» Modded Vehicle Modification Detection"].Enabled = f.on
	settings["» Modded Vehicle Modification Detection"].Value = f.value
	if f.on then
		local player_veh_id = {}
		local player_veh_plate_text = {}
		local player_veh_plate_index = {}
		local player_veh_wheel_type = {}
		local player_veh_window_tint = {}
		local player_veh_headl_colour = {}
		local player_veh_wheel_colour = {}
		local player_veh_prim_colour = {}
		local player_veh_sec_colour = {}
		local player_veh_mods = {
			["0"] = {},
			["1"] = {},
			["2"] = {},
			["3"] = {},
			["4"] = {},
			["5"] = {},
			["6"] = {},
			["7"] = {},
			["8"] = {},
			["9"] = {},
			["10"] = {},
			["11"] = {},
			["12"] = {},
			["13"] = {},
			["14"] = {},
			["15"] = {},
			["16"] = {},
			["17"] = {},
			["18"] = {},
			["19"] = {},
			["20"] = {},
			["21"] = {},
			["22"] = {},
			["23"] = {},
			["24"] = {},
			["25"] = {},
			["26"] = {},
			["27"] = {},
			["28"] = {},
			["29"] = {},
			["30"] = {},
			["31"] = {},
			["32"] = {},
			["33"] = {},
			["34"] = {},
			["35"] = {},
			["36"] = {},
			["37"] = {},
			["38"] = {},
			["39"] = {},
			["40"] = {},
			["41"] = {},
			["42"] = {},
			["43"] = {},
			["44"] = {},
			["45"] = {},
			["46"] = {},
			["47"] = {},
			["48"] = {},
			["49"] = {}
		}
		while f.on do
			system.yield(0)
			if network.is_session_started() then
				for pid = 0, 31 do
					if player.is_player_valid(pid) and player.is_player_in_any_vehicle(pid) and utilities.get_spectator_of_player(pid) == nil and utilities.get_distance_between(player.get_player_coords(pid), player.get_player_coords(player.player_id())) > 4 and utilities.get_distance_between(player.get_player_coords(pid), player.get_player_coords(player.player_id())) < 1000 and player.get_player_coords(pid).z > 0 and player.get_player_coords(pid).z < 200 and not network.has_control_of_entity(player.get_player_vehicle(pid)) and not entity.is_entity_dead(player.get_player_ped(pid)) and not entity.is_entity_dead(player.get_player_vehicle(pid)) and not player.is_player_god(pid) and not player_func.get_accurate_non_interior_bool(pid) and not entity.is_entity_in_water(player.get_player_vehicle(pid)) then
						player_veh_id[pid] = player.get_player_vehicle(pid)
						player_veh_plate_text[pid] = vehicle.get_vehicle_number_plate_text(player.get_player_vehicle(pid))
						player_veh_plate_index[pid] = vehicle.get_vehicle_number_plate_index(player.get_player_vehicle(pid))
						player_veh_wheel_type[pid] = vehicle.get_vehicle_wheel_type(player.get_player_vehicle(pid))
						player_veh_window_tint[pid] = vehicle.get_vehicle_window_tint(player.get_player_vehicle(pid))
						player_veh_headl_colour[pid] = vehicle.get_vehicle_headlight_color(player.get_player_vehicle(pid))
						player_veh_wheel_colour[pid] = vehicle.get_vehicle_custom_wheel_colour(player.get_player_vehicle(pid))
						player_veh_prim_colour[pid] = vehicle.get_vehicle_custom_primary_colour(player.get_player_vehicle(pid))
						player_veh_sec_colour[pid] = vehicle.get_vehicle_custom_secondary_colour(player.get_player_vehicle(pid))
						for i = 0, 49 do
							player_veh_mods["" .. i .. ""][pid] = vehicle.get_num_vehicle_mods(player.get_player_vehicle(pid), i)
						end
					else
						player_veh_id[pid] = nil
						player_veh_plate_text[pid] = nil
						player_veh_plate_index[pid] = nil
						player_veh_wheel_type[pid] = nil
						player_veh_window_tint[pid] = nil
						player_veh_headl_colour[pid] = nil
						player_veh_wheel_colour[pid] = nil
						player_veh_prim_colour[pid] = nil
						player_veh_sec_colour[pid] = nil
						for i = 0, 49 do
							player_veh_mods["" .. i .. ""][pid] = nil
						end
					end
				end
				system.wait(500)
				for pid = 0, 31 do
					if player.is_player_valid(pid) and player.is_player_in_any_vehicle(pid) and utilities.get_spectator_of_player(pid) == nil and utilities.get_distance_between(player.get_player_coords(pid), player.get_player_coords(player.player_id())) > 4 and utilities.get_distance_between(player.get_player_coords(pid), player.get_player_coords(player.player_id())) < 1000 and player.get_player_coords(pid).z > 0 and player.get_player_coords(pid).z < 200 and player_veh_id[pid] ~= nil and not network.has_control_of_entity(player.get_player_vehicle(pid)) and not entity.is_entity_dead(player.get_player_ped(pid)) and not entity.is_entity_dead(player.get_player_vehicle(pid)) and not player.is_player_god(pid) and not player_func.get_accurate_non_interior_bool(pid) and not entity.is_entity_in_water(player.get_player_vehicle(pid)) then
						if player_veh_id[pid] ~= nil and player_veh_id[pid] == player.get_player_vehicle(pid) and entity.get_entity_model_hash(player.get_player_vehicle(pid)) ~= 2382949506 then
							local guilty = false
							local entries = 0
							if player_veh_plate_text[pid] ~= nil then
								if vehicle.get_vehicle_number_plate_text(player.get_player_vehicle(pid)) ~= player_veh_plate_text[pid] then
									guilty = true
									entries = entries + 1
								end
							end
							if player_veh_plate_index[pid] ~= nil then
								if vehicle.get_vehicle_number_plate_index(player.get_player_vehicle(pid)) ~= player_veh_plate_index[pid] then
									guilty = true
									entries = entries + 1
								end
							end
							if player_veh_wheel_type[pid] ~= nil then
								if vehicle.get_vehicle_wheel_type(player.get_player_vehicle(pid)) ~= player_veh_wheel_type[pid] then
									guilty = true
									entries = entries + 1
								end
							end
							if player_veh_window_tint[pid] ~= nil then
								if vehicle.get_vehicle_window_tint(player.get_player_vehicle(pid)) ~= player_veh_window_tint[pid] then
									guilty = true
									entries = entries + 1
								end
							end
							if player_veh_headl_colour[pid] ~= nil then
								if vehicle.get_vehicle_headlight_color(player.get_player_vehicle(pid)) ~= player_veh_headl_colour[pid] then
									guilty = true
									entries = entries + 1
								end
							end
							if player_veh_wheel_colour[pid] ~= nil then
								if vehicle.get_vehicle_custom_wheel_colour(player.get_player_vehicle(pid)) ~= player_veh_wheel_colour[pid] then
									guilty = true
									entries = entries + 1
								end
							end
							if player_veh_prim_colour[pid] ~= nil then
								if vehicle.get_vehicle_custom_primary_colour(player.get_player_vehicle(pid)) ~= player_veh_prim_colour[pid] then
									guilty = true
									entries = entries + 1
								end
							end
							if player_veh_sec_colour[pid] ~= nil then
								if vehicle.get_vehicle_custom_secondary_colour(player.get_player_vehicle(pid)) ~= player_veh_sec_colour[pid] then
									guilty = true
									entries = entries + 1
								end
							end
							for i = 0, 49 do
								if player_veh_mods["" .. i .. ""][pid] ~= nil then
									if vehicle.get_num_vehicle_mods(player.get_player_vehicle(pid), i) ~= player_veh_mods["" .. i .. ""][pid] then
										guilty = true
										entries = entries + 1
									end
								end
							end
							if guilty then
								local entity_owner = memory.get_entity_owner(player.get_player_vehicle(pid))
								if entity_owner ~= nil and entity_owner ~= player.player_id() and entries > 1 then
									if player.is_player_valid(entity_owner) then
										if (settings["» Exclude Friends From Detections"].Enabled and player.is_player_friend(entity_owner)) or (settings["» Exclude Whitelisted Players From Detections"].Enabled and not player.can_player_be_modder(entity_owner)) then
										else
											if entity_owner ~= player.player_id() and player.is_player_valid(entity_owner) and not player.is_player_modder(entity_owner, custommodderflags["Modded Vehicle Modification"]) then
												if f.value == 0 then
													menu.notify("Player: " .. player.get_player_name(entity_owner) .. "\nReason: Modded Vehicle Modification", "Meteor Modder Detection", 12, 0x00A2FF)
													player.set_player_as_modder(entity_owner, custommodderflags["Modded Vehicle Modification"])
												elseif f.value == 1 then
													menu.notify("Player: " .. player.get_player_name(entity_owner) .. "\nReason: Modded Vehicle Modification", "Meteor Modder Detection", 12, 0x00A2FF)
												elseif f.value == 2 then
													player.set_player_as_modder(entity_owner, custommodderflags["Modded Vehicle Modification"])
												end
											end
										end
									end
								end
							end
						end
					end
					player_veh_id[pid] = nil
					player_veh_plate_text[pid] = nil
					player_veh_plate_index[pid] = nil
					player_veh_wheel_type[pid] = nil
					player_veh_window_tint[pid] = nil
					player_veh_headl_colour[pid] = nil
					player_veh_wheel_colour[pid] = nil
					player_veh_prim_colour[pid] = nil
					player_veh_sec_colour[pid] = nil
					for i = 0, 49 do
						player_veh_mods["" .. i .. ""][pid] = nil
					end
				end
			end
		end
	end
	settings["» Modded Vehicle Modification Detection"].Enabled = f.on
	settings["» Modded Vehicle Modification Detection"].Value = f.value
end)
feature["» Modded Vehicle Modification Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Modded Vehicle Modification Detection"].value = 0

feature["» Scripted Entity Spawn Detection"] = menu.add_feature("» Scripted Entity Spawn", "value_str", localparents["» Modder Detections"].id, function(f, pid)
	settings["» Scripted Entity Spawn Detection"].Enabled = f.on
	settings["» Scripted Entity Spawn Detection"].Value = f.value
	if f.on then
		local exclude_object_hashes = {1005810318, 245271664, 2586970039, 918615565, 890925600, 705446731, 602296248, 4845511, 4083544953, 3604002190, 3298955569, 3148706974, 439782367, 623406777}
		local all_weapon_hashes = weapon.get_all_weapon_hashes()
		for i = 1, #all_weapon_hashes do
			exclude_object_hashes[#exclude_object_hashes + 1] = all_weapon_hashes[i]
		end
		while f.on do
			system.yield(500)
			if network.is_session_started() and interior.get_interior_from_entity(player.get_player_ped(player.player_id())) == 0 then
				local guilty = false
				local guilty_entity = nil
				local guilty_player = nil
				local found_index = false
				if not found_index then
					local peds = ped.get_all_peds()
					for i = 1, #peds do
						if not found_index then
							if not ped.is_ped_a_player(peds[i]) then
								if memory.network_is_script_entity(peds[i]) and not network.has_control_of_entity(peds[i]) then
									if (natives.GET_ENTITY_SCRIPT(peds[i], 0):__tostring(true) == nil or natives.GET_ENTITY_SCRIPT(peds[i], 0):__tostring(true) == "nil" or natives.GET_ENTITY_SCRIPT(peds[i], 0):__tostring(true) == "main" or natives.GET_ENTITY_SCRIPT(peds[i], 0):__tostring(true) == "freemode") and not entity.is_entity_dead(peds[i]) then
										if not PedModel.get_ped_model_from_hash(entity.get_entity_model_hash(peds[i])) == "unknown" then
											guilty = true
											guilty_entity = peds[i]
											guilty_player = memory.get_entity_owner(peds[i])
										end
									end
								end
							end
						end
					end
					local vehicles = vehicle.get_all_vehicles()
					for i = 1, #vehicles do
						if not found_index then
							if memory.network_is_script_entity(vehicles[i]) and not network.has_control_of_entity(vehicles[i]) and utilities.get_distance_between(player.get_player_coords(player.player_id()), vehicles[i]) < 1000 then
								if not entity.get_entity_model_hash(vehicles[i]) == gameplay.get_hash_key("sparrow") and not entity.get_entity_model_hash(vehicles[i]) == gameplay.get_hash_key("premier") and not decorator.decor_exists_on(vehicles[i], "Player_Vehicle") and not decorator.decor_exists_on(vehicles[i], "PV_Slot") and not decorator.decor_exists_on(vehicles[i], "Not_Allow_As_Saved_Veh") and not decorator.decor_exists_on(vehicles[i], "CreatedByPegasus") and not streaming.is_model_a_train(entity.get_entity_model_hash(vehicles[i])) and ((decorator.decor_exists_on(vehicles[i], "MPBitset") and (decorator.decor_get_int(vehicles[i], "MPBitset") == 0 or decorator.decor_get_int(vehicles[i], "MPBitset") == 1 << 10)) or (not decorator.decor_exists_on(vehicles[i], "MPBitset"))) then
									if not VehicleModel.get_vehicle_model_from_hash(entity.get_entity_model_hash(vehicles[i])) == "unknown" then
										guilty = true
										guilty_entity = vehicles[i]
										guilty_player = memory.get_entity_owner(vehicles[i])
									end
								end
							end
						end
					end
					local objects = object.get_all_objects()
					for i = 1, #objects do
						if not found_index then
							if memory.network_is_script_entity(objects[i]) and not network.has_control_of_entity(objects[i]) then
								local is_object_excluded = false
								for a = 1, #exclude_object_hashes do
									if entity.get_entity_model_hash(objects[i]) == exclude_object_hashes[a] then
										is_object_excluded = true
									end
								end
								if not is_object_excluded then
									if natives.GET_ENTITY_SCRIPT(objects[i], 0):__tostring(true) == nil or natives.GET_ENTITY_SCRIPT(objects[i], 0):__tostring(true) == "nil" or natives.GET_ENTITY_SCRIPT(objects[i], 0):__tostring(true) == "main" or natives.GET_ENTITY_SCRIPT(objects[i], 0):__tostring(true) == "freemode" then
										if not ObjectModel.get_object_model_from_hash(entity.get_entity_model_hash(objects[i])) == "unknown" then
											guilty = true
											guilty_entity = objects[i]
											guilty_player = memory.get_entity_owner(objects[i])
										end
									end
								end
							end
						end
					end
					for pid = 0, 31 do
						if player.is_player_valid(pid) then
							if player.is_player_in_any_vehicle(pid) then
								if streaming.is_model_a_train(entity.get_entity_model_hash(player.get_player_vehicle(pid))) then
									guilty = true
									guilty_entity = player.get_player_vehicle(pid)
									guilty_player = pid
								end
							end
						end
					end
					if guilty and guilty_player ~= nil and guilty_entity ~= nil then
						if player.get_player_coords(guilty_player).z > 0 and interior.get_interior_from_entity(player.get_player_ped(guilty_player)) == 0 then
							if (settings["» Exclude Friends From Detections"].Enabled and player.is_player_friend(guilty_player)) or (settings["» Exclude Whitelisted Players From Detections"].Enabled and not player.can_player_be_modder(guilty_player)) then
							else
								if guilty_player ~= player.player_id() and player.is_player_valid(guilty_player) and not player.is_player_modder(guilty_player, custommodderflags["Scripted Entity Spawn"]) then
									if f.value == 0 then
										menu.notify("Player: " .. player.get_player_name(guilty_player) .. "\nReason: Scripted Entity Spawn (" .. string.format("%0x", guilty_entity) .. ")", "Meteor Modder Detection", 12, 0x00A2FF)
										player.set_player_as_modder(guilty_player, custommodderflags["Scripted Entity Spawn"])
									elseif f.value == 1 and not InvalidEntitySpawnDetectionPlayer[guilty_player] then
										menu.notify("Player: " .. player.get_player_name(guilty_player) .. "\nReason: Scripted Entity Spawn (" .. string.format("%0x", guilty_entity) .. ")", "Meteor Modder Detection", 12, 0x00A2FF)
										InvalidEntitySpawnDetectionPlayer[guilty_player] = true
									elseif f.value == 2 then
										player.set_player_as_modder(guilty_player, custommodderflags["Scripted Entity Spawn"])
									end
								end
							end
						end
					end
				end
			end
		end
	end
	settings["» Scripted Entity Spawn Detection"].Enabled = f.on
	settings["» Scripted Entity Spawn Detection"].Value = f.value
end)
feature["» Scripted Entity Spawn Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Scripted Entity Spawn Detection"].value = 0

feature["» No Ragdoll Detection"] = menu.add_feature("» No Ragdoll", "value_str", localparents["» Modder Detections"].id, function(f, pid)
	settings["» No Ragdoll Detection"].Enabled = f.on
	settings["» No Ragdoll Detection"].Value = f.value
	if f.on then
		while f.on do
			system.yield(500)
			if network.is_session_started() then
				for pid = 0, 31 do
					if entity.is_entity_visible(player.get_player_ped(pid)) and natives.IS_PLAYER_IN_CUTSCENE(pid):__tointeger() == 0 and not ped.can_ped_ragdoll(player.get_player_ped(pid)) and not ped.is_ped_ragdoll(player.get_player_ped(pid)) and not player.is_player_god(pid) and not player.is_player_in_any_vehicle(pid) and player_func.is_player_moving(pid) and not entity.is_entity_dead(player.get_player_ped(pid)) and player.is_player_playing(pid) and natives.IS_PED_JUMPING_OUT_OF_VEHICLE(player.get_player_ped(pid)):__tointeger() == 0 and natives.IS_PED_JACKING(player.get_player_ped(pid)):__tointeger() == 0 and not player_func.is_player_in_interior(pid) then
						if (settings["» Exclude Friends From Detections"].Enabled and player.is_player_friend(pid)) or (settings["» Exclude Whitelisted Players From Detections"].Enabled and not player.can_player_be_modder(pid)) then
						else
							if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["No Ragdoll"]) then
								if f.value == 0 then
									menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: No Ragdoll", "Meteor Modder Detection", 12, 0x00A2FF)
									player.set_player_as_modder(pid, custommodderflags["No Ragdoll"])
								elseif f.value == 1 and not NoRagdollDetectionPlayer[pid] then
									menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: No Ragdoll", "Meteor Modder Detection", 12, 0x00A2FF)
									NoRagdollDetectionPlayer[pid] = true
								elseif f.value == 2 then
									player.set_player_as_modder(pid, custommodderflags["No Ragdoll"])
								end
							end
						end
					end
				end
			end
		end
	end
	settings["» No Ragdoll Detection"].Enabled = f.on
	settings["» No Ragdoll Detection"].Value = f.value
end)
feature["» No Ragdoll Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» No Ragdoll Detection"].value = 0

feature["» Anti AFK Bypass Detection"] = menu.add_feature("» Anti AFK Bypass", "value_str", localparents["» Modder Detections"].id, function(f, pid)
	settings["» Anti AFK Bypass Detection"].Enabled = f.on
	settings["» Anti AFK Bypass Detection"].Value = f.value
	if f.on then
		local last_player_weapon = {}
		local last_player_ammo = {}
		while f.on do
			system.yield(0)
			if network.is_session_started() then
				for pid = 0, 31 do
					if (ai.is_task_active(player.get_player_ped(pid), 100) or ai.is_task_active(player.get_player_ped(pid), 101) or ai.is_task_active(player.get_player_ped(pid), 151) or ai.is_task_active(player.get_player_ped(pid), 221) or ai.is_task_active(player.get_player_ped(pid), 222)) and not player.is_player_in_any_vehicle(pid) and not player_func.is_player_moving_fast(pid) and not player_func.is_player_in_interior(pid) then
						if (settings["» Exclude Friends From Detections"].Enabled and player.is_player_friend(pid)) or (settings["» Exclude Whitelisted Players From Detections"].Enabled and not player.can_player_be_modder(pid)) then
						else
							if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Anti AFK Bypass"]) then
								if f.value == 0 then
									menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Anti AFK Bypass", "Meteor Modder Detection", 12, 0x00A2FF)
									player.set_player_as_modder(pid, custommodderflags["Anti AFK Bypass"])
								elseif f.value == 1 then
									menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Anti AFK Bypass", "Meteor Modder Detection", 12, 0x00A2FF)
								elseif f.value == 2 then
									player.set_player_as_modder(pid, custommodderflags["Anti AFK Bypass"])
								end
							end
						end
					end
				end
			end
		end
	end
	settings["» Anti AFK Bypass Detection"].Enabled = f.on
	settings["» Anti AFK Bypass Detection"].Value = f.value
end)
feature["» Anti AFK Bypass Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Anti AFK Bypass Detection"].value = 0

feature["» Teleportation Detection"] = menu.add_feature("» Teleportation", "value_str", localparents["» Modder Detections"].id, function(f, pid)
	settings["» Teleportation Detection"].Enabled = f.on
	settings["» Teleportation Detection"].Value = f.value
	if f.on then
		local last_player_position = {}
		while f.on do
			system.yield(0)
			if network.is_session_started() then
				for pid = 0, 31 do
					if player.is_player_valid(pid) then
						if player.is_player_playing(pid) and natives.IS_PED_IN_PARACHUTE_FREE_FALL(player.get_player_ped(pid)):__tointeger() == 0 and entity.is_entity_visible(player.get_player_ped(pid)) and not player.is_player_god(pid) and not ped.is_ped_ragdoll(player.get_player_ped(pid)) and not player.is_player_in_any_vehicle(pid) and not player_func.is_player_in_interior(pid) then
							last_player_position[pid] = player.get_player_coords(pid)
						end
					else
						last_player_position[pid] = nil
					end
				end
				system.wait(100)
				for pid = 0, 31 do
					if player.is_player_valid(pid) then
						if last_player_position[pid] ~= nil then
							if utilities.get_distance_between(v3(player.get_player_coords(pid).x, player.get_player_coords(pid).y, 100), v3(last_player_position[pid].x, last_player_position[pid].y, 100)) > 1000 and utilities.get_distance_between(player.get_player_coords(player.player_id()), player.get_player_coords(pid)) < 5000 and player.is_player_playing(pid) and natives.IS_PED_IN_PARACHUTE_FREE_FALL(player.get_player_ped(pid)):__tointeger() == 0 and entity.is_entity_visible(player.get_player_ped(pid)) and not player.is_player_god(pid) and not ped.is_ped_ragdoll(player.get_player_ped(pid)) and not player.is_player_in_any_vehicle(pid) and not player_func.is_player_in_interior(pid) then
								if (settings["» Exclude Friends From Detections"].Enabled and player.is_player_friend(pid)) or (settings["» Exclude Whitelisted Players From Detections"].Enabled and not player.can_player_be_modder(pid)) then
								else
									if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Teleportation"]) then
										if f.value == 0 then
											menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Teleportation", "Meteor Modder Detection", 12, 0x00A2FF)
											player.set_player_as_modder(pid, custommodderflags["Teleportation"])
										elseif f.value == 1 then
											menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Teleportation", "Meteor Modder Detection", 12, 0x00A2FF)
										elseif f.value == 2 then
											player.set_player_as_modder(pid, custommodderflags["Teleportation"])
										end
									end
								end
							end
						end
					end
					last_player_position[pid] = nil
				end
			end
		end
	end
	settings["» Teleportation Detection"].Enabled = f.on
	settings["» Teleportation Detection"].Value = f.value
end)
feature["» Teleportation Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Teleportation Detection"].value = 0

feature["» Super Run Detection"] = menu.add_feature("» Super Run", "value_str", localparents["» Modder Detections"].id, function(f, pid)
	settings["» Super Run Detection"].Enabled = f.on
	settings["» Super Run Detection"].Value = f.value
	if f.on then
		while f.on do
			system.yield(100)
			if network.is_session_started() then
				for pid = 0, 31 do
					if player.is_player_valid(pid) then
						if entity.get_entity_speed(player.get_player_ped(pid)) > 36 and utilities.get_distance_between(player.get_player_coords(player.player_id()), player.get_player_coords(pid)) < 800 and natives.GET_ENTITY_HEIGHT_ABOVE_GROUND(player.get_player_ped(pid)):__tonumber() > 0.0 and natives.GET_ENTITY_HEIGHT_ABOVE_GROUND(player.get_player_ped(pid)):__tonumber() < 1.2 and natives.IS_PED_JUMPING_OUT_OF_VEHICLE(player.get_player_ped(pid)):__tointeger() == 0 and natives.IS_PED_FALLING(player.get_player_ped(pid)):__tointeger() == 0 and natives.IS_PED_IN_PARACHUTE_FREE_FALL(player.get_player_ped(pid)):__tointeger() == 0 and player_func.is_player_moving(pid) and not ai.is_task_active(player.get_player_ped(pid), 422) and not player.is_player_in_any_vehicle(pid) and not ped.is_ped_ragdoll(player.get_player_ped(pid)) and not player_func.is_player_in_interior(pid) then
							if (settings["» Exclude Friends From Detections"].Enabled and player.is_player_friend(pid)) or (settings["» Exclude Whitelisted Players From Detections"].Enabled and not player.can_player_be_modder(pid)) then
							else
								if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Super Run"]) then
									if f.value == 0 then
										menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Frame Flags | Super Run", "Meteor Modder Detection", 12, 0x00A2FF)
										player.set_player_as_modder(pid, custommodderflags["Super Run"])
									elseif f.value == 1 and not SuperRunDetectionPlayer[pid] then
										menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Frame Flags | Super Run", "Meteor Modder Detection", 12, 0x00A2FF)
										SuperRunDetectionPlayer[pid] = true
									elseif f.value == 2 then
										player.set_player_as_modder(pid, custommodderflags["Super Run"])
									end
								end
							end
						end
					end
				end
			end
		end
	end
	settings["» Super Run Detection"].Enabled = f.on
	settings["» Super Run Detection"].Value = f.value
end)
feature["» Super Run Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Super Run Detection"].value = 0

feature["» Lobby Spoof Detection"] = menu.add_feature("» Lobby Spoof", "value_str", localparents["» Modder Detections"].id, function(f, pid)
	settings["» Lobby Spoof Detection"].Enabled = f.on
	settings["» Lobby Spoof Detection"].Value = f.value
	if f.on then
		local PlayerNames = {}
		local PlayerSCIDs = {}
		while f.on do
			system.yield(4000)
			if network.is_session_started() then
				for pid = 0, 31 do
					if player.is_player_valid(pid) then
						table.insert(PlayerNames, player.get_player_name(pid))
						table.insert(PlayerSCIDs, player.get_player_scid(pid))
					end
				end
				local name_entries = 0
				for a = 1, #PlayerNames do
					if PlayerNames[a] ~= nil and PlayerNames[a + 1] ~= nil then
						if PlayerNames[a] == PlayerNames[a + 1] then
							name_entries = name_entries + 1
						end
					end
				end
				local scid_entries = 0
				for a = 1, #PlayerSCIDs do
					if PlayerSCIDs[a] ~= nil and PlayerSCIDs[a + 1] ~= nil then
						if PlayerSCIDs[a] > 0 and PlayerSCIDs[a + 1] > 0 then
							if PlayerSCIDs[a] == PlayerSCIDs[a + 1] then
								scid_entries = scid_entries + 1
							end
						end
					end
				end
				if name_entries > 4 or scid_entries > 4 then
					local guilty_player = player.get_host()
					if guilty_player ~= nil then
						if player.is_player_valid(guilty_player) then
							if (settings["» Exclude Friends From Detections"].Enabled and player.is_player_friend(guilty_player)) or (settings["» Exclude Whitelisted Players From Detections"].Enabled and not player.can_player_be_modder(guilty_player)) then
							else
								if guilty_player ~= player.player_id() and player.is_player_valid(guilty_player) and not player.is_player_modder(guilty_player, custommodderflags["Lobby Spoof"]) then
									if f.value == 0 then
										menu.notify("Player: " .. player.get_player_name(guilty_player) .. "\nReason: Lobby Spoof", "Meteor Modder Detection", 12, 0x00A2FF)
										player.set_player_as_modder(guilty_player, custommodderflags["Lobby Spoof"])
									elseif f.value == 1 and not LobbySpoofDetectionPlayer[guilty_player] then
										menu.notify("Player: " .. player.get_player_name(guilty_player) .. "\nReason: Lobby Spoof", "Meteor Modder Detection", 12, 0x00A2FF)
										LobbySpoofDetectionPlayer[guilty_player] = true
									elseif f.value == 2 then
										player.set_player_as_modder(guilty_player, custommodderflags["Lobby Spoof"])
									end
								end
							end
						end
					end
				end
			end
		end
	end
	settings["» Lobby Spoof Detection"].Enabled = f.on
	settings["» Lobby Spoof Detection"].Value = f.value
end)
feature["» Lobby Spoof Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Lobby Spoof Detection"].value = 0

feature["» Exclude Friends From Detections"] = menu.add_feature("» Exclude Friends", "toggle", localparents["» Modder Detections"].id, function(f)
    settings["» Exclude Friends From Detections"].Enabled = f.on
end)

feature["» Exclude Whitelisted Players From Detections"] = menu.add_feature("» Exclude Whitelisted Players", "toggle", localparents["» Modder Detections"].id, function(f)
    settings["» Exclude Whitelisted Players From Detections"].Enabled = f.on
end)


local locations = {}

local function generate_string(id, name, x, y, z)
    return id .. "||" .. name .. "||" .. x .. "," .. y .. "," .. z
end

local function rename_teleport_location(id, name, x, y, z)
    local found_index = false
    local file = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\Data\\CustomLocations.txt", 'r')
    local file_content = {}
    local last_checked_line = 0
    for line in file:lines() do
        last_checked_line = last_checked_line + 1
        table.insert (file_content, line)

        local main_parts = text_func.split_string(line, "||")
        local location_id = main_parts[1]

        if location_id == id then
            found_index = last_checked_line
        end
    end
    io.close(file)

    if found_index then
        file_content[found_index] = generate_string(id, name, x, y, z)

        file = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\Data\\CustomLocations.txt", 'w')
        for index, value in ipairs(file_content) do
            file:write(value..'\n')
        end
        io.close(file)

        locations[id].name = name
        locations[id].data.id = id
        locations[id].data.name = name
        locations[id].data.x = x
        locations[id].data.y = y
        locations[id].data.z = z

        return true
    else
        return false
    end
end

local function delete_location(id, name, x, y, z)
    local found = false
    local file = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\Data\\CustomLocations.txt", 'r')
    local file_content = {}
    for line in file:lines() do
        local main_parts = text_func.split_string(line, "||")
        local location_id = main_parts[1]

        if location_id == id then
            found = true
        else
            table.insert(file_content, line)
        end
    end
    io.close(file)

    if found then
        file = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\Data\\CustomLocations.txt", 'w')
        for index, value in ipairs(file_content) do
            file:write(value..'\n')
        end
        io.close(file)
        
        return true
    else
        return false
    end
end


menu.add_feature("» Save To Default", "action", localparents["» General"].id, function(f)
	text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", "") .. "\\Default.ini", "w"), "")
	for i = 1, #all_settings do
		text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", "") .. "\\Default.ini", "a"), "" .. all_settings[i] .. "|" .. tostring(settings[all_settings[i]].Enabled) .. "|" .. tostring(settings[all_settings[i]].Value) .. "\n")
	end
	system.wait(100)
	menu.notify("Successfully saved config to settings!", Meteor, 3, 0x00ff00)
end)

menu.add_feature("» Reset Default Settings", "action", localparents["» General"].id, function(f)
	text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", "") .. "\\Default.ini", "w"), "")
	system.wait(100)
	menu.notify("Successfully reset settings!", Meteor, 3, 0x00ff00)
end)

menu.add_feature("» Create New Profile", "action", localparents["» General"].id, function(f)
	local input_stat, input_val = input.get("Enter Profile Name", "", 12, 0)
    if input_stat == 1 then
        return HANDLER_CONTINUE
    end
    if input_stat == 2 then
        return HANDLER_POP
    end

	if input_val ~= "" and input_val ~= "Default" then
		if not utils.file_exists(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", "") .. "\\" .. input_val .. ".ini") then
			text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", "") .. "\\" .. input_val .. ".ini", "w"), "")
			for i = 1, #all_settings do
				text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", "") .. "\\" .. input_val .. ".ini", "a"), "" .. all_settings[i] .. "|" .. tostring(settings[all_settings[i]].Enabled) .. "|" .. tostring(settings[all_settings[i]].Value) .. "\n")
			end
			system.wait(100)
			menu.notify("Successfully saved config to new profile!", Meteor, 3, 0x00ff00)
			for i = 1, 100 do
				if feature["» Settings Profile " .. i] then
					menu.delete_feature(feature["» Settings Profile " .. i].id)
				end
			end
			local all_ini_profiles = utils.get_all_files_in_directory(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles", ""), "ini")
			if #all_ini_profiles > 0 then
				for i = 1, #all_ini_profiles do
					feature["» Settings Profile " .. i] = menu.add_feature("" .. all_ini_profiles[i] .. "", "action_value_str", localparents["» Settings Profiles"].id, function(f)
						if f.value == 0 then
							if utils.file_exists(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", all_ini_profiles[i])) then
								local file = io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", all_ini_profiles[i]), "r")
								for line in file:lines() do
									if string.find(line, "|") then
										local parts = text_func.split_string(line, "|")
										if feature["" .. parts[1] .. ""] then
											if tostring(parts[2]) ~= "nil" then
												if tostring(parts[2]) == "true" then
													feature["" .. parts[1] .. ""].on = true
												else
													feature["" .. parts[1] .. ""].on = false
												end
											end
											if tostring(parts[3]) ~= "nil" then
												feature["" .. parts[1] .. ""].value = tonumber(parts[3])
												if settings["" .. parts[1] .. ""].Value then
													settings["" .. parts[1] .. ""].Value = tonumber(parts[3])
												end
											end
										end
									end
								end
								menu.notify("Successfully loaded profile!", Meteor, 4, 0x00ff00)
							end
						elseif f.value == 1 then
							if utils.file_exists(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", all_ini_profiles[i])) then
								local all_load_profiles = utils.get_all_files_in_directory(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\Load", ""), "ini")
								for i = 1, #all_load_profiles do
									if utils.file_exists(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\Settings Profiles\\Load\\" .. all_load_profiles[i]) then
										io.remove(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\Settings Profiles\\Load\\" .. all_load_profiles[i])
									end
								end
								text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\Load\\", "") .. "\\" .. all_ini_profiles[i], "w"), "")
								menu.notify("Selected Profile now loads on default!", Meteor, 3, 0x00ff00)
							end
						elseif f.value == 2 then
							if utils.file_exists(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", all_ini_profiles[i])) then
								local file_real = all_ini_profiles[i]
								text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", file_real), "w"), "")
								for i = 1, #all_settings do
									text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", file_real), "a"), "" .. all_settings[i] .. "|" .. tostring(settings[all_settings[i]].Enabled) .. "|" .. tostring(settings[all_settings[i]].Value) .. "\n")
								end
								system.wait(100)
								menu.notify("Successfully saved config to Profile!", Meteor, 3, 0x00ff00)
							end
						elseif f.value == 3 then
							if utils.file_exists(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", all_ini_profiles[i])) then
								text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", all_ini_profiles[i]), "w"), "")
								menu.notify("Successfully reset Profile!", Meteor, 3, 0x00ff00)
							end
						elseif f.value == 4 then
							if utils.file_exists(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", all_ini_profiles[i])) then
								if all_ini_profiles[i] ~= "Default.ini" then
									io.remove(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", all_ini_profiles[i]))
									menu.delete_feature(feature["» Settings Profile " .. i].id)
									menu.notify("Successfully deleted Profile!", Meteor, 3, 0x00ff00)
								else
									menu.notify("You can't delete the default profile!", Meteor, 3, 211)
								end
							end
						end
					end)
					feature["» Settings Profile " .. i]:set_str_data({"Load", "Load As Default", "Save", "Reset", "Delete"})
				end
			end
		end
	else
		menu.notify("Invalid Profile Name", Meteor, 3, 211)
	end
end)

feature["» Display Welcome Screen"] = menu.add_feature("» Display Welcome Screen", "toggle", localparents["» General"].id, function(f)
    settings["» Display Welcome Screen"].Enabled = f.on
end)

localparents["» Settings Profiles"] = menu.add_feature("» Settings Profiles", "parent", localparents["» General"].id)

do
	local all_ini_profiles = utils.get_all_files_in_directory(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles", ""), "ini")
	if #all_ini_profiles > 0 then
		for i = 1, #all_ini_profiles do
			feature["» Settings Profile " .. i] = menu.add_feature("" .. all_ini_profiles[i] .. "", "action_value_str", localparents["» Settings Profiles"].id, function(f)
				if f.value == 0 then
					if utils.file_exists(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", all_ini_profiles[i])) then
						local file = io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", all_ini_profiles[i]), "r")
						for line in file:lines() do
							if string.find(line, "|") then
								local parts = text_func.split_string(line, "|")
								if feature["" .. parts[1] .. ""] then
									if tostring(parts[2]) ~= "nil" then
										if tostring(parts[2]) == "true" then
											feature["" .. parts[1] .. ""].on = true
										else
											feature["" .. parts[1] .. ""].on = false
										end
									end
									if tostring(parts[3]) ~= "nil" then
										feature["" .. parts[1] .. ""].value = tonumber(parts[3])
										if settings["" .. parts[1] .. ""].Value then
											settings["" .. parts[1] .. ""].Value = tonumber(parts[3])
										end
									end
								end
							end
						end
						menu.notify("Successfully loaded profile!", Meteor, 4, 0x00ff00)
					end
				elseif f.value == 1 then
					if utils.file_exists(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", all_ini_profiles[i])) then
						local all_load_profiles = utils.get_all_files_in_directory(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\Load", ""), "ini")
						for i = 1, #all_load_profiles do
							if utils.file_exists(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\Settings Profiles\\Load\\" .. all_load_profiles[i]) then
								io.remove(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\Settings Profiles\\Load\\" .. all_load_profiles[i])
							end
						end
						text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\Load\\", "") .. "\\" .. all_ini_profiles[i], "w"), "")
						menu.notify("Selected Profile now loads on default!", Meteor, 3, 0x00ff00)
					end
				elseif f.value == 2 then
					if utils.file_exists(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", all_ini_profiles[i])) then
						local file_real = all_ini_profiles[i]
						text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", file_real), "w"), "")
						for i = 1, #all_settings do
							text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", file_real), "a"), "" .. all_settings[i] .. "|" .. tostring(settings[all_settings[i]].Enabled) .. "|" .. tostring(settings[all_settings[i]].Value) .. "\n")
						end
						system.wait(100)
						menu.notify("Successfully saved config to Profile!", Meteor, 3, 0x00ff00)
					end
				elseif f.value == 3 then
					if utils.file_exists(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", all_ini_profiles[i])) then
						text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", all_ini_profiles[i]), "w"), "")
						menu.notify("Successfully reset Profile!", Meteor, 3, 0x00ff00)
					end
				elseif f.value == 4 then
					if utils.file_exists(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", all_ini_profiles[i])) then
						if all_ini_profiles[i] ~= "Default.ini" then
							io.remove(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", all_ini_profiles[i]))
							menu.delete_feature(feature["» Settings Profile " .. i].id)
							menu.notify("Successfully deleted Profile!", Meteor, 3, 0x00ff00)
						else
							menu.notify("You can't delete the default profile!", Meteor, 3, 211)
						end
					end
				end
			end)
			feature["» Settings Profile " .. i]:set_str_data({"Load", "Load As Default", "Save", "Reset", "Delete"})
		end
	end
end

localparents["» Easy Autoexec"] = menu.add_feature("» Easy Autoexec", "parent", localparents["» General"].id)

local meteor_autoexec_toggled = false
local autoexec_selected_scripts = {}
local autoexec_selected_scripts_count = 1

local autoexec_delay_enabled = false
local autoexec_delay_int = 0

menu.add_feature("» Create Meteor autoexec.lua", "action", localparents["» Easy Autoexec"].id, function(f)
	if utils.file_exists(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts", "") .. "\\" .. "autoexec.lua") then
		if meteor_autoexec_toggled then
			meteor_autoexec_toggled = false
			text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts", "") .. "\\autoexec.lua", "w"), "")
			text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts", "") .. "\\autoexec.lua", "a"), "do\n    if utils.file_exists(utils.get_appdata_path(\"PopstarDevs\\\\2Take1Menu\\\\scripts\", \"\") .. \"\\\\Meteor.lua\") then\n        local meteor = loadfile(utils.get_appdata_path(\"PopstarDevs\\\\2Take1Menu\\\\scripts\", \"\") .. \"\\\\Meteor.lua\")\n		meteor()\n    end\nend")
			menu.notify("Successfully wrote Meteor autoexec!", Meteor, 5, 0x00ff00)
		else
			meteor_autoexec_toggled = true
			menu.notify("You already have an autoexec! Toggle again to overwrite the current autoexec", Meteor, 5, 211)
		end
	else
		meteor_autoexec_toggled = false
		text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts", "") .. "\\autoexec.lua", "w"), "")
		text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts", "") .. "\\autoexec.lua", "a"), "do\n    if utils.file_exists(utils.get_appdata_path(\"PopstarDevs\\\\2Take1Menu\\\\scripts\", \"\") .. \"\\\\Meteor.lua\") then\n        local meteor = loadfile(utils.get_appdata_path(\"PopstarDevs\\\\2Take1Menu\\\\scripts\", \"\") .. \"\\\\Meteor.lua\")\n		meteor()\n    end\nend")
		menu.notify("Successfully wrote Meteor autoexec!", Meteor, 5, 0x00ff00)
	end
end)

localparents["» Custom autoexec.lua"] = menu.add_feature("» Custom autoexec.lua", "parent", localparents["» Easy Autoexec"].id)

menu.add_feature("» Create autoexec.lua", "action", localparents["» Custom autoexec.lua"].id, function(f)
	if utils.file_exists(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts", "") .. "\\" .. "autoexec.lua") then
		if meteor_autoexec_toggled then
			meteor_autoexec_toggled = false
			if #autoexec_selected_scripts > 0 then
				local all_scripts_string = ""
				for i = 1, #autoexec_selected_scripts do
					all_scripts_string = all_scripts_string .. "\n        \"" .. autoexec_selected_scripts[i] .. "\","
				end
				if autoexec_delay_enabled and autoexec_delay_int > 0 then
					text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts", "") .. "\\autoexec.lua", "w"), "")
					text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts", "") .. "\\autoexec.lua", "a"), "do\n    menu.create_thread(function()\n        local all_lua_scripts = {" .. all_scripts_string .. "\n        }\n        system.wait(" .. autoexec_delay_int .. ")\n        for i = 1, #all_lua_scripts do\n            if utils.file_exists(utils.get_appdata_path(\"PopstarDevs\\\\2Take1Menu\\\\scripts\", \"\") .. \"\\\\\" .. all_lua_scripts[i] .. \"\") then\n                local all_lua_scripts_file = loadfile(utils.get_appdata_path(\"PopstarDevs\\\\2Take1Menu\\\\scripts\", \"\") .. \"\\\\\" .. all_lua_scripts[i] .. \"\")\n                all_lua_scripts_file()\n            end\n        end\n    end, nil)\nend")
				else
					text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts", "") .. "\\autoexec.lua", "w"), "")
					text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts", "") .. "\\autoexec.lua", "a"), "do\n    local all_lua_scripts = {" .. all_scripts_string .. "\n    }\n    for i = 1, #all_lua_scripts do\n        if utils.file_exists(utils.get_appdata_path(\"PopstarDevs\\\\2Take1Menu\\\\scripts\", \"\") .. \"\\\\\" .. all_lua_scripts[i] .. \"\") then\n            local all_lua_scripts_file = loadfile(utils.get_appdata_path(\"PopstarDevs\\\\2Take1Menu\\\\scripts\", \"\") .. \"\\\\\" .. all_lua_scripts[i] .. \"\")\n            all_lua_scripts_file()\n        end\n    end\nend")
				end
				menu.notify("Successfully wrote Custom autoexec!", Meteor, 5, 0x00ff00)
			else
				menu.notify("Empty Selection!", Meteor, 5, 211)
			end
		else
			meteor_autoexec_toggled = true
			menu.notify("You already have an autoexec! Toggle again to overwrite the current autoexec", Meteor, 5, 211)
		end
	else
		meteor_autoexec_toggled = false
		if #autoexec_selected_scripts > 0 then
			local all_scripts_string = ""
			for i = 1, #autoexec_selected_scripts do
				all_scripts_string = all_scripts_string .. "\n        \"" .. autoexec_selected_scripts[i] .. "\","
			end
			if autoexec_delay_enabled and autoexec_delay_int > 0 then
				text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts", "") .. "\\autoexec.lua", "w"), "")
				text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts", "") .. "\\autoexec.lua", "a"), "do\n    menu.create_thread(function()\n        local all_lua_scripts = {" .. all_scripts_string .. "\n        }\n        system.wait(" .. autoexec_delay_int .. ")\n        for i = 1, #all_lua_scripts do\n            if utils.file_exists(utils.get_appdata_path(\"PopstarDevs\\\\2Take1Menu\\\\scripts\", \"\") .. \"\\\\\" .. all_lua_scripts[i] .. \"\") then\n                local all_lua_scripts_file = loadfile(utils.get_appdata_path(\"PopstarDevs\\\\2Take1Menu\\\\scripts\", \"\") .. \"\\\\\" .. all_lua_scripts[i] .. \"\")\n                all_lua_scripts_file()\n            end\n        end\n    end, nil)\nend")
			else
				text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts", "") .. "\\autoexec.lua", "w"), "")
				text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts", "") .. "\\autoexec.lua", "a"), "do\n    local all_lua_scripts = {" .. all_scripts_string .. "\n    }\n    for i = 1, #all_lua_scripts do\n        if utils.file_exists(utils.get_appdata_path(\"PopstarDevs\\\\2Take1Menu\\\\scripts\", \"\") .. \"\\\\\" .. all_lua_scripts[i] .. \"\") then\n            local all_lua_scripts_file = loadfile(utils.get_appdata_path(\"PopstarDevs\\\\2Take1Menu\\\\scripts\", \"\") .. \"\\\\\" .. all_lua_scripts[i] .. \"\")\n            all_lua_scripts_file()\n        end\n    end\nend")
			end
			menu.notify("Successfully wrote Custom autoexec!", Meteor, 5, 0x00ff00)
		else
			menu.notify("Empty Selection!", Meteor, 5, 211)
		end
	end
end)

menu.add_feature("» Remove All Scripts In Selection", "action", localparents["» Custom autoexec.lua"].id, function(f)
	autoexec_selected_scripts = {}
	autoexec_selected_scripts_count = 1
	menu.notify("Removed all scripts from selection!", Meteor, 5, 0x00ff00)
end)

feature["» Add Delay To autoexec.lua"] = menu.add_feature("» Add Delay To autoexec.lua", "value_i", localparents["» Custom autoexec.lua"].id, function(f)
	autoexec_delay_enabled = f.on
	autoexec_delay_int = f.value
end)
feature["» Add Delay To autoexec.lua"].max = 5000
feature["» Add Delay To autoexec.lua"].min = 0
feature["» Add Delay To autoexec.lua"].mod = 200
feature["» Add Delay To autoexec.lua"].value = 0

localparents["» autoexec.lua Add Scripts"] = menu.add_feature("» Add Scripts", "parent", localparents["» Custom autoexec.lua"].id)

do
	local all_scripts = utils.get_all_files_in_directory(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts", ""), "lua")
	if #all_scripts > 0 then
		for i = 1, #all_scripts do
			menu.add_feature("" .. all_scripts[i] .. "", "action", localparents["» autoexec.lua Add Scripts"].id, function(f)
				menu.notify("Successfully added " .. all_scripts[i] .. " to the selection!", Meteor, 3, 0x00ff00)
				autoexec_selected_scripts[autoexec_selected_scripts_count] = "" .. all_scripts[i] .. ""
				autoexec_selected_scripts_count = autoexec_selected_scripts_count + 1
			end)
		end
	end
end

localparents["» Gif Headers"] = menu.add_feature("» Gif Headers", "parent", localparents["» General"].id)

feature["» Header Height Offset"] = menu.add_feature("» Header Height Offset", "autoaction_value_f", localparents["» Gif Headers"].id, function(f)
	settings["» Header Height Offset"].Value = f.value
end)
feature["» Header Height Offset"].max = 1.00
feature["» Header Height Offset"].min = -1.00
feature["» Header Height Offset"].mod = 0.01
feature["» Header Height Offset"].value = 0.00

feature["» Header Alpha"] = menu.add_feature("» Header Alpha", "autoaction_value_i", localparents["» Gif Headers"].id, function(f)
	settings["» Header Alpha"].Value = f.value
end)
feature["» Header Alpha"].max = 255
feature["» Header Alpha"].min = 0
feature["» Header Alpha"].mod = 5
feature["» Header Alpha"].value = 255

feature["» Header Playback Speed"] = menu.add_feature("» Header Playback Speed", "autoaction_value_i", localparents["» Gif Headers"].id, function(f)
	settings["» Header Playback Speed"].Value = f.value
end)
feature["» Header Playback Speed"].max = 1000
feature["» Header Playback Speed"].min = 0
feature["» Header Playback Speed"].mod = 10
feature["» Header Playback Speed"].value = 100

localparents["» Header Packs"] = menu.add_feature("» Header Packs", "parent", localparents["» Gif Headers"].id)

do
	local all_gif_packs = utils.get_all_sub_directories_in_directory(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\GIF\\", ""))
	if #all_gif_packs > 0 then
		for i = 1, #all_gif_packs do
			feature["» Header Gif Packs " .. i] = menu.add_feature("" .. all_gif_packs[i] .. "", "toggle", localparents["» Header Packs"].id, function(f)
				settings["» Header Gif Packs " .. i].Enabled = f.on
				local gif_pack_assets = utils.get_all_files_in_directory(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\GIF\\" .. all_gif_packs[i], ""), "png")
				if f.on then
					local all_registered_sprites = {}
					for a = 1, #gif_pack_assets do
						all_registered_sprites[#all_registered_sprites + 1] = scriptdraw.register_sprite(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\GIF\\" .. all_gif_packs[i] .. "\\", gif_pack_assets[a]))
					end
					local MenuXFeat = menu.get_feature_by_hierarchy_key("local.settings.menu_x")
					local MenuYFeat = menu.get_feature_by_hierarchy_key("local.settings.menu_y")
					local ElementWidthFeat = menu.get_feature_by_hierarchy_key("local.settings.menu_ui.menu_layout.element_width")
					threads["» Header Gif Packs " .. i] = menu.create_thread(function()
						while f.on do
							if #gif_pack_assets > 0 then
								for a = 1, #gif_pack_assets do
									local time = utils.time_ms() + feature["» Header Playback Speed"].value
									while time > utils.time_ms() do
										if menu.is_open() then
											-- Credits to Proddy for the math
											local spriteSize = scriptdraw.get_sprite_size(all_registered_sprites[a])
											local scale = ElementWidthFeat.value / spriteSize.x
		
											spriteSize = spriteSize * scale
		
											local menuX = MenuXFeat.value
											local menuY = MenuYFeat.value
		
											local topLeftX = (menuX + spriteSize.x / 2)
											local topLeftY = (menuY + 1 - spriteSize.y / 2) or (menuY + spriteSize.y / 2)
		
											local x = scriptdraw.pos_pixel_to_rel_x(topLeftX)
											local y = scriptdraw.pos_pixel_to_rel_y(topLeftY)
											scriptdraw.draw_sprite(all_registered_sprites[a], v2(x, y + settings["» Header Height Offset"].Value), scale, 0.0, text_func.rgba_to_uint32_t(255, 255, 255, settings["» Header Alpha"].Value))
										end
										system.yield(0)
									end
								end
							end
							system.yield(0)
						end
					end, nil)
				end
				if not f.on then
					if threads["» Header Gif Packs " .. i] then
						menu.delete_thread(threads["» Header Gif Packs " .. i])
						threads["» Header Gif Packs " .. i] = nil
					end
					all_registered_sprites = {}
				end
				settings["» Header Gif Packs " .. i].Enabled = f.on
			end)
		end
	end
end

local all_fucking_features_idk = {}

localparents["» Menu Feature Search"] = menu.add_feature("» Menu Feature Search", "parent", localparents["» General"].id, function()
	if not feature["» Search <>"] then
		feature["» Search <>"] = menu.add_feature("» Search <>", "action", localparents["» Menu Feature Search"].id, function(f)
			local input_stat, input_val = input.get("", "", 999, 0)
			if input_stat == 1 then
				return HANDLER_CONTINUE
			end
			if input_stat == 2 then
				return HANDLER_POP
			end
			for i = 1, #DataMain.main_parent_keys do
				local real = menu.get_feature_by_hierarchy_key(DataMain.main_parent_keys[i])
				local children = real.children
				for a = 1, #children do
					if children[a].type == 2048 then
						local children_children = children[a].children
						for b = 1, #children_children do
							if children_children[b].type == 2048 then
								local children_children_children = children_children[b].children
								for c = 1, #children_children_children do
									if children_children_children[c].type ~= 2048 then
										if string.find(children_children_children[c].name:lower(), input_val:lower()) then
											local name_string = children_children_children[c].name
											if children_children_children[c].parent ~= nil then
												name_string = children_children_children[c].parent.name .. " > " .. name_string
												if children_children_children[c].parent.parent ~= nil then
													name_string = children_children_children[c].parent.parent.name .. " > " .. name_string
													if children_children_children[c].parent.parent.parent ~= nil then
														name_string = children_children_children[c].parent.parent.parent.name .. " > " .. name_string
													end
												end
											end
											all_fucking_features_idk[#all_fucking_features_idk + 1] = menu.add_feature(name_string, "action", localparents["» Menu Feature Search"].id)
										end
									end
								end
							else
								if string.find(children_children[b].name:lower(), input_val:lower()) then
									local name_string = children_children[b].name
									if children_children[b].parent ~= nil then
										name_string = children_children[b].parent.name .. " > " .. name_string
										if children_children[b].parent.parent ~= nil then
											name_string = children_children[b].parent.parent.name .. " > " .. name_string
										end
									end
									all_fucking_features_idk[#all_fucking_features_idk + 1] = menu.add_feature(name_string, "action", localparents["» Menu Feature Search"].id)
								end
							end
						end
					else
						if string.find(children[a].name:lower(), input_val:lower()) then
							local name_string = children[a].name
							if children[a].parent ~= nil then
								name_string = children[a].parent.name .. " > " .. name_string
							end
							all_fucking_features_idk[#all_fucking_features_idk + 1] = menu.add_feature(name_string, "action", localparents["» Menu Feature Search"].id)
						end
					end
				end
			end
		end)

		menu.add_feature("» Clear", "action", localparents["» Menu Feature Search"].id, function(f)
			for i = #all_fucking_features_idk, 1, -1 do
				menu.delete_feature(all_fucking_features_idk[i].id)
				system.yield(0)
			end
			all_fucking_features_idk = {}
		end)
	end
end)

feature["» Downgrade To Standard"] = menu.add_feature("» Downgrade To Standard", "toggle", localparents["» General"].id, function(f)
	settings["» Downgrade To Standard"].Enabled = f.on
	for i = 1, #DataMain.all_vip_features do
		if menu.get_feature_by_hierarchy_key(DataMain.all_vip_features[i]) then
			menu.get_feature_by_hierarchy_key(DataMain.all_vip_features[i]).hidden = f.on
		end
	end
	settings["» Downgrade To Standard"].Enabled = f.on
end)

localparents["» Script Updater"] = menu.add_feature("» Script Updater", "parent", localparents["» General"].id, function()
	menu.notify("You are not supposed to use that shit atm", Meteor, 12, 0x00A2FF)
end)

menu.add_feature("» test", "action", localparents["» Script Updater"].id, function(f)
	local code, MainMeteor = web.get("https://raw.githubusercontent.com/RulyPancake/MeteorUpdate/main/Meteor.lua")
	menu.notify(MainMeteor)
end)

menu.add_feature("» tree", "action", localparents["» Script Updater"].id, function(f)
	menu.notify("https://raw.githubusercontent.com/RulyPancake/MeteorUpdate/main/Meteor.lua")
	menu.notify("https://raw.githubusercontent.com/RulyPancake/MeteorUpdate/main/Meteor/Data/DataMain.lua")
	menu.notify("https://raw.githubusercontent.com/RulyPancake/MeteorUpdate/main/Meteor/Data/LoggedPlayers.log")
	menu.notify("https://raw.githubusercontent.com/RulyPancake/MeteorUpdate/main/Meteor/Data/ModderFlags.lua")
	menu.notify("https://raw.githubusercontent.com/RulyPancake/MeteorUpdate/main/Meteor/Data/RememberedPlayers.log")
	menu.notify("https://raw.githubusercontent.com/RulyPancake/MeteorUpdate/main/Meteor/Data/Settings.lua")
	menu.notify("https://raw.githubusercontent.com/RulyPancake/MeteorUpdate/main/Meteor/Lib/Memory.lua")
	menu.notify("https://raw.githubusercontent.com/RulyPancake/MeteorUpdate/main/Meteor/Lib/Menyoo.lua")
	menu.notify("https://raw.githubusercontent.com/RulyPancake/MeteorUpdate/main/Meteor/Lib/Natives.lua")
	menu.notify("https://raw.githubusercontent.com/RulyPancake/MeteorUpdate/main/Meteor/Lib/Player_Func.lua")
	menu.notify("https://raw.githubusercontent.com/RulyPancake/MeteorUpdate/main/Meteor/Lib/Script_Func.lua")
	menu.notify("https://raw.githubusercontent.com/RulyPancake/MeteorUpdate/main/Meteor/Lib/Text_Func.lua")
	menu.notify("https://raw.githubusercontent.com/RulyPancake/MeteorUpdate/main/Meteor/Lib/Utils.lua")
	menu.notify("https://raw.githubusercontent.com/RulyPancake/MeteorUpdate/main/Meteor/Mapper/NetEventIDs.lua")
	menu.notify("https://raw.githubusercontent.com/RulyPancake/MeteorUpdate/main/Meteor/Mapper/NetEventNames.lua")
	menu.notify("https://raw.githubusercontent.com/RulyPancake/MeteorUpdate/main/Meteor/Mapper/ObjectModels.lua")
	menu.notify("https://raw.githubusercontent.com/RulyPancake/MeteorUpdate/main/Meteor/Mapper/PedModels.lua")
	menu.notify("https://raw.githubusercontent.com/RulyPancake/MeteorUpdate/main/Meteor/Mapper/UserNetEventNames.lua")
	menu.notify("https://raw.githubusercontent.com/RulyPancake/MeteorUpdate/main/Meteor/Mapper/VehicleModels.lua")
	menu.notify("https://raw.githubusercontent.com/RulyPancake/MeteorUpdate/main/Meteor/SafeMode.lua")
end)

menu.add_feature("» ver", "action", localparents["» Script Updater"].id, function(f)
	local Response, MainMeteorVersion = web.get("https://raw.githubusercontent.com/RulyPancake/Meteor/main/Version.txt")
	menu.notify(MainMeteorVersion)
	menu.notify(tostring(MainMeteorVersion == MeteorVer .. "\n"))
end)


local function random_args(id, amount)
    local args = {id}
    if not amount or amount == 0 then
        return args
    else
        for i = 2, amount + 1 do
            args[i] = math.random(-2147483647, 2147483647)
        end
        return args
    end
end

local fuck = menu.add_player_feature("» Script Host Curse", "action_value_str", playerparents["» Script Events"], function(feat)
    local events = {-1539131577, -2093023277, -786546101}
    local id = script.get_host_of_this_script()
    if player.is_player_valid(id) then
        for i = 1, 5 do
            script.trigger_script_event(events[feat.value + 1], id, random_args(player.player_id(), 15))
        end
    end
end)
fuck:set_str_data({'v1', 'v2', 'v3'})


menu.add_player_feature("» Set Bounty", "action_value_str", playerparents["» Script Events"], function(f, pid)
    local input_stat, input_val = input.get("Enter Bounty Amount (0-10000)", "", 5, 3)
    if input_stat == 1 then
        return HANDLER_CONTINUE
    end
    if input_stat == 2 then
        return HANDLER_POP
    end

	if player.is_player_valid(pid) then
		if f.value == 0 then
			for i = 0, 31 do
				if player.is_player_valid(i) then
					script.trigger_script_event(1294995624, i, {player.player_id(), pid, 1, input_val, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, script_func.get_global_9(), script_func.get_global_10()})
				end
			end
		end
		if f.value == 1 then
			for i = 0, 31 do
				if player.is_player_valid(i) then
					script.trigger_script_event(1294995624, i, {player.player_id(), pid, 1, input_val, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, script_func.get_global_9(), script_func.get_global_10()})
				end
			end
		end
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end
end):set_str_data({
	"Anonymous",
	"Named"
})

menu.add_player_feature("» Send To Cayo Perico", "action_value_str", playerparents["» Script Events"], function(f, pid)
	if player.is_player_valid(pid) then
		if f.value == 0 then
			script.trigger_script_event(-621279188, pid, {player.player_id(), 1})
		elseif f.value == 1 then
       		script.trigger_script_event(1463943751, pid, {player.player_id(), pid, pid, 3, 1})
		elseif f.value == 2 then
            script.trigger_script_event(1463943751, pid, {player.player_id(), pid, pid, 4, 1})
		elseif f.value == 3 then
            script.trigger_script_event(1463943751, pid, {player.player_id(), pid, pid, 3, 0})
		elseif f.value == 4 then
            script.trigger_script_event(1463943751, pid, {player.player_id(), pid, pid, 4, 0})
        end
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end
end):set_str_data({
	"Original",
	"Beach Party (Plane)",
	"Beach Party (Instant)",
	"Los Santos (Airport)",
	"Los Santos (Beach)"
})

menu.add_player_feature("» Send To Brazil", "action", playerparents["» Script Events"], function(f, pid)
	if player.is_player_valid(pid) then
		script_func.send_to_brazil(pid)
		menu.notify("Successfully Sent Player To Brazil", Meteor)
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Send To Warehouse", "action", playerparents["» Script Events"], function(f, pid)
	if player.is_player_valid(pid) then
		script.trigger_script_event(-446275082, pid, {player.player_id(), 0, 1, math.random(1, 22)})
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Send To Mission", "action", playerparents["» Script Events"], function(f, pid)
	if player.is_player_valid(pid) then
		script.trigger_script_event(0x786FBAAE, pid, {player.player_id(), math.random(1, 7)})
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Force Casino Cutscene", "action", playerparents["» Script Events"], function(f, pid)
	if player.is_player_valid(pid) then
		script.trigger_script_event(0x3FAC59CA, pid, {player.player_id()})
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Infinite Loading Screen", "action_value_str", playerparents["» Script Events"], function(f, pid)
	if player.is_player_valid(pid) then
		if f.value == 0 then
			script.trigger_script_event(603406648, pid, {player.player_id(), 217})
		elseif f.value == 1 then
			script.trigger_script_event(962740265, pid, {player.player_id(), math.random(1, 12)})
		end
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end
end):set_str_data({
	"v1",
	"v2"
})

menu.add_player_feature("» Cash Removed Notification", "action_value_str", playerparents["» Script Events"], function(f, pid)
	if f.value == 0 then
		if player.is_player_valid(pid) then
			script.trigger_script_event(0x285DDF33, pid, {player.player_id(), 689178114, math.random(0, 2147483647)})
		else
			menu.notify("Invalid Player.", Meteor, 3, 211)
		end
	else
		local input_stat, input_val = input.get("Enter The Amount Of Money (0 - 2147483647)", "", 10, 0)
		if input_stat == 1 then
			return HANDLER_CONTINUE
		end
		if input_stat == 2 then
			return HANDLER_POP
		end
		if player.is_player_valid(pid) then
			script.trigger_script_event(0x285DDF33, pid, {player.player_id(), 689178114, input_val})
		else
			menu.notify("Invalid Player.", Meteor, 3, 211)
		end
	end
end):set_str_data({
	"Random",
	"Input"
})

menu.add_player_feature("» Cash Stolen Notification", "action_value_str", playerparents["» Script Events"], function(f, pid)
	if f.value == 0 then
		if player.is_player_valid(pid) then
			script.trigger_script_event(0x285DDF33, pid, {player.player_id(), 2187973097, math.random(0, 2147483647)})
		else
			menu.notify("Invalid Player.", Meteor, 3, 211)
		end
	elseif f.value == 1 then
		local input_stat, input_val = input.get("Enter The Amount Of Money (0 - 2147483647)", "", 10, 0)
		if input_stat == 1 then
			return HANDLER_CONTINUE
		end
		if input_stat == 2 then
			return HANDLER_POP
		end
		if player.is_player_valid(pid) then
			script.trigger_script_event(0x285DDF33, pid, {player.player_id(), 2187973097, input_val})
		else
			menu.notify("Invalid Player.", Meteor, 3, 211)
		end
	end
end):set_str_data({
	"Random",
	"Input"
})

menu.add_player_feature("» Cash Banked Notification", "action_value_str", playerparents["» Script Events"], function(f, pid)
	if f.value == 0 then
		if player.is_player_valid(pid) then
			script.trigger_script_event(0x285DDF33, pid, {player.player_id(), 1990572980, math.random(0, 2147483647)})
		else
			menu.notify("Invalid Player.", Meteor, 3, 211)
		end
	else
		local input_stat, input_val = input.get("Enter The Amount Of Money (0 - 2147483647)", "", 10, 0)
		if input_stat == 1 then
			return HANDLER_CONTINUE
		end
		if input_stat == 2 then
			return HANDLER_POP
		end
		if player.is_player_valid(pid) then
			script.trigger_script_event(0x285DDF33, pid, {player.player_id(), 1990572980, input_val})
		else
			menu.notify("Invalid Player.", Meteor, 3, 211)
		end
	end
end):set_str_data({
	"Random",
	"Input"
})

menu.add_player_feature("» Insurance Notification", "action_value_str", playerparents["» Script Events"], function(f, pid)
	if f.value == 0 then
		if player.is_player_valid(pid) then
			script.trigger_script_event(0x2FCF970F, pid, {player.player_id(), math.random(0, 2147483647)})
		else
			menu.notify("Invalid Player.", Meteor, 3, 211)
		end
	elseif f.value == 1 then
		local input_stat, input_val = input.get("Enter The Amount Of Money (0 - 2147483647)", "", 10, 0)
		if input_stat == 1 then
			return HANDLER_CONTINUE
		end
		if input_stat == 2 then
			return HANDLER_POP
		end
		if player.is_player_valid(pid) then
			script.trigger_script_event(0x2FCF970F, pid, {player.player_id(), input_val})
		else
			menu.notify("Invalid Player.", Meteor, 3, 211)
		end
	end
end):set_str_data({
	"Random",
	"Input"
})

menu.add_player_feature("» Script Freeze", "toggle", playerparents["» Script Events"], function(f, pid)
	while f.on do
		system.yield(0)
		if player.is_player_valid(pid) then
			script.trigger_script_event(1463943751, pid, {player.player_id()})
		else
			f.on = false
			menu.notify("Invalid Player.", Meteor, 3, 211)
			return
		end
	end
end)

menu.add_player_feature("» Force Camera Forward", "toggle", playerparents["» Script Events"], function(f, pid)
	while f.on do
		system.yield(0)
		if player.is_player_valid(pid) then
			script.trigger_script_event(0x2FC154DC, pid, {player.player_id(), 869796886, 0})
		else
			f.on = false
			menu.notify("Invalid Player.", Meteor, 3, 211)
			return
		end
	end
end)

menu.add_player_feature("» Bribe Authorities", "toggle", playerparents["» Script Events"], function(f, pid)
	while f.on do
		system.yield(0)
		if player.is_player_valid(pid) then
			script.trigger_script_event(0x66B0F59A, pid, {player.player_id(), 0, 0, utils.time_ms(), 0, script_func.get_global_main(pid)})
			system.wait(5000)
		else
			f.on = false
			menu.notify("Invalid Player.", Meteor, 3, 211)
			return
		end
	end
end)

menu.add_player_feature("» Off The Radar", "toggle", playerparents["» Script Events"], function(f, pid)
	while f.on do
		system.yield(0)
		if player.is_player_valid(pid) then
			script.trigger_script_event(-0x1757DB60, pid, {player.player_id(), utils.time() - 60, utils.time(), 1, 1, script_func.get_global_main(pid)})
			system.wait(5000)
		else
			f.on = false
			menu.notify("Invalid Player.", Meteor, 3, 211)
			return
		end
	end
end)

menu.add_player_feature("» Transaction Error", "toggle", playerparents["» Script Events"], function(f, pid)
	if f.on then
		while f.on do
			system.yield(0)
			if player.is_player_valid(pid) then
				script.trigger_script_event(-0x659322C8, pid, {player.player_id(), 50000, 0, 1, script_func.get_global_main(pid), script_func.get_global_9(), script_func.get_global_10(), 1})
			else
				f.on = false
				menu.notify("Invalid Player.", Meteor, 3, 211)
				return
			end
		end
	end
end)

menu.add_player_feature("» Block Passive Mode", "toggle", playerparents["» Script Events"], function(f, pid)
	while f.on do
		system.yield(0)
		if player.is_player_valid(pid) then
			script.trigger_script_event(0x4267B065, pid, {player.player_id(), 1})
			system.wait(500)
		else
			f.on = false
			menu.notify("Invalid Player.", Meteor, 3, 211)
			return
		end
	end
	if player.is_player_valid(pid) then
		script.trigger_script_event(0x4267B065, pid, {player.player_id(), 0})
	else
		f.on = false
		menu.notify("Invalid Player.", Meteor, 3, 211)
		return
	end
end)

playerparents["» Apartment Invites"] = menu.add_player_feature("» Apartment Invites", "parent", playerparents["» Script Events"]).id

menu.add_player_feature("» Infinite Apartment Invite", "action", playerparents["» Apartment Invites"], function(f, pid)
	if player.is_player_valid(pid) then
		script.trigger_script_event(0x23F74138, pid, {player.player_id(), pid, 4294967295, 1, 115, 0, 0, 0})
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Random Apartment Invite", "action", playerparents["» Apartment Invites"], function(f, pid)
	if player.is_player_valid(pid) then
		script.trigger_script_event(0x23F74138, pid, {player.player_id(), pid, 1, 0, math.random(1, 114), 1, 1, 1})
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Apartment Invite Loop", "toggle", playerparents["» Apartment Invites"], function(f, pid)
	while f.on do
		if player.is_player_valid(pid) then
			script.trigger_script_event(0x23F74138, pid, {player.player_id(), pid, 1, 0, math.random(1, 114), 1, 1, 1})
			system.wait(5000)
		else
			menu.notify("Invalid Player.", Meteor, 3, 211)
		end
	end
end)



menu.add_feature("» Send Chat Message Global", "action", localparents["» Chat Options"].id, function(f)
    local input_stat, input_val = input.get("", "", 999, 0)
    if input_stat == 1 then
        return HANDLER_CONTINUE
    end
    if input_stat == 2 then
        return HANDLER_POP
    end
    network.send_chat_message(input_val, false)
end)

menu.add_feature("» Send Chat Message Team", "action", localparents["» Chat Options"].id, function(f)
    local input_stat, input_val = input.get("", "", 999, 0)
    if input_stat == 1 then
        return HANDLER_CONTINUE
    end
    if input_stat == 2 then
        return HANDLER_POP
    end
    network.send_chat_message(input_val, true)
end)

menu.add_feature("» Clear Chat Log", "action", localparents["» Chat Options"].id, function(f)
	if utils.file_exists(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Logs\\Chat\\", "") .. "\\Chat.log") then
		text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Logs\\Chat\\", "") .. "\\Chat.log", "w"), "")
		menu.notify("Cleared Chat Log.", Meteor)
	end
end)

menu.add_feature("» Announce Richest Player", "action", localparents["» Chat Options"].id, function(f)
	if network.is_session_started() then
		local player_table = {}
		for pid = 0, 31 do
			if player.is_player_valid(pid) then
				table.insert(player_table, pid)
			end
		end
		table.sort(player_table, function(a, b)
			return (script_func.get_player_money(a) > script_func.get_player_money(b))
		end)
		if player_table[1] ~= nil then
			network.send_chat_message(player.get_player_name(player_table[1]) .. " is the biggest baller player in the session with " .. script_func.get_player_money_str(player_table[1]) .. "!", false)
		end
	end
end)

menu.add_feature("» Announce Poorest Player", "action", localparents["» Chat Options"].id, function(f)
	if network.is_session_started() then
		local player_table = {}
		for pid = 0, 31 do
			if player.is_player_valid(pid) then
				table.insert(player_table, pid)
			end
		end
		table.sort(player_table, function(a, b)
			return (script_func.get_player_money(a) < script_func.get_player_money(b))
		end)
		if player_table[1] ~= nil then
			network.send_chat_message(player.get_player_name(player_table[1]) .. " is the poorest bitch in the session with " .. script_func.get_player_money_str(player_table[1]), false)
		end
	end
end)

feature["» Notify Sent Messages"] = menu.add_feature("» Notify Sent Messages", "toggle", localparents["» Chat Options"].id, function(f)
	settings["» Notify Sent Messages"].Enabled = f.on
	if f.on then
		if listeners["» Notify Sent Messages"] == nil then
			listeners["» Notify Sent Messages"] = event.add_event_listener("chat", function(chat_message)
				menu.notify("Player: " .. tostring(player.get_player_name(chat_message.player)) .. "\nMessage: " .. chat_message.body .. "", Meteor, 2, 0x64FA7800)
			end)
		end
	end
	if not f.on then
		if listeners["» Notify Sent Messages"] then
			event.remove_event_listener("chat", listeners["» Notify Sent Messages"])
			listeners["» Notify Sent Messages"] = nil
		end
	end
	settings["» Notify Sent Messages"].Enabled = f.on
end)

feature["» Uwu-Ify Chat Messages"] = menu.add_feature("» Uwu-Ify Chat Messages", "toggle", localparents["» Chat Options"].id, function(f)
	settings["» Uwu-Ify Chat Messages"].Enabled = f.on
	if f.on then
		if listeners["» Uwu-Ify Chat Messages"] == nil then
			listeners["» Uwu-Ify Chat Messages"] = event.add_event_listener("chat", function(chat_message)
				if did_someone_type and chat_message.player ~= player.player_id() then
					local string1_ = text_func.string_replace(chat_message.body, "r", "w")
					local string2_ = text_func.string_replace(string1_, "u", "uwu")
					network.send_chat_message(string2_, false)
				end
			end)
		end
	end
	if not f.on then
		if listeners["» Uwu-Ify Chat Messages"] then
			event.remove_event_listener("chat", listeners["» Uwu-Ify Chat Messages"])
			listeners["» Uwu-Ify Chat Messages"] = nil
		end
	end
	settings["» Uwu-Ify Chat Messages"].Enabled = f.on
end)

feature["» Session Chat Flooder"] = menu.add_feature("» Session Chat Flooder", "toggle", localparents["» Chat Options"].id, function(f)
	settings["» Session Chat Flooder"].Enabled = f.on
    if f.on then
		while f.on do
			system.yield(0)
			if network.is_session_started() then
				network.send_chat_message(" ", false)
			end
		end
	end
	settings["» Session Chat Flooder"].Enabled = f.on
end)

feature["» Log Session Chat"] = menu.add_feature("» Log Session Chat", "toggle", localparents["» Chat Options"].id, function(f)
    settings["» Log Session Chat"].Enabled = f.on
	if f.on then
		if listeners["» Log Session Chat"] == nil then
			listeners["» Log Session Chat"] = event.add_event_listener("chat", function(chat_message)
				if player.is_player_valid(chat_message.player) then
					text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Logs\\Chat\\", "") .. "\\Chat.log", "a"), "" .. os.date() .. " | " .. utilities.dec_to_ipv4(player.get_player_ip(chat_message.player)) .. " | " .. player.get_player_scid(chat_message.player) .. " | " .. player_func.get_player_flag_string(chat_message.player) .. " " .. player.get_player_name(chat_message.player) .. " >> " .. chat_message.body .. "\n")
				end
			end)
		end
	end
	if not f.on then
		if listeners["» Log Session Chat"] then
			event.remove_event_listener("chat", listeners["» Log Session Chat"])
			listeners["» Log Session Chat"] = nil
		end
	end
	settings["» Log Session Chat"].Enabled = f.on
end)

feature["» Log Session Change"] = menu.add_feature("» Log Session Change", "toggle", localparents["» Chat Options"].id, function(f)
	settings["» Log Session Change"].Enabled = f.on
	if f.on then
		if listeners["» Log Session Change Leave"] == nil then
			listeners["» Log Session Change Leave"] = event.add_event_listener("player_leave", function(left_player)
				if left_player.player == player.player_id() and player.is_player_valid(left_player.player) then
					text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Logs\\Chat\\", "") .. "\\Chat.log", "a"), "# # # # # | You Left The Session | " .. os.date() .. " | # # # # #\n")
				end
			end)
		end
		if listeners["» Log Session Change Join"] == nil then
			listeners["» Log Session Change Join"] = event.add_event_listener("player_join", function(joined_player)
				if joined_player.player == player.player_id() and player.is_player_valid(joined_player.player) then
					text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Logs\\Chat\\", "") .. "\\Chat.log", "a"), "# # # # # | You Joined A New Session | " .. os.date() .. " | # # # # #\n")
				end
			end)
		end
	end
	if not f.on then
		if listeners["» Log Session Change Leave"] then
			event.remove_event_listener("player_leave", listeners["» Log Session Change Leave"])
			listeners["» Log Session Change Leave"] = nil
		end
		if listeners["» Log Session Change Join"] then
			event.remove_event_listener("player_join", listeners["» Log Session Change Join"])
			listeners["» Log Session Change Join"] = nil
		end
	end
	settings["» Log Session Change"].Enabled = f.on
end)

feature["» Translate Chat Messages"] = menu.add_feature("» Translate Chat Messages", "toggle", localparents["» Chat Options"].id, function(f)
    settings["» Translate Chat Messages"].Enabled = f.on
	if f.on then
		if listeners["» Translate Chat Messages"] == nil then
			listeners["» Translate Chat Messages"] = event.add_event_listener("chat", function(chat_message)
				if chat_message.player ~= player.player_id() and player.is_player_valid(chat_message.player) then
					if chat_message.body ~= nil and not string.find(chat_message.body, "*") then
						local success, webdata = web.get("https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=en&dt=t&q=" .. web.urlencode(chat_message.body))
						local real = string.match(webdata, ".-\"(.-)\",\"")
						if not string.find(webdata, "\"en\"") and real ~= chat_message.body then
							if real ~= nil and chat_message.player ~= nil and player.get_player_name(chat_message.player) ~= nil then
								menu.notify("Player: " .. tostring(player.get_player_name(chat_message.player)) .. "\nTranslated: " .. tostring(real) .. "", Meteor, 12, 0x64FA7800)
							end
						end
					end
				end
			end)
		end
	end
	if not f.on then
		if listeners["» Translate Chat Messages"] then
			event.remove_event_listener("chat", listeners["» Translate Chat Messages"])
			listeners["» Translate Chat Messages"] = nil
		end
	end
	settings["» Translate Chat Messages"].Enabled = f.on
end)


playerparents["» SEP"] = menu.add_player_feature("» SEP", "parent", playerparents["» Script Events"]).id

do
	if not LaunchInSafeMode["Launch In Safe Mode"] then
		if utils.file_exists(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\cfg\\sep.cfg") then
			local file = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\cfg\\sep.cfg", "r")
			for line in file:lines() do
				if string.find(line, "]") and not string.find(line, ";") then
					playerparents["» SEP Parent " .. line] = menu.add_player_feature("» " .. line, "parent", playerparents["» SEP"]).id
					last_found_parent_in_sep = playerparents["» SEP Parent " .. line]
				end
				if string.find(line, ",") and string.find(line, "{") and string.find(line, "}") and not string.find(line, ";") then
					if string.find(line, "{0: =") then
						local has_0_param = false
						local has_1_param = false
						local has_2_param = false
						local has_3_param = false
						local has_4_param = false
						local has_5_param = false
						local has_6_param = false
						local has_7_param = false
						local has_8_param = false
						local has_9_param = false
						local has_10_param = false
						local has_11_param = false
						local has_12_param = false
						local se_parts_1 = text_func.split_string(line, ",")
						local se_params_0 = text_func.split_string(line, "{0: =")
						local se_params_1 = text_func.split_string(line, "{0: =")
						local se_params_2 = text_func.split_string(line, "{0: =")
						local se_params_3 = text_func.split_string(line, "{0: =")
						local se_params_4 = text_func.split_string(line, "{0: =")
						local se_params_5 = text_func.split_string(line, "{0: =")
						local se_params_6 = text_func.split_string(line, "{0: =")
						local se_params_7 = text_func.split_string(line, "{0: =")
						local se_params_8 = text_func.split_string(line, "{0: =")
						local se_params_9 = text_func.split_string(line, "{0: =")
						local se_params_10 = text_func.split_string(line, "{0: =")
						local se_params_11 = text_func.split_string(line, "{0: =")
						local se_params_12 = text_func.split_string(line, "{0: =")
						local final_params_0 = 0
						local final_params_1 = player.player_id()
						local final_params_2 = player.player_id()
						local final_params_3 = player.player_id()
						local final_params_4 = player.player_id()
						local final_params_5 = player.player_id()
						local final_params_6 = player.player_id()
						local final_params_7 = player.player_id()
						local final_params_8 = player.player_id()
						local final_params_9 = player.player_id()
						local final_params_10 = player.player_id()
						local final_params_11 = player.player_id()
						local final_params_12 = player.player_id()
						local all_params = {}
						if string.find(se_params_0[2], ",") then
							se_params_0 = text_func.split_string(se_params_0[2], ",")
							has_0_param = false
						else
							se_params_0 = text_func.split_string(se_params_0[2], "}")
							has_0_param = true
						end
						if string.find(se_params_1[2], "1: ") then
							se_params_1 = text_func.split_string(line, "1: ")
							if string.find(se_params_1[2], ",") then
								se_params_1 = text_func.split_string(se_params_1[2], ",")
								has_1_param = true
							else
								se_params_1 = text_func.split_string(se_params_1[2], "}")
								has_1_param = true
							end
						else
							has_1_param = false
						end
						final_params_1 = se_params_1[1]
						if string.find(final_params_1, "=") and not string.find(final_params_1, ">") and not string.find(final_params_1, "|") and not string.find(final_params_1, "<") and not string.find(final_params_1, "!") then
							se_params_1 = text_func.split_string(final_params_1, "=")
							final_params_1 = tonumber(se_params_1[2])
						elseif string.find(final_params_1, ">") and not string.find(final_params_1, "=") and not string.find(final_params_1, "|") and not string.find(final_params_1, "<") and not string.find(final_params_1, "!") then
							se_params_1 = text_func.split_string(final_params_1, ">")
							if tonumber(se_params_1[2]) + 1 < 2147483647 then
								final_params_1 = math.random(tonumber(se_params_1[2]) + 1, 2147483647)
							else
								final_params_1 = tonumber(se_params_1[2]) + 1
							end
						elseif string.find(final_params_1, "<") and not string.find(final_params_1, "=") and not string.find(final_params_1, "|") and not string.find(final_params_1, ">") and not string.find(final_params_1, "!") then
							se_params_1 = text_func.split_string(final_params_1, "<")
							if tonumber(se_params_1[2]) - 1 > -2147483647 then
								final_params_1 = math.random(-2147483647, tonumber(se_params_1[2]) - 1)
							else
								final_params_1 = tonumber(se_params_1[2]) - 1
							end
						elseif string.find(final_params_1, ">=") and not string.find(final_params_1, "|") and not string.find(final_params_1, "<") and not string.find(final_params_1, "!") then
							se_params_1 = text_func.split_string(final_params_1, ">=")
							if tonumber(se_params_1[2]) < 2147483647 then
								final_params_1 = math.random(tonumber(se_params_1[2]), 2147483647)
							else
								final_params_1 = tonumber(se_params_1[2])
							end
						elseif string.find(final_params_1, "<=") and not string.find(final_params_1, "|") and not string.find(final_params_1, ">") and not string.find(final_params_1, "!") then
							se_params_1 = text_func.split_string(final_params_1, "<=")
							if tonumber(se_params_1[2]) > -2147483647 then
								final_params_1 = math.random(-2147483647, tonumber(se_params_1[2]))
							else
								final_params_1 = tonumber(se_params_1[2])
							end
						elseif string.find(final_params_1, "=>") and not string.find(final_params_1, "|") and not string.find(final_params_1, "<") and not string.find(final_params_1, "!") then
							se_params_1 = text_func.split_string(final_params_1, "=>")
							if tonumber(se_params_1[2]) < 2147483647 then
								final_params_1 = math.random(tonumber(se_params_1[2]), 2147483647)
							else
								final_params_1 = tonumber(se_params_1[2])
							end
						elseif string.find(final_params_1, "=<") and not string.find(final_params_1, "|") and not string.find(final_params_1, ">") and not string.find(final_params_1, "!") then
							se_params_1 = text_func.split_string(final_params_1, "=<")
							if tonumber(se_params_1[2]) > -2147483647 then
								final_params_1 = math.random(-2147483647, tonumber(se_params_1[2]))
							else
								final_params_1 = tonumber(se_params_1[2])
							end
						elseif (string.find(final_params_1, "<") or string.find(final_params_1, ">") or string.find(final_params_1, "<")) and string.find(final_params_1, " | ") and not string.find(final_params_1, "!") then
							local splitt_param_1 = 2147483647
							local splitt_param_2 = -2147483647
							local is_in_a_range_1 = true
							local is_in_a_range_2 = true
							local splitt_param_1_table = text_func.split_string(final_params_1, " | ")
							local splitt_param_2_table = text_func.split_string(final_params_1, " | ")
							if string.find(splitt_param_1_table[1], "<=") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "<=")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "=<") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "=<")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], ">=") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], ">=")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "=>") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "=>")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], "=") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "<")
								splitt_param_1 = tonumber(splitt_param_1_table[2]) + 1
							elseif string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								is_in_a_range_1 = false
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], ">")
								splitt_param_1 = tonumber(splitt_param_1_table[2]) + 1
							else
								splitt_param_1 = 2147483647
							end
							if string.find(splitt_param_2_table[2], ">=") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], ">=")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "=>") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "=>")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "<=") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "<=")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "=<") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "=<")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], "=") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], ">")
								splitt_param_2 = tonumber(splitt_param_2_table[2]) - 1
							elseif string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								is_in_a_range_2 = false
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "<")
								splitt_param_2 = tonumber(splitt_param_2_table[2]) - 1
							else
								splitt_param_2 = -2147483647
							end
							if not is_in_a_range_1 and not is_in_a_range_2 then
								if tonumber(splitt_param_1) < tonumber(splitt_param_2) then
									final_params_1 = math.random(tonumber(splitt_param_1), tonumber(splitt_param_2))
								else
									final_params_1 = math.random(tonumber(splitt_param_2), tonumber(splitt_param_1))
								end
							elseif is_in_a_range_1 and not is_in_a_range_2 then
								if tonumber(splitt_param_1) < 2147483647 then
									final_params_1 = math.random(tonumber(splitt_param_1), 2147483647)
								else
									final_params_1 = tonumber(splitt_param_1)
								end
							elseif is_in_a_range_2 and not is_in_a_range_1 then
								if tonumber(splitt_param_2) > -2147483647 then
									final_params_1 = math.random(-2147483647, tonumber(splitt_param_2))
								else
									final_params_1 = tonumber(splitt_param_2)
								end
							else
								final_params_1 = math.random(-2147483647, 2147483647)
							end
						elseif string.find(final_params_1, "!") and not string.find(final_params_1, "=") and not string.find(final_params_1, "|") and not string.find(final_params_1, ">") and not string.find(final_params_1, "<") then
							se_params_1 = text_func.split_string(final_params_1, "!")
							final_params_1 = tonumber(se_params_1[2]) + 1
						else
							final_params_1 = player.player_id()
						end
						if string.find(se_params_2[2], "2: ") then
							se_params_2 = text_func.split_string(line, "2: ")
							if string.find(se_params_2[2], ",") then
								se_params_2 = text_func.split_string(se_params_2[2], ",")
								has_2_param = true
							else
								se_params_2 = text_func.split_string(se_params_2[2], "}")
								has_2_param = true
							end
						else
							has_2_param = false
						end
						final_params_2 = se_params_2[1]
						if string.find(final_params_2, "=") and not string.find(final_params_2, ">") and not string.find(final_params_2, "|") and not string.find(final_params_2, "<") and not string.find(final_params_2, "!") then
							se_params_2 = text_func.split_string(final_params_2, "=")
							final_params_2 = tonumber(se_params_2[2])
						elseif string.find(final_params_2, ">") and not string.find(final_params_2, "=") and not string.find(final_params_2, "|") and not string.find(final_params_2, "<") and not string.find(final_params_2, "!") then
							se_params_2 = text_func.split_string(final_params_2, ">")
							if tonumber(se_params_2[2]) + 1 < 2147483647 then
								final_params_2 = math.random(tonumber(se_params_2[2]) + 1, 2147483647)
							else
								final_params_2 = tonumber(se_params_2[2]) + 1
							end
						elseif string.find(final_params_2, "<") and not string.find(final_params_2, "=") and not string.find(final_params_2, "|") and not string.find(final_params_2, ">") and not string.find(final_params_2, "!") then
							se_params_2 = text_func.split_string(final_params_2, "<")
							if tonumber(se_params_2[2]) - 1 > -2147483647 then
								final_params_2 = math.random(-2147483647, tonumber(se_params_2[2]) - 1)
							else
								final_params_2 = tonumber(se_params_2[2]) - 1
							end
						elseif string.find(final_params_2, ">=") and not string.find(final_params_2, "|") and not string.find(final_params_2, "<") and not string.find(final_params_2, "!") then
							se_params_2 = text_func.split_string(final_params_2, ">=")
							if tonumber(se_params_2[2]) < 2147483647 then
								final_params_2 = math.random(tonumber(se_params_2[2]), 2147483647)
							else
								final_params_2 = tonumber(se_params_2[2])
							end
						elseif string.find(final_params_2, "<=") and not string.find(final_params_2, "|") and not string.find(final_params_2, ">") and not string.find(final_params_2, "!") then
							se_params_2 = text_func.split_string(final_params_2, "<=")
							if tonumber(se_params_2[2]) > -2147483647 then
								final_params_2 = math.random(-2147483647, tonumber(se_params_2[2]))
							else
								final_params_2 = tonumber(se_params_2[2])
							end
						elseif string.find(final_params_2, "=>") and not string.find(final_params_2, "|") and not string.find(final_params_2, "<") and not string.find(final_params_2, "!") then
							se_params_2 = text_func.split_string(final_params_2, "=>")
							if tonumber(se_params_2[2]) < 2147483647 then
								final_params_2 = math.random(tonumber(se_params_2[2]), 2147483647)
							else
								final_params_2 = tonumber(se_params_2[2])
							end
						elseif string.find(final_params_2, "=<") and not string.find(final_params_2, "|") and not string.find(final_params_2, ">") and not string.find(final_params_2, "!") then
							se_params_2 = text_func.split_string(final_params_2, "=<")
							if tonumber(se_params_2[2]) > -2147483647 then
								final_params_2 = math.random(-2147483647, tonumber(se_params_2[2]))
							else
								final_params_2 = tonumber(se_params_2[2])
							end
						elseif (string.find(final_params_2, "<") or string.find(final_params_2, ">") or string.find(final_params_2, "<")) and string.find(final_params_2, " | ") and not string.find(final_params_2, "!") then
							local splitt_param_1 = 2147483647
							local splitt_param_2 = -2147483647
							local is_in_a_range_1 = true
							local is_in_a_range_2 = true
							local splitt_param_1_table = text_func.split_string(final_params_2, " | ")
							local splitt_param_2_table = text_func.split_string(final_params_2, " | ")
							if string.find(splitt_param_1_table[1], "<=") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "<=")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "=<") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "=<")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], ">=") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], ">=")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "=>") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "=>")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], "=") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "<")
								splitt_param_1 = tonumber(splitt_param_1_table[2]) + 1
							elseif string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								is_in_a_range_1 = false
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], ">")
								splitt_param_1 = tonumber(splitt_param_1_table[2]) + 1
							else
								splitt_param_1 = 2147483647
							end
							if string.find(splitt_param_2_table[2], ">=") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], ">=")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "=>") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "=>")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "<=") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "<=")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "=<") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "=<")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], "=") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], ">")
								splitt_param_2 = tonumber(splitt_param_2_table[2]) - 1
							elseif string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								is_in_a_range_2 = false
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "<")
								splitt_param_2 = tonumber(splitt_param_2_table[2]) - 1
							else
								splitt_param_2 = -2147483647
							end
							if not is_in_a_range_1 and not is_in_a_range_2 then
								if tonumber(splitt_param_1) < tonumber(splitt_param_2) then
									final_params_2 = math.random(tonumber(splitt_param_1), tonumber(splitt_param_2))
								else
									final_params_2 = math.random(tonumber(splitt_param_2), tonumber(splitt_param_1))
								end
							elseif is_in_a_range_1 and not is_in_a_range_2 then
								if tonumber(splitt_param_1) < 2147483647 then
									final_params_2 = math.random(tonumber(splitt_param_1), 2147483647)
								else
									final_params_2 = tonumber(splitt_param_1)
								end
							elseif is_in_a_range_2 and not is_in_a_range_1 then
								if tonumber(splitt_param_2) > -2147483647 then
									final_params_2 = math.random(-2147483647, tonumber(splitt_param_2))
								else
									final_params_2 = tonumber(splitt_param_2)
								end
							else
								final_params_2 = math.random(-2147483647, 2147483647)
							end
						elseif string.find(final_params_2, "!") and not string.find(final_params_2, "=") and not string.find(final_params_2, "|") and not string.find(final_params_2, ">") and not string.find(final_params_2, "<") then
							se_params_2 = text_func.split_string(final_params_2, "!")
							final_params_2 = tonumber(se_params_2[2]) + 1
						else
							final_params_2 = player.player_id()
						end
						if string.find(se_params_3[2], "3: ") then
							se_params_3 = text_func.split_string(line, "3: ")
							if string.find(se_params_3[2], ",") then
								se_params_3 = text_func.split_string(se_params_3[2], ",")
								has_3_param = true
							else
								se_params_3 = text_func.split_string(se_params_3[2], "}")
								has_3_param = true
							end
						else
							has_3_param = false
						end
						final_params_3 = se_params_3[1]
						if string.find(final_params_3, "=") and not string.find(final_params_3, ">") and not string.find(final_params_3, "|") and not string.find(final_params_3, "<") and not string.find(final_params_3, "!") then
							se_params_3 = text_func.split_string(final_params_3, "=")
							final_params_3 = tonumber(se_params_3[2])
						elseif string.find(final_params_3, ">") and not string.find(final_params_3, "=") and not string.find(final_params_3, "|") and not string.find(final_params_3, "<") and not string.find(final_params_3, "!") then
							se_params_3 = text_func.split_string(final_params_3, ">")
							if tonumber(se_params_3[2]) + 1 < 2147483647 then
								final_params_3 = math.random(tonumber(se_params_3[2]) + 1, 2147483647)
							else
								final_params_3 = tonumber(se_params_3[2]) + 1
							end
						elseif string.find(final_params_3, "<") and not string.find(final_params_3, "=") and not string.find(final_params_3, "|") and not string.find(final_params_3, ">") and not string.find(final_params_3, "!") then
							se_params_3 = text_func.split_string(final_params_3, "<")
							if tonumber(se_params_3[2]) - 1 > -2147483647 then
								final_params_3 = math.random(-2147483647, tonumber(se_params_3[2]) - 1)
							else
								final_params_3 = tonumber(se_params_3[2]) - 1
							end
						elseif string.find(final_params_3, ">=") and not string.find(final_params_3, "|") and not string.find(final_params_3, "<") and not string.find(final_params_3, "!") then
							se_params_3 = text_func.split_string(final_params_3, ">=")
							if tonumber(se_params_3[2]) < 2147483647 then
								final_params_3 = math.random(tonumber(se_params_3[2]), 2147483647)
							else
								final_params_3 = tonumber(se_params_3[2])
							end
						elseif string.find(final_params_3, "<=") and not string.find(final_params_3, "|") and not string.find(final_params_3, ">") and not string.find(final_params_3, "!") then
							se_params_3 = text_func.split_string(final_params_3, "<=")
							if tonumber(se_params_3[2]) > -2147483647 then
								final_params_3 = math.random(-2147483647, tonumber(se_params_3[2]))
							else
								final_params_3 = tonumber(se_params_3[2])
							end
						elseif string.find(final_params_3, "=>") and not string.find(final_params_3, "|") and not string.find(final_params_3, "<") and not string.find(final_params_3, "!") then
							se_params_3 = text_func.split_string(final_params_3, "=>")
							if tonumber(se_params_3[2]) < 2147483647 then
								final_params_3 = math.random(tonumber(se_params_3[2]), 2147483647)
							else
								final_params_3 = tonumber(se_params_3[2])
							end
						elseif string.find(final_params_3, "=<") and not string.find(final_params_3, "|") and not string.find(final_params_3, ">") and not string.find(final_params_3, "!") then
							se_params_3 = text_func.split_string(final_params_3, "=<")
							if tonumber(se_params_3[2]) > -2147483647 then
								final_params_3 = math.random(-2147483647, tonumber(se_params_3[2]))
							else
								final_params_3 = tonumber(se_params_3[2])
							end
						elseif (string.find(final_params_3, "<") or string.find(final_params_3, ">") or string.find(final_params_3, "<")) and string.find(final_params_3, " | ") and not string.find(final_params_3, "!") then
							local splitt_param_1 = 2147483647
							local splitt_param_2 = -2147483647
							local is_in_a_range_1 = true
							local is_in_a_range_2 = true
							local splitt_param_1_table = text_func.split_string(final_params_3, " | ")
							local splitt_param_2_table = text_func.split_string(final_params_3, " | ")
							if string.find(splitt_param_1_table[1], "<=") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "<=")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "=<") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "=<")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], ">=") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], ">=")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "=>") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "=>")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], "=") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "<")
								splitt_param_1 = tonumber(splitt_param_1_table[2]) + 1
							elseif string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								is_in_a_range_1 = false
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], ">")
								splitt_param_1 = tonumber(splitt_param_1_table[2]) + 1
							else
								splitt_param_1 = 2147483647
							end
							if string.find(splitt_param_2_table[2], ">=") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], ">=")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "=>") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "=>")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "<=") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "<=")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "=<") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "=<")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], "=") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], ">")
								splitt_param_2 = tonumber(splitt_param_2_table[2]) - 1
							elseif string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								is_in_a_range_2 = false
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "<")
								splitt_param_2 = tonumber(splitt_param_2_table[2]) - 1
							else
								splitt_param_2 = -2147483647
							end
							if not is_in_a_range_1 and not is_in_a_range_2 then
								if tonumber(splitt_param_1) < tonumber(splitt_param_2) then
									final_params_3 = math.random(tonumber(splitt_param_1), tonumber(splitt_param_2))
								else
									final_params_3 = math.random(tonumber(splitt_param_2), tonumber(splitt_param_1))
								end
							elseif is_in_a_range_1 and not is_in_a_range_2 then
								if tonumber(splitt_param_1) < 2147483647 then
									final_params_3 = math.random(tonumber(splitt_param_1), 2147483647)
								else
									final_params_3 = tonumber(splitt_param_1)
								end
							elseif is_in_a_range_2 and not is_in_a_range_1 then
								if tonumber(splitt_param_2) > -2147483647 then
									final_params_3 = math.random(-2147483647, tonumber(splitt_param_2))
								else
									final_params_3 = tonumber(splitt_param_2)
								end
							else
								final_params_3 = math.random(-2147483647, 2147483647)
							end
						elseif string.find(final_params_3, "!") and not string.find(final_params_3, "=") and not string.find(final_params_3, "|") and not string.find(final_params_3, ">") and not string.find(final_params_3, "<") then
							se_params_3 = text_func.split_string(final_params_3, "!")
							final_params_3 = tonumber(se_params_3[2]) + 1
						else
							final_params_3 = player.player_id()
						end
						if string.find(se_params_4[2], "4: ") then
							se_params_4 = text_func.split_string(line, "4: ")
							if string.find(se_params_4[2], ",") then
								se_params_4 = text_func.split_string(se_params_4[2], ",")
								has_4_param = true
							else
								se_params_4 = text_func.split_string(se_params_4[2], "}")
								has_4_param = true
							end
						else
							has_4_param = false
						end
						final_params_4 = se_params_4[1]
						if string.find(final_params_4, "=") and not string.find(final_params_4, ">") and not string.find(final_params_4, "|") and not string.find(final_params_4, "<") and not string.find(final_params_4, "!") then
							se_params_4 = text_func.split_string(final_params_4, "=")
							final_params_4 = tonumber(se_params_4[2])
						elseif string.find(final_params_4, ">") and not string.find(final_params_4, "=") and not string.find(final_params_4, "|") and not string.find(final_params_4, "<") and not string.find(final_params_4, "!") then
							se_params_4 = text_func.split_string(final_params_4, ">")
							if tonumber(se_params_4[2]) + 1 < 2147483647 then
								final_params_4 = math.random(tonumber(se_params_4[2]) + 1, 2147483647)
							else
								final_params_4 = tonumber(se_params_4[2]) + 1
							end
						elseif string.find(final_params_4, "<") and not string.find(final_params_4, "=") and not string.find(final_params_4, "|") and not string.find(final_params_4, ">") and not string.find(final_params_4, "!") then
							se_params_4 = text_func.split_string(final_params_4, "<")
							if tonumber(se_params_4[2]) - 1 > -2147483647 then
								final_params_4 = math.random(-2147483647, tonumber(se_params_4[2]) - 1)
							else
								final_params_4 = tonumber(se_params_4[2]) - 1
							end
						elseif string.find(final_params_4, ">=") and not string.find(final_params_4, "|") and not string.find(final_params_4, "<") and not string.find(final_params_4, "!") then
							se_params_4 = text_func.split_string(final_params_4, ">=")
							if tonumber(se_params_4[2]) < 2147483647 then
								final_params_4 = math.random(tonumber(se_params_4[2]), 2147483647)
							else
								final_params_4 = tonumber(se_params_4[2])
							end
						elseif string.find(final_params_4, "<=") and not string.find(final_params_4, "|") and not string.find(final_params_4, ">") and not string.find(final_params_4, "!") then
							se_params_4 = text_func.split_string(final_params_4, "<=")
							if tonumber(se_params_4[2]) > -2147483647 then
								final_params_4 = math.random(-2147483647, tonumber(se_params_4[2]))
							else
								final_params_4 = tonumber(se_params_4[2])
							end
						elseif string.find(final_params_4, "=>") and not string.find(final_params_4, "|") and not string.find(final_params_4, "<") and not string.find(final_params_4, "!") then
							se_params_4 = text_func.split_string(final_params_4, "=>")
							if tonumber(se_params_4[2]) < 2147483647 then
								final_params_4 = math.random(tonumber(se_params_4[2]), 2147483647)
							else
								final_params_4 = tonumber(se_params_4[2])
							end
						elseif string.find(final_params_4, "=<") and not string.find(final_params_4, "|") and not string.find(final_params_4, ">") and not string.find(final_params_4, "!") then
							se_params_4 = text_func.split_string(final_params_4, "=<")
							if tonumber(se_params_4[2]) > -2147483647 then
								final_params_4 = math.random(-2147483647, tonumber(se_params_4[2]))
							else
								final_params_4 = tonumber(se_params_4[2])
							end
						elseif (string.find(final_params_4, "<") or string.find(final_params_4, ">") or string.find(final_params_4, "<")) and string.find(final_params_4, " | ") and not string.find(final_params_4, "!") then
							local splitt_param_1 = 2147483647
							local splitt_param_2 = -2147483647
							local is_in_a_range_1 = true
							local is_in_a_range_2 = true
							local splitt_param_1_table = text_func.split_string(final_params_4, " | ")
							local splitt_param_2_table = text_func.split_string(final_params_4, " | ")
							if string.find(splitt_param_1_table[1], "<=") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "<=")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "=<") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "=<")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], ">=") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], ">=")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "=>") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "=>")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], "=") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "<")
								splitt_param_1 = tonumber(splitt_param_1_table[2]) + 1
							elseif string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								is_in_a_range_1 = false
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], ">")
								splitt_param_1 = tonumber(splitt_param_1_table[2]) + 1
							else
								splitt_param_1 = 2147483647
							end
							if string.find(splitt_param_2_table[2], ">=") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], ">=")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "=>") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "=>")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "<=") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "<=")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "=<") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "=<")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], "=") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], ">")
								splitt_param_2 = tonumber(splitt_param_2_table[2]) - 1
							elseif string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								is_in_a_range_2 = false
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "<")
								splitt_param_2 = tonumber(splitt_param_2_table[2]) - 1
							else
								splitt_param_2 = -2147483647
							end
							if not is_in_a_range_1 and not is_in_a_range_2 then
								if tonumber(splitt_param_1) < tonumber(splitt_param_2) then
									final_params_4 = math.random(tonumber(splitt_param_1), tonumber(splitt_param_2))
								else
									final_params_4 = math.random(tonumber(splitt_param_2), tonumber(splitt_param_1))
								end
							elseif is_in_a_range_1 and not is_in_a_range_2 then
								if tonumber(splitt_param_1) < 2147483647 then
									final_params_4 = math.random(tonumber(splitt_param_1), 2147483647)
								else
									final_params_4 = tonumber(splitt_param_1)
								end
							elseif is_in_a_range_2 and not is_in_a_range_1 then
								if tonumber(splitt_param_2) > -2147483647 then
									final_params_4 = math.random(-2147483647, tonumber(splitt_param_2))
								else
									final_params_4 = tonumber(splitt_param_2)
								end
							else
								final_params_4 = math.random(-2147483647, 2147483647)
							end
						elseif string.find(final_params_4, "!") and not string.find(final_params_4, "=") and not string.find(final_params_4, "|") and not string.find(final_params_4, ">") and not string.find(final_params_4, "<") then
							se_params_4 = text_func.split_string(final_params_4, "!")
							final_params_4 = tonumber(se_params_4[2]) + 1
						else
							final_params_4 = player.player_id()
						end
						if string.find(se_params_5[2], "5: ") then
							se_params_5 = text_func.split_string(line, "5: ")
							if string.find(se_params_5[2], ",") then
								se_params_5 = text_func.split_string(se_params_5[2], ",")
								has_5_param = true
							else
								se_params_5 = text_func.split_string(se_params_5[2], "}")
								has_5_param = true
							end
						else
							has_5_param = false
						end
						final_params_5 = se_params_5[1]
						if string.find(final_params_5, "=") and not string.find(final_params_5, ">") and not string.find(final_params_5, "|") and not string.find(final_params_5, "<") and not string.find(final_params_5, "!") then
							se_params_5 = text_func.split_string(final_params_5, "=")
							final_params_5 = tonumber(se_params_5[2])
						elseif string.find(final_params_5, ">") and not string.find(final_params_5, "=") and not string.find(final_params_5, "|") and not string.find(final_params_5, "<") and not string.find(final_params_5, "!") then
							se_params_5 = text_func.split_string(final_params_5, ">")
							if tonumber(se_params_5[2]) + 1 < 2147483647 then
								final_params_5 = math.random(tonumber(se_params_5[2]) + 1, 2147483647)
							else
								final_params_5 = tonumber(se_params_5[2]) + 1
							end
						elseif string.find(final_params_5, "<") and not string.find(final_params_5, "=") and not string.find(final_params_5, "|") and not string.find(final_params_5, ">") and not string.find(final_params_5, "!") then
							se_params_5 = text_func.split_string(final_params_5, "<")
							if tonumber(se_params_5[2]) - 1 > -2147483647 then
								final_params_5 = math.random(-2147483647, tonumber(se_params_5[2]) - 1)
							else
								final_params_5 = tonumber(se_params_5[2]) - 1
							end
						elseif string.find(final_params_5, ">=") and not string.find(final_params_5, "|") and not string.find(final_params_5, "<") and not string.find(final_params_5, "!") then
							se_params_5 = text_func.split_string(final_params_5, ">=")
							if tonumber(se_params_5[2]) < 2147483647 then
								final_params_5 = math.random(tonumber(se_params_5[2]), 2147483647)
							else
								final_params_5 = tonumber(se_params_5[2])
							end
						elseif string.find(final_params_5, "<=") and not string.find(final_params_5, "|") and not string.find(final_params_5, ">") and not string.find(final_params_5, "!") then
							se_params_5 = text_func.split_string(final_params_5, "<=")
							if tonumber(se_params_5[2]) > -2147483647 then
								final_params_5 = math.random(-2147483647, tonumber(se_params_5[2]))
							else
								final_params_5 = tonumber(se_params_5[2])
							end
						elseif string.find(final_params_5, "=>") and not string.find(final_params_5, "|") and not string.find(final_params_5, "<") and not string.find(final_params_5, "!") then
							se_params_5 = text_func.split_string(final_params_5, "=>")
							if tonumber(se_params_5[2]) < 2147483647 then
								final_params_5 = math.random(tonumber(se_params_5[2]), 2147483647)
							else
								final_params_5 = tonumber(se_params_5[2])
							end
						elseif string.find(final_params_5, "=<") and not string.find(final_params_5, "|") and not string.find(final_params_5, ">") and not string.find(final_params_5, "!") then
							se_params_5 = text_func.split_string(final_params_5, "=<")
							if tonumber(se_params_5[2]) > -2147483647 then
								final_params_5 = math.random(-2147483647, tonumber(se_params_5[2]))
							else
								final_params_5 = tonumber(se_params_5[2])
							end
						elseif (string.find(final_params_5, "<") or string.find(final_params_5, ">") or string.find(final_params_5, "<")) and string.find(final_params_5, " | ") and not string.find(final_params_5, "!") then
							local splitt_param_1 = 2147483647
							local splitt_param_2 = -2147483647
							local is_in_a_range_1 = true
							local is_in_a_range_2 = true
							local splitt_param_1_table = text_func.split_string(final_params_5, " | ")
							local splitt_param_2_table = text_func.split_string(final_params_5, " | ")
							if string.find(splitt_param_1_table[1], "<=") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "<=")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "=<") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "=<")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], ">=") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], ">=")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "=>") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "=>")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], "=") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "<")
								splitt_param_1 = tonumber(splitt_param_1_table[2]) + 1
							elseif string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								is_in_a_range_1 = false
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], ">")
								splitt_param_1 = tonumber(splitt_param_1_table[2]) + 1
							else
								splitt_param_1 = 2147483647
							end
							if string.find(splitt_param_2_table[2], ">=") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], ">=")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "=>") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "=>")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "<=") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "<=")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "=<") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "=<")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], "=") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], ">")
								splitt_param_2 = tonumber(splitt_param_2_table[2]) - 1
							elseif string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								is_in_a_range_2 = false
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "<")
								splitt_param_2 = tonumber(splitt_param_2_table[2]) - 1
							else
								splitt_param_2 = -2147483647
							end
							if not is_in_a_range_1 and not is_in_a_range_2 then
								if tonumber(splitt_param_1) < tonumber(splitt_param_2) then
									final_params_5 = math.random(tonumber(splitt_param_1), tonumber(splitt_param_2))
								else
									final_params_5 = math.random(tonumber(splitt_param_2), tonumber(splitt_param_1))
								end
							elseif is_in_a_range_1 and not is_in_a_range_2 then
								if tonumber(splitt_param_1) < 2147483647 then
									final_params_5 = math.random(tonumber(splitt_param_1), 2147483647)
								else
									final_params_5 = tonumber(splitt_param_1)
								end
							elseif is_in_a_range_2 and not is_in_a_range_1 then
								if tonumber(splitt_param_2) > -2147483647 then
									final_params_5 = math.random(-2147483647, tonumber(splitt_param_2))
								else
									final_params_5 = tonumber(splitt_param_2)
								end
							else
								final_params_5 = math.random(-2147483647, 2147483647)
							end
						elseif string.find(final_params_5, "!") and not string.find(final_params_5, "=") and not string.find(final_params_5, "|") and not string.find(final_params_5, ">") and not string.find(final_params_5, "<") then
							se_params_5 = text_func.split_string(final_params_5, "!")
							final_params_5 = tonumber(se_params_5[2]) + 1
						else
							final_params_5 = player.player_id()
						end
						if string.find(se_params_6[2], "6: ") then
							se_params_6 = text_func.split_string(line, "6: ")
							if string.find(se_params_6[2], ",") then
								se_params_6 = text_func.split_string(se_params_6[2], ",")
								has_6_param = true
							else
								se_params_6 = text_func.split_string(se_params_6[2], "}")
								has_6_param = true
							end
						else
							has_6_param = false
						end
						final_params_6 = se_params_6[1]
						if string.find(final_params_6, "=") and not string.find(final_params_6, ">") and not string.find(final_params_6, "|") and not string.find(final_params_6, "<") and not string.find(final_params_6, "!") then
							se_params_6 = text_func.split_string(final_params_6, "=")
							final_params_6 = tonumber(se_params_6[2])
						elseif string.find(final_params_6, ">") and not string.find(final_params_6, "=") and not string.find(final_params_6, "|") and not string.find(final_params_6, "<") and not string.find(final_params_6, "!") then
							se_params_6 = text_func.split_string(final_params_6, ">")
							if tonumber(se_params_6[2]) + 1 < 2147483647 then
								final_params_6 = math.random(tonumber(se_params_6[2]) + 1, 2147483647)
							else
								final_params_6 = tonumber(se_params_6[2]) + 1
							end
						elseif string.find(final_params_6, "<") and not string.find(final_params_6, "=") and not string.find(final_params_6, "|") and not string.find(final_params_6, ">") and not string.find(final_params_6, "!") then
							se_params_6 = text_func.split_string(final_params_6, "<")
							if tonumber(se_params_6[2]) - 1 > -2147483647 then
								final_params_6 = math.random(-2147483647, tonumber(se_params_6[2]) - 1)
							else
								final_params_6 = tonumber(se_params_6[2]) - 1
							end
						elseif string.find(final_params_6, ">=") and not string.find(final_params_6, "|") and not string.find(final_params_6, "<") and not string.find(final_params_6, "!") then
							se_params_6 = text_func.split_string(final_params_6, ">=")
							if tonumber(se_params_6[2]) < 2147483647 then
								final_params_6 = math.random(tonumber(se_params_6[2]), 2147483647)
							else
								final_params_6 = tonumber(se_params_6[2])
							end
						elseif string.find(final_params_6, "<=") and not string.find(final_params_6, "|") and not string.find(final_params_6, ">") and not string.find(final_params_6, "!") then
							se_params_6 = text_func.split_string(final_params_6, "<=")
							if tonumber(se_params_6[2]) > -2147483647 then
								final_params_6 = math.random(-2147483647, tonumber(se_params_6[2]))
							else
								final_params_6 = tonumber(se_params_6[2])
							end
						elseif string.find(final_params_6, "=>") and not string.find(final_params_6, "|") and not string.find(final_params_6, "<") and not string.find(final_params_6, "!") then
							se_params_6 = text_func.split_string(final_params_6, "=>")
							if tonumber(se_params_6[2]) < 2147483647 then
								final_params_6 = math.random(tonumber(se_params_6[2]), 2147483647)
							else
								final_params_6 = tonumber(se_params_6[2])
							end
						elseif string.find(final_params_6, "=<") and not string.find(final_params_6, "|") and not string.find(final_params_6, ">") and not string.find(final_params_6, "!") then
							se_params_6 = text_func.split_string(final_params_6, "=<")
							if tonumber(se_params_6[2]) > -2147483647 then
								final_params_6 = math.random(-2147483647, tonumber(se_params_6[2]))
							else
								final_params_6 = tonumber(se_params_6[2])
							end
						elseif (string.find(final_params_6, "<") or string.find(final_params_6, ">") or string.find(final_params_6, "<")) and string.find(final_params_6, " | ") and not string.find(final_params_6, "!") then
							local splitt_param_1 = 2147483647
							local splitt_param_2 = -2147483647
							local is_in_a_range_1 = true
							local is_in_a_range_2 = true
							local splitt_param_1_table = text_func.split_string(final_params_6, " | ")
							local splitt_param_2_table = text_func.split_string(final_params_6, " | ")
							if string.find(splitt_param_1_table[1], "<=") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "<=")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "=<") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "=<")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], ">=") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], ">=")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "=>") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "=>")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], "=") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "<")
								splitt_param_1 = tonumber(splitt_param_1_table[2]) + 1
							elseif string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								is_in_a_range_1 = false
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], ">")
								splitt_param_1 = tonumber(splitt_param_1_table[2]) + 1
							else
								splitt_param_1 = 2147483647
							end
							if string.find(splitt_param_2_table[2], ">=") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], ">=")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "=>") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "=>")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "<=") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "<=")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "=<") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "=<")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], "=") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], ">")
								splitt_param_2 = tonumber(splitt_param_2_table[2]) - 1
							elseif string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								is_in_a_range_2 = false
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "<")
								splitt_param_2 = tonumber(splitt_param_2_table[2]) - 1
							else
								splitt_param_2 = -2147483647
							end
							if not is_in_a_range_1 and not is_in_a_range_2 then
								if tonumber(splitt_param_1) < tonumber(splitt_param_2) then
									final_params_6 = math.random(tonumber(splitt_param_1), tonumber(splitt_param_2))
								else
									final_params_6 = math.random(tonumber(splitt_param_2), tonumber(splitt_param_1))
								end
							elseif is_in_a_range_1 and not is_in_a_range_2 then
								if tonumber(splitt_param_1) < 2147483647 then
									final_params_6 = math.random(tonumber(splitt_param_1), 2147483647)
								else
									final_params_6 = tonumber(splitt_param_1)
								end
							elseif is_in_a_range_2 and not is_in_a_range_1 then
								if tonumber(splitt_param_2) > -2147483647 then
									final_params_6 = math.random(-2147483647, tonumber(splitt_param_2))
								else
									final_params_6 = tonumber(splitt_param_2)
								end
							else
								final_params_6 = math.random(-2147483647, 2147483647)
							end
						elseif string.find(final_params_6, "!") and not string.find(final_params_6, "=") and not string.find(final_params_6, "|") and not string.find(final_params_6, ">") and not string.find(final_params_6, "<") then
							se_params_6 = text_func.split_string(final_params_6, "!")
							final_params_6 = tonumber(se_params_6[2]) + 1
						else
							final_params_6 = player.player_id()
						end
						if string.find(se_params_7[2], "7: ") then
							se_params_7 = text_func.split_string(line, "7: ")
							if string.find(se_params_7[2], ",") then
								se_params_7 = text_func.split_string(se_params_7[2], ",")
								has_7_param = true
							else
								se_params_7 = text_func.split_string(se_params_7[2], "}")
								has_7_param = true
							end
						else
							has_7_param = false
						end
						final_params_7 = se_params_7[1]
						if string.find(final_params_7, "=") and not string.find(final_params_7, ">") and not string.find(final_params_7, "|") and not string.find(final_params_7, "<") and not string.find(final_params_7, "!") then
							se_params_7 = text_func.split_string(final_params_7, "=")
							final_params_7 = tonumber(se_params_7[2])
						elseif string.find(final_params_7, ">") and not string.find(final_params_7, "=") and not string.find(final_params_7, "|") and not string.find(final_params_7, "<") and not string.find(final_params_7, "!") then
							se_params_7 = text_func.split_string(final_params_7, ">")
							if tonumber(se_params_7[2]) + 1 < 2147483647 then
								final_params_7 = math.random(tonumber(se_params_7[2]) + 1, 2147483647)
							else
								final_params_7 = tonumber(se_params_7[2]) + 1
							end
						elseif string.find(final_params_7, "<") and not string.find(final_params_7, "=") and not string.find(final_params_7, "|") and not string.find(final_params_7, ">") and not string.find(final_params_7, "!") then
							se_params_7 = text_func.split_string(final_params_7, "<")
							if tonumber(se_params_7[2]) - 1 > -2147483647 then
								final_params_7 = math.random(-2147483647, tonumber(se_params_7[2]) - 1)
							else
								final_params_7 = tonumber(se_params_7[2]) - 1
							end
						elseif string.find(final_params_7, ">=") and not string.find(final_params_7, "|") and not string.find(final_params_7, "<") and not string.find(final_params_7, "!") then
							se_params_7 = text_func.split_string(final_params_7, ">=")
							if tonumber(se_params_7[2]) < 2147483647 then
								final_params_7 = math.random(tonumber(se_params_7[2]), 2147483647)
							else
								final_params_7 = tonumber(se_params_7[2])
							end
						elseif string.find(final_params_7, "<=") and not string.find(final_params_7, "|") and not string.find(final_params_7, ">") and not string.find(final_params_7, "!") then
							se_params_7 = text_func.split_string(final_params_7, "<=")
							if tonumber(se_params_7[2]) > -2147483647 then
								final_params_7 = math.random(-2147483647, tonumber(se_params_7[2]))
							else
								final_params_7 = tonumber(se_params_7[2])
							end
						elseif string.find(final_params_7, "=>") and not string.find(final_params_7, "|") and not string.find(final_params_7, "<") and not string.find(final_params_7, "!") then
							se_params_7 = text_func.split_string(final_params_7, "=>")
							if tonumber(se_params_7[2]) < 2147483647 then
								final_params_7 = math.random(tonumber(se_params_7[2]), 2147483647)
							else
								final_params_7 = tonumber(se_params_7[2])
							end
						elseif string.find(final_params_7, "=<") and not string.find(final_params_7, "|") and not string.find(final_params_7, ">") and not string.find(final_params_7, "!") then
							se_params_7 = text_func.split_string(final_params_7, "=<")
							if tonumber(se_params_7[2]) > -2147483647 then
								final_params_7 = math.random(-2147483647, tonumber(se_params_7[2]))
							else
								final_params_7 = tonumber(se_params_7[2])
							end
						elseif (string.find(final_params_7, "<") or string.find(final_params_7, ">") or string.find(final_params_7, "<")) and string.find(final_params_7, " | ") and not string.find(final_params_7, "!") then
							local splitt_param_1 = 2147483647
							local splitt_param_2 = -2147483647
							local is_in_a_range_1 = true
							local is_in_a_range_2 = true
							local splitt_param_1_table = text_func.split_string(final_params_7, " | ")
							local splitt_param_2_table = text_func.split_string(final_params_7, " | ")
							if string.find(splitt_param_1_table[1], "<=") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "<=")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "=<") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "=<")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], ">=") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], ">=")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "=>") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "=>")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], "=") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "<")
								splitt_param_1 = tonumber(splitt_param_1_table[2]) + 1
							elseif string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								is_in_a_range_1 = false
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], ">")
								splitt_param_1 = tonumber(splitt_param_1_table[2]) + 1
							else
								splitt_param_1 = 2147483647
							end
							if string.find(splitt_param_2_table[2], ">=") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], ">=")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "=>") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "=>")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "<=") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "<=")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "=<") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "=<")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], "=") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], ">")
								splitt_param_2 = tonumber(splitt_param_2_table[2]) - 1
							elseif string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								is_in_a_range_2 = false
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "<")
								splitt_param_2 = tonumber(splitt_param_2_table[2]) - 1
							else
								splitt_param_2 = -2147483647
							end
							if not is_in_a_range_1 and not is_in_a_range_2 then
								if tonumber(splitt_param_1) < tonumber(splitt_param_2) then
									final_params_7 = math.random(tonumber(splitt_param_1), tonumber(splitt_param_2))
								else
									final_params_7 = math.random(tonumber(splitt_param_2), tonumber(splitt_param_1))
								end
							elseif is_in_a_range_1 and not is_in_a_range_2 then
								if tonumber(splitt_param_1) < 2147483647 then
									final_params_7 = math.random(tonumber(splitt_param_1), 2147483647)
								else
									final_params_7 = tonumber(splitt_param_1)
								end
							elseif is_in_a_range_2 and not is_in_a_range_1 then
								if tonumber(splitt_param_2) > -2147483647 then
									final_params_7 = math.random(-2147483647, tonumber(splitt_param_2))
								else
									final_params_7 = tonumber(splitt_param_2)
								end
							else
								final_params_7 = math.random(-2147483647, 2147483647)
							end
						elseif string.find(final_params_7, "!") and not string.find(final_params_7, "=") and not string.find(final_params_7, "|") and not string.find(final_params_7, ">") and not string.find(final_params_7, "<") then
							se_params_7 = text_func.split_string(final_params_7, "!")
							final_params_7 = tonumber(se_params_7[2]) + 1
						else
							final_params_7 = player.player_id()
						end
						if string.find(se_params_8[2], "8: ") then
							se_params_8 = text_func.split_string(line, "8: ")
							if string.find(se_params_8[2], ",") then
								se_params_8 = text_func.split_string(se_params_8[2], ",")
								has_8_param = true
							else
								se_params_8 = text_func.split_string(se_params_8[2], "}")
								has_8_param = true
							end
						else
							has_8_param = false
						end
						final_params_8 = se_params_8[1]
						if string.find(final_params_8, "=") and not string.find(final_params_8, ">") and not string.find(final_params_8, "|") and not string.find(final_params_8, "<") and not string.find(final_params_8, "!") then
							se_params_8 = text_func.split_string(final_params_8, "=")
							final_params_8 = tonumber(se_params_8[2])
						elseif string.find(final_params_8, ">") and not string.find(final_params_8, "=") and not string.find(final_params_8, "|") and not string.find(final_params_8, "<") and not string.find(final_params_8, "!") then
							se_params_8 = text_func.split_string(final_params_8, ">")
							if tonumber(se_params_8[2]) + 1 < 2147483647 then
								final_params_8 = math.random(tonumber(se_params_8[2]) + 1, 2147483647)
							else
								final_params_8 = tonumber(se_params_8[2]) + 1
							end
						elseif string.find(final_params_8, "<") and not string.find(final_params_8, "=") and not string.find(final_params_8, "|") and not string.find(final_params_8, ">") and not string.find(final_params_8, "!") then
							se_params_8 = text_func.split_string(final_params_8, "<")
							if tonumber(se_params_8[2]) - 1 > -2147483647 then
								final_params_8 = math.random(-2147483647, tonumber(se_params_8[2]) - 1)
							else
								final_params_8 = tonumber(se_params_8[2]) - 1
							end
						elseif string.find(final_params_8, ">=") and not string.find(final_params_8, "|") and not string.find(final_params_8, "<") and not string.find(final_params_8, "!") then
							se_params_8 = text_func.split_string(final_params_8, ">=")
							if tonumber(se_params_8[2]) < 2147483647 then
								final_params_8 = math.random(tonumber(se_params_8[2]), 2147483647)
							else
								final_params_8 = tonumber(se_params_8[2])
							end
						elseif string.find(final_params_8, "<=") and not string.find(final_params_8, "|") and not string.find(final_params_8, ">") and not string.find(final_params_8, "!") then
							se_params_8 = text_func.split_string(final_params_8, "<=")
							if tonumber(se_params_8[2]) > -2147483647 then
								final_params_8 = math.random(-2147483647, tonumber(se_params_8[2]))
							else
								final_params_8 = tonumber(se_params_8[2])
							end
						elseif string.find(final_params_8, "=>") and not string.find(final_params_8, "|") and not string.find(final_params_8, "<") and not string.find(final_params_8, "!") then
							se_params_8 = text_func.split_string(final_params_8, "=>")
							if tonumber(se_params_8[2]) < 2147483647 then
								final_params_8 = math.random(tonumber(se_params_8[2]), 2147483647)
							else
								final_params_8 = tonumber(se_params_8[2])
							end
						elseif string.find(final_params_8, "=<") and not string.find(final_params_8, "|") and not string.find(final_params_8, ">") and not string.find(final_params_8, "!") then
							se_params_8 = text_func.split_string(final_params_8, "=<")
							if tonumber(se_params_8[2]) > -2147483647 then
								final_params_8 = math.random(-2147483647, tonumber(se_params_8[2]))
							else
								final_params_8 = tonumber(se_params_8[2])
							end
						elseif (string.find(final_params_8, "<") or string.find(final_params_8, ">") or string.find(final_params_8, "<")) and string.find(final_params_8, " | ") and not string.find(final_params_8, "!") then
							local splitt_param_1 = 2147483647
							local splitt_param_2 = -2147483647
							local is_in_a_range_1 = true
							local is_in_a_range_2 = true
							local splitt_param_1_table = text_func.split_string(final_params_8, " | ")
							local splitt_param_2_table = text_func.split_string(final_params_8, " | ")
							if string.find(splitt_param_1_table[1], "<=") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "<=")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "=<") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "=<")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], ">=") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], ">=")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "=>") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "=>")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], "=") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "<")
								splitt_param_1 = tonumber(splitt_param_1_table[2]) + 1
							elseif string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								is_in_a_range_1 = false
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], ">")
								splitt_param_1 = tonumber(splitt_param_1_table[2]) + 1
							else
								splitt_param_1 = 2147483647
							end
							if string.find(splitt_param_2_table[2], ">=") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], ">=")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "=>") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "=>")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "<=") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "<=")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "=<") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "=<")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], "=") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], ">")
								splitt_param_2 = tonumber(splitt_param_2_table[2]) - 1
							elseif string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								is_in_a_range_2 = false
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "<")
								splitt_param_2 = tonumber(splitt_param_2_table[2]) - 1
							else
								splitt_param_2 = -2147483647
							end
							if not is_in_a_range_1 and not is_in_a_range_2 then
								if tonumber(splitt_param_1) < tonumber(splitt_param_2) then
									final_params_8 = math.random(tonumber(splitt_param_1), tonumber(splitt_param_2))
								else
									final_params_8 = math.random(tonumber(splitt_param_2), tonumber(splitt_param_1))
								end
							elseif is_in_a_range_1 and not is_in_a_range_2 then
								if tonumber(splitt_param_1) < 2147483647 then
									final_params_8 = math.random(tonumber(splitt_param_1), 2147483647)
								else
									final_params_8 = tonumber(splitt_param_1)
								end
							elseif is_in_a_range_2 and not is_in_a_range_1 then
								if tonumber(splitt_param_2) > -2147483647 then
									final_params_8 = math.random(-2147483647, tonumber(splitt_param_2))
								else
									final_params_8 = tonumber(splitt_param_2)
								end
							else
								final_params_8 = math.random(-2147483647, 2147483647)
							end
						elseif string.find(final_params_8, "!") and not string.find(final_params_8, "=") and not string.find(final_params_8, "|") and not string.find(final_params_8, ">") and not string.find(final_params_8, "<") then
							se_params_8 = text_func.split_string(final_params_8, "!")
							final_params_8 = tonumber(se_params_8[2]) + 1
						else
							final_params_8 = player.player_id()
						end
						if string.find(se_params_9[2], "9: ") then
							se_params_9 = text_func.split_string(line, "9: ")
							if string.find(se_params_9[2], ",") then
								se_params_9 = text_func.split_string(se_params_9[2], ",")
								has_9_param = true
							else
								se_params_9 = text_func.split_string(se_params_9[2], "}")
								has_9_param = true
							end
						else
							has_9_param = false
						end
						final_params_9 = se_params_9[1]
						if string.find(final_params_9, "=") and not string.find(final_params_9, ">") and not string.find(final_params_9, "|") and not string.find(final_params_9, "<") and not string.find(final_params_9, "!") then
							se_params_9 = text_func.split_string(final_params_9, "=")
							final_params_9 = tonumber(se_params_9[2])
						elseif string.find(final_params_9, ">") and not string.find(final_params_9, "=") and not string.find(final_params_9, "|") and not string.find(final_params_9, "<") and not string.find(final_params_9, "!") then
							se_params_9 = text_func.split_string(final_params_9, ">")
							if tonumber(se_params_9[2]) + 1 < 2147483647 then
								final_params_9 = math.random(tonumber(se_params_9[2]) + 1, 2147483647)
							else
								final_params_9 = tonumber(se_params_9[2]) + 1
							end
						elseif string.find(final_params_9, "<") and not string.find(final_params_9, "=") and not string.find(final_params_9, "|") and not string.find(final_params_9, ">") and not string.find(final_params_9, "!") then
							se_params_9 = text_func.split_string(final_params_9, "<")
							if tonumber(se_params_9[2]) - 1 > -2147483647 then
								final_params_9 = math.random(-2147483647, tonumber(se_params_9[2]) - 1)
							else
								final_params_9 = tonumber(se_params_9[2]) - 1
							end
						elseif string.find(final_params_9, ">=") and not string.find(final_params_9, "|") and not string.find(final_params_9, "<") and not string.find(final_params_9, "!") then
							se_params_9 = text_func.split_string(final_params_9, ">=")
							if tonumber(se_params_9[2]) < 2147483647 then
								final_params_9 = math.random(tonumber(se_params_9[2]), 2147483647)
							else
								final_params_9 = tonumber(se_params_9[2])
							end
						elseif string.find(final_params_9, "<=") and not string.find(final_params_9, "|") and not string.find(final_params_9, ">") and not string.find(final_params_9, "!") then
							se_params_9 = text_func.split_string(final_params_9, "<=")
							if tonumber(se_params_9[2]) > -2147483647 then
								final_params_9 = math.random(-2147483647, tonumber(se_params_9[2]))
							else
								final_params_9 = tonumber(se_params_9[2])
							end
						elseif string.find(final_params_9, "=>") and not string.find(final_params_9, "|") and not string.find(final_params_9, "<") and not string.find(final_params_9, "!") then
							se_params_9 = text_func.split_string(final_params_9, "=>")
							if tonumber(se_params_9[2]) < 2147483647 then
								final_params_9 = math.random(tonumber(se_params_9[2]), 2147483647)
							else
								final_params_9 = tonumber(se_params_9[2])
							end
						elseif string.find(final_params_9, "=<") and not string.find(final_params_9, "|") and not string.find(final_params_9, ">") and not string.find(final_params_9, "!") then
							se_params_9 = text_func.split_string(final_params_9, "=<")
							if tonumber(se_params_9[2]) > -2147483647 then
								final_params_9 = math.random(-2147483647, tonumber(se_params_9[2]))
							else
								final_params_9 = tonumber(se_params_9[2])
							end
						elseif (string.find(final_params_9, "<") or string.find(final_params_9, ">") or string.find(final_params_9, "<")) and string.find(final_params_9, " | ") and not string.find(final_params_9, "!") then
							local splitt_param_1 = 2147483647
							local splitt_param_2 = -2147483647
							local is_in_a_range_1 = true
							local is_in_a_range_2 = true
							local splitt_param_1_table = text_func.split_string(final_params_9, " | ")
							local splitt_param_2_table = text_func.split_string(final_params_9, " | ")
							if string.find(splitt_param_1_table[1], "<=") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "<=")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "=<") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "=<")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], ">=") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], ">=")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "=>") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "=>")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], "=") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "<")
								splitt_param_1 = tonumber(splitt_param_1_table[2]) + 1
							elseif string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								is_in_a_range_1 = false
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], ">")
								splitt_param_1 = tonumber(splitt_param_1_table[2]) + 1
							else
								splitt_param_1 = 2147483647
							end
							if string.find(splitt_param_2_table[2], ">=") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], ">=")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "=>") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "=>")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "<=") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "<=")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "=<") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "=<")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], "=") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], ">")
								splitt_param_2 = tonumber(splitt_param_2_table[2]) - 1
							elseif string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								is_in_a_range_2 = false
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "<")
								splitt_param_2 = tonumber(splitt_param_2_table[2]) - 1
							else
								splitt_param_2 = -2147483647
							end
							if not is_in_a_range_1 and not is_in_a_range_2 then
								if tonumber(splitt_param_1) < tonumber(splitt_param_2) then
									final_params_9 = math.random(tonumber(splitt_param_1), tonumber(splitt_param_2))
								else
									final_params_9 = math.random(tonumber(splitt_param_2), tonumber(splitt_param_1))
								end
							elseif is_in_a_range_1 and not is_in_a_range_2 then
								if tonumber(splitt_param_1) < 2147483647 then
									final_params_9 = math.random(tonumber(splitt_param_1), 2147483647)
								else
									final_params_9 = tonumber(splitt_param_1)
								end
							elseif is_in_a_range_2 and not is_in_a_range_1 then
								if tonumber(splitt_param_2) > -2147483647 then
									final_params_9 = math.random(-2147483647, tonumber(splitt_param_2))
								else
									final_params_9 = tonumber(splitt_param_2)
								end
							else
								final_params_9 = math.random(-2147483647, 2147483647)
							end
						elseif string.find(final_params_9, "!") and not string.find(final_params_9, "=") and not string.find(final_params_9, "|") and not string.find(final_params_9, ">") and not string.find(final_params_9, "<") then
							se_params_9 = text_func.split_string(final_params_9, "!")
							final_params_9 = tonumber(se_params_9[2]) + 1
						else
							final_params_9 = player.player_id()
						end
						if string.find(se_params_10[2], "10: ") then
							se_params_10 = text_func.split_string(line, "10: ")
							if string.find(se_params_10[2], ",") then
								se_params_10 = text_func.split_string(se_params_10[2], ",")
								has_10_param = true
							else
								se_params_10 = text_func.split_string(se_params_10[2], "}")
								has_10_param = true
							end
						else
							has_10_param = false
						end
						final_params_10 = se_params_10[1]
						if string.find(final_params_10, "=") and not string.find(final_params_10, ">") and not string.find(final_params_10, "|") and not string.find(final_params_10, "<") and not string.find(final_params_10, "!") then
							se_params_10 = text_func.split_string(final_params_10, "=")
							final_params_10 = tonumber(se_params_10[2])
						elseif string.find(final_params_10, ">") and not string.find(final_params_10, "=") and not string.find(final_params_10, "|") and not string.find(final_params_10, "<") and not string.find(final_params_10, "!") then
							se_params_10 = text_func.split_string(final_params_10, ">")
							if tonumber(se_params_10[2]) + 1 < 2147483647 then
								final_params_10 = math.random(tonumber(se_params_10[2]) + 1, 2147483647)
							else
								final_params_10 = tonumber(se_params_10[2]) + 1
							end
						elseif string.find(final_params_10, "<") and not string.find(final_params_10, "=") and not string.find(final_params_10, "|") and not string.find(final_params_10, ">") and not string.find(final_params_10, "!") then
							se_params_10 = text_func.split_string(final_params_10, "<")
							if tonumber(se_params_10[2]) - 1 > -2147483647 then
								final_params_10 = math.random(-2147483647, tonumber(se_params_10[2]) - 1)
							else
								final_params_10 = tonumber(se_params_10[2]) - 1
							end
						elseif string.find(final_params_10, ">=") and not string.find(final_params_10, "|") and not string.find(final_params_10, "<") and not string.find(final_params_10, "!") then
							se_params_10 = text_func.split_string(final_params_10, ">=")
							if tonumber(se_params_10[2]) < 2147483647 then
								final_params_10 = math.random(tonumber(se_params_10[2]), 2147483647)
							else
								final_params_10 = tonumber(se_params_10[2])
							end
						elseif string.find(final_params_10, "<=") and not string.find(final_params_10, "|") and not string.find(final_params_10, ">") and not string.find(final_params_10, "!") then
							se_params_10 = text_func.split_string(final_params_10, "<=")
							if tonumber(se_params_10[2]) > -2147483647 then
								final_params_10 = math.random(-2147483647, tonumber(se_params_10[2]))
							else
								final_params_10 = tonumber(se_params_10[2])
							end
						elseif string.find(final_params_10, "=>") and not string.find(final_params_10, "|") and not string.find(final_params_10, "<") and not string.find(final_params_10, "!") then
							se_params_10 = text_func.split_string(final_params_10, "=>")
							if tonumber(se_params_10[2]) < 2147483647 then
								final_params_10 = math.random(tonumber(se_params_10[2]), 2147483647)
							else
								final_params_10 = tonumber(se_params_10[2])
							end
						elseif string.find(final_params_10, "=<") and not string.find(final_params_10, "|") and not string.find(final_params_10, ">") and not string.find(final_params_10, "!") then
							se_params_10 = text_func.split_string(final_params_10, "=<")
							if tonumber(se_params_10[2]) > -2147483647 then
								final_params_10 = math.random(-2147483647, tonumber(se_params_10[2]))
							else
								final_params_10 = tonumber(se_params_10[2])
							end
						elseif (string.find(final_params_10, "<") or string.find(final_params_10, ">") or string.find(final_params_10, "<")) and string.find(final_params_10, " | ") and not string.find(final_params_10, "!") then
							local splitt_param_1 = 2147483647
							local splitt_param_2 = -2147483647
							local is_in_a_range_1 = true
							local is_in_a_range_2 = true
							local splitt_param_1_table = text_func.split_string(final_params_10, " | ")
							local splitt_param_2_table = text_func.split_string(final_params_10, " | ")
							if string.find(splitt_param_1_table[1], "<=") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "<=")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "=<") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "=<")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], ">=") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], ">=")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "=>") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "=>")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], "=") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "<")
								splitt_param_1 = tonumber(splitt_param_1_table[2]) + 1
							elseif string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								is_in_a_range_1 = false
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], ">")
								splitt_param_1 = tonumber(splitt_param_1_table[2]) + 1
							else
								splitt_param_1 = 2147483647
							end
							if string.find(splitt_param_2_table[2], ">=") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], ">=")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "=>") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "=>")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "<=") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "<=")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "=<") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "=<")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], "=") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], ">")
								splitt_param_2 = tonumber(splitt_param_2_table[2]) - 1
							elseif string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								is_in_a_range_2 = false
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "<")
								splitt_param_2 = tonumber(splitt_param_2_table[2]) - 1
							else
								splitt_param_2 = -2147483647
							end
							if not is_in_a_range_1 and not is_in_a_range_2 then
								if tonumber(splitt_param_1) < tonumber(splitt_param_2) then
									final_params_10 = math.random(tonumber(splitt_param_1), tonumber(splitt_param_2))
								else
									final_params_10 = math.random(tonumber(splitt_param_2), tonumber(splitt_param_1))
								end
							elseif is_in_a_range_1 and not is_in_a_range_2 then
								if tonumber(splitt_param_1) < 2147483647 then
									final_params_10 = math.random(tonumber(splitt_param_1), 2147483647)
								else
									final_params_10 = tonumber(splitt_param_1)
								end
							elseif is_in_a_range_2 and not is_in_a_range_1 then
								if tonumber(splitt_param_2) > -2147483647 then
									final_params_10 = math.random(-2147483647, tonumber(splitt_param_2))
								else
									final_params_10 = tonumber(splitt_param_2)
								end
							else
								final_params_10 = math.random(-2147483647, 2147483647)
							end
						elseif string.find(final_params_10, "!") and not string.find(final_params_10, "=") and not string.find(final_params_10, "|") and not string.find(final_params_10, ">") and not string.find(final_params_10, "<") then
							se_params_10 = text_func.split_string(final_params_10, "!")
							final_params_10 = tonumber(se_params_10[2]) + 1
						else
							final_params_10 = player.player_id()
						end
						if string.find(se_params_11[2], "11: ") then
							se_params_11 = text_func.split_string(line, "11: ")
							if string.find(se_params_11[2], ",") then
								se_params_11 = text_func.split_string(se_params_11[2], ",")
								has_11_param = true
							else
								se_params_11 = text_func.split_string(se_params_11[2], "}")
								has_11_param = true
							end
						else
							has_11_param = false
						end
						final_params_11 = se_params_11[1]
						if string.find(final_params_11, "=") and not string.find(final_params_11, ">") and not string.find(final_params_11, "|") and not string.find(final_params_11, "<") and not string.find(final_params_11, "!") then
							se_params_11 = text_func.split_string(final_params_11, "=")
							final_params_11 = tonumber(se_params_11[2])
						elseif string.find(final_params_11, ">") and not string.find(final_params_11, "=") and not string.find(final_params_11, "|") and not string.find(final_params_11, "<") and not string.find(final_params_11, "!") then
							se_params_11 = text_func.split_string(final_params_11, ">")
							if tonumber(se_params_11[2]) + 1 < 2147483647 then
								final_params_11 = math.random(tonumber(se_params_11[2]) + 1, 2147483647)
							else
								final_params_11 = tonumber(se_params_11[2]) + 1
							end
						elseif string.find(final_params_11, "<") and not string.find(final_params_11, "=") and not string.find(final_params_11, "|") and not string.find(final_params_11, ">") and not string.find(final_params_11, "!") then
							se_params_11 = text_func.split_string(final_params_11, "<")
							if tonumber(se_params_11[2]) - 1 > -2147483647 then
								final_params_11 = math.random(-2147483647, tonumber(se_params_11[2]) - 1)
							else
								final_params_11 = tonumber(se_params_11[2]) - 1
							end
						elseif string.find(final_params_11, ">=") and not string.find(final_params_11, "|") and not string.find(final_params_11, "<") and not string.find(final_params_11, "!") then
							se_params_11 = text_func.split_string(final_params_11, ">=")
							if tonumber(se_params_11[2]) < 2147483647 then
								final_params_11 = math.random(tonumber(se_params_11[2]), 2147483647)
							else
								final_params_11 = tonumber(se_params_11[2])
							end
						elseif string.find(final_params_11, "<=") and not string.find(final_params_11, "|") and not string.find(final_params_11, ">") and not string.find(final_params_11, "!") then
							se_params_11 = text_func.split_string(final_params_11, "<=")
							if tonumber(se_params_11[2]) > -2147483647 then
								final_params_11 = math.random(-2147483647, tonumber(se_params_11[2]))
							else
								final_params_11 = tonumber(se_params_11[2])
							end
						elseif string.find(final_params_11, "=>") and not string.find(final_params_11, "|") and not string.find(final_params_11, "<") and not string.find(final_params_11, "!") then
							se_params_11 = text_func.split_string(final_params_11, "=>")
							if tonumber(se_params_11[2]) < 2147483647 then
								final_params_11 = math.random(tonumber(se_params_11[2]), 2147483647)
							else
								final_params_11 = tonumber(se_params_11[2])
							end
						elseif string.find(final_params_11, "=<") and not string.find(final_params_11, "|") and not string.find(final_params_11, ">") and not string.find(final_params_11, "!") then
							se_params_11 = text_func.split_string(final_params_11, "=<")
							if tonumber(se_params_11[2]) > -2147483647 then
								final_params_11 = math.random(-2147483647, tonumber(se_params_11[2]))
							else
								final_params_11 = tonumber(se_params_11[2])
							end
						elseif (string.find(final_params_11, "<") or string.find(final_params_11, ">") or string.find(final_params_11, "<")) and string.find(final_params_11, " | ") and not string.find(final_params_11, "!") then
							local splitt_param_1 = 2147483647
							local splitt_param_2 = -2147483647
							local is_in_a_range_1 = true
							local is_in_a_range_2 = true
							local splitt_param_1_table = text_func.split_string(final_params_11, " | ")
							local splitt_param_2_table = text_func.split_string(final_params_11, " | ")
							if string.find(splitt_param_1_table[1], "<=") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "<=")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "=<") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "=<")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], ">=") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], ">=")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "=>") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "=>")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], "=") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "<")
								splitt_param_1 = tonumber(splitt_param_1_table[2]) + 1
							elseif string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								is_in_a_range_1 = false
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], ">")
								splitt_param_1 = tonumber(splitt_param_1_table[2]) + 1
							else
								splitt_param_1 = 2147483647
							end
							if string.find(splitt_param_2_table[2], ">=") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], ">=")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "=>") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "=>")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "<=") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "<=")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "=<") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "=<")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], "=") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], ">")
								splitt_param_2 = tonumber(splitt_param_2_table[2]) - 1
							elseif string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								is_in_a_range_2 = false
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "<")
								splitt_param_2 = tonumber(splitt_param_2_table[2]) - 1
							else
								splitt_param_2 = -2147483647
							end
							if not is_in_a_range_1 and not is_in_a_range_2 then
								if tonumber(splitt_param_1) < tonumber(splitt_param_2) then
									final_params_11 = math.random(tonumber(splitt_param_1), tonumber(splitt_param_2))
								else
									final_params_11 = math.random(tonumber(splitt_param_2), tonumber(splitt_param_1))
								end
							elseif is_in_a_range_1 and not is_in_a_range_2 then
								if tonumber(splitt_param_1) < 2147483647 then
									final_params_11 = math.random(tonumber(splitt_param_1), 2147483647)
								else
									final_params_11 = tonumber(splitt_param_1)
								end
							elseif is_in_a_range_2 and not is_in_a_range_1 then
								if tonumber(splitt_param_2) > -2147483647 then
									final_params_11 = math.random(-2147483647, tonumber(splitt_param_2))
								else
									final_params_11 = tonumber(splitt_param_2)
								end
							else
								final_params_11 = math.random(-2147483647, 2147483647)
							end
						elseif string.find(final_params_11, "!") and not string.find(final_params_11, "=") and not string.find(final_params_11, "|") and not string.find(final_params_11, ">") and not string.find(final_params_11, "<") then
							se_params_11 = text_func.split_string(final_params_11, "!")
							final_params_11 = tonumber(se_params_11[2]) + 1
						else
							final_params_11 = player.player_id()
						end
						if string.find(se_params_12[2], "12: ") then
							se_params_12 = text_func.split_string(line, "12: ")
							if string.find(se_params_12[2], ",") then
								se_params_12 = text_func.split_string(se_params_12[2], ",")
								has_12_param = true
							else
								se_params_12 = text_func.split_string(se_params_12[2], "}")
								has_12_param = true
							end
						else
							has_12_param = false
						end
						final_params_12 = se_params_12[1]
						if string.find(final_params_12, "=") and not string.find(final_params_12, ">") and not string.find(final_params_12, "|") and not string.find(final_params_12, "<") and not string.find(final_params_12, "!") then
							se_params_12 = text_func.split_string(final_params_12, "=")
							final_params_12 = tonumber(se_params_12[2])
						elseif string.find(final_params_12, ">") and not string.find(final_params_12, "=") and not string.find(final_params_12, "|") and not string.find(final_params_12, "<") and not string.find(final_params_12, "!") then
							se_params_12 = text_func.split_string(final_params_12, ">")
							if tonumber(se_params_12[2]) + 1 < 2147483647 then
								final_params_12 = math.random(tonumber(se_params_12[2]) + 1, 2147483647)
							else
								final_params_12 = tonumber(se_params_12[2]) + 1
							end
						elseif string.find(final_params_12, "<") and not string.find(final_params_12, "=") and not string.find(final_params_12, "|") and not string.find(final_params_12, ">") and not string.find(final_params_12, "!") then
							se_params_12 = text_func.split_string(final_params_12, "<")
							if tonumber(se_params_12[2]) - 1 > -2147483647 then
								final_params_12 = math.random(-2147483647, tonumber(se_params_12[2]) - 1)
							else
								final_params_12 = tonumber(se_params_12[2]) - 1
							end
						elseif string.find(final_params_12, ">=") and not string.find(final_params_12, "|") and not string.find(final_params_12, "<") and not string.find(final_params_12, "!") then
							se_params_12 = text_func.split_string(final_params_12, ">=")
							if tonumber(se_params_12[2]) < 2147483647 then
								final_params_12 = math.random(tonumber(se_params_12[2]), 2147483647)
							else
								final_params_12 = tonumber(se_params_12[2])
							end
						elseif string.find(final_params_12, "<=") and not string.find(final_params_12, "|") and not string.find(final_params_12, ">") and not string.find(final_params_12, "!") then
							se_params_12 = text_func.split_string(final_params_12, "<=")
							if tonumber(se_params_12[2]) > -2147483647 then
								final_params_12 = math.random(-2147483647, tonumber(se_params_12[2]))
							else
								final_params_12 = tonumber(se_params_12[2])
							end
						elseif string.find(final_params_12, "=>") and not string.find(final_params_12, "|") and not string.find(final_params_12, "<") and not string.find(final_params_12, "!") then
							se_params_12 = text_func.split_string(final_params_12, "=>")
							if tonumber(se_params_12[2]) < 2147483647 then
								final_params_12 = math.random(tonumber(se_params_12[2]), 2147483647)
							else
								final_params_12 = tonumber(se_params_12[2])
							end
						elseif string.find(final_params_12, "=<") and not string.find(final_params_12, "|") and not string.find(final_params_12, ">") and not string.find(final_params_12, "!") then
							se_params_12 = text_func.split_string(final_params_12, "=<")
							if tonumber(se_params_12[2]) > -2147483647 then
								final_params_12 = math.random(-2147483647, tonumber(se_params_12[2]))
							else
								final_params_12 = tonumber(se_params_12[2])
							end
						elseif (string.find(final_params_12, "<") or string.find(final_params_12, ">") or string.find(final_params_12, "<")) and string.find(final_params_12, " | ") and not string.find(final_params_12, "!") then
							local splitt_param_1 = 2147483647
							local splitt_param_2 = -2147483647
							local is_in_a_range_1 = true
							local is_in_a_range_2 = true
							local splitt_param_1_table = text_func.split_string(final_params_12, " | ")
							local splitt_param_2_table = text_func.split_string(final_params_12, " | ")
							if string.find(splitt_param_1_table[1], "<=") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "<=")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "=<") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "=<")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], ">=") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], ">=")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "=>") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "=>")
								splitt_param_1 = tonumber(splitt_param_1_table[2])
							elseif string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], "=") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], "<")
								splitt_param_1 = tonumber(splitt_param_1_table[2]) + 1
							elseif string.find(splitt_param_1_table[1], ">") and not string.find(splitt_param_1_table[1], "<") and not string.find(splitt_param_1_table[1], " | ") and not string.find(splitt_param_1_table[1], "!") then
								is_in_a_range_1 = false
								splitt_param_1_table = text_func.split_string(splitt_param_1_table[1], ">")
								splitt_param_1 = tonumber(splitt_param_1_table[2]) + 1
							else
								splitt_param_1 = 2147483647
							end
							if string.find(splitt_param_2_table[2], ">=") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], ">=")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "=>") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "=>")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "<=") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "<=")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], "=<") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "=<")
								splitt_param_2 = tonumber(splitt_param_2_table[2])
							elseif string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], "=") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], ">")
								splitt_param_2 = tonumber(splitt_param_2_table[2]) - 1
							elseif string.find(splitt_param_2_table[2], "<") and not string.find(splitt_param_2_table[2], ">") and not string.find(splitt_param_2_table[2], " | ") and not string.find(splitt_param_2_table[2], "!") then
								is_in_a_range_2 = false
								splitt_param_2_table = text_func.split_string(splitt_param_2_table[2], "<")
								splitt_param_2 = tonumber(splitt_param_2_table[2]) - 1
							else
								splitt_param_2 = -2147483647
							end
							if not is_in_a_range_1 and not is_in_a_range_2 then
								if tonumber(splitt_param_1) < tonumber(splitt_param_2) then
									final_params_12 = math.random(tonumber(splitt_param_1), tonumber(splitt_param_2))
								else
									final_params_12 = math.random(tonumber(splitt_param_2), tonumber(splitt_param_1))
								end
							elseif is_in_a_range_1 and not is_in_a_range_2 then
								if tonumber(splitt_param_1) < 2147483647 then
									final_params_12 = math.random(tonumber(splitt_param_1), 2147483647)
								else
									final_params_12 = tonumber(splitt_param_1)
								end
							elseif is_in_a_range_2 and not is_in_a_range_1 then
								if tonumber(splitt_param_2) > -2147483647 then
									final_params_12 = math.random(-2147483647, tonumber(splitt_param_2))
								else
									final_params_12 = tonumber(splitt_param_2)
								end
							else
								final_params_12 = math.random(-2147483647, 2147483647)
							end
						elseif string.find(final_params_12, "!") and not string.find(final_params_12, "=") and not string.find(final_params_12, "|") and not string.find(final_params_12, ">") and not string.find(final_params_12, "<") then
							se_params_12 = text_func.split_string(final_params_12, "!")
							final_params_12 = tonumber(se_params_12[2]) + 1
						else
							final_params_12 = player.player_id()
						end
						if has_1_param then
							if math.type(tonumber(final_params_1)) == "integer" then
								table.insert(all_params, final_params_1)
							else
								table.insert(all_params, math.random(-2147483647, 2147483647))
							end
						else
							table.insert(all_params, player.player_id())
						end
						if has_2_param then
							if math.type(tonumber(final_params_2)) == "integer" then
								table.insert(all_params, final_params_2)
							else
								table.insert(all_params, math.random(-2147483647, 2147483647))
							end
						end
						if has_3_param then
							if math.type(tonumber(final_params_3)) == "integer" then
								table.insert(all_params, final_params_3)
							else
								table.insert(all_params, math.random(-2147483647, 2147483647))
							end
						end
						if has_4_param then
							if math.type(tonumber(final_params_4)) == "integer" then
								table.insert(all_params, final_params_4)
							else
								table.insert(all_params, math.random(-2147483647, 2147483647))
							end
						end
						if has_5_param then
							if math.type(tonumber(final_params_5)) == "integer" then
								table.insert(all_params, final_params_5)
							else
								table.insert(all_params, math.random(-2147483647, 2147483647))
							end
						end
						if has_6_param then
							if math.type(tonumber(final_params_6)) == "integer" then
								table.insert(all_params, final_params_6)
							else
								table.insert(all_params, math.random(-2147483647, 2147483647))
							end
						end
						if has_7_param then
							if math.type(tonumber(final_params_7)) == "integer" then
								table.insert(all_params, final_params_7)
							else
								table.insert(all_params, math.random(-2147483647, 2147483647))
							end
						end
						if has_8_param then
							if math.type(tonumber(final_params_8)) == "integer" then
								table.insert(all_params, final_params_8)
							else
								table.insert(all_params, math.random(-2147483647, 2147483647))
							end
						end
						if has_9_param then
							if math.type(tonumber(final_params_9)) == "integer" then
								table.insert(all_params, final_params_9)
							else
								table.insert(all_params, math.random(-2147483647, 2147483647))
							end
						end
						if has_10_param then
							if math.type(tonumber(final_params_10)) == "integer" then
								table.insert(all_params, final_params_10)
							else
								table.insert(all_params, math.random(-2147483647, 2147483647))
							end
						end
						if has_11_param then
							if math.type(tonumber(final_params_11)) == "integer" then
								table.insert(all_params, final_params_11)
							else
								table.insert(all_params, math.random(-2147483647, 2147483647))
							end
						end
						if has_12_param then
							if math.type(tonumber(final_params_12)) == "integer" then
								table.insert(all_params, final_params_12)
							else
								table.insert(all_params, math.random(-2147483647, 2147483647))
							end
						end
						if math.type(tonumber(se_params_0[1])) == "integer" then
							final_params_0 = se_params_0[1]
						else
							final_params_0 = 0
						end
						if last_found_parent_in_sep == nil then
							last_found_parent_in_sep = playerparents["» SEP"]
						end
						menu.add_player_feature("» " .. se_parts_1[1], "action", last_found_parent_in_sep, function(f, pid)
							if player.is_player_valid(pid) then
								script.trigger_script_event(final_params_0, pid, all_params)
							else
								menu.notify("Invalid Player.", Meteor, 3, 211)
							end
						end)
					end
				end
			end
			io.close(file)
		end
	else
		menu.add_player_feature("» SAFE MODE", "action", playerparents["» SEP"], function(f, pid)
			menu.notify("[Feature Blocked Due To Safe Mode Being Activated]", Meteor, 8, 0x00A2FF)
		end)
	end
end

menu.add_player_feature("» Crash Car", "action", playerparents["» Vehicle Options"], function(f, pid)
	if player.is_player_in_any_vehicle(pid) then
		utilities.request_model(165521376)
		local object_ = object.create_object(165521376, utilities.offset_coords_forward(player.get_player_coords(pid), player.get_player_heading(pid), 5), true, false)
		entity.set_entity_rotation(object_, v3(0, 0, entity.get_entity_rotation(player.get_player_vehicle(pid)).z + 90))
		entity.set_entity_visible(object_, false)
		system.wait(2000)
		entity.delete_entity(object_)
	else
		menu.notify("Player is not in a vehicle", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Yeet", "action", playerparents["» Vehicle Options"], function(f, pid)
	if player.is_player_in_any_vehicle(pid) then
		utilities.request_control(player.get_player_vehicle(pid))
		entity.apply_force_to_entity(player.get_player_vehicle(pid), 3, math.random(0, 360), math.random(0, 360), math.random(0, 360), math.random(0, 360), math.random(0, 360), math.random(0, 360), true, true)
	else
		menu.notify("Player is not in a vehicle", Meteor, 3, 211)
	end
end)

feature["» Set Plane Turbulence"] = menu.add_player_feature("» Set Plane Turbulence", "action_value_i", playerparents["» Vehicle Options"], function(f, pid)
	if player.is_player_in_any_vehicle(pid) and streaming.is_model_a_plane(entity.get_entity_model_hash(player.get_player_vehicle(pid))) then
		utilities.request_control(player.get_player_vehicle(pid))
		natives.SET_PLANE_TURBULENCE_MULTIPLIER(player.get_player_vehicle(pid), f.value / 10)
	else
		menu.notify("Player is not in a plane", Meteor, 3, 211)
	end
end)
feature["» Set Plane Turbulence"].max = 10
feature["» Set Plane Turbulence"].min = 0
feature["» Set Plane Turbulence"].mod = 1
feature["» Set Plane Turbulence"].value = 0

menu.add_player_feature("» Steal Vehicle", "action", playerparents["» Vehicle Options"], function(f, pid)
	if player.is_player_in_any_vehicle(pid) then
		local player_vehicle = player.get_player_vehicle(pid)
		utilities.request_control(player_vehicle)
		if network.has_control_of_entity(player_vehicle) then
			utilities.request_model(0xB5CF80E4)
			ped.clear_ped_tasks_immediately(player.get_player_ped(pid))
			local ped_ = ped.create_ped(0, 0xB5CF80E4, player.get_player_coords(pid) + v3(0, 0, 10), player.get_player_heading(pid), true, false)
			utilities.request_control_silent(ped_)
			ped.set_ped_combat_attributes(ped_, 3, false)
			ped.set_ped_into_vehicle(ped_, player_vehicle, -1)
			gameplay.shoot_single_bullet_between_coords(entity.get_entity_coords(ped_), entity.get_entity_coords(ped_), 0, gameplay.get_hash_key("weapon_pistol"), player.get_player_ped(pid), false, true, 100)
		end
	else
		menu.notify("The Player has to be in a vehicle!", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Remove Wheels", "action", playerparents["» Vehicle Options"], function(f, pid)
	if player.is_player_in_any_vehicle(pid) then
		utilities.request_control(player.get_player_vehicle(pid))
		if vehicle.get_vehicle_wheel_count(player.get_player_vehicle(pid)) ~= nil then
			for i = 0, vehicle.get_vehicle_wheel_count(player.get_player_vehicle(pid)) do
				vehicle.set_vehicle_wheel_tire_radius(player.get_player_vehicle(pid), i, 0.0000000000000000000000000000000000001)
				vehicle.set_vehicle_wheel_render_size(player.get_player_vehicle(pid), 0)
			end
		end
	else
		menu.notify("Player is not in a vehicle", Meteor, 3, 211)
	end
end)

feature["» Spin Vehicle"] = menu.add_player_feature("» Spin Vehicle", "slider", playerparents["» Vehicle Options"], function(f, pid)
	if f.on then
		local spind_speed = f.value
		if player.is_player_in_any_vehicle(pid) then
			utilities.request_control(player.get_player_vehicle(pid))
			for i = text_func.round(entity.get_entity_heading(player.get_player_vehicle(pid))), 360 do
				entity.set_entity_heading(player.get_player_vehicle(pid), i)
				system.wait(spind_speed)
			end
		end
		while f.on do
			system.yield(0)
			if player.is_player_in_any_vehicle(pid) then
				for i = 0, 360 do
					entity.set_entity_heading(player.get_player_vehicle(pid), i)
					system.wait(spind_speed)
				end
			end
		end
	end
end)
feature["» Spin Vehicle"].min = 0
feature["» Spin Vehicle"].max = 1000
feature["» Spin Vehicle"].mod = 50
feature["» Spin Vehicle"].value = 500

menu.add_player_feature("» Freeze Vehicle", "toggle", playerparents["» Vehicle Options"], function(f, pid)
	if f.on then
		utilities.request_control(player.get_player_vehicle(pid))
		while f.on do
			system.yield(100)
			entity.freeze_entity(player.get_player_vehicle(pid), true)
		end
	end
	if not f.on then
		utilities.request_control(player.get_player_vehicle(pid))
		entity.freeze_entity(player.get_player_vehicle(pid), false)
	end
end)

menu.add_player_feature("» Vehicle Godmode", "value_str", playerparents["» Vehicle Options"], function(f, pid)
	if f.on then
		utilities.request_control(player.get_player_vehicle(pid))
		while f.on do
			system.yield(0)
			utilities.request_control_silent(player.get_player_vehicle(pid))
			if f.value == 0 then
				entity.set_entity_god_mode(player.get_player_vehicle(pid), true)
			else
				natives.SET_ENTITY_PROOFS(player.get_player_vehicle(pid), true, true, true, true, true, true, true, true, true)
			end
		end
	end
	if not f.on then
		utilities.request_control_silent(player.get_player_vehicle(pid))
		if f.value == 0 then
			entity.set_entity_god_mode(player.get_player_vehicle(pid), false)
		else
			natives.SET_ENTITY_PROOFS(player.get_player_vehicle(pid), false, false, false, false, false, false, false, false, false)
		end
	end
end):set_str_data({"v1", "v2"})

menu.add_player_feature("» Fill Vehicle With Peds", "action", playerparents["» Vehicle Options"], function(f, pid)
	if player.is_player_in_any_vehicle(pid) then
		local vehicle_ = player.get_player_vehicle(pid)
		utilities.request_control(vehicle_)
		if network.has_control_of_entity(vehicle_) then
			local fill_peds = {}
			for i = -1, vehicle.get_vehicle_model_number_of_seats(entity.get_entity_model_hash(vehicle_)) do
				if natives.IS_VEHICLE_SEAT_FREE(vehicle_, i, false):__tointeger() == 1 then
					local rndmmodel
					local rndint = math.random(1, 8)
					if rndint == 1 then
						rndmmodel = 1951946145
					elseif rndint == 2 then
						rndmmodel = 826475330
					elseif rndint == 3 then
						rndmmodel = 3482496489
					elseif rndint == 4 then
						rndmmodel = 1388848350
					elseif rndint == 5 then
						rndmmodel = 3512565361
					elseif rndint == 6 then
						rndmmodel = 3188223741
					elseif rndint == 7 then
						rndmmodel = 3382649284
					else
						rndmmodel = 2597531625			
					end
					utilities.request_model(rndmmodel)
					fill_peds[#fill_peds + 1] = ped.create_ped(0, rndmmodel, player.get_player_coords(pid) + v3(0, 0, 10), 0, true, false)
					network.request_control_of_entity(fill_peds[#fill_peds])
					ped.set_ped_into_vehicle(fill_peds[#fill_peds], vehicle_, i)
					ped.set_ped_combat_attributes(fill_peds[#fill_peds], 3, false)
				end
			end
		end
	else
		menu.notify("Player is not in a vehicle", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Bouncy Vehicle", "toggle", playerparents["» Vehicle Options"], function(f, pid)
    while f.on do
		utilities.request_control(player.get_player_vehicle(pid))
        local vehicle_velocity = entity.get_entity_velocity(player.get_player_vehicle(pid))
        entity.set_entity_velocity(player.get_player_vehicle(pid), v3(vehicle_velocity.x, vehicle_velocity.y, vehicle_velocity.z + 2.5))
		system.yield(1000)
    end
end)

menu.add_player_feature("» Anti Lock-On", "toggle", playerparents["» Vehicle Options"], function(f, pid)
	if f.on then
		utilities.request_control(player.get_player_vehicle(pid))
		while f.on do
			system.yield(100)
			vehicle.set_vehicle_can_be_locked_on(player.get_player_vehicle(pid), false, true)
		end
	end
	if not f.on then
		utilities.request_control(player.get_player_vehicle(pid))
		vehicle.set_vehicle_can_be_locked_on(player.get_player_vehicle(pid), true, true)
	end
end)

menu.add_player_feature("» Reduce Vehicle Grip", "toggle", playerparents["» Vehicle Options"], function(f, pid)
	if f.on then
		utilities.request_control(player.get_player_vehicle(pid))
    	while f.on do
			vehicle.set_vehicle_reduce_grip(player.get_player_vehicle(pid), true)
			system.yield(100)
		end
    end
	if not f.on then
		utilities.request_control(player.get_player_vehicle(pid))
		vehicle.set_vehicle_reduce_grip(player.get_player_vehicle(pid), false)
	end
end)

menu.add_player_feature("» Modify Vehicle Speed", "action", playerparents["» Vehicle Options"], function(f, pid)
    if player.is_player_in_any_vehicle(pid) then
        local input_stat, input_val = input.get("Enter Speed", "", 9, 3)
        if input_stat == 1 then
            return HANDLER_CONTINUE
        end
        if input_stat == 2 then
            return HANDLER_POP
        end
		utilities.request_control(player.get_player_vehicle(pid))
        vehicle.modify_vehicle_top_speed(player.get_player_vehicle(pid), input_val / 3.6)
		entity.set_entity_max_speed(player.get_player_vehicle(pid), input_val / 3.6)
		vehicle.set_vehicle_engine_torque_multiplier_this_frame(player.get_player_vehicle(pid), input_val / 3.6)
    else
        menu.notify("Player is not in a vehicle", Meteor, 3, 211)
    end
end)

playerparents["» Vehicle Upgrades"] = menu.add_player_feature("» Vehicle Upgrades", "parent", playerparents["» Vehicle Options"]).id

menu.add_player_feature("» Max Vehicle", "action", playerparents["» Vehicle Upgrades"], function(f, pid)
	if player.is_player_in_any_vehicle(pid) then
		utilities.request_control(player.get_player_vehicle(pid))
		utilities.max_vehicle(player.get_player_vehicle(pid))
	else
		menu.notify("Player is not in a vehicle", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Repair Vehicle", "action", playerparents["» Vehicle Upgrades"], function(f, pid)
	if player.is_player_in_any_vehicle(pid) then
		utilities.request_control(player.get_player_vehicle(pid))
		vehicle.set_vehicle_undriveable(player.get_player_vehicle(pid), false)
		local entity_velocity = entity.get_entity_velocity(player.get_player_vehicle(pid))
		vehicle.set_vehicle_fixed(player.get_player_vehicle(pid))
		vehicle.set_vehicle_engine_health(player.get_player_vehicle(pid), 1000)
		vehicle.set_vehicle_engine_on(player.get_player_vehicle(pid), true, true, true)
		if entity.is_entity_on_fire(player.get_player_vehicle(pid)) then
			fire.stop_entity_fire(player.get_player_vehicle(pid))
		end
		entity.set_entity_velocity(player.get_player_vehicle(pid), entity_velocity)
	else
		menu.notify("Player is not in a vehicle", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Downgrade Vehicle", "action", playerparents["» Vehicle Upgrades"], function(f, pid)
	if player.is_player_in_any_vehicle(pid) then
		utilities.request_control(player.get_player_vehicle(pid))
		utilities.downgrade_vehicle(player.get_player_vehicle(pid))
	else
		menu.notify("Player is not in a vehicle", Meteor, 3, 211)
	end
end)

feature["» Remove Vehicle Extra"] = menu.add_player_feature("» Remove Vehicle Extra", "action_value_i", playerparents["» Vehicle Upgrades"], function(f, pid)
	if player.is_player_in_any_vehicle(pid) then
		utilities.request_control(player.get_player_vehicle(pid))
		vehicle.set_vehicle_extra(player.get_player_vehicle(pid), f.value, true)
	else
		menu.notify("Player is not in a vehicle", Meteor, 3, 211)
	end
end)
feature["» Remove Vehicle Extra"].min = 0
feature["» Remove Vehicle Extra"].max = 20
feature["» Remove Vehicle Extra"].mod = 1
feature["» Remove Vehicle Extra"].value = 0

menu.add_player_feature("» Remove All Extras", "action", playerparents["» Vehicle Upgrades"], function(f, pid)
	if player.is_player_in_any_vehicle(pid) then
		utilities.request_control(player.get_player_vehicle(pid))
		for i = 0, 20 do
			vehicle.set_vehicle_extra(player.get_player_vehicle(pid), i, true)
		end
	else
		menu.notify("Player is not in a vehicle", Meteor, 3, 211)
	end
end)

playerparents["» Door Control"] = menu.add_player_feature("» Door Control", "parent", playerparents["» Vehicle Options"]).id

menu.add_player_feature("» Destroy All Vehicle Doors", "action", playerparents["» Door Control"], function(f, pid)
	if player.is_player_in_any_vehicle(pid) then
		utilities.request_control(player.get_player_vehicle(pid))
		for i = 0, 8 do
			natives.SET_VEHICLE_DOOR_BROKEN(player.get_player_vehicle(pid), i, false)
		end
	else
		menu.notify("Player is not in a vehicle", Meteor, 3, 211)
	end
end)

feature["» Destroy Player Vehicle Door"] = menu.add_player_feature("» Destroy Vehicle Door", "action_value_i", playerparents["» Door Control"], function(f, pid)
	if player.is_player_in_any_vehicle(pid) then
		utilities.request_control(player.get_player_vehicle(pid))
		natives.SET_VEHICLE_DOOR_BROKEN(player.get_player_vehicle(pid), f.value - 1, false)
	else
		menu.notify("Player is not in a vehicle", Meteor, 3, 211)
	end
end)
feature["» Destroy Player Vehicle Door"].max = 8
feature["» Destroy Player Vehicle Door"].min = 1
feature["» Destroy Player Vehicle Door"].mod = 1
feature["» Destroy Player Vehicle Door"].value = 0

menu.add_player_feature("» Open All Vehicle Doors", "action", playerparents["» Door Control"], function(f, pid)
	if player.is_player_in_any_vehicle(pid) then
		utilities.request_control(player.get_player_vehicle(pid))
		for i = 0, 7 do
			vehicle.set_vehicle_door_open(player.get_player_vehicle(pid), i, false, true)
		end
		system.wait(100)
		for i = 0, 7 do
			vehicle.set_vehicle_door_open(player.get_player_vehicle(pid), i, false, true)
		end
	else
		menu.notify("Player is not in a vehicle", Meteor, 3, 211)
	end
end)

feature["» Open Player Vehicle Door"] = menu.add_player_feature("» Open Vehicle Door", "action_value_i", playerparents["» Door Control"], function(f, pid)
	if player.is_player_in_any_vehicle(pid) then
		utilities.request_control(player.get_player_vehicle(pid))
		vehicle.set_vehicle_door_open(player.get_player_vehicle(pid), f.value - 1, false, true)
	else
		menu.notify("Player is not in a vehicle", Meteor, 3, 211)
	end
end)
feature["» Open Player Vehicle Door"].max = 8
feature["» Open Player Vehicle Door"].min = 1
feature["» Open Player Vehicle Door"].mod = 1
feature["» Open Player Vehicle Door"].value = 0

menu.add_player_feature("» Close All Vehicle Doors", "action", playerparents["» Door Control"], function(f, pid)
	if player.is_player_in_any_vehicle(pid) then
		utilities.request_control(player.get_player_vehicle(pid))
		for i = 0, 7 do
			vehicle.set_vehicle_doors_shut(player.get_player_vehicle(pid), i, false, true)
		end
	else
		menu.notify("Player is not in a vehicle", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Lock All Vehicle Doors", "toggle", playerparents["» Door Control"], function(f, pid)
	if f.on then
		if player.is_player_in_any_vehicle(pid) then
			utilities.request_control(player.get_player_vehicle(pid))
			vehicle.set_vehicle_doors_locked(player.get_player_vehicle(pid), 4)
		else
			menu.notify("Player is not in a vehicle", Meteor, 3, 211)
			f.on = false
		end
	end
	if not f.on then
		vehicle.set_vehicle_doors_locked(player.get_player_vehicle(pid), 0)
	end
end)

playerparents["» Air Vehicles"] = menu.add_player_feature("» Air Vehicles", "parent", playerparents["» Vehicle Options"]).id

menu.add_player_feature("» Cargoplane", "action_value_str", playerparents["» Air Vehicles"], function(f, pid)
	if f.value == 0 then
		local pos = player.get_player_coords(pid)
		pos.z = 1000
    	utilities.request_model(0xE75B4B1C)
    	utilities.request_model(368211810)
    	local vehicle_ = vehicle.create_vehicle(368211810, pos + v3(math.random(-100, 100), math.random(-100, 100), 0), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
    	local ped_ = ped.create_ped(1, 0xE75B4B1C, pos + v3(math.random(-100, 100), math.random(-100, 100), 0), 1.0, true, false)
		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
    	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
    	vehicle.control_landing_gear(vehicle_, 3)
   		vehicle.set_vehicle_forward_speed(vehicle_, 100.0)
	elseif f.value == 1 then
		local pos = player.get_player_coords(pid)
    	utilities.request_model(0xE75B4B1C)
    	utilities.request_model(368211810)
    	local vehicle_ = vehicle.create_vehicle(368211810, pos + v3(0, 0, 5), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
    	local ped_ = ped.create_ped(1, 0xE75B4B1C, pos + v3(0, 0, 20), 1.0, true, false)
		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
    	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
    	vehicle.control_landing_gear(vehicle_, 3)
   		vehicle.set_vehicle_forward_speed(vehicle_, 100.0)
	end
	streaming.set_model_as_no_longer_needed(0xE75B4B1C)
	streaming.set_model_as_no_longer_needed(368211810)
end):set_str_data({
	"Air",
	"Their Pos"
})

menu.add_player_feature("» Cargoplane Opened", "action_value_str", playerparents["» Air Vehicles"], function(f, pid)
	if f.value == 0 then
		local pos = player.get_player_coords(pid)
		pos.z = 1000
    	utilities.request_model(0xE75B4B1C)
    	utilities.request_model(368211810)
    	local vehicle_ = vehicle.create_vehicle(368211810, pos + v3(math.random(-100, 100), math.random(-100, 100), 0), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
    	local ped_ = ped.create_ped(1, 0xE75B4B1C, pos + v3(math.random(-100, 100), math.random(-100, 100), 0), 1.0, true, false)
		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
    	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
    	vehicle.control_landing_gear(vehicle_, 3)
   		vehicle.set_vehicle_forward_speed(vehicle_, 200.0)
		vehicle.set_vehicle_door_open(vehicle_, 2, false, false)
	elseif f.value == 1 then
		local pos = player.get_player_coords(pid)
    	utilities.request_model(0xE75B4B1C)
    	utilities.request_model(368211810)
    	local vehicle_ = vehicle.create_vehicle(368211810, pos + v3(0, 0, 5), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
    	local ped_ = ped.create_ped(1, 0xE75B4B1C, pos + v3(0, 0, 20), 1.0, true, false)
		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
    	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
    	vehicle.control_landing_gear(vehicle_, 3)
   		vehicle.set_vehicle_forward_speed(vehicle_, 200.0)
		vehicle.set_vehicle_door_open(vehicle_, 2, false, false)
	end
	streaming.set_model_as_no_longer_needed(0xE75B4B1C)
	streaming.set_model_as_no_longer_needed(368211810)
end):set_str_data({
	"Air",
	"Their Pos"
})

menu.add_player_feature("» Jet", "action_value_str", playerparents["» Air Vehicles"], function(f, pid)
	if f.value == 0 then
		local pos = player.get_player_coords(pid)
		pos.z = 1000
    	utilities.request_model(0xE75B4B1C)
    	utilities.request_model(1058115860)

    	local vehicle_ = vehicle.create_vehicle(1058115860, pos + v3(math.random(-100, 100), math.random(-100, 100), 0), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
    	local ped_ = ped.create_ped(1, 0xE75B4B1C, pos + v3(math.random(-100, 100), math.random(-100, 100), 0), 1.0, true, false)
		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
    	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
    	vehicle.control_landing_gear(vehicle_, 3)
    	vehicle.set_vehicle_forward_speed(vehicle_, 200.0)
	elseif f.value == 1 then
		local pos = player.get_player_coords(pid)
    	utilities.request_model(0xE75B4B1C)
    	utilities.request_model(1058115860)
    	local vehicle_ = vehicle.create_vehicle(1058115860, pos + v3(0, 0, 5), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
    	local ped_ = ped.create_ped(1, 0xE75B4B1C, pos + v3(0, 0, 10), 1.0, true, false)
		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
    	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
    	vehicle.control_landing_gear(vehicle_, 3)
    	vehicle.set_vehicle_forward_speed(vehicle_, 200.0)
	end
	streaming.set_model_as_no_longer_needed(0xE75B4B1C)
	streaming.set_model_as_no_longer_needed(1058115860)
end):set_str_data({
	"Air",
	"Their Pos"
})

menu.add_player_feature("» Titan", "action_value_str", playerparents["» Air Vehicles"], function(f, pid)
	if f.value == 0 then
		local pos = player.get_player_coords(pid)
		pos.z = 700
    	utilities.request_model(0x616C97B9)
    	utilities.request_model(0x761E2AD3)
    	local vehicle_ = vehicle.create_vehicle(0x761E2AD3, pos + v3(math.random(-100, 100), math.random(-100, 100), 0), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
    	local ped_ = ped.create_ped(1, 0x616C97B9, pos + v3(math.random(-100, 100), math.random(-100, 100), 0), 1.0, true, false)
		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
    	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
    	vehicle.control_landing_gear(vehicle_, 3)
    	vehicle.set_vehicle_forward_speed(vehicle_, 100.0)
	elseif f.value == 1 then
		local pos = player.get_player_coords(pid)
    	utilities.request_model(0x616C97B9)
    	utilities.request_model(0x761E2AD3)    
    	local vehicle_ = vehicle.create_vehicle(0x761E2AD3, pos + v3(0, 0, 5), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
    	local ped_ = ped.create_ped(1, 0x616C97B9, pos + v3(0, 0, 10), 1.0, true, false)
		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
    	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
    	vehicle.control_landing_gear(vehicle_, 3)
    	vehicle.set_vehicle_forward_speed(vehicle_, 200.0)
	end
	streaming.set_model_as_no_longer_needed(0x616C97B9)
	streaming.set_model_as_no_longer_needed(0x761E2AD3)
end):set_str_data({
	"Air",
	"Their Pos"
})

menu.add_player_feature("» Blimp", "action_value_str", playerparents["» Air Vehicles"], function(f, pid)
	if f.value == 0 then
		local pos = player.get_player_coords(pid)
		pos.z = 500
    	utilities.request_model(0xE75B4B1C)
    	utilities.request_model(-150975354)
    	local vehicle_ = vehicle.create_vehicle(-150975354, pos + v3(math.random(-150, 150), math.random(-150, 150), 0), math.random(0, 360), true, false)
		local ped_ = ped.create_ped(1, 0xE75B4B1C, pos + v3(math.random(-150, 150), math.random(-150, 150), 0), 1.0, true, false)
		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
    	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
    	vehicle.control_landing_gear(vehicle_, 3)
    	vehicle.set_vehicle_forward_speed(vehicle_, 20.0)
		local pos = entity.get_entity_coords(ped_)
		gameplay.shoot_single_bullet_between_coords(pos, pos + v3(0, 0, 0.1), 0, gameplay.get_hash_key("weapon_pistol"), player.get_player_ped(pid), false, true, 100)
	elseif f.value == 1 then
		local pos = player.get_player_coords(pid)
    	utilities.request_model(0xE75B4B1C)
    	utilities.request_model(-150975354)
    	local vehicle_ = vehicle.create_vehicle(-150975354, pos + v3(0, 0, 5), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
		local ped_ = ped.create_ped(1, 0xE75B4B1C, pos + v3(0, 0, 10), 1.0, true, false)
		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
    	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
    	vehicle.control_landing_gear(vehicle_, 3)
    	vehicle.set_vehicle_forward_speed(vehicle_, 20.0)
		local pos = entity.get_entity_coords(ped_)
		gameplay.shoot_single_bullet_between_coords(pos, pos + v3(0, 0, 0.1), 0, gameplay.get_hash_key("weapon_pistol"), player.get_player_ped(pid), false, true, 100)
	end
	streaming.set_model_as_no_longer_needed(0xE75B4B1C)
	streaming.set_model_as_no_longer_needed(-150975354)
end):set_str_data({
	"Air",
	"Their Pos"
})

menu.add_player_feature("» Miljet", "action_value_str", playerparents["» Air Vehicles"], function(f, pid)
	if f.value == 0 then
		local pos = player.get_player_coords(pid)
		pos.z = 800
    	utilities.request_model(0xE75B4B1C)
    	utilities.request_model(165154707)
    	local vehicle_ = vehicle.create_vehicle(165154707, pos + v3(math.random(-100, 100), math.random(-100, 100), 0), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
    	local ped_ = ped.create_ped(1, 0xE75B4B1C, pos + v3(math.random(-100, 100), math.random(-100, 100), 0), 1.0, true, false)
		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
		ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
    	vehicle.control_landing_gear(vehicle_, 3)
    	vehicle.set_vehicle_forward_speed(vehicle_, 100.0)
	elseif f.value == 1 then
		local pos = player.get_player_coords(pid)
    	utilities.request_model(0xE75B4B1C)
    	utilities.request_model(165154707)
    	local vehicle_ = vehicle.create_vehicle(165154707, pos + v3(0, 0, 5), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
    	local ped_ = ped.create_ped(1, 0xE75B4B1C, pos + v3(0, 0, 10), 1.0, true, false)
		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
    	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
    	vehicle.control_landing_gear(vehicle_, 3)
    	vehicle.set_vehicle_forward_speed(vehicle_, 100.0)
	end
	streaming.set_model_as_no_longer_needed(0xE75B4B1C)
	streaming.set_model_as_no_longer_needed(165154707)
	streaming.set_model_as_no_longer_needed(2563194959)
	streaming.set_model_as_no_longer_needed(919005580)
	streaming.set_model_as_no_longer_needed(1446741360)
end):set_str_data({
	"Air",
	"Their Pos"
})

menu.add_player_feature("» Miljet Landing", "action_value_str", playerparents["» Air Vehicles"], function(f, pid)
	if f.value == 0 then
		local pos = player.get_player_coords(pid)
		pos.z = 800
    	utilities.request_model(0xE75B4B1C)
    	utilities.request_model(165154707)
    	local vehicle_ = vehicle.create_vehicle(165154707, pos + v3(math.random(-100, 100), math.random(-100, 100), 0), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
    	local ped_ = ped.create_ped(1, 0xE75B4B1C, pos + v3(math.random(-100, 100), math.random(-100, 100), 0), 1.0, true, false)

		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
    	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_forward_speed(vehicle_, 60.0)
	elseif f.value == 1 then
		local pos = player.get_player_coords(pid)
    	utilities.request_model(0xE75B4B1C)
    	utilities.request_model(165154707)
    	local vehicle_ = vehicle.create_vehicle(165154707, pos + v3(0, 0, 5), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
    	local ped_ = ped.create_ped(1, 0xE75B4B1C, pos + v3(0, 0, 10), 1.0, true, false)

		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
    	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_forward_speed(vehicle_, 60.0)
	end
	streaming.set_model_as_no_longer_needed(0xE75B4B1C)
	streaming.set_model_as_no_longer_needed(165154707)
end):set_str_data({
	"Air",
	"Their Pos"
})

menu.add_player_feature("» Luxor", "action_value_str", playerparents["» Air Vehicles"], function(f, pid)
	if f.value == 0 then
		local pos = player.get_player_coords(pid)
		pos.z = 800
    	utilities.request_model(0xE75B4B1C)
    	utilities.request_model(621481054)
		local vehicle_ = vehicle.create_vehicle(621481054, pos + v3(math.random(-100, 100), math.random(-100, 100), 0), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
    	local ped_ = ped.create_ped(1, 0xE75B4B1C, pos + v3(math.random(-100, 100), math.random(-100, 100), 0), 1.0, true, false)
		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
    	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
    	vehicle.control_landing_gear(vehicle_, 3)
    	vehicle.set_vehicle_forward_speed(vehicle_, 100.0)
	elseif f.value == 1 then
		local pos = player.get_player_coords(pid)
    	utilities.request_model(0xE75B4B1C)
    	utilities.request_model(621481054)
		local vehicle_ = vehicle.create_vehicle(621481054, pos + v3(0, 0, 10), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
    	local ped_ = ped.create_ped(1, 0xE75B4B1C, pos + v3(0, 0, 10), 1.0, true, false)
		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
    	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
    	vehicle.control_landing_gear(vehicle_, 3)
    	vehicle.set_vehicle_forward_speed(vehicle_, 100.0)
	end
	streaming.set_model_as_no_longer_needed(0xE75B4B1C)
	streaming.set_model_as_no_longer_needed(621481054)
end):set_str_data({
	"Air",
	"Their Pos"
})


local rootPath = utils.get_appdata_path("PopstarDevs", "2Take1Menu")
keypath = rootPath.."\\scripts\\data.txt"
local function writename(name,txt)
local namefile = io.open(txt, "w")
		io.output(namefile)
		io.write(name..'\n')
		io.close()
end


local function request_model(h, t)
			if not h then 
				return 
			end
			if not streaming.has_model_loaded(h) then
   				streaming.request_model(h)
    			local time = utils.time_ms() + t
    			while not streaming.has_model_loaded(h) and time > utils.time_ms() do
       				system.wait(5)
   				end
			end
			return streaming.has_model_loaded(h)
		end


local function Cped(type, hash, coords, dir)
			request_model(hash, 300)
			local ped = ped.create_ped(type, hash, coords, dir, true, false)
			streaming.set_model_as_no_longer_needed(hash)
			return ped
		end

local function spawn_vehicle(hash, coords, dir)
	request_model(hash, 1000)
    local car = vehicle.create_vehicle(hash, coords, dir, true, false)
	streaming.set_model_as_no_longer_needed(hash)
	return car
end

local function spawn_obj(hash, coords)
	request_model(hash, 1000)
    local object = object.create_object(hash, pos, true, false)
	streaming.set_model_as_no_longer_needed(hash)
	return object
end
local function bianshen (J)
local hash
hash = J
streaming.request_model(hash)
while(not streaming.has_model_loaded(hash))
do
system.wait(0)
end
player.set_player_model(hash)
streaming.set_model_as_no_longer_needed(hash)
return HANDLER_POP
end

local function get_control_of_entity(h, t)
if not h then 
return
end
if not network.has_control_of_entity(h) then
network.request_control_of_entity(h)
local time = utils.time_ms() + t
while entity.is_an_entity(h) and not network.has_control_of_entity(h) and time > utils.time_ms() do
system.wait(5)
end
end
return network.has_control_of_entity(h)
end



local invalidobjecthash = {
849958566,
-568220328,
2155335200,
1272323782,
1296557055,
29828513,	
2250084685,	
2349112599,
1599985244,	
3523942264,	
3457195100,	
3762929870,	
1016189997,
861098586,	
3245733464,
2494305715,	
671173206,	
3769155529,	
978689073,
100436592,	
3107991431,	
1327834842,
1327834842,
1239708330,
}

function invalidmodelcrashplayer(pid)
local invalidobj = {}
crashplayerpos = player.get_player_coords(pid)
for i , k in pairs(invalidobjecthash) do
invalidobj[i] = object.create_world_object(k,crashplayerpos, true, false)
system.wait(0)
end
system.wait(100)
for i , k in pairs(invalidobjecthash) do
entity.delete_entity(invalidobj[i])
system.wait(0)
end
end

local attachcarhash = {
887537515,
-845979911,
-1700801569,
223258115,
630371791,
-823509173,
1074326203,
444171386,
}

function attachcrashplayer(data)
local attachcar = {}
crashplayerpos = player.get_player_coords(data)
towtruck = spawn_vehicle(0xe5a2d6c6,crashplayerpos,0)
entity.set_entity_god_mode(towtruck,true)
for i , k in pairs(attachcarhash) do
attachcar[i] = spawn_vehicle(k,crashplayerpos,0)
entity.set_entity_god_mode(attachcar[i],true)
entity.attach_entity_to_entity(attachcar[i],towtruck,0, v3(0,0,0),v3(0,0,0), true, true, false, 0, true)
system.wait(0)
end
system.wait(500)
for i , k in pairs(attachcarhash) do
entity.delete_entity(attachcar[i])
system.wait(0)
end
entity.delete_entity(towtruck)
end

function attachcrashplayerbad(data)
badattachpos = v3(0,0,0)
trailer = spawn_vehicle(-1881846085,badattachpos,0)
pedp = player.get_player_ped(data)
cloneped = ped.clone_ped(pedp)
entity.freeze_entity(trailer, true)
entity.freeze_entity(cloneped, true)
entity.set_entity_god_mode(trailer,true)
entity.set_entity_god_mode(cloneped,true)
entity.attach_entity_to_entity(cloneped,trailer,0, v3(0,0,0),v3(0,0,0), true, true, false, 0, true)
crashplayerpos = player.get_player_coords(data)
entity.set_entity_coords_no_offset(trailer,crashplayerpos)
system.wait(100)
entity.set_entity_coords_no_offset(trailer,badattachpos)
end



function poolcrashplayer(pid)
local Michael = {}
local chernobog = {}
local hunter = {}
local wade = {}
local tracy = {}


chernobogposz = player.get_player_coords(pid)
chernobogposz.z = chernobogposz.z + 1010
for i = 0, 90 do
chernobog[i] = spawn_vehicle(-1006919392,chernobogposz,0)
entity.freeze_entity(chernobog[i], true)
system.wait(0)
end

wadepos = player.get_player_coords(pid)
for i = 0, 85 do
wade[i] = Cped(2,0x0D7114C9,wadepos ,0)
entity.set_entity_god_mode(wade[i],true)
entity.freeze_entity(wade[i], true)
system.wait(0)
end
system.wait(2000)
for i = 0, 90 do
entity.delete_entity(wade[i])
system.wait(0)
end
tracypos = player.get_player_coords(pid)
for i = 0, 85 do
tracy[i] = Cped(2,0x0D7114C9,tracypos ,0)
entity.set_entity_god_mode(tracy[i],true)
entity.freeze_entity(tracy[i], true)
system.wait(0)
end
system.wait(2000)
for i = 0, 90 do
entity.delete_entity(tracy[i])
system.wait(0)
end
for i = 0, 90 do
entity.delete_entity(chernobog[i])
system.wait(0)
end

chernobogpos = player.get_player_coords(pid)
for i = 0, 90 do
chernobog[i] = spawn_vehicle(-1006919392,chernobogpos,0)
entity.freeze_entity(chernobog[i], true)
system.wait(0)
end
system.wait(2000)
for i = 0, 90 do
entity.delete_entity(chernobog[i])
system.wait(0)
end


mikepos = player.get_player_coords(pid)
for i = 0, 85 do
Michael[i] = Cped(2,0x0D7114C9,mikepos ,0)
entity.set_entity_god_mode(Michael[i],true)
ped.set_ped_component_variation(Michael[i], 0, 0,9,0 )
entity.freeze_entity(Michael[i], true)
system.wait(0)
end
system.wait(2000)


for i = 0, 85 do
entity.delete_entity(Michael[i])
system.wait(0)
end

end

objecthash = {
314436594, 
352817817,
466911544,
511018606,
519594446,
772023703,
1022953480,
1067874014,
1082797888,
2041665236,
}


function handlercrashplayer(pid)
local spawnobj = {}
local attachcar = {}
pos = player.get_player_coords(pid)
handler = spawn_vehicle(444583674,pos,0)
boneveh = entity.get_entity_bone_index_by_name(handler,"frame_1")
for i , k in pairs(attachcarhash) do
attachcar[i] = spawn_vehicle(k,pos,0)
entity.attach_entity_to_entity(attachcar[i],handler,boneveh, v3(0,0,0),v3(0,0,0), true, true, false, 0, true)
system.wait(0)
end

end


function chernobogcrashplayer(pid)
local chernobog = {}
pos = player.get_player_coords(pid)
chernobogmain = spawn_vehicle(-692292317,pos,0)
for i =0, 90  do
chernobog[i] = spawn_vehicle(-692292317,pos,0)
entity.attach_entity_to_entity(chernobog[i],chernobogmain,0, v3(0,0,0),v3(0,0,0), true, true, false, 0, true)
system.wait(0)
end
system.wait(4000)
for i = 0, 90 do
entity.delete_entity(chernobog[i])
system.wait(0)
end
entity.delete_entity(chernobogmain)
end

function mc()
bianshen(0x705E61F2)
system.wait(100)
ped.set_ped_health(player.get_player_ped(player.player_id()), 0)
system.wait(100)
bianshen(0x9C9EFFD8)
system.wait(100)
ped.set_ped_health(player.get_player_ped(player.player_id()), 0)
system.wait(100)
end

function soundcrashplayer(pid)
 local time = utils.time_ms() + 2000
        while time > utils.time_ms() do
            local netsoundpos = player.get_player_coords(pid)
            for i = 1, 10 do
                audio.play_sound_from_coord(-1, '5s', netsoundpos, 'MP_MISSION_COUNTDOWN_SOUNDSET', true, 10000, false)
            end
            system.wait(0)
        end	
end

function secrashplayer(pid)
script.trigger_script_event(-2113023004, pid, {-1, -1,0,0,-20,1000})
script.trigger_script_event(-1056683619, pid, {-1, -1})
script.trigger_script_event(1757755807, pid, {-1, -1})
script.trigger_script_event(1258808115, pid, {-1, -1})
script.trigger_script_event(-786546101, pid, {-1, -1})	
end

function fakecrash(pid)
pedp = player.get_player_ped(pid)
cloneped = ped.clone_ped(pedp)
ped.clear_ped_tasks_immediately(pedp)
local titlle = "scr_martin1"
local hashid = "scr_sol1_fire_trail"
graphics.set_next_ptfx_asset(titlle)
                while not graphics.has_named_ptfx_asset_loaded(titlle) do
                    graphics.request_named_ptfx_asset(titlle)
                    system.wait(0)
                end
graphics.start_networked_ptfx_looped_on_entity(hashid,pedp, v3(0,0,0.0), v3(0, 0, 0),5)	
end

feature["» Static Horn Boost"] = menu.add_feature("» Static Horn Boost", "slider", localparents["» Vehicle Options"].id, function(f)
	settings["» Static Horn Boost"].Enabled = f.on
	settings["» Static Horn Boost"].Value = f.value
	if f.on then
		while f.on do
			system.yield(0)
			if player.is_player_in_any_vehicle(player.player_id()) and player.is_player_pressing_horn(player.player_id()) then
				vehicle.set_vehicle_forward_speed(player.get_player_vehicle(player.player_id()), f.value)
			end
		end
	end
	settings["» Static Horn Boost"].Enabled = f.on
	settings["» Static Horn Boost"].Value = f.value
end)
feature["» Static Horn Boost"].max = 200
feature["» Static Horn Boost"].min = 10
feature["» Static Horn Boost"].mod = 10
feature["» Static Horn Boost"].value = 10


feature["» Bouncy Vehicles"] = menu.add_feature("» Bouncy Vehicles", "toggle", localparents["» Vehicle Options"].id, function(f)
	settings["» Bouncy Vehicles"].Enabled = f.on
	if f.on then
  		while f.on do
    	    local vehicles = vehicle.get_all_vehicles()
    	    for i = 1, #vehicles do
   	         	network.request_control_of_entity(vehicles[i])
   	         	local vehicle_velocity = entity.get_entity_velocity(vehicles[i])
   	        	entity.set_entity_velocity(vehicles[i], v3(vehicle_velocity.x, vehicle_velocity.y, vehicle_velocity.z + 2.5))
   		    end
			system.wait(500)
   		end
	end
	settings["» Bouncy Vehicles"].Enabled = f.on
end)


feature["» Zero Gravity Vehicles"] = menu.add_feature("» Zero Gravity Vehicles", "toggle", localparents["» Vehicle Options"].id, function(f)
	settings["» Zero Gravity Vehicles"].Enabled = f.on
    if f.on then
		while f.on do
        	local vehicles = vehicle.get_all_vehicles()
       		for i = 1, #vehicles do
        	    network.request_control_of_entity(vehicles[i])
				local vehicle_velocity = entity.get_entity_velocity(vehicles[i])
				entity.set_entity_velocity(vehicles[i], v3(vehicle_velocity.x, vehicle_velocity.y, vehicle_velocity.z + 0.1))
				entity.set_entity_gravity(vehicles[i], false)
       		end
			system.wait(1000)
		end
    end
	if not f.on then
		local vehicles = vehicle.get_all_vehicles()
		for i = 1, #vehicles do
			network.request_control_of_entity(vehicles[i])
			entity.set_entity_gravity(vehicles[i], true)
		end
	end
	settings["» Zero Gravity Vehicles"].Enabled = f.on
end)

feature["» Reduce Vehicle Grip"] = menu.add_feature("» Reduce Vehicle Grip", "toggle", localparents["» Vehicle Options"].id, function(f)
	settings["» Reduce Vehicle Grip"].Enabled = f.on
	if f.on then
    	while f.on do
    	    local vehicles = vehicle.get_all_vehicles()
    	    for i = 1, #vehicles do
    	        network.request_control_of_entity(vehicles[i])
				vehicle.set_vehicle_reduce_grip(vehicles[i], true)
    	    end
			system.wait(1000)
		end
    end
	if not f.on then
		local vehicles = vehicle.get_all_vehicles()
		for i = 1, #vehicles do
			network.request_control_of_entity(vehicles[i])
			vehicle.set_vehicle_reduce_grip(vehicles[i], false)
		end
	end
	settings["» Reduce Vehicle Grip"].Enabled = f.on
end)


feature["» Vehicle Fly"] = menu.add_feature("» Vehicle Fly", "slider", localparents["» Vehicle Options"].id, function(f)
	settings["» Vehicle Fly"].Enabled = f.on
	settings["» Vehicle Fly"].Value = f.value
	if f.on then
		while f.on do
			system.yield(0)
			if player.is_player_in_any_vehicle(player.player_id()) then
				utilities.request_control_silent(player.get_player_vehicle(player.player_id()))
				entity.set_entity_velocity(player.get_player_vehicle(player.player_id()), v3(0, 0, 0))
				entity.set_entity_rotation(player.get_player_vehicle(player.player_id()), v3(cam.get_gameplay_cam_rot().x, 0, cam.get_gameplay_cam_rot().z))
				if not controls.is_disabled_control_pressed(2, 77) and not controls.is_disabled_control_pressed(2, 133) and not controls.is_disabled_control_pressed(2, 134) and not controls.is_disabled_control_pressed(2, 139) and not controls.is_disabled_control_pressed(2, 254) and not controls.is_disabled_control_pressed(2, 326) then
					entity.freeze_entity(player.get_player_vehicle(player.player_id()), true)
				end
				if player.is_player_in_any_vehicle(player.player_id()) and controls.is_disabled_control_pressed(2, 77) then
					network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
					local pos = player.get_player_coords(player.player_id())
					local dir = entity.get_entity_rotation(player.get_player_vehicle(player.player_id()))
					dir:transformRotToDir()
					dir = dir * 8
					pos = pos + dir
					dir = nil
					local pos_target = player.get_player_coords(player.player_id())
					dir = entity.get_entity_rotation(player.get_player_vehicle(player.player_id()))
					dir:transformRotToDir()
					dir = dir * 100
					pos_target = pos_target + dir
					local vectorV3 = pos_target - pos
					entity.freeze_entity(player.get_player_vehicle(player.player_id()), false)
					entity.apply_force_to_entity(player.get_player_vehicle(player.player_id()), 3, vectorV3.x * f.value, vectorV3.y * f.value, vectorV3.z * f.value, 0.0, 0.0, 0.0, false, true)
				end
				if player.is_player_in_any_vehicle(player.player_id()) and controls.is_disabled_control_pressed(2, 133) then
					network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
					local pos = player.get_player_coords(player.player_id())
					local dir = entity.get_entity_rotation(player.get_player_vehicle(player.player_id())) + v3(0, 0, 90)
					dir:transformRotToDir()
					dir = dir * 8
					pos = pos + dir
					dir = nil
					local pos_target = player.get_player_coords(player.player_id())
					dir = entity.get_entity_rotation(player.get_player_vehicle(player.player_id())) + v3(0, 0, 90)
					dir:transformRotToDir()
					dir = dir * 100
					pos_target = pos_target + dir
					local vectorV3 = pos_target - pos
					entity.freeze_entity(player.get_player_vehicle(player.player_id()), false)
					entity.apply_force_to_entity(player.get_player_vehicle(player.player_id()), 3, vectorV3.x * f.value, vectorV3.y * f.value, vectorV3.z * f.value, 0.0, 0.0, 0.0, false, true)
				end
				if player.is_player_in_any_vehicle(player.player_id()) and controls.is_disabled_control_pressed(2, 134) then
					network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
					local pos = player.get_player_coords(player.player_id())
					local dir = entity.get_entity_rotation(player.get_player_vehicle(player.player_id())) - v3(0, 0, 90)
					dir:transformRotToDir()
					dir = dir * 8
					pos = pos + dir
					dir = nil
					local pos_target = player.get_player_coords(player.player_id())
					dir = entity.get_entity_rotation(player.get_player_vehicle(player.player_id())) - v3(0, 0, 90)
					dir:transformRotToDir()
					dir = dir * 100
					pos_target = pos_target + dir
					local vectorV3 = pos_target - pos
					entity.freeze_entity(player.get_player_vehicle(player.player_id()), false)
					entity.apply_force_to_entity(player.get_player_vehicle(player.player_id()), 3, vectorV3.x * f.value, vectorV3.y * f.value, vectorV3.z * f.value, 0.0, 0.0, 0.0, false, true)
				end
				if player.is_player_in_any_vehicle(player.player_id()) and controls.is_disabled_control_pressed(2, 139) then
					network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
					local pos = player.get_player_coords(player.player_id())
					local dir = entity.get_entity_rotation(player.get_player_vehicle(player.player_id())) + v3(0, 0, 180)
					dir:transformRotToDir()
					dir = dir * 8
					pos = pos + dir
					dir = nil
					local pos_target = player.get_player_coords(player.player_id())
					dir = entity.get_entity_rotation(player.get_player_vehicle(player.player_id())) + v3(0, 0, 180)
					dir:transformRotToDir()
					dir = dir * 100
					pos_target = pos_target + dir
					local vectorV3 = pos_target - pos
					entity.freeze_entity(player.get_player_vehicle(player.player_id()), false)
					entity.apply_force_to_entity(player.get_player_vehicle(player.player_id()), 3, vectorV3.x * f.value, vectorV3.y * f.value, vectorV3.z * f.value, 0.0, 0.0, 0.0, false, true)
				end
				if player.is_player_in_any_vehicle(player.player_id()) and controls.is_disabled_control_pressed(2, 254) then
					network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
					entity.freeze_entity(player.get_player_vehicle(player.player_id()), false)
					entity.apply_force_to_entity(player.get_player_vehicle(player.player_id()), 3, 0, 0, 180, 0.0, 0.0, 0.0, false, true)
				end
				if player.is_player_in_any_vehicle(player.player_id()) and controls.is_disabled_control_pressed(2, 326) then
					network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
					entity.freeze_entity(player.get_player_vehicle(player.player_id()), false)
					entity.apply_force_to_entity(player.get_player_vehicle(player.player_id()), 3, 0, 0, -180, 0.0, 0.0, 0.0, false, true)
				end
			end
		end
	end
	if not f.on then
		entity.freeze_entity(player.get_player_vehicle(player.player_id()), false)
		system.yield(20)
		local velocity = entity.get_entity_velocity(player.get_player_vehicle(player.player_id()))
		system.yield(20)
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), entity.get_entity_coords(player.get_player_vehicle(player.player_id())))
		entity.set_entity_velocity(player.get_player_vehicle(player.player_id()), velocity)
	end
	settings["» Vehicle Fly"].Enabled = f.on
	settings["» Vehicle Fly"].Value = f.value
end)
feature["» Vehicle Fly"].max = 5
feature["» Vehicle Fly"].min = 0.2
feature["» Vehicle Fly"].mod = 0.2
feature["» Vehicle Fly"].value = 2


feature["» Demolition Boost"] = menu.add_feature("» Demolition Boost", "toggle", localparents["» Vehicle Options"].id, function(f)
	settings["» Demolition Boost"].Enabled = f.on
	if f.on then
		if not utils.file_exists(utils.get_appdata_path("PopstarDevs", "2Take1Menu") .. "\\scripts\\Meteor\\Data\\DemolitionBoost.ini") then
			menu.notify("Hold X to boost", Meteor, 12, 0x64FA7800)
			text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\Data", "") .. "\\DemolitionBoost.ini", "w"), "")
		end
		while f.on do
			system.yield(0)
			if controls.is_disabled_control_pressed(2, 323) then
				previous_position_of_vehicle = entity.get_entity_coords(player.get_player_vehicle(player.player_id()))
				previous_rotation_of_vehicle = entity.get_entity_rotation(player.get_player_vehicle(player.player_id()))
				while controls.is_disabled_control_pressed(2, 323) do
					system.yield(0)
					if player.is_player_in_any_vehicle(player.player_id()) then
						network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
						if streaming.is_model_a_plane(entity.get_entity_model_hash(player.get_player_vehicle(player.player_id()))) then
							vehicle.set_vehicle_forward_speed(player.get_player_vehicle(player.player_id()), 576 / 3.6)
						else
							vehicle.set_vehicle_forward_speed(player.get_player_vehicle(player.player_id()), 540 / 3.6)
						end
					end
				end
			else
				if previous_position_of_vehicle then
					network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
					entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), previous_position_of_vehicle)
					previous_position_of_vehicle = nil
				end
				if previous_rotation_of_vehicle then
					network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
					entity.set_entity_rotation(player.get_player_vehicle(player.player_id()), previous_rotation_of_vehicle)
					previous_rotation_of_vehicle = nil
				end
			end
		end
	end
	if not f.on then
		if previous_position_of_vehicle then
			network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
			entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), previous_position_of_vehicle)
			previous_position_of_vehicle = nil
		end
	end
	settings["» Demolition Boost"].Enabled = f.on
end)

feature["» Flight Mode"] = menu.add_feature("» Flight Mode", "toggle", localparents["» Vehicle Options"].id, function(f)
	if f.on then
		while f.on do
			system.yield(0)
			if flight_mode_vehicle == nil then
				utilities.request_model(621481054)
				flight_mode_vehicle = vehicle.create_vehicle(621481054, player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), true, false)
				network.request_control_of_entity(flight_mode_vehicle)
			end
			entity.set_entity_visible(player.get_player_ped(player.player_id()), false)
			entity.set_entity_god_mode(flight_mode_vehicle, true)
			entity.set_entity_collision(flight_mode_vehicle, false, false, false)
			entity.set_entity_coords_no_offset(flight_mode_vehicle, player.get_player_coords(player.player_id()))
			entity.set_entity_rotation(flight_mode_vehicle, entity.get_entity_rotation(player.get_player_ped(player.player_id())))
		end
	end
	if not f.on then
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
		if flight_mode_vehicle then
			network.request_control_of_entity(flight_mode_vehicle)
			utilities.hard_remove_entity(flight_mode_vehicle)
			flight_mode_vehicle = nil
		end
	end
end)


menu.add_player_feature("» Instant Desktop (Use crash cam don't spectate)", "action", playerparents["» Crashes And Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		utilities.request_model(0x303638A7)
		local table_of_all_peds = {}
		local table_of_all_vehicles = {}
        local hashes = {956849991, 1133471123, 2803699023, 386089410, 1549009676}
		local yo_momma = ped.create_ped(0, 0x303638A7, player.get_player_coords(pid) + v3(300, 300, 300), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
		network.request_control_of_entity(yo_momma)
		for i = 1, 5 do
			table_of_all_peds[i] = ped.create_ped(0, 0x3F039CBA, player.get_player_coords(pid) + v3(300, 300, 300), 0, true, false)
			network.request_control_of_entity(table_of_all_peds[i])
			entity.attach_entity_to_entity(table_of_all_peds[i], yo_momma, 0, v3(0, 0, 0), v3(0, 0, 0), true, false, true, 0, true)
			table_of_all_peds[i + 5] = ped.create_ped(0, 0x856CFB02, player.get_player_coords(pid) + v3(300, 300, 300), 0, true, false)
			network.request_control_of_entity(table_of_all_peds[i + 5])
			entity.attach_entity_to_entity(table_of_all_peds[i + 5], yo_momma, 0, v3(0, 0, 0), v3(0, 0, 0), true, false, true, 0, true)
			table_of_all_peds[i + 10] = ped.create_ped(0, 0x2D7030F3, player.get_player_coords(pid) + v3(300, 300, 300), 0, true, false)
			network.request_control_of_entity(table_of_all_peds[i + 10])
			entity.attach_entity_to_entity(table_of_all_peds[i + 10], yo_momma, 0, v3(0, 0, 0), v3(0, 0, 0), true, false, true, 0, true)
		end
        for i = 1, #hashes do
            utilities.request_model(hashes[i])
            table_of_all_vehicles[i] = vehicle.create_vehicle(hashes[i], player.get_player_coords(pid) + v3(300, 300, 300), 0, true, false)
            network.request_control_of_entity(table_of_all_vehicles[i])
			entity.attach_entity_to_entity(table_of_all_vehicles[i], yo_momma, 0, v3(0, 0, 0), v3(0, 0, 0), true, false, false, 0, true)
        end
		system.wait(0)
		network.request_control_of_entity(yo_momma)
		entity.set_entity_coords_no_offset(yo_momma, player.get_player_coords(pid))
		system.wait(0)
		for i = 1, 15 do
			if entity.is_an_entity(table_of_all_peds[i]) then
				network.request_control_of_entity(table_of_all_peds[i])
				entity.delete_entity(table_of_all_peds[i])
			end
		end
		for i = 1, 5 do
			if entity.is_an_entity(table_of_all_vehicles[i]) then
				network.request_control_of_entity(table_of_all_vehicles[i])
				entity.delete_entity(table_of_all_vehicles[i])
			end
		end
		if yo_momma then
			network.request_control_of_entity(yo_momma)
			utilities.hard_remove_entity(yo_momma)
		end
		system.wait(0)
		script.trigger_script_event(-371781708, pid, {player.player_id(), pid, pid, 1403904671})
		system.wait(0)
		script.trigger_script_event(-317318371, pid, {player.player_id(), pid, pid, 1993236673})
		system.wait(0)
		script.trigger_script_event(911179316, pid, {player.player_id(), pid, pid, pid, 1234567990, pid, pid})
		system.wait(0)
		script.trigger_script_event(846342319, pid, {player.player_id(), 578162304, 1})
		system.wait(0)
		script.trigger_script_event(-2085853000, pid, {player.player_id(), pid, 1610781286, pid, pid})
		system.wait(0)
		script.trigger_script_event(-1991317864, pid, {player.player_id(), 3, 935764694, pid, pid})
		system.wait(0)
		script.trigger_script_event(-1970125962, pid, {player.player_id(), pid, 1171952288})
		system.wait(0)
		script.trigger_script_event(-1013679841, pid, {player.player_id(), pid, 2135167326, pid})
		system.wait(0)
		script.trigger_script_event(-1767058336, pid, {player.player_id(), 1459620687})
		system.wait(0)
		script.trigger_script_event(-1892343528, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647)})
		system.wait(0)
		script.trigger_script_event(1494472464, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647)})
		system.wait(0)
		script.trigger_script_event(69874647, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647)})
		system.wait(0)
		script.trigger_script_event(998716537, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647)})
		system.wait(0)
		script.trigger_script_event(522189882, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647)})
		system.wait(0)
		script.trigger_script_event(1514515570, pid, {player.player_id(), pid, 2147483647})
		system.wait(0)
		script.trigger_script_event(-393294520, pid, {pid, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		system.wait(1)
		script.trigger_script_event(-1386010354, pid, {pid, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		system.wait(0)
		script.trigger_script_event(962740265, pid, {pid, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		system.wait(0)
		script.trigger_script_event(296518236, pid, {player.player_id(), pid, pid, pid, 1})
		system.wait(0)
		script.trigger_script_event(-1782442696, pid, {player.player_id(), 420, 69})
		system.wait(0)
		for i = 1, 5 do
			script.trigger_script_event(-1782442696, pid, {player.player_id(), math.random(-2147483647, 2147483647), 0})
			system.wait(0)
		end
		script.trigger_script_event(924535804, pid, {pid, math.random(-2147483647, 2147483647), 0})
		system.wait(0)
		script.trigger_script_event(436475575, pid, {pid, math.random(-2147483647, 2147483647), 0})
		system.wait(0)
		script.trigger_script_event(-1386010354, pid, {player.player_id(), 2147483647, 2147483647, -788905164})
		script.trigger_script_event(962740265, pid, {player.player_id(), 4294894682, -4294904289, -788905164})
		script.trigger_script_event(962740265, pid, {-72614, 63007, 59027, -12012, -26996, 33398, pid})
		script.trigger_script_event(-1386010354, pid, {player.player_id(), 2147483647, 2147483647, -72614, 63007, 59027, -12012, -26996, 33398, pid})
			utilities.request_model(1349725314)
			local vehicle_ = vehicle.create_vehicle(1349725314, utilities.offset_coords_forward(player.get_player_coords(pid), player.get_player_heading(pid), 5), player.get_player_coords(pid).z, true, false)
			network.request_control_of_entity(vehicle_)
			vehicle.set_vehicle_mod_kit_type(vehicle_, 0)
			vehicle.set_vehicle_mod(vehicle_, 48, 0, false)
			system.wait(0)
			utilities.request_control_silent(vehicle_)
			utilities.hard_remove_entity(vehicle_)
		script.trigger_script_event(-1386010354, pid, {player.player_id(), 2147483647, 2147483647, 23243, 5332, 3324, pid})
		script.trigger_script_event(962740265, pid, {player.player_id(), 23243, 5332, 3324, pid})
		script.trigger_script_event(962740265, pid, {player.player_id(), pid, 30583, pid, pid, pid, pid, -328966, 10128444})
		script.trigger_script_event(-1386010354, pid, {player.player_id(), 2147483647, 2147483647, pid, 30583, pid, pid, pid, pid, -328966, 10128444})
		script.trigger_script_event(962740265, pid, {player.player_id(), 95398, 98426, -24591, 47901, -64814})
		script.trigger_script_event(962740265, pid, {player.player_id(), 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647})
		script.trigger_script_event(-1386010354, pid, {player.player_id(), 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647})
		script.trigger_script_event(677240627, pid, {player.player_id(), -1774405356})
  script.trigger_script_event(-2043109205, pid, {0, 0, 17302, 9822, 1999, 6777888, 111222})
  script.trigger_script_event(-2043109205, pid, {0, 0, 2327, 0, 0, 0, -307, 27777})
  script.trigger_script_event(-988842806, pid, {0, 0, 2327, 0, 0, 0, -307, 27777})
  script.trigger_script_event(-2043109205, pid, {0, 0, 27983, 7601, 1020, 3209051, 111222})
  script.trigger_script_event(-2043109205, pid, {0, 0, 1010, 0, 0, 0, -2653, 50555})
  script.trigger_script_event(-988842806, pid, {0, 0, 1111, 0, 0, 0, -5621, 57766})
  script.trigger_script_event(-988842806, pid, {0, 0, -3, -90, -123, -9856, -97652})
  script.trigger_script_event(-2043109205, pid, {0, 0, -3, -90, -123, -9856, -97652})
  script.trigger_script_event(-1881357102, pid, {0, 0, -3, -90, -123, -9856, -97652})
  script.trigger_script_event(-988842806, pid, {0, 0, 20547, 1058, 1245, 2721936, 666333})
  system.wait(0)
  script.trigger_script_event(-2043109205, pid, {0, 0, 20547, 1058, 1245, 2721936, 666333})
  script.trigger_script_event(-1881357102, pid, {0, 0, 20547, 1058, 1245, 2721936, 666333})
  script.trigger_script_event(153488394, pid, {0, 868904806, 0, 0, -152, -123, -978, 0, 0, 1, 0, -167, -144})
  script.trigger_script_event(153488394, pid, {0, 868904806, 0, 0, 152, 123, 978, 0, 0, 1, 0, 167, 144})
  script.trigger_script_event(1249026189, pid, {0, 0, 97587, 5697, 3211, 8237539, 967853})
  script.trigger_script_event(1033875141, pid, {0, 0, 0, 1967})
  script.trigger_script_event(1033875141, pid, {0, 0, -123, -957, -14, -1908, -123})
  script.trigger_script_event(1033875141, pid, {0, 0, 12121, 9756, 7609, 1111111, 789666})
  script.trigger_script_event(315658550, pid, {0, 0, 87111, 5782, 9999, 3333333, 888888})
  script.trigger_script_event(-877212109, pid, {0, 0, 87111, 5782, 9999, 3333333, 888888})
  script.trigger_script_event(1926582096, pid, {0, -1, -1, -1, 18899, 1011, 3070})
  script.trigger_script_event(1926582096, pid, {0, -4640169, 0, 0, 0, -36565476, -53105203})
  script.trigger_script_event(1033875141, pid, {-17645264, -26800537, -66094971, -45281983, -24450684, -13000488,
                                                59643555, 34295654, 91870118, -3283691})
  script.trigger_script_event(-988842806, pid, {0, 0, 93})
  system.wait(0)
  script.trigger_script_event(-2043109205, pid, {0, 0, 37, 0, -7})
  script.trigger_script_event(-1881357102, pid, {0, 0, -13, 0, 0, 0, 23})
  script.trigger_script_event(153488394, pid, {0, 868904806, 0, 0, 7, 7, 19, 0, 0, 1, 0, -23, -27})
  script.trigger_script_event(1249026189, pid, {})
  script.trigger_script_event(315658550, pid, {})
  script.trigger_script_event(-877212109, pid, {})
  script.trigger_script_event(1033875141, pid, {0, 0, 0, 82})
  script.trigger_script_event(1926582096, pid, {})
  script.trigger_script_event(-977515445, pid, {26770, 95398, 98426, -24591, 47901, -64814})
  script.trigger_script_event(-1949011582, pid, {pid, -1139568479, math.random(0, 4), math.random(0, 1)})
  system.wait(0)
  script.trigger_script_event(-2043109205, pid, {0, 0, 3333, 0, 0, 0, -987, 21369})
  script.trigger_script_event(-988842806, pid, {0, 0, 2222, 0, 0, 0, -109, 73322})
  script.trigger_script_event(-977515445, pid, {26770, 95398, 98426, -24591, 47901, -64814})
  script.trigger_script_event(-1949011582, pid, {pid, -1139568479, math.random(0, 4), math.random(0, 1)})
  script.trigger_script_event(-1730227041, pid, {-494, 1526, 60541, -12988, -99097, -32105})
    script.trigger_script_event(-393294520, pid, {pid, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
    script.trigger_script_event(-1386010354, pid, {pid, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
    script.trigger_script_event(962740265, pid, {pid, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
script.trigger_script_event(962740265, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), pid})
script.trigger_script_event(962740265, pid, {player.player_id(), pid, 1001, pid})
script.trigger_script_event(-1386010354, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), pid})
script.trigger_script_event(-1386010354, pid, {player.player_id(), 2147483647, 2147483647, 232342, 112, 238452, 2832})
script.trigger_script_event(2112408256, pid, {player.player_id(), math.random(-1986324736, 1747413822), math.random(-1986324736, 1777712108), math.random(-1673857408, 1780088064), math.random(-2588888790, 2100146067)})
script.trigger_script_event(998716537, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), pid})
script.trigger_script_event(998716537, pid, {player.player_id(), pid, 1001, pid})
script.trigger_script_event(163598572, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), pid})
script.trigger_script_event(-1056683619, pid, {player.player_id(), pid, 1001, pid})
script.trigger_script_event(436475575, pid, {player.player_id(), 20})
script.trigger_script_event(1757755807, pid, {player.player_id(), 62, 2})
script.trigger_script_event(-1767058336, pid, {player.player_id(), 3})
script.trigger_script_event(-1013679841, pid, {player.player_id(), pid, 111})
script.trigger_script_event(-1501164935, pid, {player.player_id(), 0})
script.trigger_script_event(998716537, pid, {player.player_id(), 0})
script.trigger_script_event(163598572, pid, {player.player_id(), 0})
script.trigger_script_event(924535804, pid, {player.player_id(), 0})
script.trigger_script_event(69874647, pid, {player.player_id(), 0})
script.trigger_script_event(-1782442696, pid, {player.player_id(), 420, 69})
script.trigger_script_event(1445703181, pid, {player.player_id(), 28, 4294967295, 4294967295})
script.trigger_script_event(-1386010354, pid, {player.player_id(), 4294894682, -4294904289, -4294908269, 4294955284, 4294940300, -4294933898})
script.trigger_script_event(962740265, pid, {player.player_id(), 4294894682, -4294904289, -4294908269, 4294955284, 4294940300, -4294933898})
script.trigger_script_event(-1501164935, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), pid})
script.trigger_script_event(-1501164935, pid, {player.player_id(), pid, 1001, pid})
script.trigger_script_event(-0x529CD6F2, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
script.trigger_script_event(-0x756DBC8A, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
script.trigger_script_event(-0x69532BA0, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
script.trigger_script_event(0x68C5399F, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
script.trigger_script_event(-0x177132B8, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
script.trigger_script_event(962740265, pid, {player.player_id(), pid, 1001, pid})
script.trigger_script_event(-0x177132B8, pid, {player.player_id(), math.random(-2147483647, 2147483647), pid})
script.trigger_script_event(436475575, pid, {player.player_id(), 4113865})
script.trigger_script_event(-1767058336, pid, {player.player_id(), 20923579})
script.trigger_script_event(2112408256, pid, {77777778})
script.trigger_script_event(924535804, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), pid})
script.trigger_script_event(1445703181, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), 136236, math.random(-5262, 216247), math.random(-2147483647, 2147483647), math.random(-2623647, 2143247), 1587193, math.random(-214626647, 21475247), math.random(-2123647, 2363647), 651264, math.random(-13683647, 2323647), 1951923, math.random(-2147483647, 2147483647), math.random(-2136247, 21627), 2359273, math.random(-214732, 21623647), pid})
pos = player.get_player_coords(pid)
pos.x = pos.x + 2
newRope = rope.add_rope(pos,v3(0,0,10),1,1,0,1,1,false,false,false,1.0,false)
pos = player.get_player_coords(pid)
car = spawn_vehicle(0X187D938D,pos,0)
local pos = player.get_player_coords(pid)
local ppos = player.get_player_coords(pid)
pos.x = pos.x+5
ppos.z = ppos.z+1
pedp=player.get_player_ped(pid)
cargobob = spawn_vehicle(    2132890591,pos,0)
kur =Cped(26,2727244247,ppos,0)
entity.set_entity_god_mode(kur,true)
newRope = rope.add_rope(pos,v3(0,0,0),1,1,0.0000000000000000000000000000000000001,1,1,true,true,true,1.0,true)
rope.attach_entities_to_rope(newRope,cargobob,kur,entity.get_entity_coords(cargobob),entity.get_entity_coords(kur),2 ,0,0,"Center","Center")
system.wait(0)
			local vehicles = utilities.get_table_of_entities(vehicle.get_all_vehicles(), 1000, 5000, true, true, player.get_player_coords(pid))
				network.request_control_of_entity(player.get_player_ped(pid))
				menu.notify("5G Crash: " .. #vehicles .. " valid subjects found! Executing Crash...", Meteor, 4, 0x64FA7800)
				system.wait(1)
					utilities.request_model(2971866336)
					tow_truck_5g_vehicle = vehicle.create_vehicle(2971866336, utilities.offset_coords_forward(player.get_player_coords(pid) + v3(0, 0, 5), player.get_player_heading(pid), 10), 0, true, false)
					utilities.request_model(3852654278)
					tow_truck_5g_vehicle = vehicle.create_vehicle(3852654278, utilities.offset_coords_forward(player.get_player_coords(pid) + v3(0, 0, 5), player.get_player_heading(pid), 10), 0, true, false)
				entity.set_entity_god_mode(tow_truck_5g_vehicle, true)
				entity.set_entity_visible(tow_truck_5g_vehicle, false)
					system.wait(1)
					system.yield(0)
					network.request_control_of_entity(player.get_player_ped(pid))
					ped.clear_ped_tasks_immediately(player.get_player_ped(pid))
				network.request_control_of_entity(player.get_player_ped(pid))
				utilities.request_control_silent(tow_truck_5g_vehicle)
				utilities.hard_remove_entity(tow_truck_5g_vehicle)
        local model_hash = player.get_player_model(player.player_id())
		local outfit_component_table = {}
		local outfit_component_texture_table = {}
		local outfit_prop_table = {}
		local outfit_prop_texture_table = {}
		for i = 0, 11 do
			outfit_component_table[i] = ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), i)
			outfit_component_texture_table[i] = ped.get_ped_texture_variation(player.get_player_ped(player.player_id()), i)
		end
		for i = 0, 2 do
			outfit_prop_table[i] = ped.get_ped_prop_index(player.get_player_ped(player.player_id()), i)
			outfit_prop_texture_table[i] = ped.get_ped_prop_texture_index(player.get_player_ped(player.player_id()), i)
		end
        for i = 1, 2 do
            local hash = player.get_player_model(player.player_id())
            if hash == 0x9C9EFFD8 then
                hash2 = 0x705E61F2
            else
                hash2 = 0x9C9EFFD8
            end
            utilities.request_model(hash)
            utilities.request_model(hash2)
            player.set_player_model(hash2)
            system.yield(100)
            ped.set_ped_health(player.get_player_ped(player.player_id()), 0)
            system.yield(100)
            ped.resurrect_ped(player.get_player_ped(player.player_id()))
            system.yield(300)
            player.set_player_model(hash)
            system.yield(100)
            ped.set_ped_health(player.get_player_ped(player.player_id()), 0)
            system.yield(200)
            ped.resurrect_ped(player.get_player_ped(player.player_id()))
            ped.set_ped_health(player.get_player_ped(player.player_id()), 0)
            system.yield(100)
            ped.resurrect_ped(player.get_player_ped(player.player_id()))
            system.yield(100)
        end
        system.wait(1000)
        player_func.change_player_model(model_hash, nil)
        system.wait(100)
		for i = 0, 11 do
			ped.set_ped_component_variation(player.get_player_ped(player.player_id()), i, outfit_component_table[i], outfit_component_texture_table[i], 0)
		end
		for i = 0, 2 do
			ped.set_ped_prop_index(player.get_player_ped(player.player_id()), i, outfit_prop_table[i], outfit_prop_texture_table[i], 0)
		end
		menu.notify("» Instant Desktop executed successfully.")
	else
		menu.notify("Invalid Player.")
	end
end)

menu.add_player_feature("» Wtf Crash", "action", playerparents["» Crashes And Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		utilities.request_model(0x303638A7)
		local table_of_all_peds = {}
		local table_of_all_vehicles = {}
        local hashes = {956849991, 1133471123, 2803699023, 386089410, 1549009676}
		local yo_momma = ped.create_ped(0, 0x303638A7, player.get_player_coords(pid) + v3(300, 300, 300), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
		network.request_control_of_entity(yo_momma)
		for i = 1, 5 do
			table_of_all_peds[i] = ped.create_ped(0, 0x3F039CBA, player.get_player_coords(pid) + v3(300, 300, 300), 0, true, false)
			network.request_control_of_entity(table_of_all_peds[i])
			entity.attach_entity_to_entity(table_of_all_peds[i], yo_momma, 0, v3(0, 0, 0), v3(0, 0, 0), true, false, true, 0, true)
			table_of_all_peds[i + 5] = ped.create_ped(0, 0x856CFB02, player.get_player_coords(pid) + v3(300, 300, 300), 0, true, false)
			network.request_control_of_entity(table_of_all_peds[i + 5])
			entity.attach_entity_to_entity(table_of_all_peds[i + 5], yo_momma, 0, v3(0, 0, 0), v3(0, 0, 0), true, false, true, 0, true)
			table_of_all_peds[i + 10] = ped.create_ped(0, 0x2D7030F3, player.get_player_coords(pid) + v3(300, 300, 300), 0, true, false)
			network.request_control_of_entity(table_of_all_peds[i + 10])
			entity.attach_entity_to_entity(table_of_all_peds[i + 10], yo_momma, 0, v3(0, 0, 0), v3(0, 0, 0), true, false, true, 0, true)
		end
        for i = 1, #hashes do
            utilities.request_model(hashes[i])
            table_of_all_vehicles[i] = vehicle.create_vehicle(hashes[i], player.get_player_coords(pid) + v3(300, 300, 300), 0, true, false)
            network.request_control_of_entity(table_of_all_vehicles[i])
			entity.attach_entity_to_entity(table_of_all_vehicles[i], yo_momma, 0, v3(0, 0, 0), v3(0, 0, 0), true, false, false, 0, true)
        end
		system.wait(0)
		network.request_control_of_entity(yo_momma)
		entity.set_entity_coords_no_offset(yo_momma, player.get_player_coords(pid))
		system.wait(0)
		for i = 1, 15 do
			if entity.is_an_entity(table_of_all_peds[i]) then
				network.request_control_of_entity(table_of_all_peds[i])
				entity.delete_entity(table_of_all_peds[i])
			end
		end
		for i = 1, 5 do
			if entity.is_an_entity(table_of_all_vehicles[i]) then
				network.request_control_of_entity(table_of_all_vehicles[i])
				entity.delete_entity(table_of_all_vehicles[i])
			end
		end
		if yo_momma then
			network.request_control_of_entity(yo_momma)
			utilities.hard_remove_entity(yo_momma)
		end
		system.wait(0)
		script.trigger_script_event(-371781708, pid, {player.player_id(), pid, pid, 1403904671})
		system.wait(0)
		script.trigger_script_event(-317318371, pid, {player.player_id(), pid, pid, 1993236673})
		system.wait(0)
		script.trigger_script_event(911179316, pid, {player.player_id(), pid, pid, pid, 1234567990, pid, pid})
		system.wait(0)
		script.trigger_script_event(846342319, pid, {player.player_id(), 578162304, 1})
		system.wait(0)
		script.trigger_script_event(-2085853000, pid, {player.player_id(), pid, 1610781286, pid, pid})
		system.wait(0)
		script.trigger_script_event(-1991317864, pid, {player.player_id(), 3, 935764694, pid, pid})
		system.wait(0)
		script.trigger_script_event(-1970125962, pid, {player.player_id(), pid, 1171952288})
		system.wait(0)
		script.trigger_script_event(-1013679841, pid, {player.player_id(), pid, 2135167326, pid})
		system.wait(0)
		script.trigger_script_event(-1767058336, pid, {player.player_id(), 1459620687})
		system.wait(0)
		script.trigger_script_event(-1892343528, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647)})
		system.wait(0)
		script.trigger_script_event(1494472464, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647)})
		system.wait(0)
		script.trigger_script_event(69874647, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647)})
		system.wait(0)
		script.trigger_script_event(998716537, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647)})
		system.wait(0)
		script.trigger_script_event(522189882, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647)})
		system.wait(0)
		script.trigger_script_event(1514515570, pid, {player.player_id(), pid, 2147483647})
		system.wait(0)
		script.trigger_script_event(-393294520, pid, {pid, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		system.wait(1)
		script.trigger_script_event(-1386010354, pid, {pid, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		system.wait(0)
		script.trigger_script_event(962740265, pid, {pid, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		system.wait(0)
		script.trigger_script_event(296518236, pid, {player.player_id(), pid, pid, pid, 1})
		system.wait(0)
		script.trigger_script_event(-1782442696, pid, {player.player_id(), 420, 69})
		system.wait(0)
		for i = 1, 5 do
			script.trigger_script_event(-1782442696, pid, {player.player_id(), math.random(-2147483647, 2147483647), 0})
			system.wait(0)
		end
		script.trigger_script_event(924535804, pid, {pid, math.random(-2147483647, 2147483647), 0})
		system.wait(0)
		script.trigger_script_event(436475575, pid, {pid, math.random(-2147483647, 2147483647), 0})
		system.wait(0)
		script.trigger_script_event(-1386010354, pid, {player.player_id(), 2147483647, 2147483647, -788905164})
		script.trigger_script_event(962740265, pid, {player.player_id(), 4294894682, -4294904289, -788905164})
		script.trigger_script_event(962740265, pid, {-72614, 63007, 59027, -12012, -26996, 33398, pid})
		script.trigger_script_event(-1386010354, pid, {player.player_id(), 2147483647, 2147483647, -72614, 63007, 59027, -12012, -26996, 33398, pid})
			utilities.request_model(1349725314)
			local vehicle_ = vehicle.create_vehicle(1349725314, utilities.offset_coords_forward(player.get_player_coords(pid), player.get_player_heading(pid), 5), player.get_player_coords(pid).z, true, false)
			network.request_control_of_entity(vehicle_)
			vehicle.set_vehicle_mod_kit_type(vehicle_, 0)
			vehicle.set_vehicle_mod(vehicle_, 48, 0, false)
			system.wait(0)
			utilities.request_control_silent(vehicle_)
			utilities.hard_remove_entity(vehicle_)
		script.trigger_script_event(-1386010354, pid, {player.player_id(), 2147483647, 2147483647, 23243, 5332, 3324, pid})
		script.trigger_script_event(962740265, pid, {player.player_id(), 23243, 5332, 3324, pid})
		script.trigger_script_event(962740265, pid, {player.player_id(), pid, 30583, pid, pid, pid, pid, -328966, 10128444})
		script.trigger_script_event(-1386010354, pid, {player.player_id(), 2147483647, 2147483647, pid, 30583, pid, pid, pid, pid, -328966, 10128444})
		script.trigger_script_event(962740265, pid, {player.player_id(), 95398, 98426, -24591, 47901, -64814})
		script.trigger_script_event(962740265, pid, {player.player_id(), 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647})
		script.trigger_script_event(-1386010354, pid, {player.player_id(), 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647})
		script.trigger_script_event(677240627, pid, {player.player_id(), -1774405356})
  script.trigger_script_event(-2043109205, pid, {0, 0, 17302, 9822, 1999, 6777888, 111222})
  script.trigger_script_event(-2043109205, pid, {0, 0, 2327, 0, 0, 0, -307, 27777})
  script.trigger_script_event(-988842806, pid, {0, 0, 2327, 0, 0, 0, -307, 27777})
  script.trigger_script_event(-2043109205, pid, {0, 0, 27983, 7601, 1020, 3209051, 111222})
  script.trigger_script_event(-2043109205, pid, {0, 0, 1010, 0, 0, 0, -2653, 50555})
  script.trigger_script_event(-988842806, pid, {0, 0, 1111, 0, 0, 0, -5621, 57766})
  script.trigger_script_event(-988842806, pid, {0, 0, -3, -90, -123, -9856, -97652})
  script.trigger_script_event(-2043109205, pid, {0, 0, -3, -90, -123, -9856, -97652})
  script.trigger_script_event(-1881357102, pid, {0, 0, -3, -90, -123, -9856, -97652})
  script.trigger_script_event(-988842806, pid, {0, 0, 20547, 1058, 1245, 2721936, 666333})
  system.wait(0)
  script.trigger_script_event(-2043109205, pid, {0, 0, 20547, 1058, 1245, 2721936, 666333})
  script.trigger_script_event(-1881357102, pid, {0, 0, 20547, 1058, 1245, 2721936, 666333})
  script.trigger_script_event(153488394, pid, {0, 868904806, 0, 0, -152, -123, -978, 0, 0, 1, 0, -167, -144})
  script.trigger_script_event(153488394, pid, {0, 868904806, 0, 0, 152, 123, 978, 0, 0, 1, 0, 167, 144})
  script.trigger_script_event(1249026189, pid, {0, 0, 97587, 5697, 3211, 8237539, 967853})
  script.trigger_script_event(1033875141, pid, {0, 0, 0, 1967})
  script.trigger_script_event(1033875141, pid, {0, 0, -123, -957, -14, -1908, -123})
  script.trigger_script_event(1033875141, pid, {0, 0, 12121, 9756, 7609, 1111111, 789666})
  script.trigger_script_event(315658550, pid, {0, 0, 87111, 5782, 9999, 3333333, 888888})
  script.trigger_script_event(-877212109, pid, {0, 0, 87111, 5782, 9999, 3333333, 888888})
  script.trigger_script_event(1926582096, pid, {0, -1, -1, -1, 18899, 1011, 3070})
  script.trigger_script_event(1926582096, pid, {0, -4640169, 0, 0, 0, -36565476, -53105203})
  script.trigger_script_event(1033875141, pid, {-17645264, -26800537, -66094971, -45281983, -24450684, -13000488,
                                                59643555, 34295654, 91870118, -3283691})
  script.trigger_script_event(-988842806, pid, {0, 0, 93})
  system.wait(0)
  script.trigger_script_event(-2043109205, pid, {0, 0, 37, 0, -7})
  script.trigger_script_event(-1881357102, pid, {0, 0, -13, 0, 0, 0, 23})
  script.trigger_script_event(153488394, pid, {0, 868904806, 0, 0, 7, 7, 19, 0, 0, 1, 0, -23, -27})
  script.trigger_script_event(1249026189, pid, {})
  script.trigger_script_event(315658550, pid, {})
  script.trigger_script_event(-877212109, pid, {})
  script.trigger_script_event(1033875141, pid, {0, 0, 0, 82})
  script.trigger_script_event(1926582096, pid, {})
  script.trigger_script_event(-977515445, pid, {26770, 95398, 98426, -24591, 47901, -64814})
  script.trigger_script_event(-1949011582, pid, {pid, -1139568479, math.random(0, 4), math.random(0, 1)})
  system.wait(0)
  script.trigger_script_event(-2043109205, pid, {0, 0, 3333, 0, 0, 0, -987, 21369})
  script.trigger_script_event(-988842806, pid, {0, 0, 2222, 0, 0, 0, -109, 73322})
  script.trigger_script_event(-977515445, pid, {26770, 95398, 98426, -24591, 47901, -64814})
  script.trigger_script_event(-1949011582, pid, {pid, -1139568479, math.random(0, 4), math.random(0, 1)})
  script.trigger_script_event(-1730227041, pid, {-494, 1526, 60541, -12988, -99097, -32105})
    script.trigger_script_event(-393294520, pid, {pid, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
    script.trigger_script_event(-1386010354, pid, {pid, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
    script.trigger_script_event(962740265, pid, {pid, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
script.trigger_script_event(962740265, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), pid})
script.trigger_script_event(962740265, pid, {player.player_id(), pid, 1001, pid})
script.trigger_script_event(-1386010354, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), pid})
script.trigger_script_event(-1386010354, pid, {player.player_id(), 2147483647, 2147483647, 232342, 112, 238452, 2832})
script.trigger_script_event(2112408256, pid, {player.player_id(), math.random(-1986324736, 1747413822), math.random(-1986324736, 1777712108), math.random(-1673857408, 1780088064), math.random(-2588888790, 2100146067)})
script.trigger_script_event(998716537, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), pid})
script.trigger_script_event(998716537, pid, {player.player_id(), pid, 1001, pid})
script.trigger_script_event(163598572, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), pid})
script.trigger_script_event(-1056683619, pid, {player.player_id(), pid, 1001, pid})
script.trigger_script_event(436475575, pid, {player.player_id(), 20})
script.trigger_script_event(1757755807, pid, {player.player_id(), 62, 2})
script.trigger_script_event(-1767058336, pid, {player.player_id(), 3})
script.trigger_script_event(-1013679841, pid, {player.player_id(), pid, 111})
script.trigger_script_event(-1501164935, pid, {player.player_id(), 0})
script.trigger_script_event(998716537, pid, {player.player_id(), 0})
script.trigger_script_event(163598572, pid, {player.player_id(), 0})
script.trigger_script_event(924535804, pid, {player.player_id(), 0})
script.trigger_script_event(69874647, pid, {player.player_id(), 0})
script.trigger_script_event(-1782442696, pid, {player.player_id(), 420, 69})
script.trigger_script_event(1445703181, pid, {player.player_id(), 28, 4294967295, 4294967295})
script.trigger_script_event(-1386010354, pid, {player.player_id(), 4294894682, -4294904289, -4294908269, 4294955284, 4294940300, -4294933898})
script.trigger_script_event(962740265, pid, {player.player_id(), 4294894682, -4294904289, -4294908269, 4294955284, 4294940300, -4294933898})
script.trigger_script_event(-1501164935, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), pid})
script.trigger_script_event(-1501164935, pid, {player.player_id(), pid, 1001, pid})
script.trigger_script_event(-0x529CD6F2, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
script.trigger_script_event(-0x756DBC8A, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
script.trigger_script_event(-0x69532BA0, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
script.trigger_script_event(0x68C5399F, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
script.trigger_script_event(-0x177132B8, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
script.trigger_script_event(962740265, pid, {player.player_id(), pid, 1001, pid})
script.trigger_script_event(-0x177132B8, pid, {player.player_id(), math.random(-2147483647, 2147483647), pid})
script.trigger_script_event(436475575, pid, {player.player_id(), 4113865})
script.trigger_script_event(-1767058336, pid, {player.player_id(), 20923579})
script.trigger_script_event(2112408256, pid, {77777778})
script.trigger_script_event(924535804, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), pid})
script.trigger_script_event(1445703181, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), 136236, math.random(-5262, 216247), math.random(-2147483647, 2147483647), math.random(-2623647, 2143247), 1587193, math.random(-214626647, 21475247), math.random(-2123647, 2363647), 651264, math.random(-13683647, 2323647), 1951923, math.random(-2147483647, 2147483647), math.random(-2136247, 21627), 2359273, math.random(-214732, 21623647), pid})
pos = player.get_player_coords(pid)
pos.x = pos.x + 2
newRope = rope.add_rope(pos,v3(0,0,10),1,1,0,1,1,false,false,false,1.0,false)
pos = player.get_player_coords(pid)
car = spawn_vehicle(0X187D938D,pos,0)
local pos = player.get_player_coords(pid)
local ppos = player.get_player_coords(pid)
pos.x = pos.x+5
ppos.z = ppos.z+1
pedp=player.get_player_ped(pid)
cargobob = spawn_vehicle(    2132890591,pos,0)
kur =Cped(26,2727244247,ppos,0)
entity.set_entity_god_mode(kur,true)
newRope = rope.add_rope(pos,v3(0,0,0),1,1,0.0000000000000000000000000000000000001,1,1,true,true,true,1.0,true)
rope.attach_entities_to_rope(newRope,cargobob,kur,entity.get_entity_coords(cargobob),entity.get_entity_coords(kur),2 ,0,0,"Center","Center")
system.wait(0)
			local vehicles = utilities.get_table_of_entities(vehicle.get_all_vehicles(), 1000, 5000, true, true, player.get_player_coords(pid))
				network.request_control_of_entity(player.get_player_ped(pid))
				menu.notify("5G Crash: " .. #vehicles .. " valid subjects found! Executing Crash...", Meteor, 4, 0x64FA7800)
				system.wait(1)
					utilities.request_model(2971866336)
					tow_truck_5g_vehicle = vehicle.create_vehicle(2971866336, utilities.offset_coords_forward(player.get_player_coords(pid) + v3(0, 0, 5), player.get_player_heading(pid), 10), 0, true, false)
					utilities.request_model(3852654278)
					tow_truck_5g_vehicle = vehicle.create_vehicle(3852654278, utilities.offset_coords_forward(player.get_player_coords(pid) + v3(0, 0, 5), player.get_player_heading(pid), 10), 0, true, false)
				entity.set_entity_god_mode(tow_truck_5g_vehicle, true)
				entity.set_entity_visible(tow_truck_5g_vehicle, false)
					system.wait(1)
					system.yield(0)
					network.request_control_of_entity(player.get_player_ped(pid))
					ped.clear_ped_tasks_immediately(player.get_player_ped(pid))
				network.request_control_of_entity(player.get_player_ped(pid))
				utilities.request_control_silent(tow_truck_5g_vehicle)
				utilities.hard_remove_entity(tow_truck_5g_vehicle)
		menu.notify("» Wtf Crash executed successfully.")
	else
		menu.notify("Invalid Player.")
	end
end)

feature["» Math Crash Lobby"] = menu.add_feature("» Math Crash Lobby", "toggle", localparents["» Math Crash Lobby"].id, function(f)

    mypos = player.get_player_coords(player.player_id())
    mypos.x = mypos.x+10
    carc = spawn_vehicle(2598821281,mypos,0)
    pedc =Cped(26,2597531625,mypos,0)
    entity.set_entity_god_mode(carc, true)
    entity.set_entity_god_mode(pedc, true)
    entity.set_entity_visible(carc, false)
    entity.set_entity_visible(pedc, false)
    ropec = rope.add_rope(mypos,v3(0,0,0),1,1,0.00300000000000000000000000000000000000000000000001,1,1,true,true,true,1.0,true)
    rope.attach_entities_to_rope(ropec,carc,pedc,entity.get_entity_coords(carc),entity.get_entity_coords(pedc),2,0,0,"Center","Center")
    system.wait(2500)
    rope.delete_rope(ropec)
    entity.delete_entity(carc)
    entity.delete_entity(pedc)
    menu.notify("Math Crash Finished")
end)

menu.add_player_feature("» Math Crash" , "action", playerparents["» Crashes And Kicks"], function(f, pid)
local pos = player.get_player_coords(pid)
local ppos = player.get_player_coords(pid)
pos.x = pos.x+5
ppos.z = ppos.z+1
pedp=player.get_player_ped(pid)
cargobob = spawn_vehicle(    2132890591,pos,0)
kur =Cped(26,2727244247,ppos,0)
entity.set_entity_god_mode(kur,true)
newRope = rope.add_rope(pos,v3(0,0,0),1,1,0.0000000000000000000000000000000000001,1,1,true,true,true,1.0,true)
rope.attach_entities_to_rope(newRope,cargobob,kur,entity.get_entity_coords(cargobob),entity.get_entity_coords(kur),2 ,0,0,"Center","Center")
system.wait(100)
    menu.notify("Math Crash Finished")
end)

menu.add_player_feature("» Crash - 5G Tow Truck", "action_value_str", playerparents["» Crashes And Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		if network.get_player_player_is_spectating(player.player_id()) == pid or utilities.get_distance_between(player.get_player_ped(player.player_id()), player.get_player_ped(pid)) < 100 then
			local vehicles = utilities.get_table_of_entities(vehicle.get_all_vehicles(), 1000, 5000, true, true, player.get_player_coords(pid))

			for i = 1, #vehicles do
				network.request_control_of_entity(vehicles[i])
			end

			if #vehicles > 30 then
				menu.notify("5G Crash: " .. #vehicles .. " valid subjects found! Executing Crash...", Meteor, 4, 0x64FA7800)
				system.wait(1000)

				if f.value == 0 then
					utilities.request_model(2971866336)
					tow_truck_5g_vehicle = vehicle.create_vehicle(2971866336, utilities.offset_coords_forward(player.get_player_coords(pid) + v3(0, 0, 5), player.get_player_heading(pid), 10), 0, true, false)
				elseif f.value == 1 then
					utilities.request_model(3852654278)
					tow_truck_5g_vehicle = vehicle.create_vehicle(3852654278, utilities.offset_coords_forward(player.get_player_coords(pid) + v3(0, 0, 5), player.get_player_heading(pid), 10), 0, true, false)
				end
				entity.set_entity_god_mode(tow_truck_5g_vehicle, true)
				entity.set_entity_visible(tow_truck_5g_vehicle, false)

				for i = 1, #vehicles do
					network.request_control_of_entity(vehicles[i])
					entity.set_entity_god_mode(vehicles[i], true)
					entity.set_entity_visible(vehicles[i], false)
				end
				for i = 1, #vehicles do
					network.request_control_of_entity(vehicles[i])
					entity.attach_entity_to_entity(vehicles[i], tow_truck_5g_vehicle, 0, v3(), v3(), true, true, false, 0, false)
					system.wait(1)
				end

				local time = utils.time_ms() + 2000
				while time > utils.time_ms() do
					system.yield(0)
					network.request_control_of_entity(player.get_player_ped(pid))
					ped.clear_ped_tasks_immediately(player.get_player_ped(pid))
					for i = 1, #vehicles do
						network.request_control_of_entity(vehicles[i])
						entity.set_entity_coords_no_offset(vehicles[i], utilities.offset_coords_forward(player.get_player_coords(pid) + v3(0, 0, 5), player.get_player_heading(pid), 10))
					end
				end

				utilities.request_control_silent(tow_truck_5g_vehicle)
				utilities.hard_remove_entity(tow_truck_5g_vehicle)

				for i = 1, #vehicles do
					utilities.request_control_silent(vehicles[i])
					utilities.hard_remove_entity(vehicles[i])
				end

				menu.notify("5G Tow Truck Crash executed successfully.", Meteor)
			else
				menu.notify("5G Crash: Not enough valid subjects found!", Meteor, 4, 211)
			end
		else
			menu.notify("You have to spectate the target or be near them in order for this feature to work.", Meteor, 5, 211)
		end
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end
end):set_str_data({
	"v1",
	"v2"
})

menu.add_player_feature("» Crash - 5G Currupt", "action", playerparents["» Crashes And Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
			local vehicles = utilities.get_table_of_entities(vehicle.get_all_vehicles(), 1000, 5000, true, true, player.get_player_coords(pid))
				network.request_control_of_entity(player.get_player_ped(pid))
				menu.notify("5G Crash: " .. #vehicles .. " valid subjects found! Executing Crash...", Meteor, 4, 0x64FA7800)
				system.wait(1)
					utilities.request_model(2971866336)
					tow_truck_5g_vehicle = vehicle.create_vehicle(2971866336, utilities.offset_coords_forward(player.get_player_coords(pid) + v3(0, 0, 5), player.get_player_heading(pid), 10), 0, true, false)
					utilities.request_model(3852654278)
					tow_truck_5g_vehicle = vehicle.create_vehicle(3852654278, utilities.offset_coords_forward(player.get_player_coords(pid) + v3(0, 0, 5), player.get_player_heading(pid), 10), 0, true, false)
				entity.set_entity_god_mode(tow_truck_5g_vehicle, true)
				entity.set_entity_visible(tow_truck_5g_vehicle, false)
					system.wait(1)
					system.yield(0)
					network.request_control_of_entity(player.get_player_ped(pid))
					ped.clear_ped_tasks_immediately(player.get_player_ped(pid))
				network.request_control_of_entity(player.get_player_ped(pid))
				utilities.request_control_silent(tow_truck_5g_vehicle)
				utilities.hard_remove_entity(tow_truck_5g_vehicle)
		menu.notify("» 5G Currupt executed successfully.")
	else
		menu.notify("Invalid Player.")
	end
end)

playerparents["» Lobby Crashes"] = menu.add_player_feature("» Lobby Crashes", "parent", playerparents["» Crashes And Kicks"]).id


menu.add_player_feature("» Crash - Math Crash", "action", playerparents["» Lobby Crashes"], function(f, pid)
	if player.is_player_valid(player.player_id()) then
		menu.notify("Made the server do math..", Meteor)
		rope.rope_load_textures()
		utilities.request_model(2132890591)
		utilities.request_model(2727244247)
		local vehicle_ = vehicle.create_vehicle(2132890591, player.get_player_coords(player.player_id()) + v3(5, 0, 0), 0, true, false)
		local ped_ = ped.create_ped(26, 2727244247, player.get_player_coords(player.player_id()) + v3(0, 0, 1), 0, true, false)
		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
		entity.set_entity_god_mode(ped_, true)
		entity.set_entity_visible(ped_, false)
		entity.set_entity_visible(vehicle_, false)
		local rope_ = rope.add_rope(player.get_player_coords(player.player_id()) + v3(5, 0, 0), v3(0, 0, 0), 1, 1, 0.0000000000000000000000000000000000001, 1, 1, true, true, true, 1, true)
		rope.attach_entities_to_rope(rope_, vehicle_, ped_, entity.get_entity_coords(vehicle_), entity.get_entity_coords(ped_), 2, 0, 0, "Center", "Center")
		system.wait(1000)
		utilities.request_control_silent(vehicle_)
		utilities.request_control_silent(ped_)
		utilities.hard_remove_entity(vehicle_)
		utilities.hard_remove_entity(ped_)
		rope.delete_rope(rope_)
		rope.rope_unload_textures()
		menu.notify("Math Crash executed successfully.", Meteor)
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Crash - Sound Spam", "action", playerparents["» Lobby Crashes"], function(f, pid)
	if player.is_player_valid(player.player_id()) then
		local time = utils.time_ms() + 100
		while time > utils.time_ms() do
			for i = 1, 10 do
				audio.play_sound_from_coord(-1, "Event_Message_Purple", player.get_player_coords(player.player_id()), "GTAO_FM_Events_Soundset", true, 99999, false)
			end
			system.wait(0)
		end
		menu.notify("Sound Spam Crash executed successfully.", Meteor)
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Crash - Bad Head Blend Data", "action", playerparents["» Lobby Crashes"], function(f, pid)
    if player.is_player_valid(player.player_id()) then
        local model_hash = player.get_player_model(player.player_id())
		local outfit_component_table = {}
		local outfit_component_texture_table = {}
		local outfit_prop_table = {}
		local outfit_prop_texture_table = {}
		for i = 0, 11 do
			outfit_component_table[i] = ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), i)
			outfit_component_texture_table[i] = ped.get_ped_texture_variation(player.get_player_ped(player.player_id()), i)
		end
		for i = 0, 2 do
			outfit_prop_table[i] = ped.get_ped_prop_index(player.get_player_ped(player.player_id()), i)
			outfit_prop_texture_table[i] = ped.get_ped_prop_texture_index(player.get_player_ped(player.player_id()), i)
		end
        local time = utils.time_ms() + 10000
        while time > utils.time_ms() do
            system.yield(10)
            ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 0, 17, math.random(0, 50), 0)
            ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 1, 55, math.random(0, 50), 0)
            ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 2, 40, math.random(0, 50), 0)
            ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 3, 44, math.random(0, 50), 0)
            ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 4, 31, math.random(0, 50), 0)
            ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 5, 0, math.random(0, 50), 0)
            ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 6, 24, math.random(0, 50), 0)
            ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 7, 110, math.random(0, 50), 0)
            ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 8, 55, math.random(0, 50), 0)
            ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 9, 9, math.random(0, 50), 0)
            ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 10, 45, math.random(0, 50), 0)
            ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 11, 69, math.random(0, 50), 0)
            ped.set_ped_face_feature(player.get_player_ped(player.player_id()), 1, math.random(-1000, 1000))
            ped.set_ped_face_feature(player.get_player_ped(player.player_id()), 2, math.random(-1000, 1000))
            ped.set_ped_face_feature(player.get_player_ped(player.player_id()), 3, math.random(-1000, 1000))
            ped.set_ped_face_feature(player.get_player_ped(player.player_id()), 4, math.random(-1000, 1000))
            ped.set_ped_head_blend_data(player.get_player_ped(player.player_id()), math.random(-1000, 1000), math.random(-1000, 1000), math.random(-1000, 1000), math.random(-1000, 1000), math.random(-1000, 1000), math.random(-1000, 1000), math.random(-1000, 1000), math.random(-1000, 1000), math.random(-1000, 1000))
        end
        system.wait(500)
        player_func.change_player_model(model_hash, nil)
        system.wait(100)
		for i = 0, 11 do
			ped.set_ped_component_variation(player.get_player_ped(player.player_id()), i, outfit_component_table[i], outfit_component_texture_table[i], 0)
		end
		for i = 0, 2 do
			ped.set_ped_prop_index(player.get_player_ped(player.player_id()), i, outfit_prop_table[i], outfit_prop_texture_table[i], 0)
		end
		menu.notify("Bad Head Blend Data Crash executed successfully.", Meteor)
    end
end)

menu.add_player_feature("» Crash - Deathswap", "action", playerparents["» Lobby Crashes"], function(f, pid)
    if player.is_player_valid(player.player_id()) then
        local model_hash = player.get_player_model(player.player_id())
		local outfit_component_table = {}
		local outfit_component_texture_table = {}
		local outfit_prop_table = {}
		local outfit_prop_texture_table = {}
		for i = 0, 11 do
			outfit_component_table[i] = ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), i)
			outfit_component_texture_table[i] = ped.get_ped_texture_variation(player.get_player_ped(player.player_id()), i)
		end
		for i = 0, 2 do
			outfit_prop_table[i] = ped.get_ped_prop_index(player.get_player_ped(player.player_id()), i)
			outfit_prop_texture_table[i] = ped.get_ped_prop_texture_index(player.get_player_ped(player.player_id()), i)
		end
        for i = 1, 2 do
            local hash = player.get_player_model(player.player_id())
            if hash == 0x9C9EFFD8 then
                hash2 = 0x705E61F2
            else
                hash2 = 0x9C9EFFD8
            end
            utilities.request_model(hash)
            utilities.request_model(hash2)
            player.set_player_model(hash2)
            system.yield(100)
            ped.set_ped_health(player.get_player_ped(player.player_id()), 0)
            system.yield(100)
            ped.resurrect_ped(player.get_player_ped(player.player_id()))
            system.yield(300)
            player.set_player_model(hash)
            system.yield(100)
            ped.set_ped_health(player.get_player_ped(player.player_id()), 0)
            system.yield(200)
            ped.resurrect_ped(player.get_player_ped(player.player_id()))
            ped.set_ped_health(player.get_player_ped(player.player_id()), 0)
            system.yield(100)
            ped.resurrect_ped(player.get_player_ped(player.player_id()))
            system.yield(100)
        end
        system.wait(1000)
        player_func.change_player_model(model_hash, nil)
        system.wait(100)
		for i = 0, 11 do
			ped.set_ped_component_variation(player.get_player_ped(player.player_id()), i, outfit_component_table[i], outfit_component_texture_table[i], 0)
		end
		for i = 0, 2 do
			ped.set_ped_prop_index(player.get_player_ped(player.player_id()), i, outfit_prop_table[i], outfit_prop_texture_table[i], 0)
		end
        menu.notify("Deathswap Crash executed successfully.", Meteor)
    else
        menu.notify("Invalid Player.", Meteor, 3, 211)
    end
end)

menu.add_player_feature("» Crash - Bad Vehicle Parachute", "action", playerparents["» Lobby Crashes"], function(f, pid)
    if player.is_player_valid(player.player_id()) then
		utilities.request_model(941494461)
		local pos = player.get_player_coords(player.player_id())
		local parachute_vehicle = vehicle.create_vehicle(941494461, player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), true, false)
		utilities.request_control_silent(parachute_vehicle)
		entity.set_entity_god_mode(parachute_vehicle, true)
		vehicle.set_vehicle_parachute_model(parachute_vehicle, 1913502601)
		ped.set_ped_into_vehicle(player.get_player_ped(player.player_id()), parachute_vehicle, -1)
		entity.set_entity_velocity(parachute_vehicle, v3(0, 0, 40))
		local time = utils.time_ms() + 8000
		while time > utils.time_ms() do
			system.yield(0)
			vehicle.set_vehicle_parachute_active(parachute_vehicle, true)
		end
		if parachute_vehicle then
			utilities.request_control_silent(parachute_vehicle)
			utilities.hard_remove_entity(parachute_vehicle)
		end
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), pos)
		menu.notify("Bad Vehicle Parachute Crash executed successfully.", Meteor)
    else
        menu.notify("Invalid Player.", Meteor, 3, 211)
    end
end)

playerparents["» More Crashes"] = menu.add_player_feature("» More Crashes", "parent", playerparents["» Crashes And Kicks"]).id

menu.add_player_feature("» Crash - Midnight Brute", "action", playerparents["» More Crashes"], function(f, pid)
	if player.is_player_valid(pid) then
		script.trigger_script_event(-1386010354, pid, {player.player_id(), 2147483647, 2147483647, -788905164})
		script.trigger_script_event(962740265, pid, {player.player_id(), 4294894682, -4294904289, -788905164})
		menu.notify("Midnight Brute Crash executed successfully.", Meteor)
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Crash - Stand Elegant", "action", playerparents["» More Crashes"], function(f, pid)
	if player.is_player_valid(pid) then
		script.trigger_script_event(962740265, pid, {-72614, 63007, 59027, -12012, -26996, 33398, pid})
		script.trigger_script_event(-1386010354, pid, {player.player_id(), 2147483647, 2147483647, -72614, 63007, 59027, -12012, -26996, 33398, pid})
		menu.notify("Stand Elegant Crash executed successfully.", Meteor)
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Crash - Stand Next Gen", "action", playerparents["» More Crashes"], function(f, pid)
    if player.is_player_valid(pid) then
		if network.get_player_player_is_spectating(player.player_id()) == pid or utilities.get_distance_between(player.get_player_ped(player.player_id()), player.get_player_ped(pid)) < 100 then
			utilities.request_model(1349725314)
			local vehicle_ = vehicle.create_vehicle(1349725314, utilities.offset_coords_forward(player.get_player_coords(pid), player.get_player_heading(pid), 5), player.get_player_coords(pid).z, true, false)
			network.request_control_of_entity(vehicle_)
			vehicle.set_vehicle_mod_kit_type(vehicle_, 0)
			vehicle.set_vehicle_mod(vehicle_, 48, 0, false)
			system.wait(5000)
			utilities.request_control_silent(vehicle_)
			utilities.hard_remove_entity(vehicle_)
			menu.notify("Stand Next Gen Crash executed successfully.", Meteor)
		else
			menu.notify("You have to spectate the target or be near them in order for this feature to work.", Meteor, 5, 211)
		end
    else
        menu.notify("Invalid Player.", Meteor, 3, 211)
    end
end)

menu.add_player_feature("» Crash - Cherax", "action", playerparents["» More Crashes"], function(f, pid)
	if player.is_player_valid(pid) then
		script.trigger_script_event(-1386010354, pid, {player.player_id(), 2147483647, 2147483647, 23243, 5332, 3324, pid})
		script.trigger_script_event(962740265, pid, {player.player_id(), 23243, 5332, 3324, pid})
		menu.notify("Cherax Crash executed successfully.", Meteor)
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Crash - 0xCheats", "action", playerparents["» More Crashes"], function(f, pid)
	if player.is_player_valid(pid) then
		script.trigger_script_event(962740265, pid, {player.player_id(), pid, 30583, pid, pid, pid, pid, -328966, 10128444})
		script.trigger_script_event(-1386010354, pid, {player.player_id(), 2147483647, 2147483647, pid, 30583, pid, pid, pid, pid, -328966, 10128444})
		menu.notify("0xCheats Crash executed successfully.", Meteor)
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Crash - xForce Basic", "action", playerparents["» More Crashes"], function(f, pid)
	if player.is_player_valid(pid) then
		script.trigger_script_event(962740265, pid, {player.player_id(), 95398, 98426, -24591, 47901, -64814})
		script.trigger_script_event(962740265, pid, {player.player_id(), 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647})
		script.trigger_script_event(-1386010354, pid, {player.player_id(), 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647})
		script.trigger_script_event(677240627, pid, {player.player_id(), -1774405356})
		menu.notify("xForce Basic Crash executed successfully.", Meteor)
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Crash - Yo Momma", "action", playerparents["» More Crashes"], function(f, pid)
	if player.is_player_valid(pid) then
		utilities.request_model(0x303638A7)
		local table_of_all_peds = {}
		local table_of_all_vehicles = {}
        local hashes = {956849991, 1133471123, 2803699023, 386089410, 1549009676}
		local yo_momma = ped.create_ped(0, 0x303638A7, player.get_player_coords(pid) + v3(300, 300, 300), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
		network.request_control_of_entity(yo_momma)
		for i = 1, 5 do
			table_of_all_peds[i] = ped.create_ped(0, 0x3F039CBA, player.get_player_coords(pid) + v3(300, 300, 300), 0, true, false)
			network.request_control_of_entity(table_of_all_peds[i])
			entity.attach_entity_to_entity(table_of_all_peds[i], yo_momma, 0, v3(0, 0, 0), v3(0, 0, 0), true, false, true, 0, true)
			table_of_all_peds[i + 5] = ped.create_ped(0, 0x856CFB02, player.get_player_coords(pid) + v3(300, 300, 300), 0, true, false)
			network.request_control_of_entity(table_of_all_peds[i + 5])
			entity.attach_entity_to_entity(table_of_all_peds[i + 5], yo_momma, 0, v3(0, 0, 0), v3(0, 0, 0), true, false, true, 0, true)
			table_of_all_peds[i + 10] = ped.create_ped(0, 0x2D7030F3, player.get_player_coords(pid) + v3(300, 300, 300), 0, true, false)
			network.request_control_of_entity(table_of_all_peds[i + 10])
			entity.attach_entity_to_entity(table_of_all_peds[i + 10], yo_momma, 0, v3(0, 0, 0), v3(0, 0, 0), true, false, true, 0, true)
		end
        for i = 1, #hashes do
            utilities.request_model(hashes[i])
            table_of_all_vehicles[i] = vehicle.create_vehicle(hashes[i], player.get_player_coords(pid) + v3(300, 300, 300), 0, true, false)
            network.request_control_of_entity(table_of_all_vehicles[i])
			entity.attach_entity_to_entity(table_of_all_vehicles[i], yo_momma, 0, v3(0, 0, 0), v3(0, 0, 0), true, false, false, 0, true)
        end
		system.wait(0)
		network.request_control_of_entity(yo_momma)
		entity.set_entity_coords_no_offset(yo_momma, player.get_player_coords(pid))
		system.wait(2000)
		for i = 1, 15 do
			if entity.is_an_entity(table_of_all_peds[i]) then
				network.request_control_of_entity(table_of_all_peds[i])
				entity.delete_entity(table_of_all_peds[i])
			end
		end
		for i = 1, 5 do
			if entity.is_an_entity(table_of_all_vehicles[i]) then
				network.request_control_of_entity(table_of_all_vehicles[i])
				entity.delete_entity(table_of_all_vehicles[i])
			end
		end
		if yo_momma then
			network.request_control_of_entity(yo_momma)
			utilities.hard_remove_entity(yo_momma)
		end
		system.wait(1)
		script.trigger_script_event(-371781708, pid, {player.player_id(), pid, pid, 1403904671})
		system.wait(1)
		script.trigger_script_event(-317318371, pid, {player.player_id(), pid, pid, 1993236673})
		system.wait(1)
		script.trigger_script_event(911179316, pid, {player.player_id(), pid, pid, pid, 1234567990, pid, pid})
		system.wait(1)
		script.trigger_script_event(846342319, pid, {player.player_id(), 578162304, 1})
		system.wait(1)
		script.trigger_script_event(-2085853000, pid, {player.player_id(), pid, 1610781286, pid, pid})
		system.wait(1)
		script.trigger_script_event(-1991317864, pid, {player.player_id(), 3, 935764694, pid, pid})
		system.wait(1)
		script.trigger_script_event(-1970125962, pid, {player.player_id(), pid, 1171952288})
		system.wait(1)
		script.trigger_script_event(-1013679841, pid, {player.player_id(), pid, 2135167326, pid})
		system.wait(1)
		script.trigger_script_event(-1767058336, pid, {player.player_id(), 1459620687})
		system.wait(1)
		script.trigger_script_event(-1892343528, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647)})
		system.wait(1)
		script.trigger_script_event(1494472464, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647)})
		system.wait(1)
		script.trigger_script_event(69874647, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647)})
		system.wait(1)
		script.trigger_script_event(998716537, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647)})
		system.wait(1)
		script.trigger_script_event(522189882, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647)})
		system.wait(1)
		script.trigger_script_event(1514515570, pid, {player.player_id(), pid, 2147483647})
		system.wait(1)
		script.trigger_script_event(-393294520, pid, {pid, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		system.wait(1)
		script.trigger_script_event(-1386010354, pid, {pid, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		system.wait(1)
		script.trigger_script_event(962740265, pid, {pid, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		system.wait(1)
		script.trigger_script_event(296518236, pid, {player.player_id(), pid, pid, pid, 1})
		system.wait(1)
		script.trigger_script_event(-1782442696, pid, {player.player_id(), 420, 69})
		system.wait(1)
		for i = 1, 5 do
			script.trigger_script_event(-1782442696, pid, {player.player_id(), math.random(-2147483647, 2147483647), 0})
			system.wait(1)
		end
		script.trigger_script_event(924535804, pid, {pid, math.random(-2147483647, 2147483647), 0})
		system.wait(1)
		script.trigger_script_event(436475575, pid, {pid, math.random(-2147483647, 2147483647), 0})
		system.wait(1)
		menu.notify("Yo Momma Crash executed successfully.", Meteor)
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Crash - Script Event", "action_value_str", playerparents["» More Crashes"], function(f, pid)
	if player.is_player_valid(pid) then
		if f.value == 0 then
			script.trigger_script_event(962740265, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), pid})
		elseif f.value == 1 then
			script.trigger_script_event(962740265, pid, {player.player_id(), pid, 1001, pid})
		elseif f.value == 2 then
			script.trigger_script_event(-1386010354, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), pid})
		elseif f.value == 3 then
			script.trigger_script_event(-1386010354, pid, {player.player_id(), 2147483647, 2147483647, 232342, 112, 238452, 2832})
		elseif f.value == 4 then
			script.trigger_script_event(2112408256, pid, {player.player_id(), math.random(-1986324736, 1747413822), math.random(-1986324736, 1777712108), math.random(-1673857408, 1780088064), math.random(-2588888790, 2100146067)})
		elseif f.value == 5 then
			script.trigger_script_event(998716537, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), pid})
		elseif f.value == 6 then
			script.trigger_script_event(998716537, pid, {player.player_id(), pid, 1001, pid})
		elseif f.value == 7 then
			script.trigger_script_event(163598572, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), pid})
		elseif f.value == 8 then
			script.trigger_script_event(-1056683619, pid, {player.player_id(), pid, 1001, pid})
		elseif f.value == 9 then
			script.trigger_script_event(436475575, pid, {player.player_id(), 20})
		elseif f.value == 10 then
			script.trigger_script_event(1757755807, pid, {player.player_id(), 62, 2})
		elseif f.value == 11 then
			script.trigger_script_event(-1767058336, pid, {player.player_id(), 3})
		elseif f.value == 12 then
			script.trigger_script_event(-1013679841, pid, {player.player_id(), pid, 111})
		elseif f.value == 13 then
			script.trigger_script_event(-1501164935, pid, {player.player_id(), 0})
		elseif f.value == 14 then
			script.trigger_script_event(998716537, pid, {player.player_id(), 0})
		elseif f.value == 15 then
			script.trigger_script_event(163598572, pid, {player.player_id(), 0})
		elseif f.value == 16 then
			script.trigger_script_event(924535804, pid, {player.player_id(), 0})
		elseif f.value == 17 then
			script.trigger_script_event(69874647, pid, {player.player_id(), 0})
		elseif f.value == 18 then
			script.trigger_script_event(-1782442696, pid, {player.player_id(), 420, 69})
		elseif f.value == 19 then
			script.trigger_script_event(1445703181, pid, {player.player_id(), 28, 4294967295, 4294967295})
		elseif f.value == 20 then
			script.trigger_script_event(-1386010354, pid, {player.player_id(), 4294894682, -4294904289, -4294908269, 4294955284, 4294940300, -4294933898})
		elseif f.value == 21 then
			script.trigger_script_event(962740265, pid, {player.player_id(), 4294894682, -4294904289, -4294908269, 4294955284, 4294940300, -4294933898})
		elseif f.value == 22 then
			script.trigger_script_event(-1501164935, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), pid})
		elseif f.value == 23 then
			script.trigger_script_event(-1501164935, pid, {player.player_id(), pid, 1001, pid})
		elseif f.value == 24 then
			script.trigger_script_event(-0x529CD6F2, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		elseif f.value == 25 then
			script.trigger_script_event(-0x756DBC8A, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		elseif f.value == 26 then
			script.trigger_script_event(-0x69532BA0, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		elseif f.value == 27 then
			script.trigger_script_event(0x68C5399F, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		elseif f.value == 28 then
			script.trigger_script_event(-0x177132B8, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		elseif f.value == 29 then
			script.trigger_script_event(962740265, pid, {player.player_id(), pid, 1001, pid})
		elseif f.value == 30 then
			script.trigger_script_event(-0x177132B8, pid, {player.player_id(), math.random(-2147483647, 2147483647), pid})
		elseif f.value == 31 then
			script.trigger_script_event(436475575, pid, {player.player_id(), 4113865})
		elseif f.value == 32 then
			script.trigger_script_event(-1767058336, pid, {player.player_id(), 20923579})
		elseif f.value == 33 then
			script.trigger_script_event(2112408256, pid, {77777778})
		elseif f.value == 34 then
			script.trigger_script_event(924535804, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), pid})
		elseif f.value == 35 then
			script.trigger_script_event(1445703181, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), 136236, math.random(-5262, 216247), math.random(-2147483647, 2147483647), math.random(-2623647, 2143247), 1587193, math.random(-214626647, 21475247), math.random(-2123647, 2363647), 651264, math.random(-13683647, 2323647), 1951923, math.random(-2147483647, 2147483647), math.random(-2136247, 21627), 2359273, math.random(-214732, 21623647), pid})
		end
		menu.notify("Script Event Crash executed successfully.", Meteor)
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end
end):set_str_data({
	"v1",
	"v2",
	"v3",
	"v4",
	"v5",
	"v6",
	"v7",
	"v8",
	"v9",
	"v10",
	"v11",
	"v12",
	"v13",
	"v14",
	"v15",
	"v16",
	"v17",
	"v18",
	"v19",
	"v20",
	"v21",
	"v22",
	"v23",
	"v24",
	"v25",
	"v26",
	"v27",
	"v28",
	"v29",
	"v30",
	"v31",
	"v32",
	"v33",
	"v34",
	"v35",
	"v36"
})

menu.add_player_feature("» Crash - Invalid Vehicle", "action", playerparents["» More Crashes"], function(f, pid)
    if player.is_player_valid(pid) then
        local vehicle_ = {}
        local hashes = {956849991, 1133471123, 2803699023, 386089410, 1549009676}
        for i = 1, #hashes do
            utilities.request_model(hashes[i])
            vehicle_[i] = vehicle.create_vehicle(hashes[i], utilities.offset_coords_forward(player.get_player_coords(pid), player.get_player_heading(pid), 5), 0, true, false)
            network.request_control_of_entity(vehicle_[i])
        end
        system.wait(2000)
        for i = 1, #vehicle_ do
            utilities.request_control_silent(vehicle_[i])
            utilities.hard_remove_entity(vehicle_[i])
        end
        menu.notify("Invalid Vehicle Crash executed successfully.", Meteor)
    else
        menu.notify("Invalid Player.", Meteor, 3, 211)
    end
end)

menu.add_player_feature("» Crash - Bad Outfit Component", "action", playerparents["» More Crashes"], function(f, pid)
	if player.is_player_valid(pid) then
		if network.get_player_player_is_spectating(player.player_id()) == pid or utilities.get_distance_between(player.get_player_ped(player.player_id()), player.get_player_ped(pid)) < 100 then
			utilities.request_model(0x705E61F2)
			local ped_ = ped.create_ped(1, 0x705E61F2, player.get_player_coords(pid), 0, true, false)
			network.request_control_of_entity(ped_)
			ped.set_ped_component_variation(ped_, 0, 45, 0, 0)
			ped.set_ped_component_variation(ped_, 1, 197, 0, 0)
			ped.set_ped_component_variation(ped_, 2, 76, 0, 0)
			ped.set_ped_component_variation(ped_, 3, 196, 0, 0)
			ped.set_ped_component_variation(ped_, 4, 144, 0, 0)
			ped.set_ped_component_variation(ped_, 5, 99, 0, 0)
			ped.set_ped_component_variation(ped_, 6, 102, 0, 0)
			ped.set_ped_component_variation(ped_, 7, 151, 0, 0)
			ped.set_ped_component_variation(ped_, 8, 189, 0, 0)
			ped.set_ped_component_variation(ped_, 9, 56, 0, 0)
			ped.set_ped_component_variation(ped_, 10, 132, 0, 0)
			ped.set_ped_component_variation(ped_, 11, 393, 0, 0)
			system.wait(2000)
			utilities.request_control_silent(ped_)
			utilities.hard_remove_entity(ped_)
			menu.notify("Bad Outfit Component Crash executed successfully.", Meteor)
		else
			menu.notify("You have to spectate the target or be near them in order for this feature to work.", Meteor, 5, 211)
		end
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Crash - Invalid Vehicle Task", "action", playerparents["» More Crashes"], function(f, pid)
    if player.is_player_valid(pid) then
		utilities.request_control_silent(player.get_player_vehicle(pid))
		for i = 1, 3 do
			natives.TASK_VEHICLE_TEMP_ACTION(player.get_player_ped(pid), player.get_player_vehicle(pid), 15, 10)
			natives.TASK_VEHICLE_TEMP_ACTION(player.get_player_ped(pid), player.get_player_vehicle(pid), 16, 10)
			natives.TASK_VEHICLE_TEMP_ACTION(player.get_player_ped(pid), player.get_player_vehicle(pid), 18, 10)
		end
		system.wait(1000)
		for i = 1, 3 do
			natives.TASK_VEHICLE_TEMP_ACTION(player.get_player_ped(pid), player.get_player_vehicle(pid), 15, 10)
			natives.TASK_VEHICLE_TEMP_ACTION(player.get_player_ped(pid), player.get_player_vehicle(pid), 16, 10)
			natives.TASK_VEHICLE_TEMP_ACTION(player.get_player_ped(pid), player.get_player_vehicle(pid), 18, 10)
		end
		system.wait(1000)
		for i = 1, 3 do
			natives.TASK_VEHICLE_TEMP_ACTION(player.get_player_ped(pid), player.get_player_vehicle(pid), 15, 10)
			natives.TASK_VEHICLE_TEMP_ACTION(player.get_player_ped(pid), player.get_player_vehicle(pid), 16, 10)
			natives.TASK_VEHICLE_TEMP_ACTION(player.get_player_ped(pid), player.get_player_vehicle(pid), 18, 10)
		end
        menu.notify("Invalid Vehicle Task Crash executed successfully.", Meteor)
    else
        menu.notify("Invalid Player.", Meteor, 3, 211)
    end
end)

menu.add_player_feature("» Crash - Sound Spam", "action_value_str", playerparents["» More Crashes"], function(f, pid)
	if player.is_player_valid(pid) then
		local time = utils.time_ms() + 100
		while time > utils.time_ms() do
			for i = 1, 10 do
				if f.value == 0 then
					audio.play_sound_from_coord(-1, "Object_Dropped_Remote", player.get_player_coords(pid), "GTAO_FM_Events_Soundset", true, 1, false)
				elseif f.value == 1 then
					audio.play_sound_from_coord(-1, "Event_Message_Purple", player.get_player_coords(pid), "GTAO_FM_Events_Soundset", true, 1, false)
				elseif f.value == 2 then
					audio.play_sound_from_coord(-1, "Checkpoint_Cash_Hit", player.get_player_coords(pid), "GTAO_FM_Events_Soundset", true, 1, false)
				elseif f.value == 3 then
					audio.play_sound_from_coord(-1, "Event_Start_Text", player.get_player_coords(pid), "GTAO_FM_Events_Soundset", true, 1, false)
				elseif f.value == 4 then
					audio.play_sound_from_coord(-1, "Checkpoint_Hit", player.get_player_coords(pid), "GTAO_FM_Events_Soundset", true, 1, false)
				elseif f.value == 5 then
					audio.play_sound_from_coord(-1, "Return_To_Vehicle_Timer", player.get_player_coords(pid), "GTAO_FM_Events_Soundset", true, 1, false)
				elseif f.value == 6 then
					audio.play_sound_from_coord(-1, "5s", player.get_player_coords(pid), "MP_MISSION_COUNTDOWN_SOUNDSET", true, 1, false)
				elseif f.value == 7 then
					audio.play_sound_from_coord(-1, "10s", player.get_player_coords(pid), "MP_MISSION_COUNTDOWN_SOUNDSET", true, 1, false)
				end
			end
			system.wait(0)
		end
		menu.notify("Sound Spam Crash executed successfully.", Meteor)
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end
end):set_str_data({
	"1 v1",
	"1 v2",
	"1 v3",
	"1 v4",
	"1 v5",
	"1 v6",
	"2 v1",
	"2 v2"
})

menu.add_player_feature("» Crash - Bad Vehicle Modification", "action", playerparents["» More Crashes"], function(f, pid)
    if player.is_player_valid(pid) then
		if network.get_player_player_is_spectating(player.player_id()) == pid or utilities.get_distance_between(player.get_player_ped(player.player_id()), player.get_player_ped(pid)) < 100 then
			utilities.request_model(1492612435)
			utilities.request_model(3517794615)
			utilities.request_model(3889340782)
			utilities.request_model(3253274834)
			local vehicle_1 = vehicle.create_vehicle(1492612435, player.get_player_coords(pid), math.random(0, 360), true, false)
			local vehicle_2 = vehicle.create_vehicle(3517794615, player.get_player_coords(pid), math.random(0, 360), true, false)
			local vehicle_3 = vehicle.create_vehicle(3889340782, player.get_player_coords(pid), math.random(0, 360), true, false)
			local vehicle_4 = vehicle.create_vehicle(3253274834, player.get_player_coords(pid), math.random(0, 360), true, false)
			network.request_control_of_entity(vehicle_1)
			network.request_control_of_entity(vehicle_2)
			network.request_control_of_entity(vehicle_3)
			network.request_control_of_entity(vehicle_4)
			vehicle.set_vehicle_mod_kit_type(vehicle_1, 0)
			vehicle.set_vehicle_mod_kit_type(vehicle_2, 0)
			vehicle.set_vehicle_mod_kit_type(vehicle_3, 0)
			vehicle.set_vehicle_mod_kit_type(vehicle_4, 0)
			for i = 0, 49 do
				local mod = vehicle.get_num_vehicle_mods(vehicle_1, i) - 1
				vehicle.set_vehicle_mod(vehicle_1, i, mod, true)
				vehicle.toggle_vehicle_mod(vehicle_1, mod, true)
				local mod = vehicle.get_num_vehicle_mods(vehicle_2, i) - 1
				vehicle.set_vehicle_mod(vehicle_2, i, mod, true)
				vehicle.toggle_vehicle_mod(vehicle_2, mod, true)
				local mod = vehicle.get_num_vehicle_mods(vehicle_3, i) - 1
				vehicle.set_vehicle_mod(vehicle_3, i, mod, true)
				vehicle.toggle_vehicle_mod(vehicle_3, mod, true)
				local mod = vehicle.get_num_vehicle_mods(vehicle_4, i) - 1
				vehicle.set_vehicle_mod(vehicle_4, i, mod, true)
				vehicle.toggle_vehicle_mod(vehicle_4, mod, true)
			end
			for j = 0, 20 do
				if vehicle.does_extra_exist(vehicle_1, j) then
					vehicle.set_vehicle_extra(vehicle_1, j, true)
				end
				if vehicle.does_extra_exist(vehicle_2, j) then
					vehicle.set_vehicle_extra(vehicle_2, j, true)
				end
				if vehicle.does_extra_exist(vehicle_3, j) then
					vehicle.set_vehicle_extra(vehicle_3, j, true)
				end
				if vehicle.does_extra_exist(vehicle_4, j) then
					vehicle.set_vehicle_extra(vehicle_4, j, true)
				end
			end
			vehicle.set_vehicle_bulletproof_tires(vehicle_1, true)
			vehicle.set_vehicle_bulletproof_tires(vehicle_2, true)
			vehicle.set_vehicle_bulletproof_tires(vehicle_3, true)
			vehicle.set_vehicle_bulletproof_tires(vehicle_4, true)
			vehicle.set_vehicle_window_tint(vehicle_1, 1)
			vehicle.set_vehicle_window_tint(vehicle_2, 1)
			vehicle.set_vehicle_window_tint(vehicle_3, 1)
			vehicle.set_vehicle_window_tint(vehicle_4, 1)
			vehicle.set_vehicle_number_plate_index(vehicle_1, 1)
			vehicle.set_vehicle_number_plate_index(vehicle_2, 1)
			vehicle.set_vehicle_number_plate_index(vehicle_3, 1)
			vehicle.set_vehicle_number_plate_index(vehicle_4, 1)
			vehicle.set_vehicle_number_plate_text(vehicle_1, " ")
			vehicle.set_vehicle_number_plate_text(vehicle_2, " ")
			vehicle.set_vehicle_number_plate_text(vehicle_3, " ")
			vehicle.set_vehicle_number_plate_text(vehicle_4, " ")
			local time = utils.time_ms() + 500
			while time > utils.time_ms() do
				system.yield(0)
				network.request_control_of_entity(vehicle_1)
				network.request_control_of_entity(vehicle_2)
				network.request_control_of_entity(vehicle_3)
				network.request_control_of_entity(vehicle_4)
				entity.set_entity_coords_no_offset(vehicle_1, player.get_player_coords(pid))
				entity.set_entity_coords_no_offset(vehicle_2, player.get_player_coords(pid))
				entity.set_entity_coords_no_offset(vehicle_3, player.get_player_coords(pid))
				entity.set_entity_coords_no_offset(vehicle_4, player.get_player_coords(pid))
			end
			system.wait(4000)
			utilities.request_control_silent(vehicle_1)
			utilities.request_control_silent(vehicle_2)
			utilities.request_control_silent(vehicle_3)
			utilities.request_control_silent(vehicle_4)
			utilities.hard_remove_entity(vehicle_1)
			utilities.hard_remove_entity(vehicle_2)
			utilities.hard_remove_entity(vehicle_3)
			utilities.hard_remove_entity(vehicle_4)
			menu.notify("Bad Vehicle Modification Crash executed successfully.", Meteor)
		else
			menu.notify("You have to spectate the target or be near them in order for this feature to work.", Meteor, 5, 211)
		end
    else
        menu.notify("Invalid Player.", Meteor, 3, 211)
    end
end)

menu.add_player_feature("» Crash - Bad Sync Tree", "action", playerparents["» More Crashes"], function(f, pid)
	if player.is_player_valid(pid) then
		utilities.request_model(1352295901)
		local sync_tree_children_hashes = {849958566, -568220328, 2155335200, 1272323782, 1296557055, 29828513, 2250084685, 2349112599, 1599985244, 3523942264, 3457195100, 3762929870, 1016189997, 861098586, 3613262246, 3245733464, 2494305715, 671173206, 3769155529, 978689073, 100436592, 3107991431, 1327834842, 1239708330}
		local sync_tree_children = {}
		local main_sync_handler = object.create_world_object(1352295901, player.get_player_coords(pid) + v3(300, 300, 300), true, false)
		network.request_control_of_entity(main_sync_handler)
		for i = 1, #sync_tree_children_hashes do
			utilities.request_model(sync_tree_children_hashes[i])
			sync_tree_children[i] = object.create_world_object(sync_tree_children_hashes[i], player.get_player_coords(pid) + v3(300, 300, 300), true, false)
			network.request_control_of_entity(sync_tree_children[i])
			entity.attach_entity_to_entity(sync_tree_children[i], main_sync_handler, 0, v3(0, 0, 0), v3(0, 0, 0), true, true, false, 0, false)
		end
		local time = utils.time_ms() + 2000
		while time > utils.time_ms() do
			system.yield(math.random(0, 10))
			entity.set_entity_coords_no_offset(main_sync_handler, v3(player.get_player_coords(pid).x + math.random(-1, 1), player.get_player_coords(pid).y + math.random(-1, 1), player.get_player_coords(pid).z + math.random(-1, 1)))
		end
		network.request_control_of_entity(main_sync_handler)
		utilities.hard_remove_entity(main_sync_handler)
		for i = 1, #sync_tree_children do
			if entity.is_an_entity(sync_tree_children[i]) then
				utilities.request_control_silent(sync_tree_children[i])
				utilities.hard_remove_entity(sync_tree_children[i])
			end
		end
		menu.notify("Bad Sync Tree Crash executed successfully.", Meteor)
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end
end)


bad_para_crash = menu.add_player_feature("» Rope Crash", "action", playerparents["» More Crashes"], function(f, pid)
pos = player.get_player_coords(pid)
pos.x = pos.x + 2
newRope = rope.add_rope(pos,v3(0,0,10),1,1,0,1,1,false,false,false,1.0,false)
pos = player.get_player_coords(pid)
car = spawn_vehicle(0X187D938D,pos,0)
end)

aio_crash = menu.add_player_feature("» AIO-Crash", "action", playerparents["» More Crashes"], function(f, pid)
mypos = player.get_player_coords(player.player_id())
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy, v3(0,0,4000))
entity.freeze_entity(pedmy, true)
for i = 0 ,1 do
fakecrash(pid)
poolcrashplayer(pid)
invalidmodelcrashplayer(pid)
soundcrashplayer(pid)
attachcrashplayer(pid)
secrashplayer(pid)
end
entity.set_entity_coords_no_offset(pedmy, mypos)
entity.freeze_entity(pedmy, false)
end)

bad_para_crash = menu.add_player_feature("» Virgin Crash", "action", playerparents["» More Crashes"], function(f, pid)
pos = player.get_player_coords(pid)
cargobob = spawn_vehicle(0XFCFCB68B,pos,0)
vehicle = spawn_vehicle(0X187D938D,pos,0)
newRope = rope.add_rope(pos,v3(0,0,10),1,1,0,1,1,false,false,false,1.0,false)
rope.attach_entities_to_rope(newRope,cargobob,vehicle,entity.get_entity_coords(cargobob),entity.get_entity_coords(vehicle),2 ,0,0,"Center","Center")
system.wait(100)
end)

menu.add_player_feature("» SE crash" , "action", playerparents["» More Crashes"], function(f, pid)
    script.trigger_script_event(-393294520, pid, {pid, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
    script.trigger_script_event(-1386010354, pid, {pid, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
    script.trigger_script_event(962740265, pid, {pid, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
end)

menu.add_player_feature("» Crash - Invalid Ped", "action_value_str", playerparents["» More Crashes"], function(f, pid)
	if player.is_player_valid(pid) then
		if f.value == 0 then
   		 	local ped_ = ped.create_ped(0, 1057201338, player.get_player_coords(pid), 0, true, false)
			system.wait(100)
   		 	entity.delete_entity(ped_)
		elseif f.value == 1 then
			local ped_ = ped.create_ped(0, -2056455422, player.get_player_coords(pid), 0, true, false)
			system.wait(100)
    		entity.delete_entity(ped_)
		elseif f.value == 2 then
			local ped_ = ped.create_ped(0, 762327283, player.get_player_coords(pid), 0, true, false)
			system.wait(100)
   		 	entity.delete_entity(ped_)
		end
		menu.notify("Invalid Ped Crash executed successfully.", Meteor)
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end
end):set_str_data({
	"v1",
	"v2",
	"v3"
})

menu.add_player_feature("» Final Crash (Pasta Crash)", "action", playerparents["» More Crashes"], function(f, pid)
	if player.is_player_valid(pid) then
  entity.freeze_entity(player.get_player_ped(pid), true)
  script.trigger_script_event(-2043109205, pid, {0, 0, 17302, 9822, 1999, 6777888, 111222})
  script.trigger_script_event(-2043109205, pid, {0, 0, 2327, 0, 0, 0, -307, 27777})
  script.trigger_script_event(-988842806, pid, {0, 0, 2327, 0, 0, 0, -307, 27777})
  script.trigger_script_event(-2043109205, pid, {0, 0, 27983, 7601, 1020, 3209051, 111222})
  script.trigger_script_event(-2043109205, pid, {0, 0, 1010, 0, 0, 0, -2653, 50555})
  script.trigger_script_event(-988842806, pid, {0, 0, 1111, 0, 0, 0, -5621, 57766})
  script.trigger_script_event(-988842806, pid, {0, 0, -3, -90, -123, -9856, -97652})
  script.trigger_script_event(-2043109205, pid, {0, 0, -3, -90, -123, -9856, -97652})
  script.trigger_script_event(-1881357102, pid, {0, 0, -3, -90, -123, -9856, -97652})
  script.trigger_script_event(-988842806, pid, {0, 0, 20547, 1058, 1245, 2721936, 666333})
  system.wait(100)
  script.trigger_script_event(-2043109205, pid, {0, 0, 20547, 1058, 1245, 2721936, 666333})
  script.trigger_script_event(-1881357102, pid, {0, 0, 20547, 1058, 1245, 2721936, 666333})
  script.trigger_script_event(153488394, pid, {0, 868904806, 0, 0, -152, -123, -978, 0, 0, 1, 0, -167, -144})
  script.trigger_script_event(153488394, pid, {0, 868904806, 0, 0, 152, 123, 978, 0, 0, 1, 0, 167, 144})
  script.trigger_script_event(1249026189, pid, {0, 0, 97587, 5697, 3211, 8237539, 967853})
  script.trigger_script_event(1033875141, pid, {0, 0, 0, 1967})
  script.trigger_script_event(1033875141, pid, {0, 0, -123, -957, -14, -1908, -123})
  script.trigger_script_event(1033875141, pid, {0, 0, 12121, 9756, 7609, 1111111, 789666})
  script.trigger_script_event(315658550, pid, {0, 0, 87111, 5782, 9999, 3333333, 888888})
  script.trigger_script_event(-877212109, pid, {0, 0, 87111, 5782, 9999, 3333333, 888888})
  script.trigger_script_event(1926582096, pid, {0, -1, -1, -1, 18899, 1011, 3070})
  script.trigger_script_event(1926582096, pid, {0, -4640169, 0, 0, 0, -36565476, -53105203})
  script.trigger_script_event(1033875141, pid, {-17645264, -26800537, -66094971, -45281983, -24450684, -13000488,
                                                59643555, 34295654, 91870118, -3283691})
  script.trigger_script_event(-988842806, pid, {0, 0, 93})
  system.wait(100)
  script.trigger_script_event(-2043109205, pid, {0, 0, 37, 0, -7})
  script.trigger_script_event(-1881357102, pid, {0, 0, -13, 0, 0, 0, 23})
  script.trigger_script_event(153488394, pid, {0, 868904806, 0, 0, 7, 7, 19, 0, 0, 1, 0, -23, -27})
  script.trigger_script_event(1249026189, pid, {})
  script.trigger_script_event(315658550, pid, {})
  script.trigger_script_event(-877212109, pid, {})
  script.trigger_script_event(1033875141, pid, {0, 0, 0, 82})
  script.trigger_script_event(1926582096, pid, {})
  script.trigger_script_event(-977515445, pid, {26770, 95398, 98426, -24591, 47901, -64814})
  script.trigger_script_event(-1949011582, pid, {pid, -1139568479, math.random(0, 4), math.random(0, 1)})
  system.wait(100)
  script.trigger_script_event(-2043109205, pid, {0, 0, 3333, 0, 0, 0, -987, 21369})
  script.trigger_script_event(-988842806, pid, {0, 0, 2222, 0, 0, 0, -109, 73322})
  script.trigger_script_event(-977515445, pid, {26770, 95398, 98426, -24591, 47901, -64814})
  script.trigger_script_event(-1949011582, pid, {pid, -1139568479, math.random(0, 4), math.random(0, 1)})
  script.trigger_script_event(-1730227041, pid, {-494, 1526, 60541, -12988, -99097, -32105})

  local my_ped = player.get_player_ped(player.player_id())
  pos = v3(10841.274, -6928.6284, 1.0732422)

  entity.set_entity_coords_no_offset(my_ped, pos)

		menu.notify("» Final Crash (Pasta Crash) executed successfully.")
	else
		menu.notify("Invalid Player.")
	end
end)

playerparents["» Kicks"] = menu.add_player_feature("» Kicks", "parent", playerparents["» Crashes And Kicks"]).id

menu.add_player_feature("» Kick - Phantom X", "action", playerparents["» Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		script.trigger_script_event(1189947075, pid, {player.player_id(), 1204112514})
		menu.notify("Phantom X Kick executed successfully.", Meteor)
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Kick - Stand Non Host", "action", playerparents["» Kicks"], function(f, pid)
    if player.is_player_valid(pid) then
		script.trigger_script_event(-371781708, pid, {player.player_id(), pid, pid, 1403904671})
		script.trigger_script_event(-317318371, pid, {player.player_id(), pid, pid, 1993236673})
		script.trigger_script_event(911179316, pid, {player.player_id(), pid, pid, pid, 1234567990, pid, pid})
		script.trigger_script_event(846342319, pid, {player.player_id(), 578162304, 1})
		script.trigger_script_event(-2085853000, pid, {player.player_id(), pid, 1610781286, pid, pid})
		script.trigger_script_event(-1991317864, pid, {player.player_id(), 3, 935764694, pid, pid})
		script.trigger_script_event(-1970125962, pid, {player.player_id(), pid, 1171952288})
		script.trigger_script_event(-1013679841, pid, {player.player_id(), pid, 2135167326, pid})
		script.trigger_script_event(-1767058336, pid, {player.player_id(), 1459620687})
		script.trigger_script_event(-1892343528, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647)})
		script.trigger_script_event(1494472464, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647)})
		script.trigger_script_event(69874647, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647)})
		script.trigger_script_event(998716537, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647)})
		script.trigger_script_event(522189882, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647)})
		script.trigger_script_event(1514515570, pid, {player.player_id(), pid, 2147483647})
		script.trigger_script_event(296518236, pid, {player.player_id(), pid, pid, pid, 1})
		script.trigger_script_event(-1782442696, pid, {player.player_id(), 420, 69})
		for i = 1, 5 do
			script.trigger_script_event(-1782442696, pid, {player.player_id(), math.random(-2147483647, 2147483647), 0})
		end
		script.trigger_script_event(924535804, pid, {player.player_id(), math.random(-2147483647, 2147483647), 0})
		script.trigger_script_event(436475575, pid, {player.player_id(), math.random(-2147483647, 2147483647), 0})
        menu.notify("Stand Non Host Kick executed successfully.", Meteor)
    else
        menu.notify("Invalid Player.", Meteor, 3, 211)
    end
end)

menu.add_player_feature("» Kick - Ped Component 2 Desync", "action", playerparents["» Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		if network.get_player_player_is_spectating(player.player_id()) == pid or utilities.get_distance_between(player.get_player_ped(player.player_id()), player.get_player_ped(pid)) < 100 then
			utilities.request_model(0x705E61F2)
			local ped_ = ped.create_ped(1, 0x705E61F2, player.get_player_coords(pid), 0, true, false)
			network.request_control_of_entity(ped_)
			ped.set_ped_ragdoll_blocking_flags(ped_, 1)
			ped.set_ped_combat_ability(ped_, 2)
			ped.set_ped_combat_attributes(ped_, 5, true)
			ped.set_ped_component_variation(ped_, 0, 0, 0, 39, 0)
			ped.set_ped_component_variation(ped_, 1, 104, 25, -1, 0)
			ped.set_ped_component_variation(ped_, 2, 49, 0, -1, 0)
			ped.set_ped_component_variation(ped_, 3, 33, 0, 0)
			ped.set_ped_component_variation(ped_, 4, 84, 0, 0)
			ped.set_ped_component_variation(ped_, 5, 82, 0, 0)
			ped.set_ped_component_variation(ped_, 6, 33, 0, 0)
			ped.set_ped_component_variation(ped_, 7, 0, 0, 0)
			ped.set_ped_component_variation(ped_, 8, 97, 0, 0)
			ped.set_ped_component_variation(ped_, 9, 0, 0, 0)
			ped.set_ped_component_variation(ped_, 10, 0, 0, 0)
			ped.set_ped_component_variation(ped_, 11, 186, 0, 0)
			ped.set_ped_prop_index(ped_, 0, 39, 0)
			ped.set_ped_prop_index(ped_, 1, -1, 0)
			ped.set_ped_prop_index(ped_, 2, -1, 0)
			ped.set_ped_head_blend_data(ped_, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			system.wait(3000)
			script.trigger_script_event(-227800145, pid, {pid, math.random(32, 23647483647), math.random(-23647, 212347), 1, 115, math.random(-2321647, 21182412647), math.random(-2147483647, 2147483647), 26249, math.random(-1257483647, 23683647), 2623, 25136})
			utilities.request_control_silent(ped_)
			entity.delete_entity(ped_)
			menu.notify("Ped Component 2 Desync executed successfully.", Meteor)
		else
			menu.notify("You have to spectate the target or be near them in order for this feature to work.", Meteor, 5, 211)
		end
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Kick - Network Bail", "action_value_str", playerparents["» Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		if f.value == 0 then
			script.trigger_script_event(1228916411, pid, {player.player_id(), script_func.get_global_main(pid)})
		elseif f.value == 1 then
			script.trigger_script_event(0x493fc6bb, pid, {player.player_id(), script_func.get_global_main(pid)})
		elseif f.value == 2 then
			script.trigger_script_event(163598572, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), pid})
		elseif f.value == 3 then
			script.trigger_script_event(0x09c050ec, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), pid})
		end
		menu.notify("Network Bail Kick executed successfully.", Meteor)
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end
end):set_str_data({
	"v1",
	"v2",
	"v3",
	"v4"
})

menu.add_player_feature("» Kick - Invalid Apartment Invite", "action_value_str", playerparents["» Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		if f.value == 0 then
			script.trigger_script_event(0x23F74138, pid, {player.player_id(), math.random(32, 2147483647), math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		elseif f.value == 1 then
			script.trigger_script_event(0x23F74138, pid, {player.player_id(), math.random(-2147483647, -1), math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		end
		menu.notify("Invalid Apartment Invite Kick executed successfully.", Meteor)
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end
end):set_str_data({
	"v1",
	"v2"
})

menu.add_player_feature("» Kick - Script Event", "action_value_str", playerparents["» Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		if f.value == 0 then
			script.trigger_script_event(0x493FC6BB, pid, {player.player_id(), script_func.get_global_main(pid), pid})
		elseif f.value == 1 then
			script.trigger_script_event(0x37437C28, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		elseif f.value == 2 then
			script.trigger_script_event(-1308840134, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		elseif f.value == 3 then
			script.trigger_script_event(0x4E0350C6, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		elseif f.value == 4 then
			script.trigger_script_event(-0x15F5B1D4, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		elseif f.value == 5 then
			script.trigger_script_event(-0x249FE11B, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		elseif f.value == 6 then
			script.trigger_script_event(-0x76B11968, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		elseif f.value == 7 then
			script.trigger_script_event(0x493FC6BB, pid, {player.player_id(), script_func.get_global_main(pid)})
		elseif f.value == 8 then
			script.trigger_script_event(0x23F74138, pid, {player.player_id(), math.random(32, 2147483647), math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		elseif f.value == 9 then
			script.trigger_script_event(1757755807, pid, {player.player_id(), math.random(-2147483647, 2147483647), pid})
		elseif f.value == 10 then
			script.trigger_script_event(-1991317864, pid, {player.player_id(), -1, -1, -1, -1})
		elseif f.value == 11 then
			script.trigger_script_event(-614457627, pid, {player.player_id(), math.random(-2147483647, -10), math.random(-2147483647, -10), math.random(-2147483647, -10), math.random(-2147483647, -10), math.random(-2147483647, -10), math.random(-2147483647, -10), math.random(-2147483647, -10), math.random(-2147483647, -10), math.random(-2147483647, -10), math.random(-2147483647, -10), math.random(-2147483647, -10), math.random(-2147483647, -10), math.random(-2147483647, -10), math.random(-2147483647, -10), math.random(-2147483647, -10), math.random(-2147483647, -10), math.random(-2147483647, -10), math.random(-2147483647, -10), math.random(-2147483647, -10), math.random(-2147483647, -10), math.random(-2147483647, -10), math.random(-2147483647, -10)})
		elseif f.value == 12 then
			script.trigger_script_event(-569621836, pid, {player.player_id(), 13644241, 505873})
		elseif f.value == 13 then
			script.trigger_script_event(-227800145, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), 2361235669, math.random(-2147483647, 2147483647), 263261, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), 215132521, 5262462321, math.random(-2147483647, 2147483647), pid})
		end
		menu.notify("Script Event Kick executed successfully.", Meteor)
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end
end):set_str_data({
	"v1",
	"v2",
	"v3",
	"v4",
	"v5",
	"v6",
	"v7",
	"v8",
	"v9",
	"v10",
	"v11",
	"v12"
})

menu.add_player_feature("» Kick - Jumper", "action_value_str", playerparents["» Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		if f.value == 0 then
			script.trigger_script_event(-227800145, pid, {player.player_id(), math.random(32, 23647483647), math.random(-23647, 212347), 1, 115, math.random(-2321647, 21182412647), math.random(-2147483647, 2147483647), 26249, math.random(-1257483647, 23683647), 2623, 25136})
		elseif f.value == 1 then
			script.trigger_script_event(69874647, pid, {player.player_id(), math.random(32, 23647483647), math.random(-23647, 212347), 1, 115, math.random(-2321647, 21182412647), math.random(-2147483647, 2147483647), 26249, math.random(-1257483647, 23683647), 2623, 25136})
		end
		menu.notify("Jumper Kick executed successfully.", Meteor)
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end
end):set_str_data({
	"v1",
	"v2"
})

menu.add_player_feature("» Kick - Freemode Death", "action", playerparents["» Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		local freemode_death_kick_se = {-1056683619, 1757755807, 1258808115, -786546101, 1836137561, 705077142, 285955867, 1498409190, 894434968, 844746317, 330288802, 581037897, 1189947075, 227800145, 737858645, 27382701, 436475575, -1767058336 , 927169576, -225522261, 1481806247, -1892343528, 1494472464, 911179316, -2085853000, 778594779, 924535804, -569621836, -317318371, -68354216, -1970125962, 704979198, 998716537, -1501164935, 163598572, 990606644, 1116398805, 296518236, -1782442696, -371781708, -1013679841, 1560273502, 69874647, 1514515570, 1228916411, -399817245, -1208585385, 2002459655, -1872092614, 1902624891, -1308840134, -903578754, -145306724, 1258808115, -1715193475, -368423380, -1991317864, -65587051, 1445703181, 846342319, 677240627}
		script.trigger_script_event(911179316, pid, {player.player_id(), pid, pid, pid, math.random(-2147483647, 2147483647), pid})
		system.wait(1)
		script.trigger_script_event(-65587051, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), pid})
		system.wait(1)
		script.trigger_script_event(1116398805, pid, {player.player_id(), pid, math.random(-2147483647, 2147483647), pid})
		system.wait(1)
		script.trigger_script_event(-2113023004, pid, {-1, -1, 0, 0, -20, 1000})
		system.wait(1)
		script.trigger_script_event(-1846290480, pid, {player.player_id(), pid, 25, 0, 1242, pid})
		system.wait(1)
		for i = 1, #freemode_death_kick_se do
			script.trigger_script_event(freemode_death_kick_se[i], pid, {player.player_id(), -1, -1})
			system.wait(1)
		end
		menu.notify("Freemode Death Kick executed successfully.", Meteor)
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Kick - Smart Kick", "action", playerparents["» Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		if network.network_is_host() then
			network.network_session_kick_player(pid)
		elseif player.is_player_host(pid) and player.is_player_modder(pid, -1) then
			script_func.script_event_kick(pid)
		else
			network.force_remove_player(pid)
		end
		menu.notify("Smart Kick executed successfully.", Meteor)
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end	
end)

menu.add_player_feature("» Kick - Host Kick", "action", playerparents["» Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		if network.network_is_host() then
			network.network_session_kick_player(pid)
			menu.notify("Host Kick executed successfully.", Meteor)
		else
			menu.notify("You have to be Host in order to use this feature.", Meteor, 3, 211)
		end
	else
		menu.notify("Invalid Player.", Meteor, 3, 211)
	end	
end)

if utils.file_exists(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorDev\\MeteorDev.lua") then
	meteordevplayercrashes = menu.add_player_feature("» Dev Crashes And Kicks", "parent", playerparents["» Crashes And Kicks"]).id
end

menu.add_player_feature("» Copy IP", "action", playerparents["» Modder Info"], function(f, pid)
	utils.to_clipboard(utilities.dec_to_ipv4(player.get_player_ip(pid)))
end)

menu.add_player_feature("» Copy ScId", "action", playerparents["» Modder Info"], function(f, pid)
	utils.to_clipboard(tostring(player.get_player_scid(pid)))
end)

menu.add_player_feature("» Copy Vehicle Hash", "action", playerparents["» Vehicle Options"], function(f, pid)
	utils.to_clipboard(tostring(entity.get_entity_model_hash(player.get_player_vehicle(pid))))
end)

menu.add_player_feature("» Copy Vehicle Brand", "action", playerparents["» Vehicle Options"], function(f, pid)
	local brand = vehicle.get_vehicle_brand(player.get_player_vehicle(pid)) or ""
	if brand ~= "" then
		brand = brand.." "
	end
	utils.to_clipboard(brand..tostring(vehicle.get_vehicle_model(player.get_player_vehicle(pid))))
end)

menu.add_player_feature("» Mark Player As Modder", "action_value_str", playerparents["» Modder Info"], function(f, pid)
	if f.value == 0 then
		player.set_player_as_modder(pid, -1)
		InvalidSCIDDetectionPlayer[pid] = true
		ModdedHealthDetectionPlayer[pid] = true
		GodmodeDetectionPlayer[pid] = true
		InvalidNameDetectionPlayer[pid] = true
		InvalidIPDetectionPlayer[pid] = true
		StandUserDetectionPlayer[pid] = true
		MaxSpeedBypassDetectionPlayer[pid] = true
		InvalidStatsDetectionPlayer[pid] = true
		SessionHostCrashDetectionPlayer[pid] = true
		BadOutfitDataDetectionPlayer[pid] = true
		FakeTypingIndicatorDetectionPlayer[pid] = true
		ModdedSpectateDetectionPlayer[pid] = true
		ModdedOTRDetectionPlayer[pid] = true
		BadParachuteModelDetectionPlayer[pid] = true
		InvalidMovementDetectionPlayer[pid] = true
		InvalidEntitySpawnDetectionPlayer[pid] = true
		NoRagdollDetectionPlayer[pid] = true
		SuperRunDetectionPlayer[pid] = true
		LobbySpoofDetectionPlayer[pid] = true
	else
		player.set_player_as_modder(pid, 1 << f.value - 1)
	end
end):set_str_data(DataMain.all_modder_flags_table)

menu.add_player_feature("» Unmark Player As Modder", "action_value_str", playerparents["» Modder Info"], function(f, pid)
	if f.value == 0 then
		player.unset_player_as_modder(pid, -1)
		InvalidSCIDDetectionPlayer[pid] = false
		ModdedHealthDetectionPlayer[pid] = false
		GodmodeDetectionPlayer[pid] = false
		InvalidNameDetectionPlayer[pid] = false
		InvalidIPDetectionPlayer[pid] = false
		StandUserDetectionPlayer[pid] = false
		MaxSpeedBypassDetectionPlayer[pid] = false
		InvalidStatsDetectionPlayer[pid] = false
		SessionHostCrashDetectionPlayer[pid] = false
		BadOutfitDataDetectionPlayer[pid] = false
		FakeTypingIndicatorDetectionPlayer[pid] = false
		ModdedSpectateDetectionPlayer[pid] = false
		ModdedOTRDetectionPlayer[pid] = false
		BadParachuteModelDetectionPlayer[pid] = false
		InvalidMovementDetectionPlayer[pid] = false
		InvalidEntitySpawnDetectionPlayer[pid] = false
		NoRagdollDetectionPlayer[pid] = false
		SuperRunDetectionPlayer[pid] = false
		LobbySpoofDetectionPlayer[pid] = false
	else
		player.unset_player_as_modder(pid, 1 << f.value - 1)
	end
end):set_str_data(DataMain.all_modder_flags_table)

menu.add_player_feature("» Modder Flag Notify", "action_value_str", playerparents["» Modder Info"], function(f, pid)
	if f.value == 0 then
		for i = 0, 75 do
			if player.get_modder_flag_text(1 << i) ~= "" then
				menu.notify("Player: " .. tostring(player.get_player_name(pid)) .. "\nReason: " .. player.get_modder_flag_text(1 << i), "Modder Detection", 12, 0x00A2FF)
			end
		end
	else
		menu.notify("Player: " .. tostring(player.get_player_name(pid)) .. "\nReason: " .. player.get_modder_flag_text(1 << f.value - 1), "Modder Detection", 12, 0x00A2FF)
	end
end):set_str_data(DataMain.all_modder_flags_table)

menu.add_player_feature("» Log Script Events", "toggle", playerparents["» Modder Info"], function(f, pid)
	if f.on then
		if player.is_player_valid(pid) then
			local new_player_log_file = "" .. os.time() .. "r" .. math.random(1, 10000) .. " - " .. player.get_player_scid(pid) .. " - " .. tostring(player.get_player_name(pid)) .. ""
			text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Logs\\ScriptEvents\\", "") .. "\\" .. new_player_log_file .. ".log", "a"), "")
			if eventhooks["» Log Script Events " .. pid] == nil then
				eventhooks["» Log Script Events " .. pid] = hook.register_script_event_hook(function(source, target, params, count)
					if source == pid then
						for i = 1, #params do
							params[i] = params[i] & 0xFFFFFFFF
						end
						local params_string = ""
						local os_year = os.date("*t").year
						if os_year < 10 then
							os_year = "0" .. os_year .. ""
						end
						local os_month = os.date("*t").month
						if os_month < 10 then
							os_month = "0" .. os_month .. ""
						end
						local os_day = os.date("*t").day
						if os_day < 10 then
							os_day = "0" .. os_day .. ""
						end
						local os_hour = os.date("*t").hour
						if os_hour < 10 then
							os_hour = "0" .. os_hour .. ""
						end
						local os_min = os.date("*t").min
						if os_min < 10 then
							os_min = "0" .. os_min .. ""
						end
						local os_sec = os.date("*t").sec
						if os_sec < 10 then
							os_sec = "0" .. os_sec .. ""
						end
						local time_prefix = "" .. os_year .. "-" .. os_month .. "-" .. os_day .. " " .. os_hour .. ":" .. os_min .. ":" .. os_sec .. ""
						for i = 1, #params do
							if params[i] ~= nil then
								local param_real = i - 1
								if param_real < 10 then
									param_real = "0" .. param_real .. ""
								end
								params_string = params_string .. "[" .. time_prefix .. "] p[" .. param_real .. "]: 0x" .. string.format("%0x", params[i]) .. " " .. params[i] .. "\n"
							end
						end
						text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Logs\\ScriptEvents\\", "") .. "\\" .. new_player_log_file .. ".log", "a"), "[" .. time_prefix .. "] Script event by player " .. tostring(player.get_player_name(source)) .. " " .. player.get_player_scid(source) .. " / " .. player.get_player_scid(source) .. "\n" .. params_string)
					end
				end)
			end
		end
	end
	if not f.on then
		if eventhooks["» Log Script Events " .. pid] then
			hook.remove_script_event_hook(eventhooks["» Log Script Events " .. pid])
			eventhooks["» Log Script Events " .. pid] = nil
		end
	end
end)

menu.add_player_feature("» Log Net Events", "toggle", playerparents["» Modder Info"], function(f, pid)
	if f.on then
		if player.is_player_valid(pid) then
			local new_player_log_file = "" .. os.time() .. "r" .. math.random(1, 10000) .. " - " .. player.get_player_scid(pid) .. " - " .. tostring(player.get_player_name(pid)) .. ""
			text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\MeteorConfig\\NetEvents\\", "") .. "\\" .. new_player_log_file .. ".log", "a"), "")
			if eventhooks["» Log Net Events " .. pid] == nil then
				eventhooks["» Log Net Events " .. pid] = hook.register_net_event_hook(function(source, target, eventId)
					if source == pid then


						local params_string = ""
						local os_year = os.date("*t").year
						if os_year < 10 then
							os_year = "0" .. os_year .. ""
						end
						local os_month = os.date("*t").month
						if os_month < 10 then
							os_month = "0" .. os_month .. ""
						end
						local os_day = os.date("*t").day
						if os_day < 10 then
							os_day = "0" .. os_day .. ""
						end
						local os_hour = os.date("*t").hour
						if os_hour < 10 then
							os_hour = "0" .. os_hour .. ""
						end
						local os_min = os.date("*t").min
						if os_min < 10 then
							os_min = "0" .. os_min .. ""
						end
						local os_sec = os.date("*t").sec
						if os_sec < 10 then
							os_sec = "0" .. os_sec .. ""
						end
						local time_prefix = "" .. os_year .. "-" .. os_month .. "-" .. os_day .. " " .. os_hour .. ":" .. os_min .. ":" .. os_sec .. ""
						text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Logs\\NetEvents\\", "") .. "\\" .. new_player_log_file .. ".log", "a"), "[" .. time_prefix .. "] Net event " .. eventId .. " by player " .. tostring(player.get_player_name(source)) .. " " .. player.get_player_scid(source) .. " / " .. player.get_player_scid(source) .. "\n")
					end
				end)
			end
		end
	end
	if not f.on then
		if eventhooks["» Log Net Events " .. pid] then
			hook.remove_net_event_hook(eventhooks["» Log Net Events " .. pid])
			eventhooks["» Log Net Events " .. pid] = nil
		end
	end
end)

menu.add_player_feature("» IP Info", "action", playerparents["» Modder Info"], function(f, pid)
	if player.is_player_valid(pid) then
		local success, webdata = web.get("https://proxycheck.io/v2/" .. utilities.dec_to_ipv4(player.get_player_ip(pid)) .. "?vpn=1&asn=1")
		if string.find(webdata, "ok") then
			local ip_real = utilities.dec_to_ipv4(player.get_player_ip(pid))
			local provider_real = webdata:match("\"provider\":%s*\"([^\"]+)\",")
			local continent_real = webdata:match("\"continent\":%s*\"([^\"]+)\",")
			local country_real = webdata:match("\"country\":%s*\"([^\"]+)\",")
			local region_real = webdata:match("\"region\":%s*\"([^\"]+)\",")
			local city_real = webdata:match("\"city\":%s*\"([^\"]+)\",")
			local proxy_real = webdata:match("\"proxy\":%s*\"([^\"]+)\",")
			local type_real = webdata:match("\"type\":%s*\"([^\"]+)\"")
			local ping_real = text_func.round_three_dc(natives.NETWORK_GET_AVERAGE_LATENCY_FOR_PLAYER(pid):__tonumber())
			menu.notify("IP: " .. tostring(ip_real) .. "\nProvider: " .. tostring(provider_real) .. "\nContinent: " .. tostring(continent_real) .. "\nCountry: " .. tostring(country_real) .. "\nRegion: " .. tostring(region_real) .. "\nCity: " .. tostring(city_real) .. "\nProxy: " .. tostring(proxy_real) .. "\nType: " .. tostring(type_real) .. "\nPing: " .. tostring(ping_real) .. "", "Player IP Info", 24, 0x00ff00)
		elseif string.find(webdata, "error") then
			menu.notify("Invalid IP Address!\n" .. utilities.dec_to_ipv4(player.get_player_ip(pid)), "Player IP Info", 12, 0x00ff00)
		elseif string.find(webdata, "denied") then
			menu.notify("Nooo you reached the max api requests for today :(((((((((((((", Meteor, 4, 211)
		end
	end
end)

menu.add_player_feature("» Add To Spoofer Profiles", "action", playerparents["» Modder Info"], function(f, pid)
	if player.is_player_valid(pid) then
		local random_id = math.random(0, 9) .. math.random(0, 9) .. math.random(0, 9) .. math.random(0, 9) .. math.random(0, 9) .. math.random(0, 9) .. math.random(0, 9) .. math.random(0, 9) .. math.random(0, 9) .. math.random(0, 9)
		if utils.file_exists(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\spoofer", "") .. "\\" .. random_id .. ".ini") then
			menu.notify("Failed to add player to spoofer profiles, please try again.", Meteor, 3, 211)
		else
			text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\spoofer", "") .. "\\" .. random_id .. ".ini", "w"), "[Profile]\nname=" .. tostring(player.get_player_name(pid)) .. "\nscid=" .. player.get_player_scid(pid) .. "\nhost_token=" .. player.get_player_host_token(pid) .. "\nlevel=" .. script_func.get_player_rank(pid) .. "\nmoney_wallet=" .. script_func.get_player_wallet(pid) .. "\ndev=" .. natives.NETWORK_PLAYER_IS_ROCKSTAR_DEV(Playerplayer):__tointeger() .. "\nip=" .. player.get_player_ip(pid) .. "\nmoney_total=" .. script_func.get_player_money(pid) .. "\nkd=" .. script_func.get_player_kd(pid) .. "")
		end
		system.wait(100)
		if utils.file_exists(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\spoofer", "") .. "\\" .. random_id .. ".ini") then
			menu.notify("Successfully added player to spoofer profiles!", Meteor, 3, 0x00ff00)
		else
			menu.notify("Failed to add player to spoofer profiles, please try again.", Meteor, 3, 211)
		end
	end
end)

if listeners["Menu Unload"] == nil then
	listeners["Menu Unload"] = event.add_event_listener("exit", function()
		if settings["» Downgrade To Standard"].Enabled then
			for i = 1, #DataMain.all_vip_features do
				if menu.get_feature_by_hierarchy_key(DataMain.all_vip_features[i]) then
					menu.get_feature_by_hierarchy_key(DataMain.all_vip_features[i]).hidden = f.on
				end
			end
		end
		if ptfxs["» Dragon Breath"] then
			graphics.remove_particle_fx(ptfxs["» Dragon Breath"], true)
			ptfxs["» Dragon Breath"] = nil
		end
		if meteor_entities["» Dragon Breath"] then
			utilities.clear_ptfx(meteor_entities["» Dragon Breath"])
			meteor_entities["» Dragon Breath"] = nil
		end
		graphics.remove_named_ptfx_asset("weap_xs_vehicle_weapons")
		if ptfxs["» Fire Wings 1"] then
			graphics.remove_particle_fx(ptfxs["» Fire Wings 1"], true)
			ptfxs["» Fire Wings 1"] = nil
			utilities.clear_ptfx(meteor_entities["» Fire Wings 1"])
			meteor_entities["» Fire Wings 1"] = nil
		end
		if ptfxs["» Fire Wings 2"] then
			graphics.remove_particle_fx(ptfxs["» Fire Wings 2"], true)
			ptfxs["» Fire Wings 2"] = nil
			utilities.clear_ptfx(meteor_entities["» Fire Wings 2"])
			meteor_entities["» Fire Wings 2"] = nil
		end
		if ptfxs["» Fire Wings 3"] then
			graphics.remove_particle_fx(ptfxs["» Fire Wings 3"], true)
			ptfxs["» Fire Wings 3"] = nil
			utilities.clear_ptfx(meteor_entities["» Fire Wings 3"])
			meteor_entities["» Fire Wings 3"] = nil
		end
		if ptfxs["» Fire Wings 4"] then
			graphics.remove_particle_fx(ptfxs["» Fire Wings 4"], true)
			ptfxs["» Fire Wings 4"] = nil
			utilities.clear_ptfx(meteor_entities["» Fire Wings 4"])
			meteor_entities["» Fire Wings 4"] = nil
		end
		if ptfxs["» Fire Wings 5"] then
			graphics.remove_particle_fx(ptfxs["» Fire Wings 5"], true)
			ptfxs["» Fire Wings 5"] = nil
			utilities.clear_ptfx(meteor_entities["» Fire Wings 5"])
			meteor_entities["» Fire Wings 5"] = nil
		end
		if ptfxs["» Fire Wings 6"] then
			graphics.remove_particle_fx(ptfxs["» Fire Wings 6"], true)
			ptfxs["» Fire Wings 6"] = nil
			utilities.clear_ptfx(meteor_entities["» Fire Wings 6"])
			meteor_entities["» Fire Wings 6"] = nil
		end
		if ptfxs["» Fire Wings 7"] then
			graphics.remove_particle_fx(ptfxs["» Fire Wings 7"], true)
			ptfxs["» Fire Wings 7"] = nil
			utilities.clear_ptfx(meteor_entities["» Fire Wings 7"])
			meteor_entities["» Fire Wings 7"] = nil
		end
		if ptfxs["» Fire Wings 8"] then
			graphics.remove_particle_fx(ptfxs["» Fire Wings 8"], true)
			ptfxs["» Fire Wings 8"] = nil
			utilities.clear_ptfx(meteor_entities["» Fire Wings 8"])
			meteor_entities["» Fire Wings 8"] = nil
		end
		if threads["» Fire Wings 1"] then
			menu.delete_thread(threads["» Fire Wings 1"])
		end
		if threads["» Fire Wings 2"] then
			menu.delete_thread(threads["» Fire Wings 2"])
		end
		if threads["» Fire Wings 3"] then
			menu.delete_thread(threads["» Fire Wings 3"])
		end
		if threads["» Fire Wings 4"] then
			menu.delete_thread(threads["» Fire Wings 4"])
		end
		if threads["» Fire Wings 5"] then
			menu.delete_thread(threads["» Fire Wings 5"])
		end
		if threads["» Fire Wings 6"] then
			menu.delete_thread(threads["» Fire Wings 6"])
		end
		if threads["» Fire Wings 7"] then
			menu.delete_thread(threads["» Fire Wings 7"])
		end
		if threads["» Fire Wings 8"] then
			menu.delete_thread(threads["» Fire Wings 8"])
		end
		if ptfxs["» Make Area Foggy 1"] then
			utilities.clear_ptfx(meteor_entities["» Make Area Foggy 1"])
			meteor_entities["» Make Area Foggy 1"] = nil
			utilities.clear_ptfx(meteor_entities["» Make Area Foggy 2"])
			meteor_entities["» Make Area Foggy 2"] = nil
			utilities.clear_ptfx(meteor_entities["» Make Area Foggy 3"])
			meteor_entities["» Make Area Foggy 3"] = nil
			utilities.clear_ptfx(meteor_entities["» Make Area Foggy 4"])
			meteor_entities["» Make Area Foggy 4"] = nil
			utilities.clear_ptfx(meteor_entities["» Make Area Foggy 5"])
			meteor_entities["» Make Area Foggy 5"] = nil
			utilities.clear_ptfx(meteor_entities["» Make Area Foggy 6"])
			meteor_entities["» Make Area Foggy 6"] = nil
			ptfxs["» Make Area Foggy 1"] = nil
			ptfxs["» Make Area Foggy 2"] = nil
			ptfxs["» Make Area Foggy 3"] = nil
			ptfxs["» Make Area Foggy 4"] = nil
			ptfxs["» Make Area Foggy 5"] = nil
			ptfxs["» Make Area Foggy 6"] = nil
			graphics.remove_named_ptfx_asset("core")
		end
		if threads["» Altered Script Host Migration"] then
			menu.delete_thread(threads["» Altered Script Host Migration"])
		end
		if threads["» Bad World Data"] then
			menu.delete_thread(threads["» Bad World Data"])
		end
		if threads["» Script Execute"] then
			menu.delete_thread(threads["» Script Execute"])
		end
		graphics.remove_named_ptfx_asset("weap_xs_vehicle_weapons")
		if ptfxs["» Sparks 1"] then
			graphics.remove_particle_fx(ptfxs["» Sparks 1"], true)
			ptfxs["» Sparks 1"] = nil
			utilities.clear_ptfx(ptfxs["» Sparks 1"])
			ptfxs["» Sparks 1"] = nil
			graphics.remove_particle_fx(ptfxs["» Sparks 2"], true)
			ptfxs["» Sparks 2"] = nil
			utilities.clear_ptfx(ptfxs["» Sparks 2"])
			ptfxs["» Sparks 2"] = nil
			graphics.remove_particle_fx(meteor_entities["» Sparks 1"], true)
			meteor_entities["» Sparks 1"] = nil
			utilities.clear_ptfx(meteor_entities["» Sparks 1"])
			meteor_entities["» Sparks 1"] = nil
			graphics.remove_particle_fx(meteor_entities["» Sparks 2"], true)
			meteor_entities["» Sparks 2"] = nil
			utilities.clear_ptfx(meteor_entities["» Sparks 2"])
			meteor_entities["» Sparks 2"] = nil
			graphics.remove_named_ptfx_asset("scr_reconstructionaccident")
		end
		if ptfxs["» Flames 1"] then
			graphics.remove_particle_fx(ptfxs["» Flames 1"], true)
			ptfxs["» Flames 1"] = nil
			utilities.clear_ptfx(ptfxs["» Flames 1"])
			ptfxs["» Flames 1"] = nil
			graphics.remove_particle_fx(ptfxs["» Flames 2"], true)
			ptfxs["» Flames 2"] = nil
			utilities.clear_ptfx(ptfxs["» Flames 2"])
			ptfxs["» Flames 2"] = nil
			graphics.remove_particle_fx(meteor_entities["» Flames 1"], true)
			meteor_entities["» Flames 1"] = nil
			utilities.clear_ptfx(meteor_entities["» Flames 1"])
			meteor_entities["» Flames 1"] = nil
			graphics.remove_particle_fx(meteor_entities["» Flames 2"], true)
			meteor_entities["» Flames 2"] = nil
			utilities.clear_ptfx(meteor_entities["» Flames 2"])
			meteor_entities["» Flames 2"] = nil
			graphics.remove_named_ptfx_asset("core")
		end
		if ptfxs["» Flamethrower"] then
			graphics.remove_particle_fx(ptfxs["» Flamethrower"], true)
			ptfxs["» Flamethrower"] = nil
			utilities.clear_ptfx(meteor_entities["» Flamethrower"])
			meteor_entities["» Flamethrower"] = nil
		end
		if meteor_entities["» Flamethrower"] then
			graphics.remove_particle_fx(ptfxs["» Flamethrower"], true)
			ptfxs["» Flamethrower"] = nil
			utilities.clear_ptfx(meteor_entities["» Flamethrower"])
			meteor_entities["» Flamethrower"] = nil
		end
		if eventhooks["» Main Script Event Hook"] then
			hook.remove_script_event_hook(eventhooks["» Main Script Event Hook"])
			eventhooks["» Main Script Event Hook"] = nil
		end
		if eventhooks["» Main Net Event Hook"] then
			hook.remove_net_event_hook(eventhooks["» Main Net Event Hook"])
			eventhooks["» Main Net Event Hook"] = nil
		end
		if eventhooks["» Bad Net Event Detection"] then
			hook.remove_net_event_hook(eventhooks["» Bad Net Event Detection"])
			eventhooks["» Bad Net Event Detection"] = nil
		end
		if eventhooks["» Bad Script Event Detection"] then
			hook.remove_script_event_hook(eventhooks["» Bad Script Event Detection"])
			eventhooks["» Bad Script Event Detection"] = nil
		end
		if eventhooks["» Stand User Detection"] then
			hook.remove_script_event_hook(eventhooks["» Stand User Detection"])
			eventhooks["» Stand User Detection"] = nil
		end
		if eventhooks["» Notify Typing Players"] then
			hook.remove_script_event_hook(eventhooks["» Notify Typing Players"])
			eventhooks["» Notify Typing Players"] = nil
		end
		for i = 0, 87 do
			if eventhooks["» Net Event Responses " .. i] then
				hook.remove_net_event_hook(eventhooks["» Net Event Responses " .. i])
				eventhooks["» Net Event Responses " .. i] = nil
			end
		end
		if eventhooks["» Notify Orbital Cannon Room Events"] then
			hook.remove_net_event_hook(eventhooks["» Notify Orbital Cannon Room Events"])
			eventhooks["» Notify Orbital Cannon Room Events"] = nil
		end
		if eventhooks["» Anti Down Syndrome"] then
			hook.remove_net_event_hook(eventhooks["» Anti Down Syndrome"])
			eventhooks["» Anti Down Syndrome"] = nil
		end
		if eventhooks["» Guided Missile Tracker"] then
			hook.remove_script_event_hook(eventhooks["» Guided Missile Tracker"])
			eventhooks["» Guided Missile Tracker"] = nil
		end
		if eventhooks["» Uh Oh Spaghetti O's"] then
			hook.remove_script_event_hook(eventhooks["» Uh Oh Spaghetti O's"])
			eventhooks["» Uh Oh Spaghetti O's"] = nil
		end
		if eventhooks["» Modded Explosion Detection"] then
			hook.remove_script_event_hook(eventhooks["» Modded Explosion Detection"])
			eventhooks["» Modded Explosion Detection"] = nil
		end
		if listeners["» Auto Kick All Modders"] then
			event.remove_event_listener("modder", listeners["» Auto Kick All Modders"])
			listeners["» Auto Kick All Modders"] = nil
		end
		for i = 0, 75 do
			if listeners["» Auto Kick Modder " .. i] then
				event.remove_event_listener("modder", listeners["» Auto Kick Modder " .. i])
				listeners["» Auto Kick Modder " .. i] = nil
			end
		end
		if listeners["» Main Player Leave Event Listener"] then
			event.remove_event_listener("player_leave", listeners["» Main Player Leave Event Listener"])
			listeners["» Main Player Leave Event Listener"] = nil
		end
		if listeners["» Main Player Join Event Listener"] then
			event.remove_event_listener("player_join", listeners["» Main Player Join Event Listener"])
			listeners["» Main Player Join Event Listener"] = nil
		end
		if listeners["» Anti Chat Spam"] then
			event.remove_event_listener("chat", listeners["» Anti Chat Spam"])
			listeners["» Anti Chat Spam"] = nil
		end
		if listeners["» Anti Ur Mom"] then
			event.remove_event_listener("chat", listeners["» Anti Ur Mom"])
			listeners["» Anti Ur Mom"] = nil
		end
		if listeners["» Log Session Chat"] then
			event.remove_event_listener("chat", listeners["» Log Session Chat"])
			listeners["» Log Session Chat"] = nil
		end
		if listeners["» Log Session Change Leave"] then
			event.remove_event_listener("player_leave", listeners["» Log Session Change Leave"])
			listeners["» Log Session Change Leave"] = nil
		end
		if listeners["» Log Session Change Join"] then
			event.remove_event_listener("player_join", listeners["» Log Session Change Join"])
			listeners["» Log Session Change Join"] = nil
		end
		if listeners["» Notify Sent Messages"] then
			event.remove_event_listener("chat", listeners["» Notify Sent Messages"])
			listeners["» Notify Sent Messages"] = nil
		end
		if listeners["» Translate Chat Messages"] then
			event.remove_event_listener("chat", listeners["» Translate Chat Messages"])
			listeners["» Translate Chat Messages"] = nil
		end
		if listeners["» Anti East Ukraine"] then
			event.remove_event_listener("chat", listeners["» Anti East Ukraine"])
			listeners["» Anti East Ukraine"] = nil
		end
		if listeners["» Anti West Taiwan"] then
			event.remove_event_listener("chat", listeners["» Anti West Taiwan"])
			listeners["» Anti West Taiwan"] = nil
		end
		if listeners["» Uwu-Ify Chat Messages"] then
			event.remove_event_listener("chat", listeners["» Uwu-Ify Chat Messages"])
			listeners["» Uwu-Ify Chat Messages"] = nil
		end
		if listeners["» Vpn/Proxy Player Check"] then
			event.remove_event_listener("player_join", listeners["» Vpn/Proxy Player Check"])
			listeners["» Vpn/Proxy Player Check"] = nil
		end
		if listeners["» Chat Command veh <model> <max> <god>"] then
			event.remove_event_listener("chat", listeners["» Chat Command veh <model> <max> <god>"])
			listeners["» Chat Command veh <model> <max> <god>"] = nil
		end
		if listeners["» Chat Command crash <name>"] then
			event.remove_event_listener("chat", listeners["» Chat Command crash <name>"])
			listeners["» Chat Command crash <name>"] = nil
		end
		if listeners["» Chat Command kick <name>"] then
			event.remove_event_listener("chat", listeners["» Chat Command kick <name>"])
			listeners["» Chat Command kick <name>"] = nil
		end
		if listeners["» Chat Command bounty <name> <amount>"] then
			event.remove_event_listener("chat", listeners["» Chat Command bounty <name> <amount>"])
			listeners["» Chat Command bounty <name> <amount>"] = nil
		end
		if listeners["» Chat Command perico <name>"] then
			event.remove_event_listener("chat", listeners["» Chat Command perico <name>"])
			listeners["» Chat Command perico <name>"] = nil
		end
		if listeners["» Chat Command otr <name>"] then
			event.remove_event_listener("chat", listeners["» Chat Command otr <name>"])
			listeners["» Chat Command otr <name>"] = nil
		end
		streaming.remove_anim_dict("mp_am_hold_up")
		streaming.remove_anim_set("handsup_base")
		streaming.remove_anim_dict("random@arrests@busted")
		streaming.remove_anim_set("idle_c")
		streaming.remove_anim_dict("random@arrests")
		streaming.remove_anim_set("kneeling_arrest_idle")
		graphics.remove_named_ptfx_asset("weap_xs_vehicle_weapons")
		graphics.remove_named_ptfx_asset("scr_reconstructionaccident")
		graphics.remove_named_ptfx_asset("scr_trevor1")
		graphics.remove_named_ptfx_asset("core")
		graphics.remove_named_ptfx_asset("scr_agencyheistb")
		graphics.remove_named_ptfx_asset("scr_rcbarry1")
		graphics.remove_named_ptfx_asset("scr_recartheft")
		streaming.set_model_as_no_longer_needed(0xE75B4B1C)
		streaming.set_model_as_no_longer_needed(165154707)
		streaming.set_model_as_no_longer_needed(970598228)
		streaming.set_model_as_no_longer_needed(368211810)
		streaming.set_model_as_no_longer_needed(0x616C97B9)
		streaming.set_model_as_no_longer_needed(1058115860)
		streaming.set_model_as_no_longer_needed(0x761E2AD3)
		streaming.set_model_as_no_longer_needed(-150975354)
		streaming.set_model_as_no_longer_needed(621481054)
		streaming.set_model_as_no_longer_needed(0xD74B8139)
		streaming.set_model_as_no_longer_needed(0x2EA68690)
		streaming.set_model_as_no_longer_needed(0xA09E15FD)
		streaming.set_model_as_no_longer_needed(0x7ED5AD78)
		streaming.set_model_as_no_longer_needed(0xB5CF80E4)
		streaming.set_model_as_no_longer_needed(0x90EF5134)
		streaming.set_model_as_no_longer_needed(0x705E61F2)
		streaming.set_model_as_no_longer_needed(193469166)
		streaming.set_model_as_no_longer_needed(0x3F039CBA)
		streaming.set_model_as_no_longer_needed(0x856CFB02)
		streaming.set_model_as_no_longer_needed(0x2D7030F3)
		streaming.set_model_as_no_longer_needed(0xE5A2D6C6)
		streaming.set_model_as_no_longer_needed(0x82CAC433)
		streaming.set_model_as_no_longer_needed(0xB12314E0)
		streaming.set_model_as_no_longer_needed(0xAF10BD56)
		streaming.set_model_as_no_longer_needed(0x9B810FA2)
		streaming.set_model_as_no_longer_needed(0x72C0CAD2)
		streaming.set_model_as_no_longer_needed(0xFE0A508C)
		streaming.set_model_as_no_longer_needed(0x3DC92356)
		streaming.set_model_as_no_longer_needed(0xC5DD6967)
		streaming.set_model_as_no_longer_needed(3545667823)
		streaming.set_model_as_no_longer_needed(1951415382)
		if threads["» Shoot Fake Money Bags 1"] then
			menu.delete_thread(threads["» Shoot Fake Money Bags 1"])
		end
		if threads["» Shoot Stones"] then
			menu.delete_thread(threads["» Shoot Stones"])
		end
		if threads["» Shoot Dogshit"] then
			menu.delete_thread(threads["» Shoot Dogshit"])
		end
		if threads["» Fake Money Bag Drop"] then
			menu.delete_thread(threads["» Fake Money Bag Drop"])
		end
		if threads["» Drop Fake Money Bag 2"] then
			menu.delete_thread(threads["» Drop Fake Money Bag 2"])
		end
		if threads["» Drop Fake Money Bag 1"] then
			menu.delete_thread(threads["» Drop Fake Money Bag 1"])
		end
		if threads["» Fake RP Drop"] then
			menu.delete_thread(threads["» Fake RP Drop"])
		end
		if threads["» Drop Fake RP 2"] then
			menu.delete_thread(threads["» Drop Fake RP 2"])
		end
		if threads["» Drop Fake RP 1"] then
			menu.delete_thread(threads["» Drop Fake RP 1"])
		end
		if threads["» Fake Health Drop"] then
			menu.delete_thread(threads["» Fake Health Drop"])
		end
		if threads["» Drop Fake Health 2"] then
			menu.delete_thread(threads["» Drop Fake Health 2"])
		end
		if threads["» Drop Fake Health 1"] then
			menu.delete_thread(threads["» Drop Fake Health 1"])
		end
		if threads["» Fake Armor Drop"] then
			menu.delete_thread(threads["» Fake Armor Drop"])
		end
		if threads["» Drop Fake Armor 2"] then
			menu.delete_thread(threads["» Drop Fake Armor 2"])
		end
		if threads["» Drop Fake Armor 1"] then
			menu.delete_thread(threads["» Drop Fake Armor 1"])
		end
		if threads["» Fake P's & Q's Drop"] then
			menu.delete_thread(threads["» Fake P's & Q's Drop"])
		end
		if threads["» Drop Fake P's & Q's 2"] then
			menu.delete_thread(threads["» Drop Fake P's & Q's 2"])
		end
		if threads["» Drop Fake P's & Q's 1"] then
			menu.delete_thread(threads["» Drop Fake P's & Q's 1"])
		end
		if threads["» Enola Gay"] then
			menu.delete_thread(threads["» Enola Gay"])
		end
		if flight_mode_vehicle then
			utilities.request_control_silent(flight_mode_vehicle)
			utilities.hard_remove_entity(flight_mode_vehicle)
			flight_mode_vehicle = nil
		end
		entity.set_entity_collision(player.get_player_ped(player.player_id()), true, true, false)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
		if guided_missile_object then
			utilities.hard_remove_entity(guided_missile_object)
			guided_missile_object = nil
		end
		if guided_missile_object_vehicle then
			utilities.hard_remove_entity(guided_missile_object_vehicle)
			guided_missile_object_vehicle = nil
		end
		if guided_missile_cam then
			natives.DESTROY_CAM(guided_missile_cam, false)
			natives.RENDER_SCRIPT_CAMS(false, false, 0, true, true, 0)
		end
		if launch_guided_missile_scaleform then
			graphics.set_scaleform_movie_as_no_longer_needed(launch_guided_missile_scaleform)
		end
		if launch_guided_missile_scaleform_2 then
			graphics.set_scaleform_movie_as_no_longer_needed(launch_guided_missile_scaleform_2)
		end
		if save_current_pos then
			save_current_pos = nil
		end
		if model_change_object_ then
			entity.delete_entity(model_change_object_)
			entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
		end
		if world_model_change_object_ then
			entity.delete_entity(world_model_change_object_)
			entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
		end
		if prop_pizza_box_02_object_ then
			entity.delete_entity(prop_pizza_box_02_object_)
			entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
		end
		if prop_pineapple_object_ then
			entity.delete_entity(prop_pineapple_object_)
			entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
		end
		if prop_streetlight_05_object_ then
			entity.delete_entity(prop_streetlight_05_object_)
			entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
		end
		if prop_traffic_01a_object_ then
			entity.delete_entity(prop_traffic_01a_object_)
			entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
		end
		if prop_ecola_can_object_ then
			entity.delete_entity(prop_ecola_can_object_)
			entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
		end
		if prop_bin_05a_object_ then
			entity.delete_entity(prop_bin_05a_object_)
			entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
		end
		if prop_money_bag_01_object_ then
			entity.delete_entity(prop_money_bag_01_object_)
			entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
		end
		if hei_prop_cash_crate_empty_object_ then
			entity.delete_entity(hei_prop_cash_crate_empty_object_)
			entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
		end
		if prop_wine_red_object_ then
			entity.delete_entity(prop_wine_red_object_)
			entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
		end
		if prop_cash_case_02_object_ then
			entity.delete_entity(prop_cash_case_02_object_)
			entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
		end
		if prop_cash_pile_02_object_ then
			entity.delete_entity(prop_cash_pile_02_object_)
			entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
		end
		if prop_fire_hydrant_1_object_ then
			entity.delete_entity(prop_fire_hydrant_1_object_)
			entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
		end
		if prop_streetlight_05_object_ then
			entity.delete_entity(prop_streetlight_05_object_)
			entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
		end
		if prop_tree_cedar_s_01_object_ then
			entity.delete_entity(prop_tree_cedar_s_01_object_)
			entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
		end
		if prop_cs_burger_01_object_ then
			entity.delete_entity(prop_cs_burger_01_object_)
			entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
		end
		if prop_turkey_leg_01_object_ then
			entity.delete_entity(prop_turkey_leg_01_object_)
			entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
		end
		if freeze_position_pos then
			entity.set_entity_collision(player.get_player_ped(player.player_id()), true, true, false)
			freeze_position_pos = nil
		end
		if previous_position_of_vehicle then
			utilities.request_control_silent(player.get_player_vehicle(player.player_id()))
			entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), previous_position_of_vehicle)
			previous_position_of_vehicle = nil
		end
		if orbital_cannon_room_blocking_object then
			utilities.request_control_silent(orbital_cannon_room_blocking_object)
			entity.delete_entity(orbital_cannon_room_blocking_object)
			orbital_cannon_room_blocking_object = nil
		end
		for i = 0, 31 do
			if meteor_entities["Player Target Ped " .. i] ~= nil and meteor_entities["Player Target Vehicle " .. i] ~= nil then
				entity.delete_entity(meteor_entities["Player Target Ped " .. i])
				entity.delete_entity(meteor_entities["Player Target Vehicle " .. i])
				meteor_entities["Player Target Ped " .. i] = nil
				meteor_entities["Player Target Vehicle " .. i] = nil
			end
		end
		for i = 0, 31 do
			if meteor_entities["» Remote Control " .. i] then
				if player.is_player_in_any_vehicle(player.player_id()) then
					ped.clear_ped_tasks_immediately(player.get_player_ped(player.player_id()))
				end
				network.request_control_of_entity(meteor_entities["» Remote Control " .. i])
				entity.detach_entity(meteor_entities["» Remote Control " .. i])
				utilities.hard_remove_entity(meteor_entities["» Remote Control " .. i])
				entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
				meteor_entities["» Remote Control " .. i] = nil
			end
		end
		if ww2_rogue then
			for a = 1, 20 do
				if entity.is_an_entity(ww2_rogue[a]) then
					utilities.hard_remove_entity(ww2_rogue[a])
				end
				if entity.is_an_entity(ww2_ped_pilot_rogue[a]) then
					utilities.hard_remove_entity(ww2_ped_pilot_rogue[a])
				end
			end
		end
		if ww2_nokota then
			for b = 1, 10 do
				if entity.is_an_entity(ww2_nokota[b]) then
					utilities.hard_remove_entity(ww2_nokota[b])
				end
				if entity.is_an_entity(ww2_ped_pilot_nokota[b]) then
					utilities.hard_remove_entity(ww2_ped_pilot_nokota[b])
				end
			end
		end
		if ww2_rhino then
			for c = 1, 20 do
				if entity.is_an_entity(ww2_rhino[c]) then
					utilities.hard_remove_entity(ww2_rhino[c])
				end
				if entity.is_an_entity(ww2_ped_pilot_rhino[c]) then
					utilities.hard_remove_entity(ww2_ped_pilot_rhino[c])
				end
			end
		end
		if ww2_soldier then
			for d = 1, 30 do
				if entity.is_an_entity(ww2_soldier[d]) then
					utilities.hard_remove_entity(ww2_soldier[d])
				end
			end
		end
		if ww2_insurgent then
			for e = 1, 20 do
				if entity.is_an_entity(ww2_insurgent[e]) then
					utilities.hard_remove_entity(ww2_insurgent[e])
				end
				if entity.is_an_entity(ww2_ped_pilot_insurgent[e]) then
					utilities.hard_remove_entity(ww2_ped_pilot_insurgent[e])
				end
				if entity.is_an_entity(ww2_ped_pilot_2_insurgent[e]) then
					utilities.hard_remove_entity(ww2_ped_pilot_2_insurgent[e])
				end
			end
		end
		if table_of_all_lazers then
			for i = 1, #table_of_all_lazers do
				if entity.is_an_entity(table_of_all_lazers[i]) then
					utilities.hard_remove_entity(table_of_all_lazers[i])
					table_of_all_lazers[i] = nil
				end
			end
		end
		count_of_all_lazers = nil
		if enola_gay then
			utilities.hard_remove_entity(enola_gay)
			enola_gay = nil
		end
		if little_boy then
			utilities.hard_remove_entity(little_boy)
			little_boy = nil
		end
		if little_boy_2 then
			utilities.hard_remove_entity(little_boy_2)
			little_boy_2 = nil
		end
		if send_tactical_nuke then
			utilities.hard_remove_entity(send_tactical_nuke)
			send_tactical_nuke = nil
		end
		if send_tactical_nuke_blip then
			ui.remove_blip(send_tactical_nuke_blip)
		end
		dropped_little_boy = false
		little_boy_2_exploded_in_water = false
		little_boy_exploded = false
		little_boy_rotation = nil
		if enola_gay_map_blip_bomb then
			ui.remove_blip(enola_gay_map_blip_bomb)
		end
		if enola_gay_map_blip_repair then
			ui.remove_blip(enola_gay_map_blip_repair)
		end
		rope.rope_unload_textures()
		rope_target_1 = nil
		rope_target_2 = nil
		rope_wait_a_second = false
		if table_of_all_ropes then
			for i = 1, #table_of_all_ropes do
				if rope.does_rope_exist(table_of_all_ropes[i]) then
					rope.delete_rope(table_of_all_ropes[i])
					table_of_all_ropes[i] = nil
				end
			end
		end
		for i = 1, #all_front_ramps_table do
			if entity.is_an_entity(all_front_ramps_table[i]) then
				entity.delete_entity(all_front_ramps_table[i])
				all_front_ramps_table[i] = nil
			end
		end
		for i = 0, 31 do
			if eventhooks["» Log Script Events " .. i] then
				hook.remove_script_event_hook(eventhooks["» Log Script Events " .. i])
				eventhooks["» Log Script Events " .. i] = nil
			end
			if eventhooks["» Log Net Events " .. i] then
				hook.remove_net_event_hook(eventhooks["» Log Net Events " .. i])
				eventhooks["» Log Net Events " .. i] = nil
			end
		end
		all_front_ramps_count = nil
		ww2_rogue = nil
		ww2_ped_pilot_rogue = nil
		ww2_nokota = nil
		ww2_ped_pilot_nokota = nil
		ww2_rhino = nil
		ww2_ped_pilot_rhino = nil
		ww2_soldier = nil
		ww2_insurgent = nil
		ww2_ped_pilot_insurgent = nil
		ww2_ped_pilot_2_insurgent = nil
		auto_pilot_speed = nil
		auto_pilot_rotation = nil
		if freecam_player_cam then
			entity.freeze_entity(player.get_player_ped(player.player_id()), false)
			natives.DESTROY_CAM(freecam_player_cam, false)
			natives.RENDER_SCRIPT_CAMS(false, false, 0, true, true, 0)
			freecam_player_cam = nil
		end
		if anti_crash_cam_pos then
			entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), anti_crash_cam_pos)
			anti_crash_cam_pos = nil
		end
		if anti_crash_cam_player_cam then
			natives.DESTROY_CAM(anti_crash_cam_player_cam, false)
			natives.RENDER_SCRIPT_CAMS(false, false, 0, true, true, 0)
			anti_crash_cam_player_cam = nil
		end
		natives.UNLOCK_MINIMAP_POSITION()
		natives.FREEZE_ENTITY_POSITION(player.get_player_ped(player.player_id()), false)
		menu.notify("Unloaded Menu! Cleanup Successful!", Meteor, 5, 0x00ff00)
		Meteor = nil
		event.remove_event_listener("exit", listeners["Menu Unload"])
	end)
end

if utils.file_exists(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorDev\\MeteorDev.lua") then
	meteordevlocalparent = menu.add_feature("» Dev Features", "parent", localparents["» Meteor"])
	meteordevplayerparent = menu.add_player_feature("» Dev Features", "parent", playerparents["» Meteor"]).id
	local dev = loadfile(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorDev\\MeteorDev.lua")
	dev()
end

do
	threads["» Altered Script Host Migration"] = menu.create_thread(function()
		while Meteor do
			system.yield(0)
			local current_sh
			local sh_name
			if current_sh == nil then
				current_sh = script.get_host_of_this_script()
				sh_name = player.get_player_name(current_sh)
			end
			system.wait(2000)
			local new_sh = script.get_host_of_this_script()
			if current_sh ~= new_sh then
				if player.is_player_valid(new_sh) then
					if altered_sh_migration_detection_timer_left_player < utils.time_ms() and altered_sh_migration_detection_timer < utils.time_ms() then
						SessionBrokenAlteredSHMigration = true
					end
					sh_name = player.get_player_name(current_sh)
				end
			end
			system.wait(0)
		end
		system.wait(1000)
	end, nil)
end

do
	threads["» Bad World Data"] = menu.create_thread(function()
		while Meteor do
			system.yield(500)
			if network.is_session_started() then
				for pid = 0, 31 do
					if player.is_player_valid(pid) then
						if did_someone_type and (player.get_player_coords(pid).x > 10700 or player.get_player_coords(pid).y > 10700 or player.get_player_coords(pid).x < -10700 or player.get_player_coords(pid).y < -10700) then
							SessionBrokenOutOfRangeWorldRender = true
						end
					end
				end
			end
		end
	end, nil)
end

do
	local load_selected_setting = utils.get_all_files_in_directory(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\Load", ""), "ini")
	if #load_selected_setting > 0 then
		if utils.file_exists(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", "") .. "\\" .. load_selected_setting[1] .. "") then
			local file = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\Settings Profiles\\" .. load_selected_setting[1] .. "", "r")
			for line in file:lines() do
				if string.find(line, "|") then
					local parts = text_func.split_string(line, "|")
					if feature["" .. parts[1] .. ""] then
						if tostring(parts[2]) ~= "nil" then
							if tostring(parts[2]) == "true" then
								feature["" .. parts[1] .. ""].on = true
							else
								feature["" .. parts[1] .. ""].on = false
							end
						end
						if tostring(parts[3]) ~= "nil" then
							feature["" .. parts[1] .. ""].value = tonumber(parts[3])
							if settings["" .. parts[1] .. ""].Value then
								settings["" .. parts[1] .. ""].Value = tonumber(parts[3])
							end
						end
					end
				end
			end
		elseif utils.file_exists(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", "") .. "\\Default.ini") then
			local file = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\Settings Profiles\\Default.ini", "r")
			for line in file:lines() do
				if string.find(line, "|") then
					local parts = text_func.split_string(line, "|")
					if feature["" .. parts[1] .. ""] then
						if tostring(parts[2]) ~= "nil" then
							if tostring(parts[2]) == "true" then
								feature["" .. parts[1] .. ""].on = true
							else
								feature["" .. parts[1] .. ""].on = false
							end
						end
						if tostring(parts[3]) ~= "nil" then
							feature["" .. parts[1] .. ""].value = tonumber(parts[3])
							if settings["" .. parts[1] .. ""].Value then
								settings["" .. parts[1] .. ""].Value = tonumber(parts[3])
							end
						end
					end
				end
			end
		else
			text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", "") .. "\\Default.ini", "w"), "")
			for i = 1, #settings do
				text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", "") .. "\\Default.ini", "a"), "" .. settings[i].Name .. "|" .. tostring(settings[i].Enabled) .. "|" .. tostring(settings[i].Value) .. "\n")
			end
		end
	else
		if utils.file_exists(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", "") .. "\\Default.ini") then
			local file = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\Settings Profiles\\Default.ini", "r")
			for line in file:lines() do
				if string.find(line, "|") then
					local parts = text_func.split_string(line, "|")
					if feature["" .. parts[1] .. ""] then
						if tostring(parts[2]) ~= "nil" then
							if tostring(parts[2]) == "true" then
								feature["" .. parts[1] .. ""].on = true
							else
								feature["" .. parts[1] .. ""].on = false
							end
						end
						if tostring(parts[3]) ~= "nil" then
							feature["" .. parts[1] .. ""].value = tonumber(parts[3])
							if settings["" .. parts[1] .. ""].Value then
								settings["" .. parts[1] .. ""].Value = tonumber(parts[3])
							end
						end
					end
				end
			end
		else
			text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", "") .. "\\Default.ini", "w"), "")
			for i = 1, #settings do
				text_func.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", "") .. "\\Default.ini", "a"), "" .. settings[i].Name .. "|" .. tostring(settings[i].Enabled) .. "|" .. tostring(settings[i].Value) .. "\n")
			end
		end
	end
end

do
	local should_display_welcome_screen = true
	if utils.file_exists(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\MeteorConfig\\Settings Profiles\\", "") .. "\\Default.ini") then
		local file = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorConfig\\Settings Profiles\\Default.ini", "r")
		for line in file:lines() do
			if string.find(line, "» Display Welcome Screen|false|nil") then
				should_display_welcome_screen = false
			end
		end
	end
	if should_display_welcome_screen then
		feature[ "» Display Welcome Screen"].on = true
		menu.create_thread(function()
			script_execute_scaleform = graphics.request_scaleform_movie("mp_big_message_freemode")
			local time = utils.time_ms() + 4000
			audio.play_sound_from_coord(-1, "LOSER", player.get_player_coords(player.player_id()), "HUD_AWARDS", false, 0, true)
			threads["» Script Execute"] = menu.create_thread(function()
				while time > utils.time_ms() do
					system.yield(0)
					graphics.begin_scaleform_movie_method(script_execute_scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
					graphics.draw_scaleform_movie_fullscreen(script_execute_scaleform, 255, 255, 255, 255, 0)
					graphics.scaleform_movie_method_add_param_texture_name_string("KHOS GANG SHIT!!!")
					graphics.scaleform_movie_method_add_param_texture_name_string("Currupt Meteor for 2Take1")
					graphics.end_scaleform_movie_method(script_execute_scaleform)
					graphics.begin_scaleform_movie_method(script_execute_scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
					graphics.draw_scaleform_movie_fullscreen(script_execute_scaleform, 255, 255, 255, 255, 0)
					graphics.scaleform_movie_method_add_param_texture_name_string("KHOS GANG SHIT!!!")
					graphics.scaleform_movie_method_add_param_texture_name_string("Currupt Meteor for 2Take1")
					graphics.end_scaleform_movie_method(script_execute_scaleform)
					graphics.begin_scaleform_movie_method(script_execute_scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
					graphics.draw_scaleform_movie_fullscreen(script_execute_scaleform, 255, 255, 255, 255, 0)
					graphics.scaleform_movie_method_add_param_texture_name_string("KHOS GANG SHIT!!!")
					graphics.scaleform_movie_method_add_param_texture_name_string("Currupt Meteor for 2Take1")
					graphics.end_scaleform_movie_method(script_execute_scaleform)
				end
			end, nil)
			system.wait(4000)
			audio.play_sound_from_coord(-1, "CHECKPOINT_AHEAD", player.get_player_coords(player.player_id()), "HUD_MINI_GAME_SOUNDSET", false, 0, true)
			graphics.set_scaleform_movie_as_no_longer_needed(script_execute_scaleform)
		end, nil)
	end
end

menu.notify("Loaded Script Successfully!\n\nCurruptMeteor for 2Take1")
