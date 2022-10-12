local utilities = require("Meteor/Lib/Utils")
local natives = require("Meteor/Lib/Natives")

local entity_func = {}

function entity_func.hard_remove_entity(Entity) -- Credits to kektram for this function
	if entity.is_an_entity(Entity) then
		::Repeat::
		if entity.is_entity_attached(Entity) then
			Entity = entity.get_entity_attached_to(Entity)
			goto Repeat
		end
		if entity.is_an_entity(Entity) and not ped.is_ped_a_player(Entity) then
			local Attachments = {}
			local peds = ped.get_all_peds()
			local vehicles = vehicle.get_all_vehicles()
			local objects = object.get_all_objects()
			local pickups = object.get_all_pickups()
			for i = 1, #peds do
				if entity.get_entity_attached_to(peds[i]) == Entity and not ped.is_ped_a_player(peds[i]) then
					table.insert(Attachments, peds[i])
				end
			end
			for i = 1, #vehicles do
				if entity.get_entity_attached_to(vehicles[i]) == Entity then
					table.insert(Attachments, vehicles[i])
				end
			end
			for i = 1, #objects do
				if entity.get_entity_attached_to(objects[i]) == Entity then
					table.insert(Attachments, objects[i])
				end
			end
			for i = 1, #pickups do
				if entity.get_entity_attached_to(pickups[i]) == Entity then
					table.insert(Attachments, pickups[i])
				end
			end
			Attachments[#Attachments + 1] = Entity
			for i = 1, #Attachments do
				utilities.request_control(Attachments[i], 50)
				if network.has_control_of_entity(Attachments[i]) then
					entity.detach_entity(Attachments[i])
					ui.remove_blip(ui.get_blip_from_entity(Attachments[i]))
					entity.set_entity_as_mission_entity(Attachments[i], false, true)
					entity.delete_entity(Attachments[i])
				end
			end
		end
	end
end

function utilities.max_vehicle(vehicle_)
	if vehicle_ then
		vehicle.set_vehicle_mod_kit_type(vehicle_, 0)
		for i = 0, 47 do
			local mod = vehicle.get_num_vehicle_mods(vehicle_, i) - 1
			vehicle.set_vehicle_mod(vehicle_, i, mod, true)
			vehicle.toggle_vehicle_mod(vehicle_, mod, true)
		end
		vehicle.set_vehicle_bulletproof_tires(vehicle_, true)
		vehicle.set_vehicle_window_tint(vehicle_, 1)
		vehicle.set_vehicle_number_plate_index(vehicle_, 1)
	end
end

function utilities.downgrade_vehicle(vehicle_)
	if vehicle_ then
		vehicle.set_vehicle_mod_kit_type(vehicle_, 0)
		for i = 0, 47 do
			vehicle.set_vehicle_mod(vehicle_, i, -1, false)
			vehicle.toggle_vehicle_mod(vehicle_, i, false)
		end
		vehicle.set_vehicle_bulletproof_tires(vehicle_, false)
		vehicle.set_vehicle_window_tint(vehicle_, 0)
		vehicle.set_vehicle_number_plate_index(vehicle_, 0)
		vehicle.set_vehicle_livery(vehicle_, 0)
		for i = 0, 3 do
			vehicle.set_vehicle_neon_lights_color(vehicle_, 0)
			vehicle.set_vehicle_neon_light_enabled(vehicle_, i, false)
		end
	end
end

function utilities.remove_player_entities(table_of_entities)
	local new_table = {}
	for i = 1, #table_of_entities do
		if entity.is_an_entity(table_of_entities[i]) and not ped.is_ped_a_player(table_of_entities[i]) and not ped.is_ped_a_player(vehicle.get_ped_in_vehicle_seat(table_of_entities[i], -1)) then
			table.insert(new_table, table_of_entities[i])
		end
	end
	return new_table
end

function entity_func.get_table_of_entities(entity_table, max_count, max_range, remove_players, sort_to_distance, start_pos)
	local new_entity_table = {}
	local current_count = 0
	for i = 1, #entity_table do
		if current_count < max_count then
			if utilities.get_distance_between(start_pos, entity_table[i]) < max_range then
				table.insert(new_entity_table, entity_table[i])
				current_count = current_count + 1
			end
		end
	end
	if remove_players then
		new_entity_table = utilities.remove_player_entities(new_entity_table)
	end
	if sort_to_distance then
		table.sort(new_entity_table, function(a, b)
			return (utilities.get_distance_between(a, start_pos) < utilities.get_distance_between(b, start_pos))
		end)
	end
	return new_entity_table
end

function entity_func.create_vehicle_clone(Vehicle, Position, Heading, Networked, ScriptHostEnt)
	if Vehicle and entity.is_an_entity(Vehicle) and entity.is_entity_a_vehicle(Vehicle) then
		local vehicle_ = vehicle.create_vehicle(entity.get_entity_model_hash(Vehicle), Position, Heading, Networked, ScriptHostEnt)
		network.request_control_of_entity(vehicle_)
		vehicle.set_vehicle_mod_kit_type(vehicle_, 0)
		for i = 0, 49 do
			vehicle.set_vehicle_mod(vehicle_, i, vehicle.get_num_vehicle_mods(Vehicle, i), true)
		end
		for i = 0, 20 do
			if vehicle.does_extra_exist(Vehicle, i) then
				vehicle.set_vehicle_extra(vehicle_, i, vehicle.is_vehicle_extra_turned_on(Vehicle, i))
			end
		end
		vehicle.set_vehicle_colors(vehicle_, vehicle.get_vehicle_primary_color(Vehicle), vehicle.get_vehicle_secondary_color(Vehicle))
		vehicle.set_vehicle_custom_pearlescent_colour(vehicle_, vehicle.get_vehicle_pearlecent_color(Vehicle))
		vehicle.set_vehicle_custom_wheel_colour(vehicle_, vehicle.get_vehicle_wheel_color(Vehicle))
		vehicle.set_vehicle_window_tint(vehicle_, vehicle.get_vehicle_window_tint(Vehicle))
		vehicle.set_vehicle_headlight_color(vehicle_, vehicle.get_vehicle_headlight_color(Vehicle))
		vehicle.set_vehicle_neon_lights_color(vehicle_, vehicle.get_vehicle_neon_lights_color(Vehicle))
		vehicle.set_vehicle_livery(vehicle_, vehicle.get_vehicle_livery(Vehicle))
		natives.SET_VEHICLE_DIRT_LEVEL(vehicle_, natives.GET_VEHICLE_DIRT_LEVEL(Vehicle))
		vehicle.set_vehicle_tire_smoke_color(vehicle_, 255, 255, 255)
		natives.SET_VEHICLE_INTERIOR_COLOR(vehicle_, natives.GET_VEHICLE_INTERIOR_COLOR(Vehicle))
		natives.SET_VEHICLE_DASHBOARD_COLOR(vehicle_, natives.GET_VEHICLE_DASHBOARD_COLOR(Vehicle))
		vehicle.set_vehicle_number_plate_text(vehicle_, vehicle.get_vehicle_number_plate_text(Vehicle))
		vehicle.set_vehicle_number_plate_index(vehicle_, vehicle.get_vehicle_number_plate_index(Vehicle))
		vehicle.set_vehicle_wheel_type(vehicle_, vehicle.get_vehicle_wheel_type(Vehicle))
		for i = 0, 7 do
			if vehicle.is_vehicle_neon_light_enabled(Vehicle, i) then
				vehicle.set_vehicle_neon_light_enabled(vehicle_, i)
			end
		end
		return vehicle_
	end
end

function entity_func.create_nuke_explosion(Position, Named)
    local Owner
    if Named then
        Owner = player.get_player_ped(player.player_id())
    else
        Owner = 0
    end
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	fire.add_explosion(Position, 59, true, false, 5, Owner)
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position, v3(0, 180, 0), 4.5, true, true, true)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	fire.add_explosion(Position, 59, true, false, 1, Owner)
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position, v3(0, 180, 0), 4.5, true, true, true)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position, v3(0, 180, 0), 4.5, true, true, true)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position, v3(0, 180, 0), 4.5, true, true, true)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position, v3(0, 180, 0), 4.5, true, true, true)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position, v3(0, 180, 0), 4.5, true, true, true)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position, v3(0, 180, 0), 4.5, true, true, true)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position, v3(0, 180, 0), 4.5, true, true, true)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position, v3(0, 180, 0), 4.5, true, true, true)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position, v3(0, 180, 0), 4.5, true, true, true)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position, v3(0, 180, 0), 4.5, true, true, true)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position, v3(0, 180, 0), 4.5, true, true, true)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position, v3(0, 180, 0), 4.5, true, true, true)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position, v3(0, 180, 0), 4.5, true, true, true)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position, v3(0, 180, 0), 4.5, true, true, true)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position, v3(0, 180, 0), 4.5, true, true, true)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position, v3(0, 180, 0), 4.5, true, true, true)
	fire.add_explosion(Position + v3(10, 0, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(0, 10, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(10, 10, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(-10, 0, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(0, -10, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(-10, -10, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(10, -10, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(-10, 10, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(20, 0, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(0, 20, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(20, 20, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(-20, 0, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(0, -20, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(-20, -20, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(20, -20, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(-20, 20, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(30, 0, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(0, 30, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(30, 30, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(-30, 0, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(0, -30, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(-30, -30, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(30, -30, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(-30, 30, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(10, 30, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(30, 10, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(-30, -10, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(-10, -30, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(-10, 30, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(-30, 10, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(30, -10, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(10, -30, 0), 59, true, false, 1, Owner)
	for pid = 0, 31 do
		if player.is_player_valid(pid) then
			if utilities.get_distance_between(player.get_player_coords(pid), player.get_player_coords(player.player_id())) < 75 then
				fire.add_explosion(player.get_player_coords(pid), 59, true, false, 1, Owner)
			end
		end
	end
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	fire.add_explosion(Position + v3(0, 0, -10), 59, true, false, 1, Owner)
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position - v3(0, 0, 10), v3(0, 180, 0), 4.5, true, true, true)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position - v3(0, 0, 10), v3(0, 180, 0), 4.5, true, true, true)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	fire.add_explosion(Position + v3(0, 0, -10), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(10, 0, -10), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(0, 10, -10), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(10, 10, -10), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(-10, 0, -10), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(0, -10, -10), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(-10, -10, -10), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(10, -10, -10), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(-10, 10, -10), 59, true, false, 1, Owner)
	system.wait(10)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 1), v3(0, 180, 0), 1.5, true, true, true)
	system.wait(10)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 3), v3(0, 180, 0), 1.5, true, true, true)
	system.wait(10)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	fire.add_explosion(Position + v3(0, 0, 5), 59, true, false, 1, Owner)
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 5), v3(0, 180, 0), 1.5, true, true, true)
	system.wait(10)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 7), v3(0, 180, 0), 1.5, true, true, true)
	system.wait(10)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	fire.add_explosion(Position + v3(0, 0, 10), 59, true, false, 1, Owner)
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 10), v3(0, 180, 0), 1.5, true, true, true)
	system.wait(10)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 12), v3(0, 180, 0), 1.5, true, true, true)
	system.wait(10)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	fire.add_explosion(Position + v3(0, 0, 15), 59, true, false, 1, Owner)
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 15), v3(0, 180, 0), 1.5, true, true, true)
	system.wait(10)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 17), v3(0, 180, 0), 1.5, true, true, true)
	system.wait(10)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	fire.add_explosion(Position + v3(0, 0, 20), 59, true, false, 1, Owner)
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 20), v3(0, 180, 0), 1.5, true, true, true)
	system.wait(10)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 22), v3(0, 180, 0), 1.5, true, true, true)
	system.wait(10)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	fire.add_explosion(Position + v3(0, 0, 25), 59, true, false, 1, Owner)
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 25), v3(0, 180, 0), 1.5, true, true, true)
	system.wait(10)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 27), v3(0, 180, 0), 1.5, true, true, true)
	system.wait(10)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	fire.add_explosion(Position + v3(0, 0, 30), 59, true, false, 1, Owner)
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 30), v3(0, 180, 0), 1.5, true, true, true)
	system.wait(10)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 32), v3(0, 180, 0), 1.5, true, true, true)
	system.wait(10)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	fire.add_explosion(Position + v3(0, 0, 35), 59, true, false, 1, Owner)
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 35), v3(0, 180, 0), 1.5, true, true, true)
	system.wait(10)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 37), v3(0, 180, 0), 1.5, true, true, true)
	system.wait(10)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	fire.add_explosion(Position + v3(0, 0, 40), 59, true, false, 1, Owner)
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 40), v3(0, 180, 0), 1.5, true, true, true)
	system.wait(10)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 42), v3(0, 180, 0), 1.5, true, true, true)
	system.wait(10)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	fire.add_explosion(Position + v3(0, 0, 45), 59, true, false, 1, Owner)
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 45), v3(0, 180, 0), 1.5, true, true, true)
	system.wait(10)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 47), v3(0, 180, 0), 1.5, true, true, true)
	system.wait(10)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	fire.add_explosion(Position + v3(0, 0, 50), 59, true, false, 1, Owner)
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 50), v3(0, 180, 0), 1.5, true, true, true)
	system.wait(10)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 52), v3(0, 180, 0), 1.5, true, true, true)
	system.wait(10)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	fire.add_explosion(Position + v3(0, 0, 55), 59, true, false, 1, Owner)
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 55), v3(0, 180, 0), 1.5, true, true, true)
	system.wait(10)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 57), v3(0, 180, 0), 1.5, true, true, true)
	system.wait(10)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	fire.add_explosion(Position + v3(0, 0, 57), 59, true, false, 1, Owner)
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 59), v3(0, 180, 0), 1.5, true, true, true)
	system.wait(10)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 61), v3(0, 180, 0), 1.5, true, true, true)
	system.wait(10)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 63), v3(0, 180, 0), 1.5, true, true, true)
	system.wait(10)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	fire.add_explosion(Position + v3(0, 0, 57), 59, true, false, 1, Owner)
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 65), v3(0, 180, 0), 1.5, true, true, true)
	system.wait(10)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	fire.add_explosion(Position + v3(0, 0, 75), 59, true, false, 1, Owner)
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 75), v3(0, 0, 0), 3.5, true, true, true)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 75), v3(0, 0, 0), 3.5, true, true, true)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 75), v3(0, 0, 0), 3.5, true, true, true)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 75), v3(0, 0, 0), 3.5, true, true, true)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 80), v3(0, 0, 0), 3, true, true, true)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", Position + v3(0, 0, 80), v3(0, 0, 0), 3, true, true, true)
	fire.add_explosion(Position + v3(10, 0, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(0, 10, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(10, 10, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(-10, 0, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(0, -10, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(-10, -10, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(10, -10, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position + v3(-10, 10, 0), 59, true, false, 1, Owner)
	fire.add_explosion(Position, 59, true, false, 1, Owner)
	local peds = ped.get_all_peds()
	for i = 1, #peds do
		if utilities.get_distance_between(peds[i], Position) < 200 and player.get_player_from_ped(peds[i]) ~= player.player_id() then
			network.request_control_of_entity(peds[i])
			fire.add_explosion(entity.get_entity_coords(peds[i]), 3, true, false, 0.1, Owner)
			ped.set_ped_to_ragdoll(peds[i], 1000, 1000, 0)
			entity.set_entity_velocity(peds[i], (entity.get_entity_coords(peds[i]) - Position) * (100 / utilities.get_distance_between(peds[i], Position)))
			if not ped.is_ped_a_player(peds[i]) then
				ped.set_ped_health(peds[i], 0)
			end
		elseif utilities.get_distance_between(peds[i], Position) > 200 and utilities.get_distance_between(peds[i], Position) < 400 and player.get_player_from_ped(peds[i]) ~= player.player_id() then
			network.request_control_of_entity(peds[i])
			fire.add_explosion(entity.get_entity_coords(peds[i]), 3, true, false, 0.1, Owner)
			ped.set_ped_to_ragdoll(peds[i], 1000, 1000, 0)
			entity.set_entity_velocity(peds[i], (entity.get_entity_coords(peds[i]) - Position) * (40 / utilities.get_distance_between(peds[i], Position)))
			if not ped.is_ped_a_player(peds[i]) then
				ped.set_ped_health(peds[i], 0)
			end
		end
	end
	local found_index = false
	local found_train = nil
	local vehicles = vehicle.get_all_vehicles()
	for i = 1, #vehicles do
		if utilities.get_distance_between(vehicles[i], Position) < 400 then
			network.request_control_of_entity(vehicles[i])
			natives.SET_VEHICLE_PETROL_TANK_HEALTH(vehicles[i], -999.90002441406)
			entity.set_entity_velocity(vehicles[i], (entity.get_entity_coords(vehicles[i]) - Position) * (100 / utilities.get_distance_between(vehicles[i], Position)))
		elseif utilities.get_distance_between(vehicles[i], Position) > 200 and utilities.get_distance_between(vehicles[i], Position) < 400 then
			network.request_control_of_entity(vehicles[i])
			vehicle.set_vehicle_engine_health(vehicles[i], -4000)
			entity.set_entity_velocity(vehicles[i], (entity.get_entity_coords(vehicles[i]) - Position) * (40 / utilities.get_distance_between(vehicles[i], Position)))
		end
		if entity.get_entity_model_hash(vehicles[i]) == 1030400667 then
			if not found_index then
				found_train = vehicles[i]
			end
			found_index = true
		end
	end
	if found_index and found_train ~= nil then
		natives.SET_TRAIN_SPEED(found_train, 0.0)
		natives.SET_TRAIN_CRUISE_SPEED(found_train, 0.0)
		natives.SET_RENDER_TRAIN_AS_DERAILED(found_train, true)
	end
end

function entity_func.get_richest_ped()
	local peds = ped.get_all_peds()
	if #peds > 1 then
		table.sort(peds, function(a, b)
			return (natives.GET_PED_MONEY(a) > natives.GET_PED_MONEY(b))
		end)
		return peds[1]
	elseif #peds == 1 then
		return peds[1]
	else
		return nil
	end
end

return entity_func