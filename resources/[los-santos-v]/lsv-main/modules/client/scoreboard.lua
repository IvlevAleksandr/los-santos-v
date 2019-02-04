RegisterNetEvent('lsv:updateScoreboard')


Scoreboard = { }


local scoreboard = { }


function Scoreboard.GetPlayerPatreonTier(playerId)
	local serverId = GetPlayerServerId(playerId)
	local player = table.find_if(scoreboard, function(player) return player.id == serverId end)
	return player and player.patreonTier or nil
end


-- Sizes
local headerTableSpacing = 0.0075

local tableSpacing = 0.001875
local tableHeight = 0.02625
local tablePositionWidth = 0.13125
local tableCashWidth = 0.075
local tableKdRatioWidth = 0.075
local tableKillsWidth = 0.075
local tableDeathsWidth = 0.075
local tableTextHorizontalMargin = 0.00225
local tableTextVerticalMargin = 0.00245
local onlineStatusWidth = 0.00225

local tableWidth = tablePositionWidth + tableCashWidth + tableKdRatioWidth + tableKillsWidth + tableDeathsWidth

local headerScale = 0.2625
local positionScale = 0.375
local rankScale = 0.3375
local cashScale = 0.2625
local kdRatioScale = 0.2625
local killsScale = 0.2625
local deathsScale = 0.2625


-- Colors
local tableHeaderColor = { ['r'] = 25, ['g'] = 118, ['b'] = 210, ['a'] = 255 }
local tableHeaderTextColor = { ['r'] = 255, ['g'] = 255, ['b'] = 255, ['a'] = 255 }

local tablePositionTextColor = { ['r'] = 255, ['g'] = 255, ['b'] = 255, ['a'] = 255 }

local tablePositionRankBackgroundColor = { ['r'] = 0, ['g'] = 0, ['b'] = 0, ['a'] = 255 }
local tablePositionRankColor = { ['r'] = 63, ['g'] = 81, ['b'] = 181, ['a'] = 255 }
local tablePositionRankTextColor = { ['r'] = 255, ['g'] = 255, ['b'] = 255, ['a'] = 255 }

local tableCashColor = { ['r'] = 0, ['g'] = 0, ['b'] = 0, ['a'] = 160 }
local tableCashTextColor = { ['r'] = 255, ['g'] = 255, ['b'] = 255, ['a'] = 255 }

local tableKdRatioColor = { ['r'] = 0, ['g'] = 0, ['b'] = 0, ['a'] = 160 }
local tableKdRatioTextColor = { ['r'] = 255, ['g'] = 255, ['b'] = 255, ['a'] = 255 }

local tableKillsColor = { ['r'] = 0, ['g'] = 0, ['b'] = 0, ['a'] = 160 }
local tableKillsTextColor = { ['r'] = 255, ['g'] = 255, ['b'] = 255, ['a'] = 255 }

local tableDeathsColor = { ['r'] = 0, ['g'] = 0, ['b'] = 0, ['a'] = 160 }
local tableDeathsTextColor = { ['r'] = 255, ['g'] = 255, ['b'] = 255, ['a'] = 255 }


AddEventHandler('lsv:updateScoreboard', function(serverScoreboard)
	scoreboard = table.filter(serverScoreboard, function(player)
		local id = GetPlayerFromServerId(player.id)
		return id == PlayerId() or NetworkIsPlayerActive(id)
	end)
end)


