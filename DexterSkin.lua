script_name('DexterSkin 2.0')
script_author('Dexter')
script_description('https://youtube.com/@dexy.sexy1')

require "lib.moonloader"

local favskin = 0;

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end

	sampRegisterChatCommand("dexskin", nsc_cmd)
	sampAddChatMessage("{00ff00}[DexterSkin {ff0000}2.0{00ff00}]: {00ffff}SkinChanger 2.0 loaded.", -1)
	sampAddChatMessage("{00ff00}[DexterSkin {ff0000}2.0{00ff00}]: {00ffff}Use - {ff0000}/dexskin ID", -1)

	while true do
		wait(100)
		if favskin ~= 0 then
			nowskinid = getCharModel(PLAYER_PED)
			if nowskinid ~= favskin then
				_, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
				set_player_skin(id, favskin)
				sampAddChatMessage("{00ff00}[DexterSkin {ff0000}2.0{00ff00}]: {00ffff}Skin reset to your favorite!", -1)
			end
		end
	end
end

function nsc_cmd(arg)
	if #arg == 0 then
		sampAddChatMessage("/dexskin [skin ID]", -1)
	else
		local skinid = tonumber(arg)
		if skinid == 0 then
			favskin = 0
			sampAddChatMessage("{ff0000}DexterSkin disabled.", -1)
		else
			favskin = skinid
			_, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
			set_player_skin(id, favskin)
			sampAddChatMessage("{00ff00}[DexterSkin]: {00ffff}Skin changed successfully!", -1)
		end
	end
end

function set_player_skin(id, skin)
	local BS = raknetNewBitStream()
	raknetBitStreamWriteInt32(BS, id)
	raknetBitStreamWriteInt32(BS, skin)
	raknetEmulRpcReceiveBitStream(153, BS)
	raknetDeleteBitStream(BS)
end