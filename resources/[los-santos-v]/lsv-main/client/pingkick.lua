RegisterNetEvent('lsv:playerHighPingWarned')
AddEventHandler('lsv:playerHighPingWarned', function(ping)
	FlashMinimapDisplay()
	PlaySoundFrontend(-1, 'MP_IDLE_TIMER', 'HUD_FRONTEND_DEFAULT_SOUNDSET', true)
	Gui.DisplayNotification('~r~Warning: Your ping is too high ('..ping..' ms). Please fix it.')
end)