function Scoreboard.DisplayThisFrame()
	local scoreboardPosition = { ['x'] = (1.0 - tableWidth) / 2, ['y'] = SafeZone.Top() }

	local tableHeader = { ['y'] = scoreboardPosition.y + tableHeight / 2 }
	local tableHeaderText = { ['y'] = tableHeader.y - tableHeight / 2 + tableTextVerticalMargin }

	local tablePositionHeader = { ['x'] = scoreboardPosition.x + tablePositionWidth / 2, ['y'] = tableHeader.y }
	local tableCashHeader = { ['x'] = tablePositionHeader.x + tablePositionWidth / 2 + tableCashWidth / 2 , ['y'] = tableHeader.y }
	local tableKdRatioHeader = { ['x'] = tableCashHeader.x + tableCashWidth / 2 + tableKdRatioWidth / 2 , ['y'] = tableHeader.y }
	local tableKillsHeader = { ['x'] = tableKdRatioHeader.x + tableKdRatioWidth / 2 + tableKillsWidth / 2 , ['y'] = tableHeader.y }
	local tableDeathsHeader = { ['x'] = tableKillsHeader.x + tableKillsWidth / 2 + tableDeathsWidth / 2 , ['y'] = tableHeader.y }

	-- Draw 'POSITION' header
	Gui.DrawRect(tablePositionHeader, tablePositionWidth, tableHeight, tableHeaderColor)
	Gui.SetTextParams(0, tableHeaderTextColor, headerScale, false, false, true)
	Gui.DrawText('POSITION', { ['x'] = tablePositionHeader.x, ['y'] = tableHeaderText.y })

	-- Draw 'CASH' header
	Gui.DrawRect(tableCashHeader, tableCashWidth, tableHeight, tableHeaderColor)
	Gui.SetTextParams(0, tableHeaderTextColor, headerScale, false, false, true)
	Gui.DrawText('CASH', { ['x'] = tableCashHeader.x, ['y'] = tableHeaderText.y })

	-- Draw 'KILLSTREAK' header
	Gui.DrawRect(tableKdRatioHeader, tableKdRatioWidth, tableHeight, tableHeaderColor)
	Gui.SetTextParams(0, tableHeaderTextColor, headerScale, false, false, true)
	Gui.DrawText('K/D RATIO', { ['x'] = tableKdRatioHeader.x, ['y'] = tableHeaderText.y })

	-- Draw 'KILLS' header
	Gui.DrawRect(tableKillsHeader, tableKillsWidth, tableHeight, tableHeaderColor)
	Gui.SetTextParams(0, tableHeaderTextColor, headerScale, false, false, true)
	Gui.DrawText('KILLS', { ['x'] = tableKillsHeader.x, ['y'] = tableHeaderText.y })

	-- Draw 'DEATHS' header
	Gui.DrawRect(tableDeathsHeader, tableDeathsWidth, tableHeight, tableHeaderColor)
	Gui.SetTextParams(0, tableHeaderTextColor, headerScale, false, false, true)
	Gui.DrawText('DEATHS', { ['x'] = tableDeathsHeader.x, ['y'] = tableHeaderText.y })

	-- Draw table
	local tablePosition = { ['y'] = tablePositionHeader.y + tableHeight + headerTableSpacing }
	local tableAvatarPositionWidth = (tableHeight * 9 / 16)

	table.foreach(scoreboard, function(player)
		local avatarPosition = { ['x'] = scoreboardPosition.x + tableAvatarPositionWidth / 2, ['y'] = tablePosition.y }
		local playerPosition = { ['x'] = avatarPosition.x + tablePositionWidth / 2, ['y'] = tablePosition.y }
		local onlineStatusPosition = { ['x'] = avatarPosition.x + tableAvatarPositionWidth / 2 + onlineStatusWidth / 2, ['y'] = tablePosition.y }
		local cashPosition = { ['x'] = tableCashHeader.x, ['y'] = tablePosition.y }
		local kdRatioPosition = { ['x'] = tableKdRatioHeader.x, ['y'] = tablePosition.y }
		local killsPosition = { ['x'] = tableKillsHeader.x, ['y'] = tablePosition.y }
		local deathsPosition = { ['x'] = tableDeathsHeader.x, ['y'] = tablePosition.y }
		local tableText = { ['y'] = tablePosition.y - tableHeight / 2 }

		-- Draw player id
		Gui.DrawRect(avatarPosition, tableAvatarPositionWidth, tableHeight, tableCashColor)
		Gui.SetTextParams(0, tableCashTextColor, cashScale, false, false, true)
		Gui.DrawNumeric(player.id, { ['x'] = avatarPosition.x, ['y'] = tableText.y + tableTextVerticalMargin })

		-- Draw player name
		local isPatron = player.patreonTier ~= 0
		local playerColor = Color.GetHudFromBlipColor(Color.BlipDarkBlue())
		if isPatron then
			playerColor = Color.GetHudFromBlipColor(Color.BlipOrange())
		elseif player.id == Player.ServerId() then
			playerColor = Color.GetHudFromBlipColor(Color.BlipBlue())
		end
		local tablePositionColor = { ['r'] = playerColor.r, ['g'] = playerColor.g, ['b'] = playerColor.b, ['a'] = isPatron and 228 or 160 }

		Gui.DrawRect(playerPosition, tablePositionWidth - tableAvatarPositionWidth, tableHeight, tablePositionColor)
		Gui.SetTextParams(4, tablePositionTextColor, positionScale, false, isPatron)
		Gui.DrawText(player.name, { ['x'] = playerPosition.x - (tablePositionWidth - tableAvatarPositionWidth) / 2 + onlineStatusWidth + tableTextHorizontalMargin,
			['y'] = tableText.y })

		-- Draw online status (make it real)
		local onlineStatusColor = isPatron and Color.GetHudFromBlipColor(Color.BlipOrange()) or Color.GetHudFromBlipColor(Color.BlipWhite())
		Gui.DrawRect(onlineStatusPosition, onlineStatusWidth, tableHeight, onlineStatusColor)

		-- Draw cash
		Gui.DrawRect(cashPosition, tableCashWidth, tableHeight, tableCashColor)
		Gui.SetTextParams(0, tableCashTextColor, cashScale, false, false, true)
		Gui.DrawNumericTextEntry('MONEY_ENTRY', { ['x'] = tableCashHeader.x, ['y'] = tableText.y + tableTextVerticalMargin }, player.cash)

		-- Draw kdRatio
		Gui.DrawRect(kdRatioPosition, tableKdRatioWidth, tableHeight, tableKdRatioColor)
		Gui.SetTextParams(0, tableKdRatioTextColor, kdRatioScale, false, false, true)
		local kdRatio = '-'
		if player.kdRatio then
			kdRatio = string.format('%.2f', player.kdRatio)
		end
		Gui.DrawText(kdRatio, { ['x'] = tableKdRatioHeader.x, ['y'] = tableText.y + tableTextVerticalMargin })

		-- Draw kills
		Gui.DrawRect(killsPosition, tableKillsWidth, tableHeight, tableKillsColor)
		Gui.SetTextParams(0, tableKillsTextColor, killsScale, false, false, true)
		Gui.DrawNumeric(player.kills, { ['x'] = tableKillsHeader.x, ['y'] = tableText.y + tableTextVerticalMargin })

		-- Draw deaths
		Gui.DrawRect(deathsPosition, tableDeathsWidth, tableHeight, tableDeathsColor)
		Gui.SetTextParams(0, tableDeathsTextColor, deathsScale, false, false, true)
		Gui.DrawNumeric(player.deaths, { ['x'] = tableDeathsHeader.x, ['y'] = tableText.y + tableTextVerticalMargin })

		-- Update table position
		tablePosition.y = tablePosition.y + tableSpacing + tableHeight
	end)
end
