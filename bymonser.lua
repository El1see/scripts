script_name('bymonser') 
script_author ('Кетчуп') 
script_description ('script') 

require "lib.moonloader"
local dlstatus = require('moonloader').download_status
local inicfg = require 'inicfg'
local keys = require "vkeys"
local encoding = require "encoding"
encoding.default = "CP1251"
u8 = encoding.UTF8

update_state = false

local script_vers = 3
local script_vers_text = "1.03"

local update_url = "https://raw.githubusercontent.com/El1see/scripts/main/update.ini" -- тут тоже свою ссылку
local update_path = getWorkingDirectory() .. "/update.ini" -- и тут свою ссылку

local script_url = "https://github.com/El1see/scripts/blob/main/bymonser.luac?raw=true" -- тут свою ссылку
local script_path = thisScript().path


function main()
	 if not isSampLoaded() or not isSampfuncsLoaded() then return end
	 while not isSampAvailable() do wait(100) end

	 downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.vers) > script_vers then
                sampAddChatMessage('[Script by monser]: Обнаружено обновление. Пытаюсь обновиться c '..script_vers_text..' на ' .. updateIni.info.vers_text, -1)
                update_state = true
            end
            os.remove(update_path)
        end
     end)

	 while true do
		wait(0)

		if update_state then
			downloadUrlToFile(script_url, script_path, function(id, status)
				if status == dlstatus.STATUS_ENDDOWNLOADDATA then
					sampAddChatMessage("[Script by monser]: Готов к работе!.", -1)
					thisScript():reload()
				end
			end)
			break
		end

		if isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not sampIsDialogActive() and not isPauseMenuActive() and not isSampfuncsConsoleActive() then
			sampSendChat('/healme')
		end	
		if isKeyJustPressed(VK_N) and not sampIsChatInputActive() and not sampIsDialogActive() and not isPauseMenuActive() and not isSampfuncsConsoleActive() then
			sampSendChat('/mask')	
		end	
		if isKeyJustPressed(VK_L) and not sampIsChatInputActive() and not sampIsDialogActive() and not isPauseMenuActive() and not isSampfuncsConsoleActive() then
			sampSendChat('/anim 1')	
		end
		if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() and not isPauseMenuActive() and not isSampfuncsConsoleActive() then
			sampSendChat('x')	
		end
	 end
end