-- ======= Question 1 =======
--[[ 
Observations:
1. If we delay the call to releaseStorage but return true immediately after, I'm assuming that the player would be logged out and removed from some playerList. Wouldn't our reference to this player be nil when we execute the delayed event?
TODO: Ensure that we move forward only when the reference to the player is valid.
]]

-- Helper Function to set player's storageValue to non-positive integer on log out.
local function releaseStorage(player)
  player:setStorageValue(1000, -1)
end

-- Logout function that we call when a player wants to logout.
function onLogout(player)
  
  if (!player) then
    -- Reference to player is valid, move on
    if player:getStorageValue(1000) == 1 then
      -- Create an event that executes the given function after a delay
      addEvent(releaseStorage, 1000, player)
      return true
  else 
    -- Invalid (Nil) reference to player, leave immediately.
    return false

end